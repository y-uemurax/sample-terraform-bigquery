module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 4.2"

  dataset_id                  = var.dataset_id
  dataset_name                = var.dataset_name
  description                 = "some description"
  project_id                  = var.project_id
  location                    = var.dataset_location
  default_table_expiration_ms = 3600000

  tables = [
  {
    table_id          = "foo",
    schema            =  "tables/foo.json",
    time_partitioning = {
      type                     = "DAY",
      field                    = null,
      require_partition_filter = false,
      expiration_ms            = null,
    },
    expiration_time = null,
    clustering      = ["id", "first_name", "last_name"],
    labels          = {
      env      = "dev"
      billable = "true"
      owner    = "joedoe"
    }
  },
  {
    table_id          = "bar",
    schema            =  "tables/bar.json",
    time_partitioning = null,
    expiration_time   = 2524604400000, # 2050/01/01
    clustering        = [],
    labels = {
      env      = "devops"
      billable = "true"
      owner    = "joedoe"
    },
  }
  ]

  views = [
    {
      view_id    = "barview",
      use_legacy_sql = false,
      query          = "${file("./views/hoge.sql")}"
      labels = {
        env      = "devops"
        billable = "true"
        owner    = "joedoe"
      }
    }
  ]
  dataset_labels = {
    env      = "dev"
    billable = "true"
  }
}
