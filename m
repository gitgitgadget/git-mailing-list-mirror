Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2622E1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfHMShr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43140 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHMShq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so2748336wrn.10
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PyM1qKTqvQtxPRqaE70D2frHc0Dbfrg007PaDhWs1G4=;
        b=EHYSWpi5m316E2tkn2QvpvtdxMGlejIxnLTrDHUj95PpAWIYCJs3q5tchRZAyIjE7o
         JHDoPc7o9tzmQV8bq28Lp3ah9i1HZBydtfPGo3gVgYUIKdxrK5zLahyKWJq5Nnbzte+D
         ULRsg7om28ZdTuMv1gWYXc11HmHBBV0qyCmrv7TH6C9VHnGHszxlfaUl731JR+Vdco5o
         9VzREEnVnTVfvJzHI92QRKX075Kp+PrmLraQrTTq+vLFPYzAGikSLoM6V85pgzDR10y+
         RqT8w3NtSKe2wkUxNfx+6Ry7C0Kq/5iyJRlK2sAEteih6uvsC/10UyogaGUJsxavs8px
         lgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PyM1qKTqvQtxPRqaE70D2frHc0Dbfrg007PaDhWs1G4=;
        b=geEuXHUrGMt7xL+So3FlXY4E1ZcI5+lGRJ5nu7uYGpYeo0TctdLrUBJfiFNBMGTiX0
         3VQ+Z63cI2vGKNUU4baJruP01SDTTodut30S2Fg4YJnTU/otZZ/k90R+MCrxM7/TBn+3
         iaXngGsPbmgjlJCAYRgUCdJzedlfAal2i1NlwoNl6Q4b1LbLdwdUhY6jtsJ88wfsWkWd
         up8UzZdHw05rtBgAHxrUvVKC4FfIma3tDaedfqjIASZbIjIEo8N5n6H3eQBwqqXKyimX
         zecCkOK+HZHXYo8xbSb95pIiC9TQqptNudrbEaAIxb+LaYdOu8xgKZzWA8usKz0pEpoC
         qQUQ==
X-Gm-Message-State: APjAAAUCzW+VEtL7wMTx4fEelZqvId1dOxAx5Y0AfcaNrDwHGWKUzvYU
        u3QeMpDRi8lDVf/oX7K8H6Cto3oE
X-Google-Smtp-Source: APXvYqwDvYks+zA9lfo3VGop1E5f8xjpAkbUqHtVehk2tLH5ncRxh5TUUpXyVY+5fkrxV31CIOowMg==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr31791909wrm.271.1565721463393;
        Tue, 13 Aug 2019 11:37:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r190sm4572973wmf.0.2019.08.13.11.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:42 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:42 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:35 GMT
Message-Id: <pull.292.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v3.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/6] Create 'feature.*' config area and some centralized config parsing
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

UPDATE: Instead of "feature.manyCommits", this series includes making
core.commitGraph and gc.writeCommitGraph true by default!

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
   
   

Updates in V4:

 * Remove feature.manyCommits in favor of turning commit-graph on by
   default.
   
   
 * Update docs and 0 constant in feature.experimental around
   merge.directoryRenames.
   
   

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Derrick Stolee (6):
  repo-settings: consolidate some config settings
  t6501: use 'git gc' in quiet mode
  commit-graph: turn on commit-graph by default
  repo-settings: parse core.untrackedCache
  repo-settings: create feature.manyFiles setting
  repo-settings: create feature.experimental setting

 Documentation/config.txt             |  2 +
 Documentation/config/core.txt        |  6 ++-
 Documentation/config/feature.txt     | 29 +++++++++++++
 Documentation/config/fetch.txt       |  3 +-
 Documentation/config/gc.txt          |  2 +-
 Documentation/config/index.txt       |  1 +
 Documentation/config/pack.txt        |  3 +-
 Makefile                             |  1 +
 builtin/gc.c                         | 12 +++---
 builtin/pack-objects.c               |  8 ++--
 builtin/update-index.c               |  6 ++-
 commit-graph.c                       |  6 +--
 config.c                             | 24 -----------
 fetch-negotiator.c                   | 25 +++++------
 fetch-negotiator.h                   |  5 ++-
 fetch-pack.c                         | 11 +++--
 read-cache.c                         | 30 ++++++-------
 repo-settings.c                      | 64 ++++++++++++++++++++++++++++
 repository.h                         | 30 +++++++++++++
 t/t0410-partial-clone.sh             |  2 +-
 t/t1600-index.sh                     | 31 +++++++++++---
 t/t5307-pack-missing-commit.sh       |  4 +-
 t/t5324-split-commit-graph.sh        |  2 +
 t/t5552-skipping-fetch-negotiator.sh | 23 ----------
 t/t6011-rev-list-with-bad-commit.sh  |  2 +-
 t/t6501-freshen-objects.sh           |  6 +--
 26 files changed, 223 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/config/feature.txt
 create mode 100644 repo-settings.c


base-commit: 9c9b961d7eb15fb583a2a812088713a68a85f1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-292%2Fderrickstolee%2Frepo-settings%2Fhead-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-292/derrickstolee/repo-settings/head-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/292

Range-diff vs v3:

 1:  4d0db57ecb ! 1:  1a0b30b88a repo-settings: consolidate some config settings
     @@ -184,14 +184,6 @@
       diff --git a/repository.h b/repository.h
       --- a/repository.h
       +++ b/repository.h
     -@@
     - #include "path.h"
     - 
     - struct config_set;
     -+struct repo_settings;
     - struct git_hash_algo;
     - struct index_state;
     - struct lock_file;
      @@
       struct raw_object_store;
       struct submodule_cache;
 2:  c0129066a0 < -:  ---------- repo-settings: add feature.manyCommits setting
 -:  ---------- > 2:  6bf3584a60 t6501: use 'git gc' in quiet mode
 -:  ---------- > 3:  651e2d526b commit-graph: turn on commit-graph by default
 3:  b0a2d0e188 ! 4:  ec0abffd8b repo-settings: parse core.untrackedCache
     @@ -154,19 +154,12 @@
       
       	if (!repo_config_get_bool(r, "pack.usesparse", &value))
       		r->settings.pack_use_sparse = value;
     --
     -+	
     - 	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
     - 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
     - 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
     - 	}
      +
      +	/* Hack for test programs like test-dump-untracked-cache */
      +	if (ignore_untracked_cache_config)
      +		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
      +	else
     -+		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     -+
     ++		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
       }
      
       diff --git a/repository.h b/repository.h
 4:  0d4774d45f ! 5:  082fc57288 repo-settings: create feature.manyFiles setting
     @@ -13,6 +13,19 @@
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/Documentation/config.txt b/Documentation/config.txt
     + --- a/Documentation/config.txt
     + +++ b/Documentation/config.txt
     +@@
     + 
     + include::config/fastimport.txt[]
     + 
     ++include::config/feature.txt[]
     ++
     + include::config/fetch.txt[]
     + 
     + include::config/format.txt[]
     +
       diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
       --- a/Documentation/config/core.txt
       +++ b/Documentation/config/core.txt
     @@ -29,15 +42,15 @@
       	When missing or is set to `default`, many fields in the stat
      
       diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
     - --- a/Documentation/config/feature.txt
     + new file mode 100644
     + --- /dev/null
       +++ b/Documentation/config/feature.txt
      @@
     - * `core.commitGraph=true` enables reading the commit-graph file.
     - +
     - * `gc.writeCommitGraph=true` enables writing the commit-graph file during
     --garbage collection.
     - \ No newline at end of file
     -+garbage collection.
     ++feature.*::
     ++	The config settings that start with `feature.` modify the defaults of
     ++	a group of other config settings. These groups are created by the Git
     ++	developer community as recommended defaults and are subject to change.
     ++	In particular, new config options may be added with different defaults.
      +
      +feature.manyFiles::
      +	Enable config options that optimize for repos with many files in the
     @@ -48,7 +61,6 @@
      ++
      +* `core.untrackedCache=true` enables the untracked cache. This setting assumes
      +that mtime is working on your machine.
     - \ No newline at end of file
      
       diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
       --- a/Documentation/config/index.txt
     @@ -63,12 +75,15 @@
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
     - 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
     + 		free(strval);
       	}
     + 
     +-
     + 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     + 		r->settings.pack_use_sparse = value;
      +	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
     -+		UPDATE_DEFAULT(r->settings.index_version, 4);
     -+		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
     ++		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
     ++		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
      +	}
       
       	/* Hack for test programs like test-dump-untracked-cache */
 5:  2e153fac22 ! 6:  f30e25fcd6 repo-settings: create feature.experimental setting
     @@ -10,8 +10,6 @@
      
          * 'pack.useSparse=true'
      
     -    * 'merge.directoryRenames=true'
     -
          * 'fetch.negotiationAlgorithm=skipping'
      
          In the case of fetch.negotiationAlgorithm, the existing logic
     @@ -41,15 +39,12 @@
      +* `pack.useSparse=true` uses a new algorithm when constructing a pack-file
      +which can improve `git push` performance in repos with many files.
      ++
     -+* `merge.directoryRenames=true` uses a new algorithm for detecting renames by
     -+using entire directories at a time instead of single files at a time.
     -++
      +* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
      +skipping more commits at a time, reducing the number of round trips.
      +
     - feature.manyCommits::
     - 	Enable config options that optimize for repos with many commits. This
     - 	setting is recommended for repos with at least 100,000 commits. The
     + feature.manyFiles::
     + 	Enable config options that optimize for repos with many files in the
     + 	working directory. With many files, commands such as `git status` and
      
       diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
       --- a/Documentation/config/fetch.txt
     @@ -65,20 +60,6 @@
       +
       See also the `--negotiation-tip` option for linkgit:git-fetch[1].
      
     - diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
     - --- a/Documentation/config/merge.txt
     - +++ b/Documentation/config/merge.txt
     -@@
     - 	moved into the new directory.  If set to "conflict", a conflict
     - 	will be reported for such paths.  If merge.renames is false,
     - 	merge.directoryRenames is ignored and treated as false.  Defaults
     --	to "conflict".
     -+	to "conflict" unless `feature.experimental` is enabled and the
     -+	default is "true".
     - 
     - merge.renormalize::
     - 	Tell Git that canonical representation of files in the
     -
       diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
       --- a/Documentation/config/pack.txt
       +++ b/Documentation/config/pack.txt
     @@ -214,38 +195,6 @@
       	git_config(fetch_pack_config_cb, NULL);
       }
      
     - diff --git a/merge-recursive.c b/merge-recursive.c
     - --- a/merge-recursive.c
     - +++ b/merge-recursive.c
     -@@
     - 		opt->merge_detect_rename = git_config_rename("merge.renames", value);
     - 		free(value);
     - 	}
     --	if (!git_config_get_string("merge.directoryrenames", &value)) {
     --		int boolval = git_parse_maybe_bool(value);
     --		if (0 <= boolval) {
     --			opt->detect_directory_renames = boolval ? 2 : 0;
     --		} else if (!strcasecmp(value, "conflict")) {
     --			opt->detect_directory_renames = 1;
     --		} /* avoid erroring on values from future versions of git */
     --		free(value);
     --	}
     - 	git_config(git_xmerge_config, NULL);
     - }
     - 
     -@@
     - 	opt->diff_detect_rename = -1;
     - 	opt->merge_detect_rename = -1;
     - 	opt->detect_directory_renames = 1;
     -+
     -+	prepare_repo_settings(repo);
     -+	if (repo->settings.merge_directory_renames >= 0)
     -+		opt->detect_directory_renames = repo->settings.merge_directory_renames;
     -+
     - 	merge_recursive_config(opt);
     - 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
     - 	if (merge_verbosity)
     -
       diff --git a/repo-settings.c b/repo-settings.c
       --- a/repo-settings.c
       +++ b/repo-settings.c
     @@ -253,39 +202,31 @@
       		free(strval);
       	}
       
     -+	if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
     -+		r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
     -+	else if (!repo_config_get_string(r, "merge.directoryrenames", &strval)) {
     -+		if (!strcasecmp(strval, "conflict"))
     -+			r->settings.merge_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
     -+	}
      +	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
      +		if (!strcasecmp(strval, "skipping"))
      +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
      +		else
      +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
      +	}
     - 
     ++
       	if (!repo_config_get_bool(r, "pack.usesparse", &value))
       		r->settings.pack_use_sparse = value;
     -@@
     - 		UPDATE_DEFAULT(r->settings.index_version, 4);
     - 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
     + 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
     + 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
     + 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
       	}
      +	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
     -+		UPDATE_DEFAULT(r->settings.pack_use_sparse, 1);
     -+		UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
     -+		UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
     ++		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
     ++		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
      +	}
       
       	/* Hack for test programs like test-dump-untracked-cache */
       	if (ignore_untracked_cache_config)
     -@@
     + 		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
       	else
     - 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     - 
     -+	UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
     -+	UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
     + 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     ++
     ++	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
       }
      
       diff --git a/repository.h b/repository.h
     @@ -295,13 +236,6 @@
       	UNTRACKED_CACHE_WRITE = 2
       };
       
     -+enum merge_directory_renames_setting {
     -+	MERGE_DIRECTORY_RENAMES_UNSET = -1,
     -+	MERGE_DIRECTORY_RENAMES_NONE = 0,
     -+	MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
     -+	MERGE_DIRECTORY_RENAMES_TRUE = 2,
     -+};
     -+
      +enum fetch_negotiation_setting {
      +	FETCH_NEGOTIATION_UNSET = -1,
      +	FETCH_NEGOTIATION_NONE = 0,
     @@ -316,7 +250,6 @@
       	enum untracked_cache_setting core_untracked_cache;
       
       	int pack_use_sparse;
     -+	enum merge_directory_renames_setting merge_directory_renames;
      +	enum fetch_negotiation_setting fetch_negotiation_algorithm;
       };
       

-- 
gitgitgadget
