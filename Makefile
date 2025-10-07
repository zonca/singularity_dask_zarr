CONTAINER_NAME = singularity_dask_zarr.sif

.PHONY: all build test clean

all: build test

build: $(CONTAINER_NAME)

$(CONTAINER_NAME): Singularity.def requirements.txt
	@echo "Building Singularity container..."
	sudo singularity build $(CONTAINER_NAME) Singularity.def

test: $(CONTAINER_NAME)
	@echo "Testing Singularity container..."
	singularity exec $(CONTAINER_NAME) python -c "import dask; import zarr; print(f'Dask version: {dask.__version__}'); print(f'Zarr version: {zarr.__version__}')"

clean:
	@echo "Cleaning up..."
	rm -f $(CONTAINER_NAME)
