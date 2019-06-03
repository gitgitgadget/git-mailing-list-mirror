Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C26D1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFCUSW (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35174 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfFCUSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so28651830edr.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bT+5IuBlg24t0fyBm0iYNv12ZUeB1OPbB0P2YzP8iBE=;
        b=h0F4T3zsDciU1wDSjwt7DUdYaPR/i0RnZ8/j+qy9Qmhdwo13agnWcNFlDXbSXoQsEt
         S98pvHle3unbJvRZ4JKQVPIjNmlE3IFcJrwGy0GLddHdIZZOTv0o/MrYaarVHJfEVdiG
         JgxfSDLuDSR7Gpeg7rQGanq9JTV5hBq7wwbNxrHtRq2OppX/5w+3dEQVxrmw8maAPy+J
         Dgbgl9KpfdLLtxeTQdELap5ODc7zDg3/22M/AZpiHAHiFdv6WMG7EauI3XJQavcw5wfO
         ujxdbXYY2kGL02gL+Mln9jVi7r1nTFk0CsPrM93nOJkVlodOOw8Hav/d9euOGTir28LL
         wcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bT+5IuBlg24t0fyBm0iYNv12ZUeB1OPbB0P2YzP8iBE=;
        b=TUt3WDc+xd+nvJNUbmUehS4M0au3H7764nvk6ChBaRaoFSZxLDRQIkeoo6cKzggp08
         lXVGHepULI+O8usvto7jgTJYjttkrevTgZjNSDoEb5HbHzW0UucNiLAaWFVufGPnqz/c
         dxb4x9Wt34/VqDWYUf0Xg0fPmVsHVkECv/yHK+GXmvoEUTbs+ACAJXTsmSRkPCFnBQUD
         Jf9q12V7yTIDD9HKlbYp3yuOEr8QQb81Gr82VrDoUNI49F9pxXBosX0nW9aPPtUiAxdv
         lW5R9jEjdhHZNl0OzlXGWiZ3kRMZKcU14RkZLyhTnEeuXAzGyKyjIA8CB0/C+jwZPGqV
         KsYw==
X-Gm-Message-State: APjAAAXpD/3SRwF882wl7+Ray+dtouAjceQHzNy5GBu9T8t9IRjUFwCq
        7OLXJWAMJ3i/SU/cB472GD+N4n/Q
X-Google-Smtp-Source: APXvYqwWYfd5IrKXaLEw4QJJ3X9ev8TwS4+6v215I9X9vSNoOUjqV4dk4VI4z+mDuqBiHDmBxPHlSg==
X-Received: by 2002:a50:fc97:: with SMTP id f23mr31314378edq.104.1559593099664;
        Mon, 03 Jun 2019 13:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm4092974edi.72.2019.06.03.13.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:19 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:19 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:07 GMT
Message-Id: <704613f4480e3b9aacab91d2241247791f34ce22.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/11] repo-settings: create repo.size=large setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Several advanced config settings are highly recommended for clients
using large repositories. Power users learn these one-by-one and
enable them as they see fit. This could be made simpler, to allow
more users to have access to these almost-always beneficial features
(and more beneficial in larger repos).

Create a 'repo.size' config setting whose only accepted value is
'large'. When a repo.size=large is given, change the default values
of some config settings. If the setting is given explicitly, then
take the explicit value.

This change adds these two defaults to the repo.size=large setting:

 * core.commitGraph=true
 * gc.writeCommitGraph=true

To centralize these config options and properly set the defaults,
create a repo_settings that contains chars for each config variable.
Use -1 as "unset", with 0 for false and 1 for true.

The prepare_repo_settings() method ensures that this settings
struct has been initialized, and avoids double-scanning the config
settings.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt | 16 +++++++++++--
 Documentation/config/gc.txt   |  4 ++--
 Makefile                      |  1 +
 builtin/gc.c                  |  6 ++---
 commit-graph.c                |  7 +++---
 repo-settings.c               | 44 +++++++++++++++++++++++++++++++++++
 repo-settings.h               | 13 +++++++++++
 repository.h                  |  3 +++
 8 files changed, 84 insertions(+), 10 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..1a188db620 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -577,8 +577,9 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
 	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to false. See
-	linkgit:git-commit-graph[1] for more information.
+	to parse the graph structure of commits. Defaults to false, unless
+	`core.size=large`. See linkgit:git-commit-graph[1] for more
+	information.
 
 core.useReplaceRefs::
 	If set to `false`, behave as if the `--no-replace-objects`
@@ -601,3 +602,14 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
+
+core.size::
+	When specified as "large", change the default values of some config
+	variables to improve performance in a large repository. If a variable
+	is specified explicitly, the explicit value will override these
+	defaults:
++
+* `core.commitGraph=true` enables reading commit-graph files.
++
+* `gc.writeCommitGraph=true` eneables writing commit-graph files during
+`git gc`.
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 02b92b18b5..680721ebbb 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -63,8 +63,8 @@ gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using `git gc --auto`
 	the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
-	for details.
+	required. Default is false, unless `core.size=large`.
+	See linkgit:git-commit-graph[1] for details.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` will print
diff --git a/Makefile b/Makefile
index 8a7e235352..2d3499d7ac 100644
--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,7 @@ LIB_OBJS += refspec.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git a/builtin/gc.c b/builtin/gc.c
index 8943bcc300..6281aad961 100644
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
@@ -685,7 +684,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	if (gc_write_commit_graph)
+	prepare_repo_settings(the_repository);
+	if (the_repository->settings->gc_write_commit_graph == 1)
 		write_commit_graph_reachable(get_object_directory(), 0,
 					     !quiet && !daemonized);
 
diff --git a/commit-graph.c b/commit-graph.c
index 7c5e54875f..b09c465a7a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "repo-settings.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -311,7 +312,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
-	int config_value;
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
 		die("dying as requested by the '%s' variable on commit-graph load!",
@@ -321,9 +321,10 @@ static int prepare_commit_graph(struct repository *r)
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
diff --git a/repo-settings.c b/repo-settings.c
new file mode 100644
index 0000000000..6f5e18d92e
--- /dev/null
+++ b/repo-settings.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "repo-settings.h"
+
+
+#define UPDATE_DEFAULT(s,v) if (s != -1) { s = v; }
+
+static int git_repo_config(const char *key, const char *value, void *cb)
+{
+	struct repo_settings *rs = (struct repo_settings *)cb;
+
+	if (!strcmp(key, "core.size")) {
+		if (!strcmp(value, "large")) {
+			UPDATE_DEFAULT(rs->core_commit_graph, 1);
+			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
+		}
+		return 0;
+	}
+	if (!strcmp(key, "core.commitgraph")) {
+		rs->core_commit_graph = git_config_bool(key, value);
+		return 0;
+	}
+	if (!strcmp(key, "gc.writecommitgraph")) {
+		rs->gc_write_commit_graph = git_config_bool(key, value);
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
+
+	repo_config(r, git_repo_config, r->settings);
+}
diff --git a/repo-settings.h b/repo-settings.h
new file mode 100644
index 0000000000..11d08648e1
--- /dev/null
+++ b/repo-settings.h
@@ -0,0 +1,13 @@
+#ifndef REPO_SETTINGS_H
+#define REPO_SETTINGS_H
+
+struct repo_settings {
+	char core_commit_graph;
+	char gc_write_commit_graph;
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

