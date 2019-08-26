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
	by dcvr.yhbt.net (Postfix) with ESMTP id 295DB1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfHZQaD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:30:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38233 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732827AbfHZQaC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:30:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so134157wmm.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mCb+1cnFjNqkNpJrYQ8zOPM/eF8rHm5XQidZBbGYkQs=;
        b=grcc9ETHt3rB7NZ6tuTiVRrneoaag+LJ75+cke56ZIqWB+RIFmEm8+yssNlQABiZ67
         8l57wYXH27LSshRymO27WnwEkMi5zFLDxKOcaGoM7IYz6seP7EajZx0xRb6sm5EO1/06
         SllwyYIEnU+fuLD7zSAcKDLH8OpJqryo2s5PiaBBU+kdJAzuAbRf1RutCi9YK7MYvnd5
         FYAmNDNiW26qOq3qY3Eve5BTgkqdnjgsHuPN2pZRnWW5Ik1UTxfnoDgbocEcHBs0ZG3Z
         runo3qT4wwPY4CKBgkzBTTQiNRJ71tTa7b2hW/sX0wUV3Ogv+pfvVmA5EhJqgY5uojxC
         hvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mCb+1cnFjNqkNpJrYQ8zOPM/eF8rHm5XQidZBbGYkQs=;
        b=B/ZdFy9MFOeAWjfMCFtneI3pPSbLs989NkMsy62/iYyGPcQ9Ux3E5UVkdUbnUakecX
         HUX1pip3DjnpZ8Ls2pOBb4mABNeO7BGYKhPSxSzLs73PwmdrDyGwq66JsbDOHlYwF+6i
         1rLx0DCzrjc5NwfdGNV2zkWNqUUDn5sUcTvUk2VRytQxO7JkAW6lHGfAoreHlUyTw2kl
         e8E0leR1ZQLerccb4021Q+UsrqiER14LvDpjaPyEPKeUXlv3ZxN3socAcx6MOdT1VSUL
         zvA0g/ZES+U3/FKGK6kzAR/cHHZmeH0JRtxq4cEYz0lLpnuw44XBNeDXqCdKCcLdNKy4
         GpxQ==
X-Gm-Message-State: APjAAAU/9SmjwnLF9JKShYxHmRKpq6GbtvvAioesPHl2qy4mZAUUl2rw
        IPxv+bp/jeiBVI/5V7HWU8hXXpUc++Y=
X-Google-Smtp-Source: APXvYqxNaziQDjecZke5ZcibsLPeFGdl2K5VQZwGKP6xIwdCoj7YLg1Bsuamc59V2tC3746Lcyvwyw==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr21683808wmh.173.1566836999293;
        Mon, 26 Aug 2019 09:29:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm7747wmz.16.2019.08.26.09.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:29:58 -0700 (PDT)
Date:   Mon, 26 Aug 2019 09:29:58 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 16:29:57 GMT
Message-Id: <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.315.v2.git.gitgitgadget@gmail.com>
References: <pull.315.git.gitgitgadget@gmail.com>
        <pull.315.v2.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] commit-graph: add --[no-]progress to write and verify.
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
 Documentation/git-commit-graph.txt |  7 ++++--
 builtin/commit-graph.c             | 21 ++++++++++++-----
 commit-graph.c                     |  6 +++--
 t/t5318-commit-graph.sh            | 36 ++++++++++++++++++++++++++++++
 t/t5324-split-commit-graph.sh      |  2 +-
 5 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index eb5e7865f0..ca0b1a683f 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
-'git commit-graph verify' [--object-dir <dir>] [--shallow]
-'git commit-graph write' <options> [--object-dir <dir>]
+'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
+'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
 
 
 DESCRIPTION
@@ -29,6 +29,9 @@ OPTIONS
 	commit-graph file is expected to be in the `<dir>/info` directory and
 	the packfiles are expected to be in `<dir>/pack`.
 
+--[no-]progress::
+	Turn progress on/off explicitly. If neither is specified, progress is 
+	shown if standard error is connected to a terminal.
 
 COMMANDS
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 57863619b7..faf349a6c1 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,13 +10,13 @@
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
 
@@ -26,7 +26,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -38,6 +38,7 @@ static struct opts_commit_graph {
 	int append;
 	int split;
 	int shallow;
+	int progress;
 } opts;
 
 static int graph_verify(int argc, const char **argv)
@@ -55,9 +56,11 @@ static int graph_verify(int argc, const char **argv)
 			   N_("The object directory to store the graph")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
+	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_verify_options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -66,7 +69,9 @@ static int graph_verify(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
-
+	if (opts.progress)
+		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+	
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok && errno != ENOENT)
@@ -154,7 +159,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result = 0;
-	enum commit_graph_write_flags flags = COMMIT_GRAPH_WRITE_PROGRESS;
+	enum commit_graph_write_flags flags = 0;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -168,6 +173,7 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
@@ -179,6 +185,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	opts.progress = isatty(2);
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -195,6 +202,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
+	if (opts.progress)
+		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	read_replace_refs = 0;
 
diff --git a/commit-graph.c b/commit-graph.c
index f2888c203b..2802f2ade6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1992,8 +1992,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
-	progress = start_progress(_("Verifying commits in commit graph"),
-				  g->num_commits);
+	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+		progress = start_progress(_("Verifying commits in commit graph"),
+					g->num_commits);
+
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ab3eccf0fa..df3fed3a08 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -124,6 +124,42 @@ test_expect_success 'Add more commits' '
 	git repack
 '
 
+test_expect_success 'commit-graph write progress off for redirected stderr' '
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
+test_expect_success 'commit-graph verify progress off for redirected stderr' '
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
