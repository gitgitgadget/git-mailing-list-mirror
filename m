Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512B51F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfG3Tfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40921 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfG3Tf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so57692414wmj.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hs06JvXqwmtzg3A9+0olVIVnR9ohwBIQUa4DXzLZBvU=;
        b=UXucvnkBbAmWP5JdoKLM67rpcpysgm5KIuD+B4Cjl7a97JeRo9VfZH/nwwRIB7Nlm4
         qOvtDNngajl/WDR4IHABCferMZ4BQoNfIrH1oz6k5c+ak4T7c3k2R9VZSFcuDtma8e5X
         7K1WyR/tmHzGYps4fvjey/68q/Fr5eb6CetJKwAGTY7kfmMjj2ljANyVOTJV9P6FlEri
         6rvyzMCAj/LKLuBpTD6B6WsdsA7BXsHsbdTLePncpAlSUi58xKdeCLu660Q3C1QF1trO
         Hin7/+EmRgdBA4zxiyHJG6/SU6tXVeGrTap76+MnRL+tVUpxkTCVJUb92D7FsgcXDKew
         6HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hs06JvXqwmtzg3A9+0olVIVnR9ohwBIQUa4DXzLZBvU=;
        b=ZJBhyLD0ahb14khxGsn7ebEuM+glVzCvkUItEn+evdsT4caf1O3aW8uMzPWb9ZgSvc
         eKJ3Sv8gaWtK3iiLRdF/ZM1NMP7WNr21ZrLW/vwdTaPYr4q8dfou1ht8mwvCn8lM1vqw
         EgTfzK3+uqlqd8XPtniQ1SMlWn6dWXUHSteRj8U9HchGsjLG4K12dLSiSTz5fraxIV+n
         9lUHKVKvIJnir25bQqCYS+td6CjESaKMuzH/YxZZVofIn7j1kgjVg/T3Q+gG9IYYbJXP
         QQ+V0frpnHBSDNcMnQlD9Q5Xb2AEi9Sq4l1bpWA5xwR7r0gVSgHQaDkBfryHCzl4BC1h
         prAg==
X-Gm-Message-State: APjAAAUGXDLU83t5gMWrXSQ2MBzCPDYBl+v7KFPE3HjOw9H30a9uRWgM
        yGaHOm68UteCSPI01Q6h2ywhc+jE
X-Google-Smtp-Source: APXvYqxZXR19UYf6dQXQG9gN39mlC7qmxBLNOTT+qhM55OM/fUYjjzvJWlBlwprbsSolldwEjwT+7Q==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr110796280wmj.116.1564515325767;
        Tue, 30 Jul 2019 12:35:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm46145298wmf.48.2019.07.30.12.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:35:25 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:35:25 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Jul 2019 19:35:19 GMT
Message-Id: <pull.292.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v2.git.gitgitgadget@gmail.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/5] Create 'feature.*' config area and some centralized config parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a brand-new thread to replace ds/early-access. The discussion on
that thread was very helpful [1].

With this in mind, I propose instead a set of "feature.*" config settings
that form groups of "community recommended" settings (with some caveats). In
the space below, I'll list a set of possible feature names and the implied
config options.

First, the main two categories we've discussed so far: many commits and many
files. These two feature sets are for when your repo is large in one of
these dimensions. Perhaps there are other settings to include in these?

feature.manyFiles:
    index.version = 4
    core.untrackedCache = true

feature.manyCommits:
    core.commitGraph = true
    gc.writeCommitGraph = true
    (future: fetch.writeSplitCommitGraph = true)

Note: the fetch.writeSplitCommitGraph does not exist yet, but could be
introduced in a later release to write a new commit-graph (with --split) on
fetch.

The other category that has been discussed already is that of "experimental
features that we generally think are helpful but change behavior slightly in
some cases".

feature.experimental:
    pack.useSparse = true
    merge.directoryRenames = true
    fetch.negotiationAlgorithm = skipping

Specifically, this setting is for config values we are not sure will ever be
on by default, but additional testing is needed to be sure. This is
different than a possible 'feature.preview' setting that would include
config settings that we are committed to updating the defaults in a future
release. There are many ways we can take this idea in the future (including
more additions to these categories).

Thanks, -Stolee

Updates in V2: I'm responding to Dscho's comments early, as they were very
valuable.

 * Rearranged how we are checking for the feature.* settings, so if one
   layer turns the setting on and a later layer turns it off, we do not
   adjust the defaults.
   
   
 * Switched to using enums for the non-boolean config options.
   
   
 * Placed the repo_settings struct directly in the repository struct.
   
   
 * All struct members are initialized to -1 using memset.
   
   
 * The config changes around directory rename detection is greatly
   simplified.
   
   

Updates in V3: These are more Dscho comments, and are quite small.

 * Remove repo-settings.h by placing the struct and function definitions in
   repository.h.
   
   
 * Move the initialization int into "struct repo_settings".
   
   

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Derrick Stolee (5):
  repo-settings: consolidate some config settings
  repo-settings: add feature.manyCommits setting
  repo-settings: parse core.untrackedCache
  repo-settings: create feature.manyFiles setting
  repo-settings: create feature.experimental setting

 Documentation/config.txt             |  2 +
 Documentation/config/core.txt        |  7 ++-
 Documentation/config/feature.txt     | 42 ++++++++++++++++
 Documentation/config/fetch.txt       |  3 +-
 Documentation/config/gc.txt          |  4 +-
 Documentation/config/index.txt       |  1 +
 Documentation/config/merge.txt       |  3 +-
 Documentation/config/pack.txt        |  3 +-
 Makefile                             |  1 +
 builtin/gc.c                         | 12 ++---
 builtin/pack-objects.c               |  8 +--
 builtin/update-index.c               |  6 ++-
 commit-graph.c                       |  6 +--
 config.c                             | 24 ---------
 fetch-negotiator.c                   | 25 +++++-----
 fetch-negotiator.h                   |  5 +-
 fetch-pack.c                         | 11 ++--
 merge-recursive.c                    | 14 ++----
 read-cache.c                         | 30 +++++------
 repo-settings.c                      | 75 ++++++++++++++++++++++++++++
 repository.h                         | 39 +++++++++++++++
 t/t1600-index.sh                     | 31 ++++++++++--
 t/t5552-skipping-fetch-negotiator.sh | 23 ---------
 23 files changed, 256 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/config/feature.txt
 create mode 100644 repo-settings.c


base-commit: 9c9b961d7eb15fb583a2a812088713a68a85f1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-292%2Fderrickstolee%2Frepo-settings%2Fhead-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-292/derrickstolee/repo-settings/head-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/292

Range-diff vs v2:

 1:  597ab7d621 ! 1:  4d0db57ecb repo-settings: consolidate some config settings
     @@ -30,14 +30,6 @@
       diff --git a/builtin/gc.c b/builtin/gc.c
       --- a/builtin/gc.c
       +++ b/builtin/gc.c
     -@@
     - #include "pack-objects.h"
     - #include "blob.h"
     - #include "tree.h"
     -+#include "repo-settings.h"
     - 
     - #define FAILED_RUN "failed to run %s"
     - 
      @@
       static int aggressive_window = 250;
       static int gc_auto_threshold = 6700;
     @@ -75,14 +67,6 @@
       diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
       --- a/builtin/pack-objects.c
       +++ b/builtin/pack-objects.c
     -@@
     - #include "dir.h"
     - #include "midx.h"
     - #include "trace2.h"
     -+#include "repo-settings.h"
     - 
     - #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
     - #define SIZE(obj) oe_size(&to_pack, obj)
      @@
       		use_bitmap_index_default = git_config_bool(k, v);
       		return 0;
     @@ -109,14 +93,6 @@
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
     -@@
     - #include "hashmap.h"
     - #include "replace-object.h"
     - #include "progress.h"
     -+#include "repo-settings.h"
     - 
     - #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
     - #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
      @@
       static int prepare_commit_graph(struct repository *r)
       {
     @@ -142,14 +118,6 @@
       diff --git a/read-cache.c b/read-cache.c
       --- a/read-cache.c
       +++ b/read-cache.c
     -@@
     - #include "fsmonitor.h"
     - #include "thread-utils.h"
     - #include "progress.h"
     -+#include "repo-settings.h"
     - 
     - /* Mask for the name length in ce_flags in the on-disk index */
     - 
      @@
       
       #define INDEX_FORMAT_DEFAULT 3
     @@ -188,15 +156,14 @@
       +++ b/repo-settings.c
      @@
      +#include "cache.h"
     -+#include "repository.h"
      +#include "config.h"
     -+#include "repo-settings.h"
     ++#include "repository.h"
      +
      +void prepare_repo_settings(struct repository *r)
      +{
      +	int value;
      +
     -+	if (r->settings_initialized)
     ++	if (r->settings.initialized)
      +		return;
      +
      +	/* Defaults */
     @@ -212,54 +179,50 @@
      +
      +	if (!repo_config_get_bool(r, "pack.usesparse", &value))
      +		r->settings.pack_use_sparse = value;
     -+
     -+	r->settings_initialized = 1;
      +}
      
     - diff --git a/repo-settings.h b/repo-settings.h
     - new file mode 100644
     - --- /dev/null
     - +++ b/repo-settings.h
     -@@
     -+#ifndef REPO_SETTINGS_H
     -+#define REPO_SETTINGS_H
     -+
     -+struct repo_settings {
     -+	int core_commit_graph;
     -+	int gc_write_commit_graph;
     -+
     -+	int index_version;
     -+
     -+	int pack_use_sparse;
     -+};
     -+
     -+struct repository;
     -+
     -+void prepare_repo_settings(struct repository *r);
     -+
     -+#endif /* REPO_SETTINGS_H */
     -
       diff --git a/repository.h b/repository.h
       --- a/repository.h
       +++ b/repository.h
      @@
     - #define REPOSITORY_H
     - 
       #include "path.h"
     -+#include "repo-settings.h"
       
       struct config_set;
      +struct repo_settings;
       struct git_hash_algo;
       struct index_state;
       struct lock_file;
     +@@
     + struct raw_object_store;
     + struct submodule_cache;
     + 
     ++struct repo_settings {
     ++	int initialized;
     ++
     ++	int core_commit_graph;
     ++	int gc_write_commit_graph;
     ++
     ++	int index_version;
     ++
     ++	int pack_use_sparse;
     ++};
     ++
     + struct repository {
     + 	/* Environment */
     + 	/*
      @@
       	 */
       	char *submodule_prefix;
       
     -+	int settings_initialized;
      +	struct repo_settings settings;
      +
       	/* Subsystems */
       	/*
       	 * Repository's config which contains key-value pairs from the usual
     +@@
     +  */
     + void repo_update_index_if_able(struct repository *, struct lock_file *);
     + 
     ++void prepare_repo_settings(struct repository *r);
     + 
     + #endif /* REPOSITORY_H */
 2:  86380c7832 ! 2:  c0129066a0 repo-settings: add feature.manyCommits setting
     @@ -81,7 +81,7 @@
       +++ b/repo-settings.c
      @@
       #include "config.h"
     - #include "repo-settings.h"
     + #include "repository.h"
       
      +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
      +
     @@ -89,13 +89,12 @@
       {
       	int value;
      @@
     + 
       	if (!repo_config_get_bool(r, "pack.usesparse", &value))
       		r->settings.pack_use_sparse = value;
     - 
     ++
      +	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
      +		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
      +		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
      +	}
     -+
     - 	r->settings_initialized = 1;
       }
 3:  49be7a7345 ! 3:  b0a2d0e188 repo-settings: parse core.untrackedCache
     @@ -25,14 +25,6 @@
       diff --git a/builtin/update-index.c b/builtin/update-index.c
       --- a/builtin/update-index.c
       +++ b/builtin/update-index.c
     -@@
     - #include "dir.h"
     - #include "split-index.h"
     - #include "fsmonitor.h"
     -+#include "repo-settings.h"
     - 
     - /*
     -  * Default to not allowing changes to the list of files. The
      @@
       	struct parse_opt_ctx_t ctx;
       	strbuf_getline_fn getline_fn;
     @@ -141,7 +133,7 @@
       	int value;
      +	char *strval;
       
     - 	if (r->settings_initialized)
     + 	if (r->settings.initialized)
       		return;
      @@
       
     @@ -168,22 +160,21 @@
       		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
       		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
       	}
     - 
     ++
      +	/* Hack for test programs like test-dump-untracked-cache */
      +	if (ignore_untracked_cache_config)
      +		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
      +	else
      +		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
      +
     - 	r->settings_initialized = 1;
       }
      
     - diff --git a/repo-settings.h b/repo-settings.h
     - --- a/repo-settings.h
     - +++ b/repo-settings.h
     + diff --git a/repository.h b/repository.h
     + --- a/repository.h
     + +++ b/repository.h
      @@
     - #ifndef REPO_SETTINGS_H
     - #define REPO_SETTINGS_H
     + struct raw_object_store;
     + struct submodule_cache;
       
      +enum untracked_cache_setting {
      +	UNTRACKED_CACHE_UNSET = -1,
     @@ -193,7 +184,9 @@
      +};
      +
       struct repo_settings {
     - 	int core_commit_graph;
     + 	int initialized;
     + 
     +@@
       	int gc_write_commit_graph;
       
       	int index_version;
 4:  86a5a0c589 = 4:  0d4774d45f repo-settings: create feature.manyFiles setting
 5:  b8a631683a ! 5:  2e153fac22 repo-settings: create feature.experimental setting
     @@ -93,18 +93,6 @@
       pack.writeBitmaps (deprecated)::
       	This is a deprecated synonym for `repack.writeBitmaps`.
      
     - diff --git a/builtin/am.c b/builtin/am.c
     - --- a/builtin/am.c
     - +++ b/builtin/am.c
     -@@
     - #include "string-list.h"
     - #include "packfile.h"
     - #include "repository.h"
     -+#include "repo-settings.h"
     - 
     - /**
     -  * Returns the length of the first line of msg.
     -
       diff --git a/fetch-negotiator.c b/fetch-negotiator.c
       --- a/fetch-negotiator.c
       +++ b/fetch-negotiator.c
     @@ -113,7 +101,6 @@
       #include "negotiator/default.h"
       #include "negotiator/skipping.h"
      +#include "repository.h"
     -+#include "repo-settings.h"
       
      -void fetch_negotiator_init(struct fetch_negotiator *negotiator,
      -			   const char *algorithm)
     @@ -230,14 +217,6 @@
       diff --git a/merge-recursive.c b/merge-recursive.c
       --- a/merge-recursive.c
       +++ b/merge-recursive.c
     -@@
     - #include "submodule.h"
     - #include "revision.h"
     - #include "commit-reach.h"
     -+#include "repo-settings.h"
     - 
     - struct path_hashmap_entry {
     - 	struct hashmap_entry e;
      @@
       		opt->merge_detect_rename = git_config_rename("merge.renames", value);
       		free(value);
     @@ -307,13 +286,11 @@
       
      +	UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
      +	UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
     -+
     - 	r->settings_initialized = 1;
       }
      
     - diff --git a/repo-settings.h b/repo-settings.h
     - --- a/repo-settings.h
     - +++ b/repo-settings.h
     + diff --git a/repository.h b/repository.h
     + --- a/repository.h
     + +++ b/repository.h
      @@
       	UNTRACKED_CACHE_WRITE = 2
       };
     @@ -333,8 +310,8 @@
      +};
      +
       struct repo_settings {
     - 	int core_commit_graph;
     - 	int gc_write_commit_graph;
     + 	int initialized;
     + 
      @@
       	enum untracked_cache_setting core_untracked_cache;
       
     @@ -343,7 +320,7 @@
      +	enum fetch_negotiation_setting fetch_negotiation_algorithm;
       };
       
     - struct repository;
     + struct repository {
      
       diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
       --- a/t/t5552-skipping-fetch-negotiator.sh

-- 
gitgitgadget
