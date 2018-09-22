Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDC51F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIVX7g (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:36 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33808 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVX7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:35 -0400
Received: by mail-lj1-f170.google.com with SMTP id f8-v6so14843169ljk.1
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8J8dBUF4Prj9QmGpgiC4Gznkd0zFmKp3YxI06lFz/cY=;
        b=hE36PaZrlFYq6YI5uPIa6BS+aWqD0g7NsrJJ9MA1ovZ7xCC43yQ9cHn5G6a8g1wE2X
         ugoQK6dephyAJWGZgI86qqR1vDE1h1199vHCWj+XcB0enVM3DGEx+1Lzp8dnIR5oSLNm
         3LUVcoo6bksBG5TuKU8BIEpcSgynFCxgstdad0rqKbC4AigCXouHosRdGVHLP5X6YSUb
         iknddzDD8ZSJa8NmR2ohZGMTQS5TrAO2E6JDdbAj29ZXTsj4ItbKanPRit0LDq0MxJaL
         FB3DkDLZgXCM/xqEF8KN8obctPA5OHdYrJp4cxf1H66r3mMr2HiTlPZYDeZz0okxkGxW
         +AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8J8dBUF4Prj9QmGpgiC4Gznkd0zFmKp3YxI06lFz/cY=;
        b=DpYcczM623npWEF2M7yi6PLD14FINgNo5JTXJiyBgD7izbAc9oASFwYokp2K8x0Zbn
         sbrsTTiOuNItN8SBOILNJReEHFkUo02Kf8e+cyzOD+er7bR2LgfrHrjI9hD5aVL3p9vB
         kyzi5mEjERP66T4SuWxmZxSDaQ4p/I9uwfOkmaouWBiup768S4bFY6s8M6WByBCEjO/v
         Ne3XhukPLYX+Lk/nn+YXGtFYJ3m840uDNzM/UEdUUV9C8xaqaEG/xxiWbRNi8REhq9l+
         05mTIp/5I9oEwloZaw5YeOVRN5o9BvMMnE0wTfYVKy2wtpsMAL/dlg1HB+Nr+eehdo82
         YJ4w==
X-Gm-Message-State: ABuFfojRdAps7cK4usM/QaFrc6QcvQ4+4pXJfklW9SBnMYJB9grJiuaI
        U3+uO91YK7r3PXSGk3+djuCKejZS
X-Google-Smtp-Source: ACcGV62FJ8RsgvD0ypmPrPGboBXSmXfpdReyhOlvk9YLAiKrO29nMoDWaLI+Bf3IrMfTemtBlaPq1Q==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr5885038lja.149.1537639508476;
        Sat, 22 Sep 2018 11:05:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
Date:   Sat, 22 Sep 2018 20:04:54 +0200
Message-Id: <20180922180500.4689-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple worktrees are used, we need rules to determine if
something belongs to one worktree or all of them. Instead of keeping
adding rules when new stuff comes, have a generic rule:

- Inside $GIT_DIR, which is per-worktree by default, add
  $GIT_DIR/common which is always shared. New features that want to
  share stuff should put stuff under this directory.

- Inside refs/, which is shared by default except refs/bisect, add
  refs/local/ which is per-worktree. We may eventually move
  refs/bisect to this new location and remove the exception in refs
  code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitrepository-layout.txt | 11 ++++++--
 path.c                                 |  1 +
 refs.c                                 |  1 +
 refs/files-backend.c                   | 14 +++++++---
 t/t0060-path-utils.sh                  |  2 ++
 t/t1415-worktree-refs.sh               | 36 ++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 5 deletions(-)
 create mode 100755 t/t1415-worktree-refs.sh

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index e85148f05e..fad404ed7c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -95,8 +95,10 @@ refs::
 	References are stored in subdirectories of this
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
-	its subdirectories. This directory is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/refs" will be used instead.
+	its subdirectories.
+	This directory is ignored (except refs/bisect and refs/local)
+	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/refs" will be
+	used instead.
 
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
@@ -165,6 +167,11 @@ hooks::
 	each hook. This directory is ignored if $GIT_COMMON_DIR is set
 	and "$GIT_COMMON_DIR/hooks" will be used instead.
 
+common::
+	When multiple working trees are used, most of files in
+	$GIT_DIR are per-worktree with a few known exceptions. All
+	files under 'common' however will be shared between all
+	working trees.
 
 index::
 	The current index file for the repository.  It is
diff --git a/path.c b/path.c
index 34f0f98349..7eb61bf31b 100644
--- a/path.c
+++ b/path.c
@@ -108,6 +108,7 @@ struct common_dir {
 
 static struct common_dir common_list[] = {
 	{ 0, 1, 0, "branches" },
+	{ 0, 1, 0, "common" },
 	{ 0, 1, 0, "hooks" },
 	{ 0, 1, 0, "info" },
 	{ 0, 0, 1, "info/sparse-checkout" },
diff --git a/refs.c b/refs.c
index 9f7268d5fe..a851ef085b 100644
--- a/refs.c
+++ b/refs.c
@@ -624,6 +624,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/local/") ||
 		starts_with(refname, "refs/bisect/") ||
 		starts_with(refname, "refs/rewritten/");
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 16ef9325e0..416eafa453 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -269,9 +269,9 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	closedir(d);
 
 	/*
-	 * Manually add refs/bisect, which, being per-worktree, might
-	 * not appear in the directory listing for refs/ in the main
-	 * repo.
+	 * Manually add refs/bisect and refs/local, which, being
+	 * per-worktree, might not appear in the directory listing for
+	 * refs/ in the main repo.
 	 */
 	if (!strcmp(dirname, "refs/")) {
 		int pos = search_ref_dir(dir, "refs/bisect/", 12);
@@ -281,6 +281,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					dir->cache, "refs/bisect/", 12, 1);
 			add_entry_to_dir(dir, child_entry);
 		}
+
+		pos = search_ref_dir(dir, "refs/local/", 11);
+
+		if (pos < 0) {
+			struct ref_entry *child_entry = create_dir_entry(
+					dir->cache, "refs/local/", 11, 1);
+			add_entry_to_dir(dir, child_entry);
+		}
 	}
 }
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index cd74c0a471..c7b53e494b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -306,6 +306,8 @@ test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
 test_git_path GIT_COMMON_DIR=bar packed-refs              bar/packed-refs
 test_git_path GIT_COMMON_DIR=bar shallow                  bar/shallow
+test_git_path GIT_COMMON_DIR=bar common                   bar/common
+test_git_path GIT_COMMON_DIR=bar common/file              bar/common/file
 
 # In the tests below, $(pwd) must be used because it is a native path on
 # Windows and avoids MSYS's path mangling (which simplifies "foo/../bar" and
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
new file mode 100755
index 0000000000..0c2d5f89a9
--- /dev/null
+++ b/t/t1415-worktree-refs.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='per-worktree refs'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	test_commit wt1 &&
+	test_commit wt2 &&
+	git worktree add wt1 wt1 &&
+	git worktree add wt2 wt2 &&
+	git checkout initial
+'
+
+test_expect_success 'add refs/local' '
+	git update-ref refs/local/foo HEAD &&
+	git -C wt1 update-ref refs/local/foo HEAD &&
+	git -C wt2 update-ref refs/local/foo HEAD
+'
+
+test_expect_success 'refs/local must not be packed' '
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/tags/wt1 &&
+	test_path_is_file .git/refs/local/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/local/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/local/foo
+'
+
+test_expect_success 'refs/local are per-worktree' '
+	test_cmp_rev local/foo initial &&
+	( cd wt1 && test_cmp_rev local/foo wt1 ) &&
+	( cd wt2 && test_cmp_rev local/foo wt2 )
+'
+
+test_done
-- 
2.19.0.647.gb9a6049235

