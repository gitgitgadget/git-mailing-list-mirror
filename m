Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671441F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439020AbeKWJr7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32851 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439013AbeKWJr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so10466175wmo.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IwLyEiVNgHsVpd7nleD2lClFGx3fHtkemRezojKKM8=;
        b=JYL52DBJtHcIVQOBrGZntoz4GIBTAvAB/FtTgsIBY2EX93jCYBES8K6ejk8ki9MWrl
         dLVJvGrgQJjyyY4DqPlwmfsrmZfouGx/6cxkSxAOIga/Wj3xI/ukJFrgEZ2/Ag9njKum
         /cBn6oNCVTNsCUb7umOG7GG3Bib/PtWkK1rLNEk55cSYdEF2eZa95dJqZ3IDDT/nZats
         CjqHwmvVaURMpCsPkyIN9m8ZggD7LHszV1AWUYhb12Tem3jfI0wWjwVMcu/HM7WX6aTk
         xGhgR4Mk724i2Cv7Z3VvhI5BMt+F8A2Os9/i2r6H+MKfkJftQWPF6+eUnCztIHeTj3DS
         dtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IwLyEiVNgHsVpd7nleD2lClFGx3fHtkemRezojKKM8=;
        b=Don/PQ2jpWwIb/qCwxRdpbAQ5Xxowy9duTpLFIm4SHmMKjdzCrAODENgNo+g5GpdpP
         c9Fjpj/bS4FL7MiDuEoSUoM6thdAunGYzAtp7rO9U1BEeYCn0zQxING5/SCaU4LKZbUt
         REbMhxONF70i9x1aMPqEe1FBBEA5G8r+nxD0vL+h7r/1MYuKNS1PD6Z62W5ZMz+NJ2bh
         ryG6jSWW3PTC7YckiO3Zg7LR29Gv02Coj8GwBlV7PZsVGfNxuhZ1vOF5wNh+g2Dns4XQ
         Ke1/hzu1YbUXQKNqjcmXwTX5B0Tq1SDWhjfGjJZVJlzQAA0gvv3C3ZPK8QK8pvYTs+72
         9YzQ==
X-Gm-Message-State: AGRZ1gJNZjO0eY5yxumCK8XU8Se6HYGllXIf7TmMD/c3HSYjkaamDoAc
        liZAY2Kh1adXdGSI6Ko1CusLnj14
X-Google-Smtp-Source: AJdET5f+RP4LnD8v5r1iv2nSruEY9FFOR7isK1PYs7bhz/m9JgeJ9jenPZ928rEDeRcBiHYKBL36aw==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr10743521wme.21.1542927976526;
        Thu, 22 Nov 2018 15:06:16 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:15 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 05/22] t3903: modernize style
Date:   Fri, 23 Nov 2018 01:05:25 +0200
Message-Id: <7784ea24aa1ada5c5cbd9407a16c870b06a43d6c.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove whitespaces after redirection operators and wrap
long lines.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 120 ++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4f8aa56021..098a387a82 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -8,22 +8,22 @@ test_description='Test git stash'
 . ./test-lib.sh
 
 test_expect_success 'stash some dirty working directory' '
-	echo 1 > file &&
+	echo 1 >file &&
 	git add file &&
 	echo unrelated >other-file &&
 	git add other-file &&
 	test_tick &&
 	git commit -m initial &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git add file &&
-	echo 3 > file &&
+	echo 3 >file &&
 	test_tick &&
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/file b/file
 index 0cfbf08..00750ed 100644
 --- a/file
@@ -35,7 +35,7 @@ EOF
 
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
-	git diff stash^2..stash > output &&
+	git diff stash^2..stash >output &&
 	test_cmp expect output
 '
 
@@ -74,7 +74,7 @@ test_expect_success 'apply stashed changes' '
 
 test_expect_success 'apply stashed changes (including index)' '
 	git reset --hard HEAD^ &&
-	echo 6 > other-file &&
+	echo 6 >other-file &&
 	git add other-file &&
 	test_tick &&
 	git commit -m other-file &&
@@ -99,12 +99,12 @@ test_expect_success 'stash drop complains of extra options' '
 
 test_expect_success 'drop top stash' '
 	git reset --hard &&
-	git stash list > stashlist1 &&
-	echo 7 > file &&
+	git stash list >expected &&
+	echo 7 >file &&
 	git stash &&
 	git stash drop &&
-	git stash list > stashlist2 &&
-	test_cmp stashlist1 stashlist2 &&
+	git stash list >actual &&
+	test_cmp expected actual &&
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
@@ -113,9 +113,9 @@ test_expect_success 'drop top stash' '
 
 test_expect_success 'drop middle stash' '
 	git reset --hard &&
-	echo 8 > file &&
+	echo 8 >file &&
 	git stash &&
-	echo 9 > file &&
+	echo 9 >file &&
 	git stash &&
 	git stash drop stash@{1} &&
 	test 2 = $(git stash list | wc -l) &&
@@ -160,7 +160,7 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/file2 b/file2
 new file mode 100644
 index 0000000..1fe912c
@@ -170,7 +170,7 @@ index 0000000..1fe912c
 +bar2
 EOF
 
-cat > expect1 << EOF
+cat >expect1 <<EOF
 diff --git a/file b/file
 index 257cc56..5716ca5 100644
 --- a/file
@@ -180,7 +180,7 @@ index 257cc56..5716ca5 100644
 +bar
 EOF
 
-cat > expect2 << EOF
+cat >expect2 <<EOF
 diff --git a/file b/file
 index 7601807..5716ca5 100644
 --- a/file
@@ -198,79 +198,79 @@ index 0000000..1fe912c
 EOF
 
 test_expect_success 'stash branch' '
-	echo foo > file &&
+	echo foo >file &&
 	git commit file -m first &&
-	echo bar > file &&
-	echo bar2 > file2 &&
+	echo bar >file &&
+	echo bar2 >file2 &&
 	git add file2 &&
 	git stash &&
-	echo baz > file &&
+	echo baz >file &&
 	git commit file -m second &&
 	git stash branch stashbranch &&
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
 	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
-	git diff --cached > output &&
+	git diff --cached >output &&
 	test_cmp expect output &&
-	git diff > output &&
+	git diff >output &&
 	test_cmp expect1 output &&
 	git add file &&
 	git commit -m alternate\ second &&
-	git diff master..stashbranch > output &&
+	git diff master..stashbranch >output &&
 	test_cmp output expect2 &&
 	test 0 = $(git stash list | wc -l)
 '
 
 test_expect_success 'apply -q is quiet' '
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	git stash apply -q > output.out 2>&1 &&
+	git stash apply -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'save -q is quiet' '
-	git stash save --quiet > output.out 2>&1 &&
+	git stash save --quiet >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'pop -q is quiet' '
-	git stash pop -q > output.out 2>&1 &&
+	git stash pop -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'pop -q --index works and is quiet' '
-	echo foo > file &&
+	echo foo >file &&
 	git add file &&
 	git stash save --quiet &&
-	git stash pop -q --index > output.out 2>&1 &&
+	git stash pop -q --index >output.out 2>&1 &&
 	test foo = "$(git show :file)" &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'drop -q is quiet' '
 	git stash &&
-	git stash drop -q > output.out 2>&1 &&
+	git stash drop -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'stash -k' '
-	echo bar3 > file &&
-	echo bar4 > file2 &&
+	echo bar3 >file &&
+	echo bar4 >file2 &&
 	git add file2 &&
 	git stash -k &&
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash --no-keep-index' '
-	echo bar33 > file &&
-	echo bar44 > file2 &&
+	echo bar33 >file &&
+	echo bar44 >file2 &&
 	git add file2 &&
 	git stash --no-keep-index &&
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash --invalid-option' '
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	test_must_fail git stash --invalid-option &&
 	test_must_fail git stash save --invalid-option &&
@@ -486,11 +486,12 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test_when_finished "git reset --hard HEAD && git checkout master &&
+	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
@@ -498,14 +499,15 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test_when_finished "git reset --hard HEAD && git checkout master &&
+	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
@@ -518,10 +520,10 @@ test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -536,10 +538,10 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	echo "1	0	file" >expected &&
@@ -551,10 +553,10 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -574,7 +576,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	echo "1	0	file" >expected &&
@@ -586,7 +588,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -606,9 +608,9 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	echo bar > file &&
+	echo bar >file &&
 	git stash &&
 	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
 	git stash pop &&
@@ -620,9 +622,9 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	echo bar > file &&
+	echo bar >file &&
 	git stash &&
 	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
 	git stash pop &&
@@ -632,8 +634,8 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 
 test_expect_success 'ref with non-existent reflog' '
 	git stash clear &&
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	git stash &&
 	test_must_fail git rev-parse --quiet --verify does-not-exist &&
@@ -653,8 +655,8 @@ test_expect_success 'ref with non-existent reflog' '
 test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash clear &&
 	test_must_fail git stash drop stash@{0} &&
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	git stash &&
 	test_must_fail git stash drop stash@{1} &&
@@ -724,7 +726,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
 	test_i18ncmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/HEAD b/HEAD
 new file mode 100644
 index 0000000..fe0cbee
@@ -737,14 +739,14 @@ EOF
 test_expect_success 'stash where working directory contains "HEAD" file' '
 	git stash clear &&
 	git reset --hard &&
-	echo file-not-a-ref > HEAD &&
+	echo file-not-a-ref >HEAD &&
 	git add HEAD &&
 	test_tick &&
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD &&
 	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
-	git diff stash^..stash > output &&
+	git diff stash^..stash >output &&
 	test_cmp expect output
 '
 
-- 
2.19.1.878.g0482332a22

