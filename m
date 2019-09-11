Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B93A1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfIKPhU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 11:37:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfIKPhU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 11:37:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so25079275wrx.5
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j/wB6/dlu+MucxGNoOF610Ad6q3hdBIBCSPefp1TCdA=;
        b=DzbcER00vtw+jKuSiOHE+rPyJGolwGuPcR0gi2PwPOr3EhMh8Gos49PBtsacsy6Dr3
         VVpL5uKbexKAXz7/24f0BYlmlD2hIKUuiBo3YFZVpghtzBv7RgaPsyIjMllNiuGXIi+/
         ngGxJyB0UbASOacwkNQOUHIwF0QmI9ulOAuLJXAp4uzW77e9hPRxeiqmMe88dDIbojaT
         T8TZgUgdrm0q+/R+Bo7EZxB3cjcvsqHyrQoHfidAqTmnA5txcWXHbDEuyKyt1gUQJW+O
         bpxX/50H2qe/lO4RxEyYhgpwHaTAR2CBbNfycxb7KXcMv3oZYrEtA1DrD3esqPUFRHb9
         q3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j/wB6/dlu+MucxGNoOF610Ad6q3hdBIBCSPefp1TCdA=;
        b=qrhDh2VNzJgBKr5GWAHuhQ6rnhy6ED2M3r9JpPZPsHk5sxB4IspTS2cCRBQ9sVjgPh
         l2dvQiOYB8DnMvh+1I76YaVFffAx80HfDckPd4tERhp3b+LCDPV8u6a+dtD5tKy1fo6N
         +F9vrjXgunfKstm4jxf5OHQyYKVg3Sm+E27Cg5YZf3Iicw8IjOH0PyAtatJf4/KsPSaH
         spO86sh+NR/pKXUuKWKvspZB5T65Gl+Nw+bsuEvpKXe32YqOPtLwrwmbCMen0JqEkF/J
         mEZhExh0nFS96AnGGHnVB676pwBV2lks6Tpaej6NPYmGrm+rf9UFUWuQNvjK0MX46csa
         /U/w==
X-Gm-Message-State: APjAAAXagD/A5gwKD9gYc3A7aXkaVIHk5MjRMASqGn4tsaUiL16lThp+
        MIK5LhRp8orFerArOW2EfJKX/3iC
X-Google-Smtp-Source: APXvYqyITIkPsyq54Th0nx58Y9kwIzunb3tokzo0kHBV71UzcHKq1Z0wkZVEwE/Brn4xwbpJuNCvGA==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr30363833wro.219.1568216235979;
        Wed, 11 Sep 2019 08:37:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm20338186wrl.78.2019.09.11.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:37:15 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:37:15 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 15:37:13 GMT
Message-Id: <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.git.gitgitgadget@gmail.com>
References: <pull.337.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] multi-pack-index: add --no-progress Add --no-progress
 option to git multi-pack-index. The progress feature was added in 144d703
 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the
 ability to opt-out was overlooked.
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

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  6 +++++-
 builtin/multi-pack-index.c             | 14 +++++++++---
 midx.c                                 | 30 +++++++++++++++++---------
 midx.h                                 |  6 ++++--
 t/t5319-multi-pack-index.sh            | 30 ++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 233b2b7862..19a5a42dc0 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <subcommand>
+'git multi-pack-index' [--object-dir=<dir>] <subcommand> [--[no-]progress]
 
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
index b1ea1a6aa1..f8b2a74179 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -6,34 +6,41 @@
 #include "trace2.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>) [--[no-]progress]"),
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
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
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
@@ -47,14 +54,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	trace2_cmd_mode(argv[0]);
 
 	if (!strcmp(argv[0], "repack"))
-		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
+		return midx_repack(the_repository, opts.object_dir, 
+			(size_t)opts.batch_size, flags);
 	if (opts.batch_size)
 		die(_("--batch-size option is only for 'repack' subcommand"));
 
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(the_repository, opts.object_dir);
+		return verify_midx_file(the_repository, opts.object_dir, flags);
 	if (!strcmp(argv[0], "expire"))
 		return expire_midx_packs(the_repository, opts.object_dir);
 
diff --git a/midx.c b/midx.c
index d649644420..b1a9ad9e5b 100644
--- a/midx.c
+++ b/midx.c
@@ -1077,19 +1077,20 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(struct repository *r, const char *object_dir)
+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
 {
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
-	struct progress *progress;
+	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
 	if (!m)
 		return 0;
 
-	progress = start_progress(_("Looking for referenced packfiles"),
-				  m->num_packs);
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Looking for referenced packfiles"),
+				 	 m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
@@ -1107,8 +1108,9 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
-	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
-					 m->num_objects - 1);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Verifying OID order in MIDX"),
+						 m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -1135,13 +1137,15 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
 
-	progress = start_sparse_progress(_("Sorting objects by packfile"),
-					 m->num_objects);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Sorting objects by packfile"),
+						 m->num_objects);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
 
-	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -1316,7 +1320,7 @@ static int fill_included_packs_batch(struct repository *r,
 	return 0;
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
 	uint32_t i;
@@ -1341,6 +1345,12 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
+
+	if (flags & MIDX_PROGRESS)
+		argv_array_push(&cmd.args, "--progress");
+	else
+		argv_array_push(&cmd.args, "-q");
+
 	strbuf_release(&base_name);
 
 	cmd.git_cmd = 1;
diff --git a/midx.h b/midx.h
index f0ae656b5d..88abc85bc3 100644
--- a/midx.h
+++ b/midx.h
@@ -37,6 +37,8 @@ struct multi_pack_index {
 	char object_dir[FLEX_ARRAY];
 };
 
+#define MIDX_PROGRESS     (1 << 0)
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
@@ -49,9 +51,9 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
-int verify_midx_file(struct repository *r, const char *object_dir);
+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir);
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size);
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c72ca04399..cdc09b85f1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -169,6 +169,21 @@ test_expect_success 'verify multi-pack-index success' '
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
@@ -284,6 +299,21 @@ test_expect_success 'git-fsck incorrect offset' '
 		"git -c core.multipackindex=true fsck"
 '
 
+test_expect_success 'repack progress off for redirected stderr' '
+	git multi-pack-index repack --object-dir=$objdir 2>err &&
+	test_line_count = 0 err
+'
+
+test_expect_success 'repack force progress on for stderr' '
+	git multi-pack-index repack --object-dir=$objdir --progress 2>err &&
+	test_file_not_empty err
+'
+
+test_expect_success 'repack with the --no-progress option' '
+	git multi-pack-index repack --object-dir=$objdir --no-progress 2>err &&
+	test_line_count = 0 err
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
-- 
gitgitgadget
