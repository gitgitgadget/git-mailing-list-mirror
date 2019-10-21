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
	by dcvr.yhbt.net (Postfix) with ESMTP id 876801F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfJUN4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38493 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbfJUN4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so12920738wmi.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HPCoGDbDPcDqC/pbjT+30VDXyZIKnsXuCsp2/MBOYfs=;
        b=aaBk+Sva/wOHqr5lJv/j20KbP/kGVxqjLP4RMdPDMcsrhkg6a+YBSM//Z6Mm6tJW3r
         /pdNtmOwXf2jz8y1FWsjcm6PGup346cZawZvdgtiwI03IKBos7KhNBR39+lL6jM+D5Fz
         QrY1r3OT4JwjJEs8B81xJ00uX6zPKXO2BKIqkeiM2by8ixNyD+JEvAv8I7jnletBJu0B
         rM3yx46+AliNNTwmMLJUlagDnOWOEXfNaNh3Alv+m8J90LEiKva+1q/d7Js6qDGiwGeG
         eZlBxoHIsbOrKuMp2PFyRuk/sY0oMhjo/BuBVuCxWgn1zYaB+qL0YupaGvBwtbdcQkGC
         ut4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HPCoGDbDPcDqC/pbjT+30VDXyZIKnsXuCsp2/MBOYfs=;
        b=B+Iu0o8fuKDocN43TkBeZDg4DvAAUpyjX3eKURrI6UyuT+MAxvHjIauSWscP5qUl7s
         Rzzd2qg0zZrL5Rlx5fFSUtpo3NGzEd9IOq2XZGZsxpi1t2ySdguEJltVYJ6zuEPPQedw
         OXScgQ7R9hpWqcbDnbKpzf2ES4+fkd8PADEhkCTnWaK/k/9fZwIYKZJjr8zxbbLcmYBE
         LoCsaoSwhK1wL3mSXu7Cc4zNTeHEk+qpCv605aK7TP4TEKxhyn0Bn5LOl4vNqoOs5vn+
         y9P3oCI9Yp3nketL96qy4QMZeAhBJ7d26pIg8XkabhXdE0Xjbi5NCwTGaNDFcPu6/hgY
         kMXQ==
X-Gm-Message-State: APjAAAXbO1tX3TJDGnIhE0uWbDG0yCfD63pPXgpHCsh6yJEcXjd+qdSg
        jth83xEQkCoEnJmeLm7eqhhAku0K
X-Google-Smtp-Source: APXvYqxkwReR32ocqSqlMx7Z+GC+g4iRcQHlS20K8XXWnAg2E5HeFfaxKgOj6Rj8MS20Rc5/KRWKkA==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr7480422wmb.168.1571666195413;
        Mon, 21 Oct 2019 06:56:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm15998321wra.34.2019.10.21.06.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:34 -0700 (PDT)
Message-Id: <121d878882609907cc8d13f9d76f2414b15618be.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:17 +0000
Subject: [PATCH v5 08/17] sparse-checkout: add 'cone' mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
introducing a tri-state option.

The config option does nothing right now, but will be expanded
upon in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt         | 10 ++++--
 Documentation/git-sparse-checkout.txt | 50 +++++++++++++++++++++++++++
 cache.h                               |  4 ++-
 config.c                              |  5 +++
 environment.c                         |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 14 ++++++++
 6 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 852d2ba37a..bdbbee58b9 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -593,8 +593,14 @@ core.multiPackIndex::
 	multi-pack-index design document].
 
 core.sparseCheckout::
-	Enable "sparse checkout" feature. See section "Sparse checkout" in
-	linkgit:git-read-tree[1] for more information.
+	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
+	for more information.
+
+core.sparseCheckoutCone::
+	Enables the "cone mode" of the sparse checkout feature. When the
+	sparse-checkout file contains a limited set of patterns, then this
+	mode provides significant performance advantages. See
+	linkgit:git-sparse-checkout[1] for more information.
 
 core.abbrev::
 	Set the length object names are abbreviated to.  If
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index f794d4797a..3931e4f2ad 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -92,6 +92,56 @@ using negative patterns. For example, to remove the file `unwanted`:
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
index 04cabaac11..4980ee198e 100644
--- a/cache.h
+++ b/cache.h
@@ -918,12 +918,14 @@ extern char *git_replace_ref_base;
 
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
index e7052b3977..d75f88ca0c 100644
--- a/config.c
+++ b/config.c
@@ -1364,6 +1364,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
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
index efa072680a..2a1a866659 100644
--- a/environment.c
+++ b/environment.c
@@ -67,6 +67,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_sparse_checkout_cone;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 583c232e9e..b3058d0e9b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -148,6 +148,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
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

