Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F5420248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfDQKZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39939 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbfDQKY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:24:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so2906419wmi.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=QgoUQD2tc8QMdrAftq0auCAIPOtS30/fzvCDcVacN4E=;
        b=EqfjOHC2FhelAS6tjMcnWATkzMgzkR+0Fe0oj0CieO2KctiAgdcDWaSB23O28k2yyX
         zU82Ar4gWWPTm/lGstnlbe6T+4+YYFVUGDDD9ViEZoZBnkEuN1+x3WSCB2a1ikyAT/wj
         E4vQ9O7n1bHDIW/191ioGmlIiIN7lp8ikQD+pXmaggJdMKjTfd/rpy+6ea8cffp1nWnb
         D8W8dfuQhIx72wFcIfZaPF1/ZNhZ8Ly+9vuQGi+ZJ0WqVg/s7YwMDfZ2R56UesHkl+OT
         At+WG7cBPnIsOlaG6tc3IPsDLIw+Ec2+tnO201Q3JE8+ZBgj6mOZbf+277Lad8kRo9Fu
         UbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=QgoUQD2tc8QMdrAftq0auCAIPOtS30/fzvCDcVacN4E=;
        b=dbQ5YbvUNqpaBW+JyA1xEKqiyfXAYWcJBKToGahkIRXs/PYZYZW2RmunSF/ceEFHpd
         HuDttt4RKkINpUjWmxTda+/GPoBx1GIRrZaf7gtM7Ce/wfY2i1ovrUwb2fjG9Y9C0KMR
         ARpCkB7Np84DbwkeDksjIO+ixE+XpGpCQSaY03tmOAyf+Tb5BzfaXBJaDWs08uPDCRNk
         crI+O7pJET0q7d/JQ5rAYjvUUeaKC0w5taxGuKUSRPYIlFghdIgZo/JMBf5UKPxxHg2Z
         HimLT5qmiudON5Lax0HeKZP8zX/iyMyBMeUh3Yp1avV7pxFYlQIdUZim7UXlwQ7VKC3A
         PInA==
X-Gm-Message-State: APjAAAXEMyQY29PuQrv/byaoiK/62ZCXmgwyH867UpDyWYwS3Vtl0+y7
        OFiFyc7eobwVp+iwYbMs15vecMcOSdk=
X-Google-Smtp-Source: APXvYqz+FZC6VpjaxA9mxaPV6oE+tTafUp5/kKbPQ7PwtoUhJuHvs8iULxXtf8XN964dlEf7lvOCUw==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr30182368wma.135.1555496695894;
        Wed, 17 Apr 2019 03:24:55 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:55 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 02/10] t3507: clean up style
Date:   Wed, 17 Apr 2019 11:23:22 +0100
Message-Id: <20190417102330.24434-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Remove space after redirection operators for style. Also, remove a git
command which was upstream of a pipe. Finally, let grep and sed open
their own input instead of letting the shell redirect the input.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 42 ++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..777fb23d18 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -88,15 +88,15 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 
 test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git cherry-pick base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
 test_expect_success \
 	'cherry-pick --strategy=resolve w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git cherry-pick --strategy=resolve base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
@@ -175,23 +175,23 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 		git ls-files --stage foo &&
 		git checkout picked -- foo &&
 		git ls-files --stage foo
-	} > stages &&
+	} >stages &&
 	sed "
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" < stages > expected &&
+	" stages >expected &&
 	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
-	git ls-files --stage --unmerged > actual &&
+	git ls-files --stage --unmerged >actual &&
 
 	test_cmp expected actual
 '
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	=======
@@ -201,14 +201,14 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	||||||| parent of objid picked
@@ -220,14 +220,14 @@ test_expect_success 'diff3 -m style' '
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'revert also handles conflicts sanely' '
 	git config --unset merge.conflictstyle &&
 	pristine_detach initial &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	=======
@@ -241,24 +241,24 @@ test_expect_success 'revert also handles conflicts sanely' '
 		git ls-files --stage foo &&
 		git checkout base -- foo &&
 		git ls-files --stage foo
-	} > stages &&
+	} >stages &&
 	sed "
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" < stages > expected-stages &&
+	" stages >expected-stages &&
 	git read-tree -u --reset HEAD &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
 	newhead=$(git rev-parse HEAD) &&
-	git ls-files --stage --unmerged > actual-stages &&
+	git ls-files --stage --unmerged >actual-stages &&
 
 	test "$head" = "$newhead" &&
 	test_must_fail git update-index --refresh -q &&
 	test_must_fail git diff-index --exit-code HEAD &&
 	test_cmp expected-stages actual-stages &&
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -284,7 +284,7 @@ test_expect_success 'revert --no-commit sets REVERT_HEAD' '
 
 test_expect_success 'revert w/dirty tree does not set REVERT_HEAD' '
 	pristine_detach base &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git revert base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
 	test_must_fail git rev-parse --verify REVERT_HEAD
@@ -319,7 +319,7 @@ test_expect_success 'failed commit does not clear REVERT_HEAD' '
 test_expect_success 'revert conflict, diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	||||||| objid picked
@@ -331,7 +331,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 
 	test_must_fail git revert picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -345,7 +345,7 @@ test_expect_success 'commit after failed cherry-pick does not add duplicated -s'
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked-signed &&
 	git commit -a -s &&
-	test $(git show -s |grep -c "Signed-off-by") = 1
+	test $(git show -s >tmp && grep -c "Signed-off-by" tmp && rm tmp) = 1
 '
 
 test_expect_success 'commit after failed cherry-pick adds -s at the right place' '
@@ -359,7 +359,7 @@ test_expect_success 'commit after failed cherry-pick adds -s at the right place'
 	Signed-off-by: C O Mitter <committer@example.com>
 	# Conflicts:
 	EOF
-	grep -e "^# Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^# Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual &&
 
 	cat <<-\EOF >expected &&
@@ -378,7 +378,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 
 	# emulate old-style conflicts block
 	mv .git/MERGE_MSG .git/MERGE_MSG+ &&
-	sed -e "/^# Conflicts:/,\$s/^# *//" <.git/MERGE_MSG+ >.git/MERGE_MSG &&
+	sed -e "/^# Conflicts:/,\$s/^# *//" .git/MERGE_MSG+ >.git/MERGE_MSG &&
 
 	git commit -a &&
 	git commit --amend -s &&
@@ -388,7 +388,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	Signed-off-by: C O Mitter <committer@example.com>
 	Conflicts:
 	EOF
-	grep -e "^Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
-- 
2.21.0

