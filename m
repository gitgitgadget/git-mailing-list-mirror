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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA091F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG3Tfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50592 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfG3Tfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so58312108wml.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wSjLATlje7BBQn1lgDkHqeH/4H/E84eEP8u+Oxm9r+U=;
        b=ZPnxTbbK6Hgun1uWADzRvztEyZR0SxsxShR9ARGJy8mdJ6ucr4tapbaHZLd1Z5jg7w
         45RVsXejtxIYf4o4f4/s95mL8Ik/t37Xfy/5x43LNeFoxhZ4cxUJ7Ri4AVCwd1B0lqNZ
         JDyL4mK4Xc+PzItMfCpfYcNXA/pV0ucO2lGjhAfkFBDXXO/1SpJPhuDMNZ7varnVeWbu
         VSJQYaBmShBtX3LWk7ezGmaLc5+6DzWU7eh/SjFlF2ntI+JdpoeS/KkmJ6vQW9v3yWgv
         U6rOAueTjQyNa4ncQYIkwuvMhp0GNa5QN31HC1u8CNMD9h5y3oSwPYBZseh+bSLm0Z+I
         fbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wSjLATlje7BBQn1lgDkHqeH/4H/E84eEP8u+Oxm9r+U=;
        b=dj1zaHe7o88iNpo6V5QDwe+0Wi9ON1IqEvwkzx0QBXCaqcT+TJ8yhhE+iiiJRVwJvL
         N+BZh824Al45Vq3C/tn9bBkdhjiv4azkJFFiUn9TW6rhfo/dINNjV0Suw+0q7kDK2XB4
         q0xYNlmVF7HdhJorFmBeZLhgtG2fOAY3MpviZaEBm0sE4EzwRLmUQYBf5l/lcF1amKNN
         xmHGr/3VYdMPqt2Rk+tMr5XG+aRYfrfQpitvQOuGvAm1VlISFK0/6SdGeA/oC+mAjmoL
         YY5g2Tfo3Ds4UWeSWtn/mCDmzhO+BOk1q1yeXSOA8xxlRsC6DNFud6rR7Z7wPkv28ljD
         Y6oA==
X-Gm-Message-State: APjAAAUau57WsvWcXQ9YmPvurxbkpq74Y6nV0nsxz9iThQ+7M477Exhy
        bJdd4b1uX3nimp3Ctmpt2EiBuduS
X-Google-Smtp-Source: APXvYqx1N28hbMssxkWyN0K4S8st3w9Faj1d7EbbKwl2LCTbuJCipK2XRiXq32+9ifr40rgi3CT8RA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr104794538wmh.100.1564515326834;
        Tue, 30 Jul 2019 12:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm49919310wma.32.2019.07.30.12.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:35:26 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:35:26 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Jul 2019 19:35:20 GMT
Message-Id: <4d0db57ecb4d241b61ba1f9c6f23aedc6b9bb4d9.1564515324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v3.git.gitgitgadget@gmail.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/5] repo-settings: consolidate some config settings
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
 builtin/gc.c           | 12 +++++-------
 builtin/pack-objects.c |  8 ++++----
 commit-graph.c         |  6 +++---
 read-cache.c           | 11 ++++++-----
 repo-settings.c        | 25 +++++++++++++++++++++++++
 repository.h           | 15 +++++++++++++++
 7 files changed, 59 insertions(+), 19 deletions(-)
 create mode 100644 repo-settings.c

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
index c18efadda5..4b8fbb9965 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,7 +41,6 @@ static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
-static int gc_write_commit_graph;
 static int detach_auto = 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
@@ -148,7 +147,6 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
-	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
@@ -685,11 +683,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(),
-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
-					 NULL))
-		return 1;
+	prepare_repo_settings(the_repository);
+	if (the_repository->settings.gc_write_commit_graph == 1)
+		write_commit_graph_reachable(get_object_directory(),
+					     !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
+					     NULL);
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 267c562b1f..f9f7181f3f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2709,10 +2709,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
@@ -3332,6 +3328,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
+	prepare_repo_settings(the_repository);
+	if (!sparse && the_repository->settings.pack_use_sparse != -1)
+		sparse = the_repository->settings.pack_use_sparse;
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/commit-graph.c b/commit-graph.c
index b3c4de79b6..7854e491b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -466,7 +466,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
-	int config_value;
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
 		die("dying as requested by the '%s' variable on commit-graph load!",
@@ -476,9 +475,10 @@ static int prepare_commit_graph(struct repository *r)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
+	prepare_repo_settings(r);
+
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
-	    !config_value))
+	    r->settings.core_commit_graph != 1)
 		/*
 		 * This repository is not configured to use commit graphs, so
 		 * do not load one. (But report commit_graph_attempted anyway
diff --git a/read-cache.c b/read-cache.c
index c701f7f8b8..59dbebc15d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1599,16 +1599,17 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 
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
+		if (r->settings.index_version >= 0)
+			version = r->settings.index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
 			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
@@ -2765,7 +2766,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 
 	if (!istate->version) {
-		istate->version = get_index_format_default();
+		istate->version = get_index_format_default(the_repository);
 		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			init_split_index(istate);
 	}
diff --git a/repo-settings.c b/repo-settings.c
new file mode 100644
index 0000000000..309577f6bc
--- /dev/null
+++ b/repo-settings.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+
+void prepare_repo_settings(struct repository *r)
+{
+	int value;
+
+	if (r->settings.initialized)
+		return;
+
+	/* Defaults */
+	memset(&r->settings, -1, sizeof(r->settings));
+
+	if (!repo_config_get_bool(r, "core.commitgraph", &value))
+		r->settings.core_commit_graph = value;
+	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
+		r->settings.gc_write_commit_graph = value;
+
+	if (!repo_config_get_bool(r, "index.version", &value))
+		r->settings.index_version = value;
+
+	if (!repo_config_get_bool(r, "pack.usesparse", &value))
+		r->settings.pack_use_sparse = value;
+}
diff --git a/repository.h b/repository.h
index 4fb6a5885f..2bb2bc3eea 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 #include "path.h"
 
 struct config_set;
+struct repo_settings;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -11,6 +12,17 @@ struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
 
+struct repo_settings {
+	int initialized;
+
+	int core_commit_graph;
+	int gc_write_commit_graph;
+
+	int index_version;
+
+	int pack_use_sparse;
+};
+
 struct repository {
 	/* Environment */
 	/*
@@ -72,6 +84,8 @@ struct repository {
 	 */
 	char *submodule_prefix;
 
+	struct repo_settings settings;
+
 	/* Subsystems */
 	/*
 	 * Repository's config which contains key-value pairs from the usual
@@ -157,5 +171,6 @@ int repo_read_index_unmerged(struct repository *);
  */
 void repo_update_index_if_able(struct repository *, struct lock_file *);
 
+void prepare_repo_settings(struct repository *r);
 
 #endif /* REPOSITORY_H */
-- 
gitgitgadget

