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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DE71F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfJUSkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfJUSkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so15155063wro.7
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4pth2CkARhKtWPSHhwE8qNmUBYG37d//Xo/IsFWNM0I=;
        b=nR3Z0BNUwkVi6rSiMcxq62SZg+D4sZkgvoqMaZmLVIBOLkvCOH32CMDKA2v3VLgxRJ
         VtWJYtxqI8qXsR/lIsTuAyc+WofGfckNT/YPTmybfKf7x0MTIQFuI6PK/uzwPPSxufaK
         89HwZMMDT/npfVwEQGNKmkkze9CGI5EVXwQE6MLXVnr4G4Y1U8rk8SyJZgljFXUd14wm
         PInFu9rzZdMwVqY5pAz2cgctN6vLKIKU6+PAOfayUc1WWtFkvGjaGVBDBNfhJBq9MsO0
         bVP9GkKYm+mQHmT583mOSKyZAUDPM6q71rmHo6+lmGTp/MmSh/yz90n/jOhz725pyU+u
         hDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4pth2CkARhKtWPSHhwE8qNmUBYG37d//Xo/IsFWNM0I=;
        b=LYIITq9hqTsxzuh2vJqt/tq7jytwOqhN4LaWaDN1snBW+A3gvPdJKLFHBUVlcwxXW1
         wGX/1dZaepiOGUYc80WvwsPGHFydEFlAVPepGPf4lEtScxWk3RVHF4Fp/yFdIUT8VQEc
         PuwH+0kHrby2v2zw76xn72oL9yrX3dKxUK0xmb0AflbTnZpkjsYKcxJOyD16eHJGQ9xn
         lMTEiQILoGZb9YwGoK2EPLthEPqgLugI59+3Vc6JHNUSfRkKltOE1qZ/BkPjSwwRfDc+
         fVmQNLmPzQk/h9sUNRSYTh5N15lLQ/p3hu9Sxt4ASOxsRKxzCpWudC44/1ltlZ+PsMP7
         yVeA==
X-Gm-Message-State: APjAAAXoIPW16QY15B4OYLVm181Jj42vRIxhrrbszv9CQ2a+QgpT0QEj
        FmsB0d3/PYxk8XtBirMngA9v0Yhi
X-Google-Smtp-Source: APXvYqzTjoHqj71BF4AKC1K+wTK0wpd61O53MjI2CURiTu9CW93iz0ZrByu640HeFU29tyr66RRV6w==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7489000wrs.366.1571683205170;
        Mon, 21 Oct 2019 11:40:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q124sm28787702wma.5.2019.10.21.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:04 -0700 (PDT)
Message-Id: <e7b1cc633bc8f5dbdb4f113456d20f1f11476662.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:39:58 +0000
Subject: [PATCH v4 1/6] midx: add MIDX_PROGRESS flag
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

Add the MIDX_PROGRESS flag and update the
write|verify|expire|repack functions in midx.h
to accept a flags parameter.  The MIDX_PROGRESS
flag indicates whether the caller of the function
would like progress information to be displayed.
This patch only changes the method prototypes
and does not change the functionality. The
functionality change will be handled by a later patch.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 builtin/multi-pack-index.c |  8 ++++----
 builtin/repack.c           |  2 +-
 midx.c                     |  8 ++++----
 midx.h                     | 10 ++++++----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index b1ea1a6aa1..e86b8cd17d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -47,16 +47,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	trace2_cmd_mode(argv[0]);
 
 	if (!strcmp(argv[0], "repack"))
-		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
+		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size, 0);
 	if (opts.batch_size)
 		die(_("--batch-size option is only for 'repack' subcommand"));
 
 	if (!strcmp(argv[0], "write"))
-		return write_midx_file(opts.object_dir);
+		return write_midx_file(opts.object_dir, 0);
 	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(the_repository, opts.object_dir);
+		return verify_midx_file(the_repository, opts.object_dir, 0);
 	if (!strcmp(argv[0], "expire"))
-		return expire_midx_packs(the_repository, opts.object_dir);
+		return expire_midx_packs(the_repository, opts.object_dir, 0);
 
 	die(_("unrecognized subcommand: %s"), argv[0]);
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index 094c2f8ea4..397081d568 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -562,7 +562,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	remove_temporary_files();
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		write_midx_file(get_object_directory());
+		write_midx_file(get_object_directory(), 0);
 
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
diff --git a/midx.c b/midx.c
index f29afc0d2d..f169a681dd 100644
--- a/midx.c
+++ b/midx.c
@@ -1016,7 +1016,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	return result;
 }
 
-int write_midx_file(const char *object_dir)
+int write_midx_file(const char *object_dir, unsigned flags)
 {
 	return write_midx_internal(object_dir, NULL, NULL);
 }
@@ -1076,7 +1076,7 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(struct repository *r, const char *object_dir)
+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
 {
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
@@ -1183,7 +1183,7 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 	return verify_midx_error;
 }
 
-int expire_midx_packs(struct repository *r, const char *object_dir)
+int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
@@ -1315,7 +1315,7 @@ static int fill_included_packs_batch(struct repository *r,
 	return 0;
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
 	uint32_t i;
diff --git a/midx.h b/midx.h
index f0ae656b5d..e6fa356b5c 100644
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
@@ -47,11 +49,11 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-int write_midx_file(const char *object_dir);
+int write_midx_file(const char *object_dir, unsigned flags);
 void clear_midx_file(struct repository *r);
-int verify_midx_file(struct repository *r, const char *object_dir);
-int expire_midx_packs(struct repository *r, const char *object_dir);
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size);
+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
+int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
 
 void close_midx(struct multi_pack_index *m);
 
-- 
gitgitgadget

