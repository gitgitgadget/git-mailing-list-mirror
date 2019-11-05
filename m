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
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F0D1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390434AbfKERHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42478 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbfKERHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so22294322wrf.9
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/1YwCqlFoxyH/Xdw0mC35tBzONrDm2VwJTWvstQFNN0=;
        b=RhlQcH3CDxVQN5zXrazHZa16os1zTD3LXD3PrwwFWTY3XilZtinoVBgYn0cvdBrzQt
         JbNUSQ3n7R/1RzhJ1lVRBwnU8iIE/nSin4UsImpoxjqlbWwloeyyII/jTQlSEpLKTCpG
         bcQGEKV7+EwlzvnAautCxfKoO83ULOYNID7YeEvWzJv9yl3sgp68EaICXpeiQS8qj4if
         Z1CJpyAk4v2pqHiDF/KLN+L91BsNaD1TEpvaY2vV08FBAyFICvu3aXzN5Gf/Ck3CQCqx
         t02bxOsScYdcmi7rsffeqGf466mq4ntdAuPa7NMEoo1C1jW1XrF0LNZX8ukFZ5JZv98F
         0RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/1YwCqlFoxyH/Xdw0mC35tBzONrDm2VwJTWvstQFNN0=;
        b=gQQ3M5DfCv39cS92c+DH4GWX7WmoiEMXRxxJ+5/tviBsuOAdld1ZLFFsQ9zxqMQV+2
         FimaTLGoKP7kWhG1W+WRvSWTrMdhPoZOOcoBNZO4Ygbi4iidub/90kbqhHNNq37OpDID
         kXI0QCpuJPq72VVCdVstkvLsSFgsvL+5RrwVOn5KUWqSaPucv8r8TvxDRYF3Fy71qgND
         SMeWR03GxaoxW9TwBer8Xy/bRF1eKgpUR/3UAoPfuBaBCtrkBmSE6+/J3L9+1u9t855Y
         1nfpnTAd9NqhBu8tbu9N7RJsiW8O0xUq9EkTSpzWcJbEOzC0obE7hYHF6mvKsXv13SWq
         nB0Q==
X-Gm-Message-State: APjAAAXGpqAL+5TElfraz2A+XoQoKY8hJElagIQMSXfawocMMeIs842h
        QhNiHisqyiwETDhFTiYln0yoLlZu
X-Google-Smtp-Source: APXvYqyfQfM8g2OhB3K3+ucObrCJmuCDWuTPfYWZ76C0w+74YnWd8q6jNJXmiV0f/AvPojfEPGDDDQ==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr29195155wrw.167.1572973661134;
        Tue, 05 Nov 2019 09:07:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm16527285wrw.20.2019.11.05.09.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:40 -0800 (PST)
Message-Id: <e31ef1184e0fe304e5973a12582bdb8ea8fd46f0.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:27 +0000
Subject: [PATCH v2 08/11] Fix spelling errors in test commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Apply several spelling fixes that technically change what the tests are
executing, but do so in a way that is not tested and does not affect results
(e.g. modify the commit message to remove a typo, remove spelling mistakes
from refnames, etc.)

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3210-pack-refs.sh               |  2 +-
 t/t3905-stash-include-untracked.sh |  4 ++--
 t/t4100/t-apply-1.patch            |  4 ++--
 t/t4100/t-apply-5.patch            |  4 ++--
 t/t5545-push-options.sh            |  2 +-
 t/t6036-recursive-corner-cases.sh  |  4 ++--
 t/t7030-verify-tag.sh              | 14 +++++++-------
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 9ea5fa4fd2..f41b2afb99 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -240,7 +240,7 @@ test_expect_success 'retry acquiring packed-refs.lock' '
 
 test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	# First make sure that symlinking works when reading:
-	git update-ref refs/heads/loosy refs/heads/master &&
+	git update-ref refs/heads/lossy refs/heads/master &&
 	git for-each-ref >all-refs-before &&
 	mv .git/packed-refs .git/my-deviant-packed-refs &&
 	ln -s my-deviant-packed-refs .git/packed-refs &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 29ca76f2fb..f075c7f1f3 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -277,8 +277,8 @@ test_expect_success 'stash -u -- <ignored> leaves ignored file alone' '
 	test_path_is_file ignored.d/bar
 '
 
-test_expect_success 'stash -u -- <non-existant> shows no changes when there are none' '
-	git stash push -u -- non-existant >actual &&
+test_expect_success 'stash -u -- <non-existent> shows no changes when there are none' '
+	git stash push -u -- non-existent >actual &&
 	echo "No local changes to save" >expect &&
 	test_i18ncmp expect actual
 '
diff --git a/t/t4100/t-apply-1.patch b/t/t4100/t-apply-1.patch
index 90ab54f0f5..43394f8285 100644
--- a/t/t4100/t-apply-1.patch
+++ b/t/t4100/t-apply-1.patch
@@ -75,8 +75,8 @@ diff --git a/Documentation/git.txt b/Documentation/git.txt
 +link:git-ssh-pull.html[git-ssh-pull]::
  	Pulls from a remote repository over ssh connection
  
- Interogators:
-@@ -156,8 +156,8 @@ Interogators:
+ Interrogators:
+@@ -156,8 +156,8 @@ Interrogators:
  link:git-diff-helper.html[git-diff-helper]::
  	Generates patch format output for git-diff-*
  
diff --git a/t/t4100/t-apply-5.patch b/t/t4100/t-apply-5.patch
index 5f6ddc1059..57ec79d887 100644
--- a/t/t4100/t-apply-5.patch
+++ b/t/t4100/t-apply-5.patch
@@ -185,8 +185,8 @@ diff a/Documentation/git.txt b/Documentation/git.txt
 +link:git-ssh-pull.html[git-ssh-pull]::
  	Pulls from a remote repository over ssh connection
  
- Interogators:
-@@ -156,8 +156,8 @@ Interogators:
+ Interrogators:
+@@ -156,8 +156,8 @@ Interrogators:
  link:git-diff-helper.html[git-diff-helper]::
  	Generates patch format output for git-diff-*
  
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 04b34c4de1..38e6f7340e 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -115,7 +115,7 @@ test_expect_success 'push options and submodules' '
 
 	git -C parent submodule add ../upstream workbench &&
 	git -C parent/workbench remote add up ../../upstream &&
-	git -C parent commit -m "add submoule" &&
+	git -C parent commit -m "add submodule" &&
 
 	test_commit -C parent/workbench two &&
 	git -C parent add workbench &&
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 7fddcc8c73..7d73afdcda 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1532,7 +1532,7 @@ test_expect_success 'setup nested conflicts' '
 		mv -f b_R1 b &&
 		mv -f a_R1 a &&
 		git add b a &&
-		test_tick && git commit -m "verson R1 of files" &&
+		test_tick && git commit -m "version R1 of files" &&
 		git tag R1 &&
 
 		# Create first merge on left side
@@ -1696,7 +1696,7 @@ test_expect_success 'setup virtual merge base with nested conflicts' '
 		git checkout R &&
 		echo right >>content &&
 		git add content &&
-		test_tick && git commit -m "verson R1 of content" &&
+		test_tick && git commit -m "version R1 of content" &&
 		git tag R1 &&
 
 		# Create L2
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 041e319e79..8f077bea60 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -44,8 +44,8 @@ test_expect_success GPG 'create signed tags' '
 test_expect_success GPGSM 'create signed tags x509 ' '
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
-	echo 9 >file && test_tick && git commit -a -m "nineth gpgsm-signed" &&
-	git tag -s -m nineth nineth-signed-x509
+	echo 9 >file && test_tick && git commit -a -m "ninth gpgsm-signed" &&
+	git tag -s -m ninth ninth-signed-x509
 '
 
 test_expect_success GPG 'verify and show signatures' '
@@ -80,10 +80,10 @@ test_expect_success GPG 'verify and show signatures' '
 '
 
 test_expect_success GPGSM 'verify and show signatures x509' '
-	git verify-tag nineth-signed-x509 2>actual &&
+	git verify-tag ninth-signed-x509 2>actual &&
 	grep "Good signature from" actual &&
 	! grep "BAD signature from" actual &&
-	echo nineth-signed-x509 OK
+	echo ninth-signed-x509 OK
 '
 
 test_expect_success GPG 'detect fudged signature' '
@@ -127,10 +127,10 @@ test_expect_success GPG 'verify signatures with --raw' '
 '
 
 test_expect_success GPGSM 'verify signatures with --raw x509' '
-	git verify-tag --raw nineth-signed-x509 2>actual &&
+	git verify-tag --raw ninth-signed-x509 2>actual &&
 	grep "GOODSIG" actual &&
 	! grep "BADSIG" actual &&
-	echo nineth-signed-x509 OK
+	echo ninth-signed-x509 OK
 '
 
 test_expect_success GPG 'verify multiple tags' '
@@ -147,7 +147,7 @@ test_expect_success GPG 'verify multiple tags' '
 '
 
 test_expect_success GPGSM 'verify multiple tags x509' '
-	tags="seventh-signed nineth-signed-x509" &&
+	tags="seventh-signed ninth-signed-x509" &&
 	for i in $tags
 	do
 		git verify-tag -v --raw $i || return 1
-- 
gitgitgadget

