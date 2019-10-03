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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC231F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfJCRxg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfJCRxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so2921895wmd.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yMzdfN/I70pLOe+T+cryhZT69SZxba0nL1YRbk2ftDQ=;
        b=RqnA4JXSAJESIkw3SdTZTrcZq4JKSlyfwzimfA2AzbP/QLxE4v7s8yvX/PwDzwY8lp
         x/9WcPF5Op8GmX3TZarTjftQcj3xaDhGxhNaNAfM1Do70tms7HM5gq2l78BMNFZlr2fr
         dvOfQ24NVDSRfytDl9sAeuzB0XMJ9H95Xb/qyQbKuXj4ueaH+ld/uJGppmWo9vnoe5rr
         MEW2+pLGjGdGjE2mXDxdaU+dv65cNlikyHZVahcoaXNLl/whdan3Z4QenJU3kBykjrQY
         Rh+eN6O0AH3XqkLHAerkc8HlhjO87X3dvL9yHgMzOZV4rU2/VKviEamRVO/xSfhAC8ZH
         FUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yMzdfN/I70pLOe+T+cryhZT69SZxba0nL1YRbk2ftDQ=;
        b=Yq8pXnSJ5sNs/cZ2hmNaehcGRMoSPp1FBMw9TfuQILRDj+PlkbzoLbeAgy+iiCuyhC
         WbD+aRDJx0DQACOmpNSneoaCx4ql/THNt07/wCSUxqYHEp0y5yvCV2GePJ3QQSkyXhf7
         NIWxepK0sEkkBcwdxRd8aEViVmRd2GFtN5EIuCmdXswDoSkqbpaAfn/Ixs75zQvigGRw
         8atQGjvaK1BKAiQMlbgiXK0B0mVYArtIsdNlKtW9wkf2tBWp+p1ecYxBU9sz7uI34vMu
         fxaJxPP1HAkZG2m6trQtvM5vGHJqYXLVNzEjiUiZOLwrXUOom5obZ9x1apzg6KBDV+mA
         eXsQ==
X-Gm-Message-State: APjAAAWZv1C94McV2sPbVHSRkpyncnvsxrijoxixwvJajRtNFY9YhfbR
        TQuAUBSOQf4KZ5+dQfTHJRg8w3WF
X-Google-Smtp-Source: APXvYqx8Gn8JW8vjE6dNa2eY6UxhgRXCPpND+vY+4jDJ/qzzI+XyCFYzrlFg7rF+78kiwEUjH8nN4Q==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr2972186wmj.1.1570125212514;
        Thu, 03 Oct 2019 10:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm4423824wmh.38.2019.10.03.10.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:31 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:31 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:24 GMT
Message-Id: <cd041107defd0032043737c060a0aba1326d6ac2.1570125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/6] midx: add MIDX_PROGRESS flag
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
index 632c0c0a79..5b3623337f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -561,7 +561,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	remove_temporary_files();
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		write_midx_file(get_object_directory());
+		write_midx_file(get_object_directory(), 0);
 
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
diff --git a/midx.c b/midx.c
index d649644420..b2673f52e8 100644
--- a/midx.c
+++ b/midx.c
@@ -1017,7 +1017,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	return result;
 }
 
-int write_midx_file(const char *object_dir)
+int write_midx_file(const char *object_dir, unsigned flags)
 {
 	return write_midx_internal(object_dir, NULL, NULL);
 }
@@ -1077,7 +1077,7 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(struct repository *r, const char *object_dir)
+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
 {
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
@@ -1184,7 +1184,7 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 	return verify_midx_error;
 }
 
-int expire_midx_packs(struct repository *r, const char *object_dir)
+int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
@@ -1316,7 +1316,7 @@ static int fill_included_packs_batch(struct repository *r,
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

