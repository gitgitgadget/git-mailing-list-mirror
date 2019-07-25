Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A971F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfGYKLY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42168 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfGYKLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so204921wrr.9
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RMedZnkPl4qfOofvp4du5XYtfe42AbXTaWEPUuPOiNw=;
        b=oAKxPHHbwZeBQrA0k9mtV8UvmGyGVhzzlH/YzXICICn4tuQu8+uqUaL+0dyWULuOr1
         Kx+QjJatzo0dJkLt20wxhz5OQh7tqSejbj/+VRjTa1zHgaNR9gQ+S0r/Eb/nL8zt4bqr
         ygsciM+O5rlvz+Rl7gdDTEjVUDjzBlG8zAdD7MySew+pN1d3jkZj37W1e/hpQyY1jnpn
         yyHkcV4mUdqAipFAVYwYyP43ChZO9RvdcUOKemkYMSA/sBsSIllUQZ6ZDkCSUk8iS/5B
         Et7Kkh2x2YmnEUu4ch6YmaISpZvERSBQk4UNS3ZPvLUGcd4kEdCEC8thV8YaMx9lMYA4
         nffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RMedZnkPl4qfOofvp4du5XYtfe42AbXTaWEPUuPOiNw=;
        b=IsIRd8tOMZtkyFqrfgsQ8nYIbr/n//+Xf7ucHU5cjrzKp9+tM0S6v7NWQNYTelTPJS
         j1SO5WzZPokFXj69F9DmBzZZWjou6rE+DBcuEwcrH9o+BXHLgvmqfkzzZaMCqnkgO2Rr
         JKhnnn/fYu9pA59IuGZtULB3rim8ImDD3udo1p5PY6iYx6yQxCfYf5B3WO0MsHTzCTC0
         KpsSc+hz2hAmiNdAJqqMWg1gQVi9Oh4A0rNH0L75rA5oujmdw3U4uW3BZfxv+ZBsCsQC
         mKVTO4XF4LJ/gH4MrjGMKMu1eIbCj3v/dPsxMrCF/YnK5trEpadzfNYxA5njBdKHqZFt
         ZQ1w==
X-Gm-Message-State: APjAAAU8nsznnasDQ8jZNvtIhYj2RvO2Wv1HlORJ+EF3r0b+ENULLXHU
        up/ePZp+H/MYPzf1KlmyYCh2rlxW
X-Google-Smtp-Source: APXvYqygexMHWNcLcNVYhP/MUTwBXjfnhGC7ZS1UhRVaJOy9fED90gNoHseyQ7gADqkvGN4B7Jgrrw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr64518489wrv.39.1564049477780;
        Thu, 25 Jul 2019 03:11:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm46459285wrh.67.2019.07.25.03.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:17 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:17 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:04 GMT
Message-Id: <a3944c54802670d6a0cceba1921b67a1d01ff555.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/12] t3427: move the `filter-branch` invocation into the
 `setup` case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The step to prepare a pre-rebase commit history is _identical_ in _all_
of the test cases (except of course the `setup` case). It should
therefore clearly a part of the `setup` test case instead.

As the `git filter-branch` command is quite costly on platforms where
Unix shell scripting is simply slow (meaning: on Windows), this shaves
off a noticeable part of the runtime: in this developer's setup, the
time was reduced from ~1m25s to ~1m.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index f41a08e436..c0e6a49b61 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -56,15 +56,17 @@ test_expect_success 'setup' '
 
 	: add two extra commits to rebase &&
 	test_commit -C files_subtree master4 &&
-	test_commit files_subtree/master5
+	test_commit files_subtree/master5 &&
+
+	git checkout -b to-rebase &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty
 '
 
 # FAILURE: Does not preserve master4.
 test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-preserve-merges-4 to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
 '
@@ -72,9 +74,7 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 # FAILURE: Does not preserve master5.
 test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-preserve-merges-5 to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
@@ -82,9 +82,7 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 # FAILURE: Does not preserve master4.
 test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-4 to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
 '
@@ -92,9 +90,7 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 # FAILURE: Does not preserve master5.
 test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-5 to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
 '
@@ -102,9 +98,7 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 # FAILURE: Does not preserve Empty.
 test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
@@ -112,9 +106,7 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empt
 # FAILURE: fatal: Could not parse object
 test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 	reset_rebase &&
-	git checkout -b rebase-onto-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-onto-4 to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
 '
@@ -122,18 +114,14 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 # FAILURE: fatal: Could not parse object
 test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
 	reset_rebase &&
-	git checkout -b rebase-onto-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-onto-5 to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
 '
 # FAILURE: fatal: Could not parse object
 test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
 	reset_rebase &&
-	git checkout -b rebase-onto-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-onto-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
-- 
gitgitgadget

