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
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B891F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfGVRy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38955 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfGVRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so25820624wmc.4
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KCLe0F80vzC+QHFWWQhBAqilghkzUT+PHsxap9niw5o=;
        b=W4gw+ulZ6axxmKyy1uWD8PydWUtpa6Xetr9xX7qDtWB9GVTOH2MZWaeYE/KwSjgDN8
         OzoA/j3Bc7E2pX211xHNVDbFtCnpXUkb6B6m29mwywZXQtyyoFuXLOTE/KuCf6sJyZrL
         Yiec2VkPfuCjCJTz1NvkQf1jUoSmnaHsFxVN3+zz5zacF6bJmyZxcdmeyeqCPiLldRd3
         qyCn3tQBcTcq9F5oGAGBCaMsqq82l0u/sDeL8L0XipO64vcQJn1wMIVrqmCoU+aKWYyP
         pOgwh1yKWemp6c8kbKVO7pdnu0mJ4ydOfT7t3oH/ggA+lhbM+8lPnSHwGYAVJcDdp28g
         tsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KCLe0F80vzC+QHFWWQhBAqilghkzUT+PHsxap9niw5o=;
        b=tLqBFIatpYOOgoVQvfCuMWmUi04AMuIbJM0LKBoMHlVk8mz3BFbNFvxUEd07AR5Dw4
         uE/H1OztEFUFNEQ7EymvdjDO+wrDob7WEK3le68vBp1RKsHrDZna1s964lzMIHQ3yF1G
         5u1N2DsrPsFX3OyjMWjtgsLNMKcFv1Utj6Iu2bgSV+WgdSCToi5BM7szLCkC4fSPQ4cM
         vQv5g13wmVHMDY61ChFQJpH5rhIov7l1mv2eVo/AhPU3pTav/V61amldcaFbAgxnWH1m
         uTYIztuBxoaW7U5sdGUAKJl5sBx5kUvRbgM28UiqaE+am2eaP4+VaD8XkdLW8NUL5F1F
         nSZA==
X-Gm-Message-State: APjAAAXG7bgIQ8cDN7QSyNpzfjAdX2ff0HvmyKTcXgykhnU+higq8cu2
        W70LY6GcN3SAoXFjyqpCFRoPhP19
X-Google-Smtp-Source: APXvYqyfWsAL/kVFetGEbac8Eah+FzclXWUcTdy58W4v0YGJ3fUTUbjktQwb+GxIpfkNChqW0pOlcw==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr62929163wmb.66.1563818061976;
        Mon, 22 Jul 2019 10:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm34563377wml.41.2019.07.22.10.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:21 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:21 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:15 GMT
Message-Id: <72f652b89c71526cc423e7812de66f41a079f181.1563818059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] repo-settings: consolidate some config settings
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

There are a few important config settings that are not loaded
during git_default_config. These are instead loaded on-demand.

Centralize these config options to a single scan, and store
all of the values in a repo_settings struct. The values for
each setting are initialized as negative to indicate "unset".

This centralization will be particularly important in a later
change to introduce "meta" config settings that change the
defaults for these config settings.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile               |  1 +
 builtin/gc.c           | 13 ++++++-------
 builtin/pack-objects.c |  9 +++++----
 commit-graph.c         |  7 ++++---
 read-cache.c           | 12 +++++++-----
 repo-settings.c        | 44 ++++++++++++++++++++++++++++++++++++++++++
 repo-settings.h        | 15 ++++++++++++++
 repository.h           |  3 +++
 8 files changed, 85 insertions(+), 19 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h

diff --git a/Makefile b/Makefile
index 11ccea4071..032fe9b5f9 100644
--- a/Makefile
+++ b/Makefile
@@ -964,6 +964,7 @@ LIB_OBJS += refspec.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git a/builtin/gc.c b/builtin/gc.c
index c18efadda5..243be2907b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,6 +27,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "repo-settings.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -41,7 +42,6 @@ static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
-static int gc_write_commit_graph;
 static int detach_auto = 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
@@ -148,7 +148,6 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
-	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
@@ -685,11 +684,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(),
-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
-					 NULL))
-		return 1;
+	prepare_repo_settings(the_repository);
+	if (the_repository->settings->gc_write_commit_graph == 1)
+		write_commit_graph_reachable(get_object_directory(),
+					     !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
+					     NULL);
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 267c562b1f..223038b309 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,6 +34,7 @@
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
+#include "repo-settings.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -2709,10 +2710,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "pack.usesparse")) {
-		sparse = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3332,6 +3329,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
+	prepare_repo_settings(the_repository);
+	if (!sparse && the_repository->settings->pack_use_sparse != -1)
+		sparse = the_repository->settings->pack_use_sparse;
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/commit-graph.c b/commit-graph.c
index b3c4de79b6..48e03aa285 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "repo-settings.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -466,7 +467,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
-	int config_value;
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
 		die("dying as requested by the '%s' variable on commit-graph load!",
@@ -476,9 +476,10 @@ static int prepare_commit_graph(struct repository *r)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
+	prepare_repo_settings(r);
+
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
-	    !config_value))
+	    r->settings->core_commit_graph != 1)
 		/*
 		 * This repository is not configured to use commit graphs, so
 		 * do not load one. (But report commit_graph_attempted anyway
diff --git a/read-cache.c b/read-cache.c
index c701f7f8b8..ee1aaa8917 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "repo-settings.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1599,16 +1600,17 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 
 #define INDEX_FORMAT_DEFAULT 3
 
-static unsigned int get_index_format_default(void)
+static unsigned int get_index_format_default(struct repository *r)
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
 	char *endp;
-	int value;
 	unsigned int version = INDEX_FORMAT_DEFAULT;
 
 	if (!envversion) {
-		if (!git_config_get_int("index.version", &value))
-			version = value;
+		prepare_repo_settings(r);
+
+		if (r->settings->index_version >= 0)
+			version = r->settings->index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
 			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
@@ -2765,7 +2767,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 
 	if (!istate->version) {
-		istate->version = get_index_format_default();
+		istate->version = get_index_format_default(the_repository);
 		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			init_split_index(istate);
 	}
diff --git a/repo-settings.c b/repo-settings.c
new file mode 100644
index 0000000000..13a9128f62
--- /dev/null
+++ b/repo-settings.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "repo-settings.h"
+
+static int git_repo_config(const char *key, const char *value, void *cb)
+{
+	struct repo_settings *rs = (struct repo_settings *)cb;
+
+	if (!strcmp(key, "core.commitgraph")) {
+		rs->core_commit_graph = git_config_bool(key, value);
+		return 0;
+	}
+	if (!strcmp(key, "gc.writecommitgraph")) {
+		rs->gc_write_commit_graph = git_config_bool(key, value);
+		return 0;
+	}
+	if (!strcmp(key, "pack.usesparse")) {
+		rs->pack_use_sparse = git_config_bool(key, value);
+		return 0;
+	}
+	if (!strcmp(key, "index.version")) {
+		rs->index_version = git_config_int(key, value);
+		return 0;
+	}
+
+	return 1;
+}
+
+void prepare_repo_settings(struct repository *r)
+{
+	if (r->settings)
+		return;
+
+	r->settings = xmalloc(sizeof(*r->settings));
+
+	/* Defaults */
+	r->settings->core_commit_graph = -1;
+	r->settings->gc_write_commit_graph = -1;
+	r->settings->pack_use_sparse = -1;
+	r->settings->index_version = -1;
+
+	repo_config(r, git_repo_config, r->settings);
+}
diff --git a/repo-settings.h b/repo-settings.h
new file mode 100644
index 0000000000..1151c2193a
--- /dev/null
+++ b/repo-settings.h
@@ -0,0 +1,15 @@
+#ifndef REPO_SETTINGS_H
+#define REPO_SETTINGS_H
+
+struct repo_settings {
+	int core_commit_graph;
+	int gc_write_commit_graph;
+	int pack_use_sparse;
+	int index_version;
+};
+
+struct repository;
+
+void prepare_repo_settings(struct repository *r);
+
+#endif /* REPO_SETTINGS_H */
diff --git a/repository.h b/repository.h
index 4fb6a5885f..352afc9cd8 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 #include "path.h"
 
 struct config_set;
+struct repo_settings;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -72,6 +73,8 @@ struct repository {
 	 */
 	char *submodule_prefix;
 
+	struct repo_settings *settings;
+
 	/* Subsystems */
 	/*
 	 * Repository's config which contains key-value pairs from the usual
-- 
gitgitgadget

