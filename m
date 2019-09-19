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
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAB11F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbfISOnV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54502 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfISOnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so4880330wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t/Ap4W5f4tarbhO3g+AQilFQK2ONrOzMhIiaKf4QM2A=;
        b=n3YBZ/RGOCEjiWjitquF2cYYGkeMtyfRf+pFnBstJ8++ra/iQP1tFnIaBfLMVPA0nd
         zoEu/ZQrqij8FT9Gi5HmbEnnj3VxqL9zz6Lg6QioqwI9XJpCqFAVk60+GK8A+lN0ZI0y
         /kDFgB7PJIE7s3Te3BBRfFAVG2xSOWHWl2ixeayMIDXFG3PLHhQeLj3dDXLuc9KfGumz
         iXN2sPs/IC/mQprA7/BaaVDP6JRehfLUjITwVz0nC+Q+5RVLzHLuKjr+JiI1aUG0bwac
         vSy/p9RqgP3vKA3zv3lfsK5Gnfsc0E0bpXmzq2Kx9KWMMcIn5ADy1YtgMino4bI1L+qD
         Z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t/Ap4W5f4tarbhO3g+AQilFQK2ONrOzMhIiaKf4QM2A=;
        b=laVN21I4OMN/sURJbYcy2IMXk1ZnBcKpAlPri0t3GToZ/wOQUbtwRS7V2R9SbfGVbv
         sGoDp0qIWyeN5JpxHYGy4shECFdII/gPntdvtfMzTNKJ+2GlBzfW9Ydq29lQwaFmHCym
         MiUXwGNmTgKzh73fHyl3Iekv1HQ+x7s581w/WZuL5+9QNvhnH/NDofhhoU8QQ/RqVEeK
         xqey6hc1rG4V9dM248lhAomv0wQi7xnxkutEm4UTO3FK518mmcqMmy1tBUA/CuiyUtJa
         Us1KzndpwYZjcw7DXwwYj8YZIo5T4ePeV7qNVDRidO0qSOOCP5OEGt6m0JoPKN4rNSQx
         hs5Q==
X-Gm-Message-State: APjAAAUxQmsO9V/WsfjiluhzAEDJETqHwR54onLtck9dS4FvgG/S769r
        NTQSFmz76zBjlIllYaSNI0s5Qibc
X-Google-Smtp-Source: APXvYqxYQUVkiMO2vE5DX7ULyDurZpKMhrPZdSAtOJP0VOWKyX+RS6oWPxsjtOtCvNxGQUq9orBHQA==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr3127491wmi.70.1568904196499;
        Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm8429128wmf.38.2019.09.19.07.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:05 GMT
Message-Id: <84511255d1f28e1bdcec3de6096d2d9ac2a9f483.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/11] sparse-checkout: add 'cone' mode
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

The sparse-checkout feature can have quadratic performance as
the number of patterns and number of entries in the index grow.
If there are 1,000 patterns and 1,000,000 entries, this time can
be very significant.

Create a new Boolean config option, core.sparseCheckoutCone, to
indicate that we expect the sparse-checkout file to contain a
more limited set of patterns. This is a separate config setting
from core.sparseCheckout to avoid breaking older clients by
introcuding a tri-state option.

The config option does nothing right now, but will be expanded
upon in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt         |  7 ++--
 Documentation/git-sparse-checkout.txt | 50 +++++++++++++++++++++++++++
 cache.h                               |  4 ++-
 config.c                              |  5 +++
 environment.c                         |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 14 ++++++++
 6 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..9b8ab2a6d4 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -591,8 +591,11 @@ core.multiPackIndex::
 	multi-pack-index design document].
 
 core.sparseCheckout::
-	Enable "sparse checkout" feature. See section "Sparse checkout" in
-	linkgit:git-read-tree[1] for more information.
+	Enable "sparse checkout" feature. If "false", then sparse-checkout
+	is disabled. If "true", then sparse-checkout is enabled with the full
+	.gitignore pattern set. If "cone", then sparse-checkout is enabled with
+	a restricted pattern set. See linkgit:git-sparse-checkout[1] for more
+	information.
 
 core.abbrev::
 	Set the length object names are abbreviated to.  If
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index da95b28b1c..757326618d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -87,6 +87,56 @@ using negative patterns. For example, to remove the file `unwanted`:
 ----------------
 
 
+## CONE PATTERN SET
+
+The full pattern set allows for arbitrary pattern matches and complicated
+inclusion/exclusion rules. These can result in O(N*M) pattern matches when
+updating the index, where N is the number of patterns and M is the number
+of paths in the index. To combat this performance issue, a more restricted
+pattern set is allowed when `core.spareCheckoutCone` is enabled.
+
+The accepted patterns in the cone pattern set are:
+
+1. *Recursive:* All paths inside a directory are included.
+
+2. *Parent:* All files immediately inside a directory are included.
+
+In addition to the above two patterns, we also expect that all files in the
+root directory are included. If a recursive pattern is added, then all
+leading directories are added as parent patterns.
+
+By default, when running `git sparse-checkout init`, the root directory is
+added as a parent pattern. At this point, the sparse-checkout file contains
+the following patterns:
+
+```
+/*
+!/*/
+```
+
+This says "include everything in root, but nothing two levels below root."
+If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
+`A/B` are added as parent patterns. The resulting sparse-checkout file is
+now
+
+```
+/*
+!/*/
+/A/
+!/A/*/
+/A/B/
+!/A/B/*/
+/A/B/C/
+```
+
+Here, order matters, so the negative patterns are overridden by the positive
+patterns that appear lower in the file.
+
+If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
+expecting patterns of these types. Git will warn if the patterns do not match.
+If the patterns do match the expected format, then Git will use faster hash-
+based algorithms to compute inclusion in the sparse-checkout.
+
 SEE ALSO
 --------
 
diff --git a/cache.h b/cache.h
index cf5d70c196..8e8ea67efa 100644
--- a/cache.h
+++ b/cache.h
@@ -911,12 +911,14 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
-extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
 
+int core_apply_sparse_checkout;
+int core_sparse_checkout_cone;
+
 /*
  * Include broken refs in all ref iterations, which will
  * generally choke dangerous operations rather than letting
diff --git a/config.c b/config.c
index 296a6d9cc4..f65c74f5b7 100644
--- a/config.c
+++ b/config.c
@@ -1329,6 +1329,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.sparsecheckoutcone")) {
+		core_sparse_checkout_cone = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 89af47cb85..670d92bcc0 100644
--- a/environment.c
+++ b/environment.c
@@ -69,6 +69,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_sparse_checkout_cone;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 22fa032d6d..9b089c98c4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -140,6 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: match patterns' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	rm -rf repo/a repo/folder1 repo/folder2 &&
+	git -C repo read-tree -mu HEAD &&
+	git -C repo reset --hard &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_expect_success 'sparse-checkout disable' '
 	git -C repo sparse-checkout disable &&
 	test_path_is_missing repo/.git/info/sparse-checkout &&
-- 
gitgitgadget

