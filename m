Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CE51F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeIZEoN (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:13 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43929 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZEoN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:13 -0400
Received: by mail-ed1-f42.google.com with SMTP id u23so170261edx.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M/QkGfQgoZAiVyf4pAXjNr60DiJ4w+OiJEissB4UwsY=;
        b=jS0oFV+mJOYZJUX5pxqi4RqyGHeiv38aiQ3CUwfRp22GLjfBrx3209hT9vlcn/UVXL
         1ruhQ0a1nXMPew7VgjxBmK2y1uU7L+rhDoTa4ql5oLUspNLNKgy7WYuT3DEWi31F5nki
         ZwKk/iS6Y2/cstLb3Oz1zkbZpkGqkoUDWSw0nzo1OFvpBa33ZMdp+RpY6qtLv4YWMX7I
         7fcK0ELud8CPQAy+vHtbAJEAQrxSgERjqurqua8xntZAwGQ4WsWMC3+Nu2AGnvnH97oM
         tCxejyoC9uAoYraubskZsa8BvJRErP+gj3vIwkS4ZGuSeG+8MLBzR9JZUhDs4T2QrZeW
         VA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/QkGfQgoZAiVyf4pAXjNr60DiJ4w+OiJEissB4UwsY=;
        b=p24bOCiwjuSqEkMe0BSrdxwSCBmLTD10Ub147jO4wGjHoLOc7N7yWi43UqYNZWsXsq
         vlhOMMyDbQexv52hgdoQhA8XMI5qkAZn90BgCZSYdAJnmCliwFfgtDR2ZrQBIuDAXsOA
         4FgoshPJBg6XjOY6gEuxgSKq1SHsxUuopJhj+i4JbOt3fblJsX6XBfrFRyGwrHIEZSO+
         Kk+1f/Mia0ZB8BLxBxIkyK6pTfG7VSppkdTL54Bu9r5u6eWcybu8H+2rzG6aEw5Mgrh1
         S/of0SvzoowafMpMZH3CpnV1xSWVeTAQbWXQ3hta97abpruVQlTEB1/7ICrlOEigldd7
         KOqw==
X-Gm-Message-State: ABuFfoi6wvbsRzCPN94kQ8EkjLSn5Dx+3kbsbj25lV2klRxso52V1wt+
        HHwqfZHF1RzBK2znQ0yETUrsqK90
X-Google-Smtp-Source: ACcGV6189FiGh2P6b38pH74U2mLhnVKmnPZ7BV7KgZnHEUWOSrct/jQ2OBXo9GbY26737lgHEnu1AA==
X-Received: by 2002:a50:8807:: with SMTP id b7-v6mr4935633edb.182.1537914865507;
        Tue, 25 Sep 2018 15:34:25 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:24 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 04/21] stash: update test cases conform to coding guidelines
Date:   Wed, 26 Sep 2018 01:33:18 +0300
Message-Id: <e2ced7320ffc205739133858a6b301c57893254f.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removed whitespaces after redirection operators.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 120 ++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index af7586d43d..de6cab1fe7 100755
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
 	test_cmp output expect
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
 	test_cmp output expect &&
-	git diff > output &&
+	git diff >output &&
 	test_cmp output expect1 &&
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
 	test_cmp output expect
 '
 
-- 
2.19.0.rc0.23.g1fb9f40d88

