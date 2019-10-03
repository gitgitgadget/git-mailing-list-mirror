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
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C2D1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfJCRxk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40890 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJCRxk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so2996607wmj.5
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SvwofeYTqREFHlTGQn30PKnEAMTDsdYqWXxwdwYSFAw=;
        b=cYD5kxvrO2yyWjwMzoYgi2t2o7s/BeHQnyuhrZNRlXOxDhdg0DOEO2MDrccy37q04f
         5dEZobq+ZvDHN7Q5f2deV9sypXLf9SsFVHQgyFrWIKbHl1xu5et2PgV7WP9QLnvml21J
         SPvb2e3jy7EdXjVSYtbKEp2AHtbQL82jQcHDslk9Bti8mWC+DSywH5WSxWAJ2sAUlRDv
         hyW8JOxIxhmoHo0uF6sXSOB0J7pVnGTddQlqfnZUdJsnLgz2k+5YHQikODpsKLOecGRV
         FaK5JVzdkUmmk1piG/H6jUUF2r8ptFg6ehATBQhRYR8WyaY51UklXOQ9SpWMtvEYLOIw
         7R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SvwofeYTqREFHlTGQn30PKnEAMTDsdYqWXxwdwYSFAw=;
        b=Y7JXLxcy3u120Y7pLTiEUjSAiMXV1oTmlP9xMOuRdf2G0zV0eYsRgoAiN2Q+NhrA6g
         GIuBVXvlxfUi8DEqrIHEd9ujLkSo/NwMR+VK17aU68WBu3DB5/tGx1f5nE/BZ1R7OTiB
         YK7CzDbqQz9I9pD7IESRThHka+IeYO/RfqV9nZRVxyCXT/oTzvVUZPxP1t8KU8RHFqAN
         xRHR229dQ1lsXNYf/yfX3tcsEz6+51nnx//9vK96Rp8hfwF1NQMZMWEg5B+enmtyDYW4
         A9Way40WmzXv1ck2EFb7O3Qsa5lzkLLX0OxU0vYevMDBBHEq1ysH26pySaTbH5cnEHfD
         rSwQ==
X-Gm-Message-State: APjAAAWWoq977e8QZhWSU6UO+OM7kSx26PVTU5bRAVwGuuJOLEb0t1SB
        d5Va5xP2ypo9wCIznu2tE6zTbQGz
X-Google-Smtp-Source: APXvYqxWVMWmr7I1B11qXqFd6NeLikzZmf79JfGhSUJLxbKUx3AJlENWl56Rda32zQwQQmDS2ncrvw==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr7488384wmr.47.1570125216526;
        Thu, 03 Oct 2019 10:53:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm6174750wrh.46.2019.10.03.10.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:36 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:36 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:29 GMT
Message-Id: <a3c50948d9df62c18228c4c1a1a99da1250237c2.1570125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/6] multi-pack-index: add [--[no-]progress] option.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Add the --[no-]progress option to git multi-pack-index.
Pass the MIDX_PROGRESS flag to the subcommand functions
when progress should be displayed by multi-pack-index.
The progress feature was added to 'verify' in 144d703
("multi-pack-index: report progress during 'verify'", 2018-09-13)
but some subcommands were not updated to display progress, and
the ability to opt-out was overlooked.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  6 ++-
 builtin/multi-pack-index.c             | 18 +++++--
 t/t5319-multi-pack-index.sh            | 69 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 233b2b7862..d7a02cc6fa 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <subcommand>
+'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress] <subcommand>
 
 DESCRIPTION
 -----------
@@ -23,6 +23,10 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+--[no-]progress::
+	Turn progress on/off explicitly. If neither is specified, progress is 
+	shown if standard error is connected to a terminal.
+
 The following subcommands are available:
 
 write::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index e86b8cd17d..1730b21901 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -6,21 +6,25 @@
 #include "trace2.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
+	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
 	NULL
 };
 
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
+	int progress;
 } opts;
 
 int cmd_multi_pack_index(int argc, const char **argv,
 			 const char *prefix)
 {
+	unsigned flags = 0;
+
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
@@ -28,12 +32,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
+	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage, 0);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
+	if (opts.progress)
+		flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
@@ -47,16 +54,17 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	trace2_cmd_mode(argv[0]);
 
 	if (!strcmp(argv[0], "repack"))
-		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size, 0);
+		return midx_repack(the_repository, opts.object_dir, 
+			(size_t)opts.batch_size, flags);
 	if (opts.batch_size)
 		die(_("--batch-size option is only for 'repack' subcommand"));
 
 	if (!strcmp(argv[0], "write"))
-		return write_midx_file(opts.object_dir, 0);
+		return write_midx_file(opts.object_dir, flags);
 	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(the_repository, opts.object_dir, 0);
+		return verify_midx_file(the_repository, opts.object_dir, flags);
 	if (!strcmp(argv[0], "expire"))
-		return expire_midx_packs(the_repository, opts.object_dir, 0);
+		return expire_midx_packs(the_repository, opts.object_dir, flags);
 
 	die(_("unrecognized subcommand: %s"), argv[0]);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c72ca04399..cd2f87be6a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -147,6 +147,21 @@ test_expect_success 'write midx with two packs' '
 
 compare_results_with_midx "two packs"
 
+test_expect_success 'write progress off for redirected stderr' '
+	git multi-pack-index --object-dir=$objdir write 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'write force progress on for stderr' '
+	git multi-pack-index --object-dir=$objdir --progress write 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'write with the --no-progress option' '
+	git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
+	test_line_count = 0 err
+'
+
 test_expect_success 'add more packs' '
 	for j in $(test_seq 11 20)
 	do
@@ -169,6 +184,21 @@ test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
 
+test_expect_success 'verify progress off for redirected stderr' '
+	git multi-pack-index verify --object-dir=$objdir 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'verify force progress on for stderr' '
+	git multi-pack-index verify --object-dir=$objdir --progress 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'verify with the --no-progress option' '
+	git multi-pack-index verify --object-dir=$objdir --no-progress 2>err &&
+	test_line_count = 0 err
+'
+
 # usage: corrupt_midx_and_verify <pos> <data> <objdir> <string>
 corrupt_midx_and_verify() {
 	POS=$1 &&
@@ -284,6 +314,21 @@ test_expect_success 'git-fsck incorrect offset' '
 		"git -c core.multipackindex=true fsck"
 '
 
+test_expect_success 'repack progress off for redirected stderr' '
+	git multi-pack-index --object-dir=$objdir repack 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'repack force progress on for stderr' '
+	git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'repack with the --no-progress option' '
+	git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
+	test_line_count = 0 err
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
@@ -413,6 +458,30 @@ test_expect_success 'expire does not remove any packs' '
 	)
 '
 
+test_expect_success 'expire progress off for redirected stderr' '
+	(
+		cd dup &&
+		git multi-pack-index expire 2>err &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success 'expire force progress on for stderr' '
+	(
+		cd dup &&
+		git multi-pack-index --progress expire 2>err &&
+		test_file_not_empty err
+	)
+'
+
+test_expect_success 'expire with the --no-progress option' '
+	(
+		cd dup &&
+		git multi-pack-index --no-progress expire 2>err &&
+		test_line_count = 0 err
+	)
+'
+
 test_expect_success 'expire removes unreferenced packs' '
 	(
 		cd dup &&
-- 
gitgitgadget
