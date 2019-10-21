Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7C01F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfJUSkM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33668 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbfJUSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so1973413wmf.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SvwofeYTqREFHlTGQn30PKnEAMTDsdYqWXxwdwYSFAw=;
        b=vYtfax0MFI1bNFHqvKT7/rMKyATUJRP6b0Odg54LcNReFlfY2Y1IlNRIIFMTGgkgnY
         aha067yRs9sQu04m+KH2sLiQ7NY5YjvDtjOJmC4T+tRz7hpT7CbwJIhpK3oX3pZJPBml
         1VcSUAsvSGw5EVbymG8E880+0E+uSEIunKDeq8nUXAlxFUFsKZ3Bv9Wktuk83CB9fGT9
         BchRYpP7iy7a7x7RHpxKsdOB8rBvOKmhMHYgQHwDgK2D266yvQuPH4yer/GQYrE5P0L8
         d0N1j22dvIU4I53tph/mNwpQSh+5SgOxdul6afLlmFC/fhaMl52jfKcXmdc3KGUjslL0
         RO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SvwofeYTqREFHlTGQn30PKnEAMTDsdYqWXxwdwYSFAw=;
        b=ihnU8lT5KXEbxfp2oExSKXaPjG5oaIpAbRX3cNIX5pOgiUyLFM9EnuvPpp0EpRH8zF
         y6kq2roxHd5gz+2pw4p03H8KTCiTXaObXosnE5rL/v3iQAvpietbtXSIzAquV6P/i92i
         T8tsupQJ6biW+khtrBKrZ5C+qytB+VWZ7Tpo5lN2c4BjRZazfT+uycM87KFGe6XL5Tzv
         AO4/axz69BH8JC4EdGG117iJHnUPIxde3/DuhkXA24U06xoRROAco51dpnbVu7EDoVr7
         c6hXQETx5Pp1aWq/WAfVyZczqeDqcM9l04982ljSkEa+NCLQA0p3WuaDTAqmM8lpT5mo
         KKBw==
X-Gm-Message-State: APjAAAWdeb4lv9JqRdTlZd5kWS1CLP1sYM4MefsNR9zZCfB08cCytamL
        NZl1wCFaGx8A9otwxiC+6a1J9yc3
X-Google-Smtp-Source: APXvYqyvdC5aBDWL2Z2ReW1Y4JBMNEtK3KixmMRNG04hwKkA7WUscjpGb8obFech9B4NiYKQp9zASw==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr21364091wmf.174.1571683208687;
        Mon, 21 Oct 2019 11:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm8787929wrm.26.2019.10.21.11.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:08 -0700 (PDT)
Message-Id: <ea4f869780fc95ccaf00fa9b95a0df3a53f88951.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:40:03 +0000
Subject: [PATCH v4 6/6] multi-pack-index: add [--[no-]progress] option.
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
