count_taxa <-
function(checklist_dat){
    # Add a number to each group
    checklist_dat$GROUP <- ifelse(checklist_dat$GROUP == "Ferns and lycophytes", 
                                  paste("2", checklist_dat$GROUP), checklist_dat$GROUP)
    checklist_dat$GROUP <- ifelse(is.na(checklist_dat$GROUP),                    
                                  "",                              checklist_dat$GROUP)
    checklist_dat$GROUP <- ifelse(checklist_dat$GROUP == "Gymnosperms",          
                                  paste("3", checklist_dat$GROUP), checklist_dat$GROUP)
    checklist_dat$GROUP <- ifelse(checklist_dat$GROUP == "Angiosperms",          
                                  paste("4", checklist_dat$GROUP), checklist_dat$GROUP)
    
    checklist_dat$FAMILY_NUMBER <- gsub("[^0-9]", "", checklist_dat$FAMILY_NUMBER)
    
    # Sorting by GROUP, FAMILY_NUMBER and SPECIES_FULL
    checklist_dat[is.na(checklist_dat)] <- ""
    
    checklist_dat3 <- checklist_dat[order(checklist_dat$GROUP,
                                          checklist_dat$FAMILY_NUMBER,
                                          checklist_dat$SPECIES_FULL), ]
    
    no_genera_by_family_dat <- unique(data.frame(GENUS = checklist_dat3$GENUS, FAMILY = checklist_dat3$FAMILY))
    no_genera_by_family <- aggregate(no_genera_by_family_dat$GENUS, list(no_genera_by_family_dat$FAMILY), "length")
    colnames(no_genera_by_family) <- c("family", "no_of_genera")
    
    no_species_by_family_dat <- unique(data.frame(SPECIES = checklist_dat3$SPECIES, FAMILY = checklist_dat3$FAMILY))
    no_species_by_family <- aggregate(no_species_by_family_dat$SPECIES,  list(no_species_by_family_dat$FAMILY), "length")
    colnames(no_species_by_family) <- c("family", "no_of_species")
    
    no_genera_by_group_dat <- unique(data.frame(GENUS = checklist_dat3$GENUS, GROUP = checklist_dat3$GROUP))
    no_genera_by_group <- aggregate(no_genera_by_group_dat$GENUS,  list(no_genera_by_group_dat$GROUP), "length")
    colnames(no_genera_by_group) <- c("group", "no_of_genera")
    
    no_species_by_group_dat <- unique(data.frame(SPECIES = checklist_dat3$SPECIES, GROUP = checklist_dat3$GROUP))
    no_species_by_group <- aggregate(no_species_by_group_dat$SPECIES,  list(no_species_by_group_dat$GROUP), "length")
    colnames(no_species_by_group) <- c("group", "no_of_species")
    
    no_families_by_group_dat <- unique(data.frame(FAMILY = checklist_dat3$FAMILY, GROUP = checklist_dat3$GROUP))
    no_families_by_group <- aggregate(no_families_by_group_dat$FAMILY,  list(no_families_by_group_dat$GROUP), "length")
    colnames(no_families_by_group) <- c("group", "no_of_families")
    
    no_species_by_genus_dat <- unique(data.frame(SPECIES = checklist_dat3$SPECIES, GENUS = checklist_dat3$GENUS))
    no_species_by_genus <- aggregate(no_species_by_genus_dat$SPECIES,  list(no_species_by_genus_dat$GENUS), "length")
    colnames(no_species_by_genus) <- c("genus", "no_of_species")
    
    no_families <- length(unique(checklist_dat3$FAMILY))
    no_genera   <- length(unique(checklist_dat3$GENUS))
    no_species  <- length(unique(checklist_dat3$SPECIES))
    
    return(list(NO_OF_FAMILIES           = no_families,
                NO_OF_GENERA             = no_genera,
                NO_OF_SPECIES            = no_species,
                NO_OF_FAMILIES_BY_GROUP = no_families_by_group,
                NO_OF_GENERA_BY_GROUP   = no_genera_by_group,
                NO_OF_SPECIES_BY_GROUP  = no_species_by_group,
                NO_OF_GENERA_BY_FAMILY  = no_genera_by_family,
                NO_OF_SPECIES_BY_FAMILY = no_species_by_family, 
                NO_OF_SPECIES_BY_GENUS  = no_species_by_genus))
}
