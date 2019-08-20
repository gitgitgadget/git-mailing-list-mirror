Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DEBA1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfHTSiA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:38:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbfHTSiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:38:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so3521556wmj.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uy+96vV15QTFvP9NLKQFO0c7hYd/Wc/5tyUzFTn7nDs=;
        b=auUEFvbnDtuso6hnYzeWwGW0AHp/Nlk4QYnLVxW2aIezr1NKg1sx3rahRk1bvqyZGl
         XncFQsA3+yKOVBWV7mrNdhENXpnAncrcP3lUViKw8Q9jRGIMtB5zoGDZp/Fe9kVqm7BI
         vDxOx4ZN3A8aPUYTM1Gt2A+kVgK+rgtXZpRbqXMd989r3tOqsFUXVqCBnTKl80hQZbJY
         61+QLL3wRGxF16MqFQMyEKLPEEHtr84hRFl5BR0A+xeKunwzM0+I7SLqmDInY93fF5XA
         RC4mWNJZ+aUPiTbeXqRDTnq9ueF6IjHp0e6wjCcejBiKk1SpucNZ1h3gD63ZUMAxtOpc
         00lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uy+96vV15QTFvP9NLKQFO0c7hYd/Wc/5tyUzFTn7nDs=;
        b=j51xFp+MlumtHtq5EGfUzYRDZMpzXZZWPKVs5zCs4NUs4fss7aTKQy5CnIn+WDxgr7
         85tsRKt6jQGDeGwsOHaElUA9b4ODCvtsmnadse4KBZy8BlKwb5eFca02ir8LxYU9XIj3
         xc+PnNWaE5YR6mhdjVYI9nssJhnOJ7K+4g7Vroq57dYihO6cPLgQK4q3Ee74okYYQGuR
         LIqbJhsCt8RGUXBd+uwcv2wLvlLPxsjyByvI9Dx8vjh2TNsp7oJg+gDNQLmXUGz4aw1y
         cGnpqdPJ50r/gsBVxDjPgZsWydmzdlW4o3BMvN0fZQhQcFX2SJioNGAZ08oY9LcWLs4C
         iOEw==
X-Gm-Message-State: APjAAAURbAGt7E//66uYOWiLOCNYA+X+jKC0XJarL/SNQJJ9k0k+2c6w
        z+AXeSn9eGiAVvkUmhOycDTEfxJm
X-Google-Smtp-Source: APXvYqxtGMb5h35wDTZtMzA+ae12gLs/dlNJzjlO60itx5kgaKwJwFBUWuzbxxGAfkH1L5OlQqwBzA==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr1462044wmh.63.1566326276943;
        Tue, 20 Aug 2019 11:37:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm19814703wrx.59.2019.08.20.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:37:56 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:37:56 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 18:37:55 GMT
Message-Id: <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.315.git.gitgitgadget@gmail.com>
References: <pull.315.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-graph: add --[no-]progress to write and verify.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add --[no-]progress to git commit-graph write and verify.
The progress feature was introduced in 7b0f229
("commit-graph write: add progress output", 2018-09-17) but
the ability to opt-out was overlooked.

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Documentation/git-commit-graph.txt |  4 +++-
 builtin/commit-graph.c             | 29 +++++++++++++++++-------
 commit-graph.c                     |  7 ++++--
 t/t5318-commit-graph.sh            | 36 ++++++++++++++++++++++++++++++
 t/t5324-split-commit-graph.sh      |  2 +-
 5 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index eb5e7865f0..1256a80a81 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
-'git commit-graph verify' [--object-dir <dir>] [--shallow]
+'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -29,6 +29,8 @@ OPTIONS
 	commit-graph file is expected to be in the `<dir>/info` directory and
 	the packfiles are expected to be in `<dir>/pack`.
 
+--[no-]progress::
+	Toggle whether to show progress or not.
 
 COMMANDS
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 38027b83d9..71796910fc 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,17 +6,18 @@
 #include "repository.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "unistd.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
 	NULL
 };
 
 static const char * const builtin_commit_graph_verify_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow]"),
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	NULL
 };
 
@@ -26,7 +27,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -38,6 +39,7 @@ static struct opts_commit_graph {
 	int append;
 	int split;
 	int shallow;
+	int progress;
 } opts;
 
 static int graph_verify(int argc, const char **argv)
@@ -48,16 +50,20 @@ static int graph_verify(int argc, const char **argv)
 	int fd;
 	struct stat st;
 	int flags = 0;
-
+	int defaultProgressState = isatty(2);
+	
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			   N_("dir"),
 			   N_("The object directory to store the graph")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
+	opts.progress = defaultProgressState;
+	
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_verify_options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -66,7 +72,9 @@ static int graph_verify(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
-
+	if (opts.progress)
+		flags |= COMMIT_GRAPH_PROGRESS;
+	
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok && errno != ENOENT)
@@ -154,8 +162,9 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result = 0;
-	unsigned int flags = COMMIT_GRAPH_PROGRESS;
-
+	unsigned int flags = 0;
+	int defaultProgressState = isatty(2);
+	
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
@@ -168,6 +177,7 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
@@ -179,6 +189,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	opts.progress = defaultProgressState;
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -195,6 +206,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_APPEND;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_SPLIT;
+	if (opts.progress)
+		flags |= COMMIT_GRAPH_PROGRESS;
 
 	read_replace_refs = 0;
 
diff --git a/commit-graph.c b/commit-graph.c
index fe954ab5f8..b10d47f99a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1986,14 +1986,17 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
-	progress = start_progress(_("Verifying commits in commit graph"),
-				  g->num_commits);
+	if (flags & COMMIT_GRAPH_PROGRESS)
+		progress = start_progress(_("Verifying commits in commit graph"),
+					g->num_commits);
+
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
 		uint32_t max_generation = 0;
 
 		display_progress(progress, i + 1);
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 22cb9d6643..a98d9f88f4 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -116,6 +116,42 @@ test_expect_success 'Add more commits' '
 	git repack
 '
 
+test_expect_success 'commit-graph write progress off by default for stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'commit-graph write force progress on for stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --progress 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'commit-graph write with the --no-progress option' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --no-progress 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'commit-graph verify progress off by default for stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'commit-graph verify force progress on for stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify --progress 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'commit-graph verify with the --no-progress option' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify --no-progress 2>err &&
+	test_line_count = 0 err
+'
+
 # Current graph structure:
 #
 #   __M3___
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 99f4ef4c19..4fc3fda9d6 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -319,7 +319,7 @@ test_expect_success 'add octopus merge' '
 	git merge commits/3 commits/4 &&
 	git branch merge/octopus &&
 	git commit-graph write --reachable --split &&
-	git commit-graph verify 2>err &&
+	git commit-graph verify --progress 2>err &&
 	test_line_count = 3 err &&
 	test_i18ngrep ! warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
-- 
gitgitgadget
