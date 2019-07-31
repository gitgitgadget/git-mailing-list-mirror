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
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B861F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfGaPSs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52256 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfGaPSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so61214704wms.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rSp10mstME6UcB4J0hkWg95DaWgZxEl1O7Mw9hWi4gQ=;
        b=dNP+EXnNiu+BX/HOh87xkHEoRy6sFMC7mqc7vdaGsQyR9w5yNxsiEzogd4GKC/pPp3
         4esSsIZ+8knwkYn2UVG1NZJe80jL7dUoE3sKmFy0LUHhE1qKY6c4lE53vj8TNeGzCFGC
         KWoDKKbYTutqWzCg82nGAHPkFgVzvFtNTXmNzoBD1e5pF+DDj2ojPMuQIzsOsSUrYnoB
         mZs44gKL6ImsUe0xnocDgiZymP4LjWYbeXkahKBG03Z/p4OpGgSPzM9qiGokbgC9TVLg
         yLuI2EdsHkukRa4DocwWwQz0V6HCn/BpekKSAfx2nhQrmuvr9cQvcxjZU1HgkSjEa3ii
         QLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rSp10mstME6UcB4J0hkWg95DaWgZxEl1O7Mw9hWi4gQ=;
        b=Z1A1Ptm/Pj52Z74AjHvWPuDDOvoaWr7Wni77A0WFi/cZQKAaRVUAHwddA5GuwLqa3C
         6rZi1+o21C1tLuDBJrKs/C7Mc8H4m6YgDiaPJOrqRM7wFtPhaPlfPRkWVB2yXcfjiWV7
         5weeVthDFTJT20WPRRHuCtLzjXMVxv+St+sAiBe9nq7DJTGVHDPhRwFMFUcehX5NvPVF
         EMu5+3vPbH8xFGkUbdKRSGAhf1F2dPZNluiUFGR/cRZ26g65Mm3eYZbuVe7SdTIxBQOL
         uwSSjFQDdIy1c39IgscEmjbh3zzogl6iu9CtTqnBIOomdxZT/ho9GCGQnLZbg5QYN/aL
         NL4A==
X-Gm-Message-State: APjAAAXbBIpBbNUkdJC21Mpet/92YCJG1HfdDnKJjajoh1qi0cEqnzhT
        4mL1jbinAulfrXjahMEAmbY+ohfe
X-Google-Smtp-Source: APXvYqx+RtdR0a8Eh/s8CnoH2RqsER+mSwQiDPLaSLcPvFmwOur//JI8n6nkKzPkpwILS2cbbDNBQw==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr108122075wmo.166.1564586323995;
        Wed, 31 Jul 2019 08:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm69472671wru.24.2019.07.31.08.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:43 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:43 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:28 GMT
Message-Id: <138ff362fbf3d948e431489841602d787e360c69.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/16] t3427: move the `filter-branch` invocation into the
 `setup` case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
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
index 36c4f92e06..64ba95f3e0 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -56,16 +56,18 @@ test_expect_success 'setup' '
 
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
 test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-preserve-merges-4 to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
 '
@@ -74,9 +76,7 @@ test_expect_failure REBASE_P \
 test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-preserve-merges-5 to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
@@ -85,9 +85,7 @@ test_expect_failure REBASE_P \
 test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-4 to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
 '
@@ -96,9 +94,7 @@ test_expect_failure REBASE_P \
 test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-5 to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
 '
@@ -107,9 +103,7 @@ test_expect_failure REBASE_P \
 test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-	git commit -m "Empty commit" --allow-empty &&
+	git checkout -b rebase-keep-empty-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
@@ -117,9 +111,7 @@ test_expect_failure REBASE_P \
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
@@ -127,18 +119,14 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
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

