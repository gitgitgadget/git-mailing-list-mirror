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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7F51F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfGVRyc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:32 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53975 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfGVRy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:28 -0400
Received: by mail-wm1-f47.google.com with SMTP id x15so36067946wmj.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qqIIXMHwUPOwywuNFKfJca6KkHvvTOqROYxhxzO+jI=;
        b=Pk5Sy7kYF7Rla5unAoE5dis3dr1jAbuUimttTs8YdJKEWbRY/KUy64f02Wp5/8sDea
         CjGS55JgcgUWjy8w+UipJz6FUzrVOpDI332YnyZZTS87ZlLeSZK3DW6SCW2wuQnJeECP
         uMxlyJYnpID6gwK2iZVd0f2y3vXBfsEZ7iDBZROLCpyuWcU6qVGxL8BfYDE8MbUJ23AJ
         kBREzongBAOMj0cGULMybNu8vu02PhkgG6A1P2EISsB+w8o3d4rIugUhtlsY/5TF7p3H
         M7i4y2Hn6DCo0oRB2hoyGbuXM+aU5mNV05KRRFZsyeQDuXg/s9UY6hRRjFNv2mkY1fo5
         mTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qqIIXMHwUPOwywuNFKfJca6KkHvvTOqROYxhxzO+jI=;
        b=jiMBMbQuS1oVuBTJCUD3rqDz44wVn+8KiWSPSDLRsWfM9dC+yZ0x1EtnquUORedQt8
         fAmgfPlY7xIOrFTsLiKcwzUFzKQtDe4xY1OSuwWmR9p78Zp3GknYhiA5xEGkuebMLO4l
         ChV+j9gIj1lgsx/hJBB2Pe3qjyvFCrxAYH7fOJCI0cmW9+Lo0THY4g8ldJlutOBcabuL
         D/VRvBdYLlwH5qNmf9qgfaMmKFchumCNOJcq6mPC4BXC0PoofK9EMyMoiOxZw2PNXPOw
         NBvdv7l8BC+azQbtsrJR3ExO8aNagScy2n5YOfLfSLaI66AsLY1WjSnINr6V1HIc9y/f
         2Sxw==
X-Gm-Message-State: APjAAAX+Troex/Rla0JatjivJ/usn3JJP/K1CVfaXB08UnP1cZHHssgO
        +exo6tKpvK/kMbfygDEZMkqL/ISb
X-Google-Smtp-Source: APXvYqyJPRjOjEMkJKPg7+xHfDFYD9cS8APbXyxMnms8pebZz2/U1e7NInJdJPo6Advz/ckXOZAlFA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr62999078wmi.16.1563818065299;
        Mon, 22 Jul 2019 10:54:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm36492356wrt.93.2019.07.22.10.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:24 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:24 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:19 GMT
Message-Id: <da7685936f44a32121ec0568df2a9f23e4003506.1563818059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] repo-settings: create feature.experimental setting
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
 Documentation/config/feature.txt     | 17 +++++++++++++++
 Documentation/config/fetch.txt       |  3 ++-
 Documentation/config/merge.txt       |  3 ++-
 Documentation/config/pack.txt        |  3 ++-
 builtin/am.c                         |  4 +++-
 fetch-negotiator.c                   | 26 +++++++++++-----------
 fetch-negotiator.h                   |  5 +++--
 fetch-pack.c                         | 11 +++++-----
 merge-recursive.c                    | 32 +++++++++++++++-------------
 merge-recursive.h                    |  1 -
 repo-settings.c                      | 32 +++++++++++++++++++++++++++-
 repo-settings.h                      | 12 ++++++++++-
 t/t5552-skipping-fetch-negotiator.sh | 23 --------------------
 13 files changed, 107 insertions(+), 65 deletions(-)

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
index 1aea657a7f..5f3ee3e6cd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "repo-settings.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -1538,7 +1539,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = their_tree_name;
-	o.detect_directory_renames = 0;
+	prepare_repo_settings(the_repository);
+	the_repository->settings->merge_directory_renames = 0;
 
 	if (state->quiet)
 		o.verbosity = 0;
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index d6d685cba0..e2990cf46e 100644
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
+	switch(r->settings->fetch_negotiation_algorithm) {
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
index 12300131fc..162d5a4753 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -28,6 +28,7 @@
 #include "submodule.h"
 #include "revision.h"
 #include "commit-reach.h"
+#include "repo-settings.h"
 
 struct path_hashmap_entry {
 	struct hashmap_entry e;
@@ -1375,10 +1376,14 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	 * there is no content merge to do; just move the file into the
 	 * desired final location.
 	 */
+	struct repository *r = the_repository;
 	const struct rename *ren = ci->ren1;
 	const struct diff_filespec *dest = ren->pair->two;
 	char *file_path = dest->path;
-	int mark_conflicted = (opt->detect_directory_renames == 1);
+	int mark_conflicted;
+
+	prepare_repo_settings(r);
+	mark_conflicted = (r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
 	assert(ren->dir_rename_original_dest);
 
 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
@@ -2850,6 +2855,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 				      struct string_list *entries,
 				      struct rename_info *ri)
 {
+	struct repository *r = the_repository;
 	struct diff_queue_struct *head_pairs, *merge_pairs;
 	struct hashmap *dir_re_head, *dir_re_merge;
 	int clean = 1;
@@ -2863,7 +2869,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	head_pairs = get_diffpairs(opt, common, head);
 	merge_pairs = get_diffpairs(opt, common, merge);
 
-	if (opt->detect_directory_renames) {
+	prepare_repo_settings(r);
+	if (r->settings->merge_directory_renames) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
@@ -3112,6 +3119,7 @@ static int handle_rename_normal(struct merge_options *opt,
 				const struct diff_filespec *b,
 				struct rename_conflict_info *ci)
 {
+	struct repository *r = the_repository;
 	struct rename *ren = ci->ren1;
 	struct merge_file_info mfi;
 	int clean;
@@ -3121,7 +3129,9 @@ static int handle_rename_normal(struct merge_options *opt,
 	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
 				     o, a, b, ci);
 
-	if (clean && opt->detect_directory_renames == 1 &&
+	prepare_repo_settings(r);
+	if (clean &&
+	    r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
 	    ren->dir_rename_original_dest) {
 		if (update_stages(opt, path,
 				  NULL,
@@ -3155,6 +3165,7 @@ static void dir_rename_warning(const char *msg,
 static int warn_about_dir_renamed_entries(struct merge_options *opt,
 					  struct rename *ren)
 {
+	struct repository *r = the_repository;
 	const char *msg;
 	int clean = 1, is_add;
 
@@ -3166,12 +3177,13 @@ static int warn_about_dir_renamed_entries(struct merge_options *opt,
 		return clean;
 
 	/* Sanity checks */
-	assert(opt->detect_directory_renames > 0);
+	prepare_repo_settings(r);
+	assert(r->settings->merge_directory_renames > 0);
 	assert(ren->dir_rename_original_type == 'A' ||
 	       ren->dir_rename_original_type == 'R');
 
 	/* Check whether to treat directory renames as a conflict */
-	clean = (opt->detect_directory_renames == 2);
+	clean = (r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE);
 
 	is_add = (ren->dir_rename_original_type == 'A');
 	if (ren->dir_rename_original_type == 'A' && clean) {
@@ -3662,15 +3674,6 @@ static void merge_recursive_config(struct merge_options *opt)
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
 
@@ -3687,7 +3690,6 @@ void init_merge_options(struct merge_options *opt,
 	opt->renormalize = 0;
 	opt->diff_detect_rename = -1;
 	opt->merge_detect_rename = -1;
-	opt->detect_directory_renames = 1;
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..b8eba244ee 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -22,7 +22,6 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-	int detect_directory_renames;
 	int diff_detect_rename;
 	int merge_detect_rename;
 	int diff_rename_limit;
diff --git a/repo-settings.c b/repo-settings.c
index 9e4b8e6268..5e9249c437 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -9,6 +9,12 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 {
 	struct repo_settings *rs = (struct repo_settings *)cb;
 
+	if (!strcmp(key, "feature.experimental")) {
+		UPDATE_DEFAULT(rs->pack_use_sparse, 1);
+		UPDATE_DEFAULT(rs->merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
+		UPDATE_DEFAULT(rs->fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
+		return 0;
+	}
 	if (!strcmp(key, "feature.manycommits")) {
 		UPDATE_DEFAULT(rs->core_commit_graph, 1);
 		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
@@ -50,6 +56,23 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 				"using 'keep' default value"), value);
 		return 0;
 	}
+	if (!strcmp(key, "merge.directoryrenames")) {
+		int bool_value = git_parse_maybe_bool(value);
+		if (0 <= bool_value) {
+			rs->merge_directory_renames = bool_value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
+		} else if (!strcasecmp(value, "conflict")) {
+			rs->merge_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
+		}
+		return 0;
+	}
+	if (!strcmp(key, "fetch.negotiationalgorithm"))	{
+		if (!strcasecmp(value, "skipping")) {
+			rs->fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		} else {
+			rs->fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+		}
+		return 0;
+	}
 
 	return 1;
 }
@@ -64,10 +87,14 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
-	r->settings->pack_use_sparse = -1;
+
 	r->settings->index_version = -1;
 	r->settings->core_untracked_cache = -1;
 
+	r->settings->pack_use_sparse = -1;
+	r->settings->merge_directory_renames = -1;
+	r->settings->fetch_negotiation_algorithm = -1;
+
 	repo_config(r, git_repo_config, r->settings);
 
 	/* Hack for test programs like test-dump-untracked-cache */
@@ -75,4 +102,7 @@ void prepare_repo_settings(struct repository *r)
 		r->settings->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
 	else
 		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACHE_KEEP);
+
+	UPDATE_DEFAULT(r->settings->merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
+	UPDATE_DEFAULT(r->settings->fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
 }
diff --git a/repo-settings.h b/repo-settings.h
index bac9b87d49..cecf7d0028 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -4,12 +4,22 @@
 #define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
 #define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
 
+#define MERGE_DIRECTORY_RENAMES_CONFLICT 1
+#define MERGE_DIRECTORY_RENAMES_TRUE 2
+
+#define FETCH_NEGOTIATION_DEFAULT 1
+#define FETCH_NEGOTIATION_SKIPPING 2
+
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
-	int pack_use_sparse;
+
 	int index_version;
 	int core_untracked_cache;
+
+	int pack_use_sparse;
+	int merge_directory_renames;
+	int fetch_negotiation_algorithm;
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
