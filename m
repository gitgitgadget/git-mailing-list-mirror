Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03AA91F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfFSPME (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:12:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42846 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSPMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:12:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so27698376edq.9
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpKmlNCI58s1USymbgoo+yq7OHNAkbg8D8zYmiSZEcU=;
        b=UVcOU+cEbYUSGgtvLBSa7WCloMORd3ZyJi4XWHUPsvzV8eRCFVBMk+dUPBPRqw9cB1
         tEVWNpLOpOSILtV7BhT34h1V4fBKgxqEmGIUugMTcTkimijFT56XuCSJ2NuZiLFVK8+I
         XGp8IZMA8jjnvbtZGJs9meFXccruDyM4XNXrb2IvlcWgurvL8uw0A6HbbmJ3D8kltZ1w
         x3F59ZgwrHGXA6ohZuNAIfmjfBTHOMmjBfIfqICCVW1NGGUxnTljtUMQOZ3fHkL52YD7
         Ra8g5c/hVD6HNJVSeou02jeVSBUO7N1YGydZo3lrdmS8FK01BwrK3HALUeh3wNu+uSli
         utsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KpKmlNCI58s1USymbgoo+yq7OHNAkbg8D8zYmiSZEcU=;
        b=Nu20dg36BRPf47FtzUsDlOgrKVyoz3rmvCfY13W2KwtwET7527jEHqZwUKLiNwEf9U
         SQeCIdOiA+QZiXDsGMNQdLHVWcJjLlxITEt8FmsTU1FDcT/7t/NQCpuJV0+CyMwFsSse
         tPyunWAiA2nzsezJuYP/mXuWMmk5UoLafwolljr7ZgnLKyJVUtYioAznAIfbu25Qnw1G
         MiXD+3WurAlCBfWtNsS1qIb9Jc7be1ysZGFzdDBfNGyadvlNApjsuDcVnRWTIu4TclLv
         gGAfBbk/hvPMz3iHd09l4sHp+mQLaxkzh2KO3mhPav9ydeUjZS9yBrWzO5eBOE4kKO1M
         pYVg==
X-Gm-Message-State: APjAAAXwvW0CTJVNGFJhE7VusHFuiC5AIbH86si9Wp1B5FwRRMW/0OEn
        07pmYqO4jjUPq0uKlugEoRZUu0yI
X-Google-Smtp-Source: APXvYqwvNPhu7JT3Ep6NigXy9eOu+XWAbogImS5zYkz4bhTZE7hG7n8Vr6Pr10cjZjxLtsrndneNPQ==
X-Received: by 2002:a17:906:52d8:: with SMTP id w24mr90272213ejn.269.1560957120778;
        Wed, 19 Jun 2019 08:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm1156546eja.14.2019.06.19.08.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:12:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:12:00 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 15:11:56 GMT
Message-Id: <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v2.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
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

Create a 'core.featureAdoptionRate' config setting that allows integer
values. This is a rating from 0 to 10 for the user's willingness to
adopt new or experimental features that improve Git performance.
The default is 0, meaning "don't change anything!" A value of 10
would mean "I'm willing for some behavior to change to get the
best performance I can get, and can take experimental features
in their first release." As we integrate this with more config
settings, we will make this scale more clear.

This config setting only changes the default values of other config
settings. If the setting is given explicitly, then take the
explicit value.

This change adds these two defaults when core.featureAdoptionRate
is at least three:

 * core.commitGraph=true
 * gc.writeCommitGraph=true

The use of "three or higher" for these settings means that a value
of 3 means "I'm willing to add optional features that can augment
the data on disk in favor of improved performance, but those
features should be stable after being included in multiple major
releases."

To centralize these config options and properly set the defaults,
create a repo_settings that contains chars for each config variable.
Use -1 as "unset", with 0 for false and 1 for true.

The prepare_repo_settings() method ensures that this settings
struct has been initialized, and avoids double-scanning the config
settings.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt | 21 ++++++++++++++++-
 Documentation/config/gc.txt   |  4 ++--
 Makefile                      |  1 +
 builtin/gc.c                  |  6 ++---
 commit-graph.c                |  7 +++---
 repo-settings.c               | 44 +++++++++++++++++++++++++++++++++++
 repo-settings.h               | 13 +++++++++++
 repository.h                  |  3 +++
 8 files changed, 90 insertions(+), 9 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..6a9f707815 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -577,7 +577,8 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
 	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to false. See
+	to parse the graph structure of commits. Defaults to false, unless
+	`core.featureAdoptionRate` is at least three. See
 	linkgit:git-commit-graph[1] for more information.
 
 core.useReplaceRefs::
@@ -601,3 +602,21 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
+
+core.featureAdoptionRate::
+	Set an integer value on a scale from 0 to 10 describing your
+	desire to adopt new performance features. Defaults to 0. As
+	the value increases, features are enabled by changing the
+	default values of other config settings. If a config variable
+	is specified explicitly, the explicit value will override these
+	defaults:
++
+If the value is at least 3, then the following defaults are modified.
+These represent relatively new features that have existed for multiple
+major releases, and present significant performance benefits. They do
+not modify the user-facing output of porcelain commands.
++
+* `core.commitGraph=true` enables reading commit-graph files.
++
+* `gc.writeCommitGraph=true` eneables writing commit-graph files during
+`git gc`.
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 02b92b18b5..898263209c 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -63,8 +63,8 @@ gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using `git gc --auto`
 	the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
-	for details.
+	required. Default is false, unless `core.featureAdoptionRage`
+	is at least three. See linkgit:git-commit-graph[1] for details.
 
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
index 0000000000..f7fc2a1959
--- /dev/null
+++ b/repo-settings.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "repo-settings.h"
+
+#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
+
+static int git_repo_config(const char *key, const char *value, void *cb)
+{
+	struct repo_settings *rs = (struct repo_settings *)cb;
+
+	if (!strcmp(key, "core.featureadoptionrate")) {
+		int rate = git_config_int(key, value);
+		if (rate >= 3) {
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

