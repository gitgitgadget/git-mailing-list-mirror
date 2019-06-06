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
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D7A1F609
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfFFOPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33329 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfFFOPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9so3602690edr.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q0e3aO6Nc/qE/6BhN6bK/9xnssJEzUGKsPQBm1yqWAA=;
        b=A05ASh2AV6KCZ12JXvaTl2m8tpQgc2LcwAOIms5DKB2IgS9k6tpHpE1+6Ww38Zd3Yk
         +2sm3Ik3Rm7wI2tI3IK1vvh3NU6rTPCMiPSA8tlTMB/Tkeg3PAOeCna5tfIliie9MhK8
         W2+xLVd60Ljt4QY0ed6qRlftpy6AHZfincr5ffXLnrXCos7Zfvr7/BCT8zQ5clTk5SAp
         S5MkavtvTlWqc5hwOOesQO3BL5yY5B5i/TU67aGJjxBLCGAQVDbUH/OHhGUNaMRvsMHG
         t2yFjERLXGAQ9pps4nG3kKKU51xmgXf1wyRMHVyjB5sUO+ZClMWt1YbtDypgkQZYJMc7
         2P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q0e3aO6Nc/qE/6BhN6bK/9xnssJEzUGKsPQBm1yqWAA=;
        b=qfG3Z7LxAUyglXUwNZeCQJat98tTqbk8M8ydlsdb36/XBvNfkVmu9olE+BBY3WlXIX
         eKWBOwTWQTEALFVOmZJed0cRF5SIAUBbsL1MFR9M/aFpmhHk6j4kgiT28Y9XbTbgNA5v
         kJPW8HXFouzycToxNYSmMy2W0VbS9n6mZiXOFwnqGOIrG+hhj2A7BvWUxDmcsVdptIvK
         6hOColTOhLR1XO4mDX2BcE39dyArcNkKzoWJCYwgwRccWuwdvXqThaX2Gas0+M6IQ60q
         D2upVe3S9WAcZ5HX4MvWWVu17od6huSXK+3T26Ik61OWEDuajUsWsQoFqMznF35++f9B
         gFMA==
X-Gm-Message-State: APjAAAUMyx9qjlSy801AYu3v6GvaBDJG4o7BsRo7CM+0XF48X7SG8+lX
        FKlKrFwit0Vjv9Vneg1f40mCcCP6
X-Google-Smtp-Source: APXvYqz/YNqGLpoByhAZbKlwen2bmHnUxt5S4POZVHZvFE5KkHwX5qtuyKhS/EXDfaXg9ir5cd/q0g==
X-Received: by 2002:a50:9431:: with SMTP id p46mr31692957eda.38.1559830539873;
        Thu, 06 Jun 2019 07:15:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm352748ejp.34.2019.06.06.07.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:39 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:39 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:25 GMT
Message-Id: <ac5586a20f7ed600f8912b1aed07dea5098ea046.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 12/14] commit-graph: create options for split files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The split commit-graph feature is now fully implemented, but needs
some more run-time configurability. Allow direct callers to 'git
commit-graph write --split' to specify the values used in the
merge strategy and the expire time.

Update the documentation to specify these values.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt       | 21 +++++++++++++-
 Documentation/technical/commit-graph.txt |  7 +++--
 builtin/commit-graph.c                   | 20 +++++++++++---
 builtin/commit.c                         |  2 +-
 builtin/gc.c                             |  3 +-
 commit-graph.c                           | 35 ++++++++++++++++--------
 commit-graph.h                           | 12 ++++++--
 t/t5323-split-commit-graph.sh            | 35 ++++++++++++++++++++++++
 8 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 624470e198..365e145e82 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -26,7 +26,7 @@ OPTIONS
 	Use given directory for the location of packfiles and commit-graph
 	file. This parameter exists to specify the location of an alternate
 	that only has the objects directory, not a full `.git` directory. The
-	commit-graph file is expected to be at `<dir>/info/commit-graph` and
+	commit-graph file is expected to be in the `<dir>/info` directory and
 	the packfiles are expected to be in `<dir>/pack`.
 
 
@@ -51,6 +51,25 @@ or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
++
+With the `--split` option, write the commit-graph as a chain of multiple
+commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
+not already in the commit-graph are added in a new "tip" file. This file
+is merged with the existing file if the following merge conditions are
+met:
++
+* If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
+tip file would have `N` commits and the previous tip has `M` commits and
+`X` times `N` is greater than  `M`, instead merge the two files into a
+single file.
++
+* If `--max-commits=<M>` is specified with `M` a positive integer, and the
+new tip file would have more than `M` commits, then instead merge the new
+tip with the previous tip.
++
+Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
+be the current time. After writing the split commit-graph, delete all
+unused commit-graph whose modified times are older than `datetime`.
 
 'read'::
 
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index aed4350a59..729fbcb32f 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -248,10 +248,11 @@ When writing a set of commits that do not exist in the commit-graph stack of
 height N, we default to creating a new file at level N + 1. We then decide to
 merge with the Nth level if one of two conditions hold:
 
-  1. The expected file size for level N + 1 is at least half the file size for
-     level N.
+  1. `--size-multiple=<X>` is specified or X = 2, and the number of commits in
+     level N is less than X times the number of commits in level N + 1.
 
-  2. Level N + 1 contains more than 64,0000 commits.
+  2. `--max-commits=<C>` is specified with non-zero C and the number of commits
+     in level N + 1 is more than C commits.
 
 This decision cascades down the levels: when we merge a level we create a new
 set of commits that then compares to the next level.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c2c07d3917..18e3b61fb6 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
 	NULL
 };
 
@@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
 	NULL
 };
 
@@ -135,6 +135,7 @@ static int graph_read(int argc, const char **argv)
 }
 
 extern int read_replace_refs;
+struct split_commit_graph_opts split_opts;
 
 static int graph_write(int argc, const char **argv)
 {
@@ -158,9 +159,19 @@ static int graph_write(int argc, const char **argv)
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
+		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
+			N_("maximum number of commits in a non-base split commit-graph")),
+		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
+			N_("maximum ratio between two levels of a split commit-graph")),
+		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
+			N_("maximum number of commits in a non-base split commit-graph")),
 		OPT_END(),
 	};
 
+	split_opts.size_multiple = 2;
+	split_opts.max_commits = 0;
+	split_opts.expire_time = 0;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
@@ -177,7 +188,7 @@ static int graph_write(int argc, const char **argv)
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, flags);
+		return write_commit_graph_reachable(opts.obj_dir, flags, &split_opts);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -197,7 +208,8 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    flags);
+				    flags,
+				    &split_opts);
 
 	UNLEAK(lines);
 	return result;
diff --git a/builtin/commit.c b/builtin/commit.c
index b001ef565d..9216e9c043 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,7 +1670,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0))
+	    write_commit_graph_reachable(get_object_directory(), 0, NULL))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index df2573f124..2ab590ffd4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -666,7 +666,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (gc_write_commit_graph &&
 	    write_commit_graph_reachable(get_object_directory(),
-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
+					 NULL))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index 6409e5ed8d..abbfc12f1f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -762,6 +762,8 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1;
+
+	const struct split_commit_graph_opts *split_opts;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1110,14 +1112,15 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+				 const struct split_commit_graph_opts *split_opts)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    flags);
+				    flags, split_opts);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -1492,20 +1495,25 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	return 0;
 }
 
-static int split_strategy_max_commits = 64000;
-static float split_strategy_size_mult = 2.0f;
-
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 {
 	struct commit_graph *g = ctx->r->objects->commit_graph;
 	uint32_t num_commits = ctx->commits.nr;
 	uint32_t i;
 
+	int max_commits = 0;
+	int size_mult = 2;
+
+	if (ctx->split_opts) {
+		max_commits = ctx->split_opts->max_commits;
+		size_mult = ctx->split_opts->size_multiple;
+	}
+
 	g = ctx->r->objects->commit_graph;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
-	while (g && (g->num_commits <= split_strategy_size_mult * num_commits ||
-		     num_commits > split_strategy_max_commits)) {
+	while (g && (g->num_commits <= size_mult * num_commits ||
+		    (max_commits && num_commits > max_commits))) {
 		if (strcmp(g->obj_dir, ctx->obj_dir))
 			break;
 
@@ -1673,7 +1681,10 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	DIR *dir;
 	struct dirent *de;
 	size_t dirnamelen;
-	time_t expire_time = time(NULL);
+	timestamp_t expire_time = time(NULL);
+
+	if (ctx->split_opts && ctx->split_opts->expire_time)
+		expire_time -= ctx->split_opts->expire_time;
 
 	strbuf_addstr(&path, ctx->obj_dir);
 	strbuf_addstr(&path, "/info/commit-graphs");
@@ -1716,7 +1727,8 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags)
+		       unsigned int flags,
+		       const struct split_commit_graph_opts *split_opts)
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
@@ -1731,6 +1743,7 @@ int write_commit_graph(const char *obj_dir,
 	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
+	ctx->split_opts = split_opts;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1758,8 +1771,8 @@ int write_commit_graph(const char *obj_dir,
 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;
 
-	if (ctx->split && ctx->oids.alloc > split_strategy_max_commits)
-		ctx->oids.alloc = split_strategy_max_commits;
+	if (ctx->split && split_opts && ctx->oids.alloc > split_opts->max_commits)
+		ctx->oids.alloc = split_opts->max_commits;
 
 	if (ctx->append) {
 		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
diff --git a/commit-graph.h b/commit-graph.h
index 10466bc064..194acab2b7 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -75,11 +75,19 @@ int generation_numbers_enabled(struct repository *r);
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
 #define COMMIT_GRAPH_SPLIT      (1 << 2)
 
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
+struct split_commit_graph_opts {
+	int size_multiple;
+	int max_commits;
+	timestamp_t expire_time;
+};
+
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+				 const struct split_commit_graph_opts *split_opts);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags);
+		       unsigned int flags,
+		       const struct split_commit_graph_opts *split_opts);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index c6bb685eb9..a915ef388c 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -169,4 +169,39 @@ test_expect_success 'create fork and chain across alternate' '
 
 graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
 
+test_expect_success 'test merge stragety constants' '
+	git clone . merge-2 &&
+	(
+		cd merge-2 &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --size-multiple=2 &&
+		test_line_count = 3 $graphdir/commit-graph-chain
+
+	) &&
+	git clone . merge-10 &&
+	(
+		cd merge-10 &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --size-multiple=10 &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files
+	) &&
+	git clone . merge-10-expire &&
+	(
+		cd merge-10-expire &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 15 &&
+		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 3 graph-files
+	)
+'
+
 test_done
-- 
gitgitgadget

