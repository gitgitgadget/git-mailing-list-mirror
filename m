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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5711F462
	for <e@80x24.org>; Thu, 25 Jul 2019 02:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbfGYCXX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 22:23:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbfGYCXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 22:23:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so48994293wrm.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ap/SUs9HcudhvxxU9tooEfSrAL5PHr5m8VIZLFfV3vE=;
        b=c6DaEc0RSWIVFUD/hAzoa0bRgSdzP1MXgDHOBHn+8/+JTat0VCMIp/wqjuD9papbRV
         Zp/05NGehh7U5kAWStbsT/B5zWjhMeqFwhwizQDpMuHc+wQmeqBE0Jx2LesMe4b3qs3g
         lFIih2NprNkiwRDJ/cCLvm1zicnKfhG7B9F0FIgEJR8BJuWJ06f3PlR2WS/qbSKASM31
         TjcAffRlSedhJuZB1MVSPrGV4PeIg+QB2/o3r1gbcgGdfvHIvSRbJr4Rve88PgCClRyH
         bKMjyp7Sc+f+HT8PxDjD61gmMIMH4kGWUNFcw0GroitlNk6M+lw1kW2uvWc8DDLBzi5m
         uiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ap/SUs9HcudhvxxU9tooEfSrAL5PHr5m8VIZLFfV3vE=;
        b=h2H5sHIXR35ivjStHZqXbrQ3v+boWyIqlewFILUomUC6thJ7jAqoJ+JX7IIzn5QV8l
         82BwB5SIrgR8osGuXug+Y34kckzwYEiHEwakyzxcQcImdg7Rf9dHR/marG1nBJ8ElHlC
         fMXcLjPcfUa1RCHecYIz2RSuBRXBkxMDKA7sSmkOqSVwfyULDDvMvrpK2BIpSXfKnOXg
         nAB3fplXgBLbKLlARZmlCYZJ1WCHrOokUOHGP02xnlCXr27ZGTyqcgjOtvYJqrgtAZvQ
         hWTmc/xkm6jSwFXHimseimkDKfEiA7tgQ75LbBZQHcM8ALuTq+PtREBt79TfzB57bYZP
         hIrw==
X-Gm-Message-State: APjAAAXf9tlK28SHlkSu5/eKYZ+G0EH/lvBwzH5MNujXqLUKDLlNw/Yx
        XRtslDNAhwnCLYzjKI+b+ZissIac
X-Google-Smtp-Source: APXvYqwFmI0Vmf7+vlTaQgv3ogaONEtJJaLMgjGaASZ1wpDlserOgmQ/iGj9TDV3vOs0rZVeDtiP/Q==
X-Received: by 2002:adf:b612:: with SMTP id f18mr80244405wre.97.1564021398509;
        Wed, 24 Jul 2019 19:23:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a67sm50759262wmh.40.2019.07.24.19.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:23:18 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:23:18 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 02:23:12 GMT
Message-Id: <b8a631683a116f48ddf7ac3ff98db7f81aa2bcc0.1564021393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v2.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
        <pull.292.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/5] repo-settings: create feature.experimental setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'feature.experimental' setting includes config options that are
not committed to become defaults, but could use additional testing.

Update the following config settings to take new defaults, and to
use the repo_settings struct if not already using them:

* 'pack.useSparse=true'

* 'merge.directoryRenames=true'

* 'fetch.negotiationAlgorithm=skipping'

In the case of fetch.negotiationAlgorithm, the existing logic
would load the config option only when about to use the setting,
so had a die() statement on an unknown string value. This is
removed as now the config is parsed under prepare_repo_settings().
In general, this die() is probably misplaced and not valuable.
A test was removed that checked this die() statement executed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/feature.txt     | 17 +++++++++++++++++
 Documentation/config/fetch.txt       |  3 ++-
 Documentation/config/merge.txt       |  3 ++-
 Documentation/config/pack.txt        |  3 ++-
 builtin/am.c                         |  1 +
 fetch-negotiator.c                   | 26 ++++++++++++++------------
 fetch-negotiator.h                   |  5 +++--
 fetch-pack.c                         | 11 +++++------
 merge-recursive.c                    | 15 ++++++---------
 repo-settings.c                      | 20 ++++++++++++++++++++
 repo-settings.h                      | 16 ++++++++++++++++
 t/t5552-skipping-fetch-negotiator.sh | 23 -----------------------
 12 files changed, 88 insertions(+), 55 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index c2d9ef7473..287621b1e8 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -4,6 +4,23 @@ feature.*::
 	developer community as recommended defaults and are subject to change.
 	In particular, new config options may be added with different defaults.
 
+feature.experimental::
+	Enable config options that are new to Git, and are being considered for
+	future defaults. Config settings included here may be added or removed
+	with each release, including minor version updates. These settings may
+	have unintended interactions since they are so new. Please enable this
+	setting if you are interested in providing feedback on experimental
+	features. The new default values are:
++
+* `pack.useSparse=true` uses a new algorithm when constructing a pack-file
+which can improve `git push` performance in repos with many files.
++
+* `merge.directoryRenames=true` uses a new algorithm for detecting renames by
+using entire directories at a time instead of single files at a time.
++
+* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
+skipping more commits at a time, reducing the number of round trips.
+
 feature.manyCommits::
 	Enable config options that optimize for repos with many commits. This
 	setting is recommended for repos with at least 100,000 commits. The
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index ba890b5884..d402110638 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -59,7 +59,8 @@ fetch.negotiationAlgorithm::
 	effort to converge faster, but may result in a larger-than-necessary
 	packfile; The default is "default" which instructs Git to use the default algorithm
 	that never skips commits (unless the server has acknowledged it or one
-	of its descendants).
+	of its descendants). If `feature.experimental` is enabled, then this
+	setting defaults to "skipping".
 	Unknown values will cause 'git fetch' to error out.
 +
 See also the `--negotiation-tip` option for linkgit:git-fetch[1].
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6a313937f8..e8def2d63c 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -54,7 +54,8 @@ merge.directoryRenames::
 	moved into the new directory.  If set to "conflict", a conflict
 	will be reported for such paths.  If merge.renames is false,
 	merge.directoryRenames is ignored and treated as false.  Defaults
-	to "conflict".
+	to "conflict" unless `feature.experimental` is enabled and the
+	default is "true".
 
 merge.renormalize::
 	Tell Git that canonical representation of files in the
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9cdcfa7324..1d66f0c992 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -112,7 +112,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames.
+	commits contain certain types of direct renames. Default is `false`
+	unless `feature.experimental` is enabled.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..912c6155b8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "repo-settings.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index d6d685cba0..1a68be1a2e 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -2,19 +2,21 @@
 #include "fetch-negotiator.h"
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
+#include "repository.h"
+#include "repo-settings.h"
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator,
-			   const char *algorithm)
+void fetch_negotiator_init(struct repository *r,
+			   struct fetch_negotiator *negotiator)
 {
-	if (algorithm) {
-		if (!strcmp(algorithm, "skipping")) {
-			skipping_negotiator_init(negotiator);
-			return;
-		} else if (!strcmp(algorithm, "default")) {
-			/* Fall through to default initialization */
-		} else {
-			die("unknown fetch negotiation algorithm '%s'", algorithm);
-		}
+	prepare_repo_settings(r);
+	switch(r->settings.fetch_negotiation_algorithm) {
+	case FETCH_NEGOTIATION_SKIPPING:
+		skipping_negotiator_init(negotiator);
+		return;
+
+	case FETCH_NEGOTIATION_DEFAULT:
+	default:
+		default_negotiator_init(negotiator);
+		return;
 	}
-	default_negotiator_init(negotiator);
 }
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index 9e3967ce66..ea78868504 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -2,6 +2,7 @@
 #define FETCH_NEGOTIATOR_H
 
 struct commit;
+struct repository;
 
 /*
  * An object that supplies the information needed to negotiate the contents of
@@ -52,7 +53,7 @@ struct fetch_negotiator {
 	void *data;
 };
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator,
-			   const char *algorithm);
+void fetch_negotiator_init(struct repository *r,
+			   struct fetch_negotiator *negotiator);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 65be043f2a..d81f47c07b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -36,7 +36,6 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
-static char *negotiation_algorithm;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 
 /* Remember to update object flag allocation in object.h */
@@ -892,12 +891,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 struct shallow_info *si,
 				 char **pack_lockfile)
 {
+	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator, negotiation_algorithm);
+	fetch_negotiator_init(r, &negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -911,7 +911,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
-	else if (args->depth > 0 || is_repository_shallow(the_repository))
+	else if (args->depth > 0 || is_repository_shallow(r))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
@@ -1379,6 +1379,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    struct shallow_info *si,
 				    char **pack_lockfile)
 {
+	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
@@ -1386,7 +1387,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator, negotiation_algorithm);
+	fetch_negotiator_init(r, &negotiator);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -1505,8 +1506,6 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
-	git_config_get_string("fetch.negotiationalgorithm",
-			      &negotiation_algorithm);
 
 	git_config(fetch_pack_config_cb, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 12300131fc..f39c31c9c4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -28,6 +28,7 @@
 #include "submodule.h"
 #include "revision.h"
 #include "commit-reach.h"
+#include "repo-settings.h"
 
 struct path_hashmap_entry {
 	struct hashmap_entry e;
@@ -3662,15 +3663,6 @@ static void merge_recursive_config(struct merge_options *opt)
 		opt->merge_detect_rename = git_config_rename("merge.renames", value);
 		free(value);
 	}
-	if (!git_config_get_string("merge.directoryrenames", &value)) {
-		int boolval = git_parse_maybe_bool(value);
-		if (0 <= boolval) {
-			opt->detect_directory_renames = boolval ? 2 : 0;
-		} else if (!strcasecmp(value, "conflict")) {
-			opt->detect_directory_renames = 1;
-		} /* avoid erroring on values from future versions of git */
-		free(value);
-	}
 	git_config(git_xmerge_config, NULL);
 }
 
@@ -3688,6 +3680,11 @@ void init_merge_options(struct merge_options *opt,
 	opt->diff_detect_rename = -1;
 	opt->merge_detect_rename = -1;
 	opt->detect_directory_renames = 1;
+
+	prepare_repo_settings(repo);
+	if (repo->settings.merge_directory_renames >= 0)
+		opt->detect_directory_renames = repo->settings.merge_directory_renames;
+
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/repo-settings.c b/repo-settings.c
index 3a5cf33814..bfb3288fda 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -35,6 +35,18 @@ void prepare_repo_settings(struct repository *r)
 		free(strval);
 	}
 
+	if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
+		r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
+	else if (!repo_config_get_string(r, "merge.directoryrenames", &strval)) {
+		if (!strcasecmp(strval, "conflict"))
+			r->settings.merge_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
+	}
+	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
+		if (!strcasecmp(strval, "skipping"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		else
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+	}
 
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
@@ -47,6 +59,11 @@ void prepare_repo_settings(struct repository *r)
 		UPDATE_DEFAULT(r->settings.index_version, 4);
 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
 	}
+	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
+		UPDATE_DEFAULT(r->settings.pack_use_sparse, 1);
+		UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
+		UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
+	}
 
 	/* Hack for test programs like test-dump-untracked-cache */
 	if (ignore_untracked_cache_config)
@@ -54,5 +71,8 @@ void prepare_repo_settings(struct repository *r)
 	else
 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
 
+	UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
+	UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
+
 	r->settings_initialized = 1;
 }
diff --git a/repo-settings.h b/repo-settings.h
index e9b028e1a9..95d3392df2 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -8,6 +8,20 @@ enum untracked_cache_setting {
 	UNTRACKED_CACHE_WRITE = 2
 };
 
+enum merge_directory_renames_setting {
+	MERGE_DIRECTORY_RENAMES_UNSET = -1,
+	MERGE_DIRECTORY_RENAMES_NONE = 0,
+	MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
+	MERGE_DIRECTORY_RENAMES_TRUE = 2,
+};
+
+enum fetch_negotiation_setting {
+	FETCH_NEGOTIATION_UNSET = -1,
+	FETCH_NEGOTIATION_NONE = 0,
+	FETCH_NEGOTIATION_DEFAULT = 1,
+	FETCH_NEGOTIATION_SKIPPING = 2,
+};
+
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
@@ -16,6 +30,8 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	enum merge_directory_renames_setting merge_directory_renames;
+	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 };
 
 struct repository;
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 8a14be51a1..f70cbcc9ca 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -60,29 +60,6 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	have_not_sent c6 c4 c3
 '
 
-test_expect_success 'unknown fetch.negotiationAlgorithm values error out' '
-	rm -rf server client trace &&
-	git init server &&
-	test_commit -C server to_fetch &&
-
-	git init client &&
-	test_commit -C client on_client &&
-	git -C client checkout on_client &&
-
-	test_config -C client fetch.negotiationAlgorithm invalid &&
-	test_must_fail git -C client fetch "$(pwd)/server" 2>err &&
-	test_i18ngrep "unknown fetch negotiation algorithm" err &&
-
-	# Explicit "default" value
-	test_config -C client fetch.negotiationAlgorithm default &&
-	git -C client -c fetch.negotiationAlgorithm=default fetch "$(pwd)/server" &&
-
-	# Implementation detail: If there is nothing to fetch, we will not error out
-	test_config -C client fetch.negotiationAlgorithm invalid &&
-	git -C client fetch "$(pwd)/server" 2>err &&
-	test_i18ngrep ! "unknown fetch negotiation algorithm" err
-'
-
 test_expect_success 'when two skips collide, favor the larger one' '
 	rm -rf server client trace &&
 	git init server &&
-- 
gitgitgadget
