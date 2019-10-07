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
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DDC1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfJGUIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47066 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfJGUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so16723404wrv.13
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7bzgwgdCydpgqPF6OX/Rcw8pxWIqn2f0XiBaaMLM44c=;
        b=FwYjNtiGXOofOOcJUtyQw5GCO05X3sFqp4D7wp7d2Pn4Peha+JbZ/+j75o8SQ9W1Eh
         mB4OzmDjo6ZF/j+GTuAwNDJDwYAc/mU+3L+COHo1ypRasXT+wdxC7Mpj4SQymiEAmy3e
         rMDdL2wjp8ZqHEfncw5Zgw/Pl1ybGnlEtpSlBceyl4LdHX4JZOqGIJndtN4Ecrjrm/+q
         JVebj94BkuCmFhsc9iBihHw0ViR4+6nUEodOnGPcWSoUidalKGx3dAJ91iVvRC6rJrXh
         9XoiTXPntoKCIlU0XuTD9qI3q3noR85Al+TY1hOxgn6usPWK+twMisRXa8bBir4LG0lv
         k5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7bzgwgdCydpgqPF6OX/Rcw8pxWIqn2f0XiBaaMLM44c=;
        b=PRiXVmdQ6PqPTZy+HausOb8F4t2p7PuJgSitvz3QVluoGUHRzuJBij+w533WKwmgRd
         coaihIiZ4Y0FV5AsrKEJhpaWIkXTXUXwodhXPKSjejgFFB8lYW1vBzSJmvL4NhsxjZ3i
         vFN//GTSy+3cwzu/Gn+7Vf+A9xwhzMqkyI1z1YYVaUMhjYg7mRdniSuP0/KBJzLDFf4A
         BH+ijzY131DJh7Rt+EZpDPlnHXlspRHtS7ejNU2/bwYCuWAkEbmSIRX1jYHrWDnXrHYZ
         aDOZVntuG5tGG7sIcLIcE9Y2Xk4hQS2VnaliEk1aoshtVaenpwUL8LvGNwG0d0xb/J7a
         BmHw==
X-Gm-Message-State: APjAAAUFm25F0dRhyPpF3NF6n8K4H/p6ms1f+EfxagMFBK4YNbyJUwb/
        f4rMZoSOCxYhZ/bze8mdaU2p80zi
X-Google-Smtp-Source: APXvYqwr9558j+eCqXq2ndwDYisxiToXTBab1K2q8EddPpqIdQeQnSPsuIrOJWztYVv75vOqWYWDmQ==
X-Received: by 2002:adf:fec9:: with SMTP id q9mr13277041wrs.336.1570478915704;
        Mon, 07 Oct 2019 13:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p85sm793319wme.23.2019.10.07.13.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:35 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:35 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:16 GMT
Message-Id: <a66ec1affc22829d693090af2287692e032263d3.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 08/17] sparse-checkout: add 'cone' mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
index 75538d27e7..e2d343f738 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -591,8 +591,14 @@ core.multiPackIndex::
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
index b12bf385ae..e2eb82ec45 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -88,6 +88,56 @@ using negative patterns. For example, to remove the file `unwanted`:
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
index 52d24c66ba..36fda5907b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -147,6 +147,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
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

