Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF88202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 09:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGJ6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:58:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33801 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGJ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:58:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so11041535pfn.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RpDS5/0/di5rFf5vadj6lCJZy5mpsEbpelKVZGSvqsM=;
        b=eE1ItwsCG4bavLGmwD43+L+nVFNgR2XPSl+o5gvGROGhndNrsQvQlj5+GtijuCxpJ0
         1SCEniGr3ZT84ynoThdLyrvqzXIveIxBWMOh8ldHEGhlb1G1oe4I784WJfo8qTRQSxNz
         Rto8QkuoR/zJjxjipBAy55f2nqeaV/H2VV2s/JjcuGEgl1HY24uvfrVgGSlDRZtJ8aAn
         NqtWw1WmAwYnb5niJfo0xH4tCZ5mTMOIDLl3OxSdgC3c4n5tJM9xVCnMvr9jYBzpqsZI
         kac4dTRMF/tVACDQCkXjiJXf097yCKNdsDdVHJuMjY7wxVDWh5uwqgbwieC3+mvjaUT7
         /dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RpDS5/0/di5rFf5vadj6lCJZy5mpsEbpelKVZGSvqsM=;
        b=L4q0KdNiW8Vzhde4KekFyYUMltat42P844TrHP0QungOSpSYfiBYcYAGKfZMclKx+3
         Eja8brEKvXc+1LtT27+1ev9d8ZgyRa0VHiGsEc2ezc1DidONJoFK9pqU1jDXi9hwvdsp
         ngm7QdLrIC6CVAjsOXWNr4rIOvqC8UHVP/vPUnJeMsb06aFAGsf9OrIdzXn3bh8I7wi2
         z2SGYlAVjEf2Y5eh9R+mgWvjA57S2Ud07pOQUEErG1qQ00Qht6WOrRM029ye/5T8vyCv
         Nemoo4AbfAe79EUp6DYQz830oEMN/FFL2riUTS9CcMF69ISel/oMGM4RdE3m6RXlggOg
         Zxpw==
X-Gm-Message-State: APjAAAXWOPqUEJZDqhLUvbPZ8Gt79S2LB1blYkYZL16aTxBS80GWR4F3
        QRGxsvoc3IfxiCL8IX4TntbNt0Kc
X-Google-Smtp-Source: APXvYqyZDGjdK9DtjizdhnR9CJTgX01LYP8Z59PCairB7q6aCoKlw9bE3epCEBDKJ6JUCCDxAgwRPg==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr11836595pfk.186.1551952712599;
        Thu, 07 Mar 2019 01:58:32 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b7sm9767078pfi.36.2019.03.07.01.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:58:32 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:58:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] t3507: cleanup space after redirection operators
Message-ID: <6bce4d4722dd9408c4146daefc21c7e3443748c9.1551951770.git.liu.denton@gmail.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551951770.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..74ff925526 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -88,7 +88,7 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 
 test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git cherry-pick base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
@@ -96,7 +96,7 @@ test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
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
+	" <stages >expected &&
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
+	" <stages >expected-stages &&
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
 
-- 
2.21.0.370.g4fdb13b891

