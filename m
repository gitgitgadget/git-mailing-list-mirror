Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C133220248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfCFKac (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:30:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFKac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:30:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so8254519pfn.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8q62KNR8KHERFuqpvSAxiGiA8ZxtHeualjrSJLOVbs=;
        b=Vk8WR/y8+ne3GTygyL1Wj9y0qxgicdkMVxg/DylKbZJpqZpFS1vyEJHwrQqQvyykbh
         XPe5aT3t5cVUhDSULy/J2KaTtqabbWt0H0+IYttr7NCJMtJk7pcabtvien2jT3OPtw3f
         hAY6K4hKBCsmwB26DYt9OfWlH9mqcG3b7QeAgT+npl7w58qRkX9FgvvOJPnaInJPX//L
         cyLkgdkZjYcC2WW0sSRe8qqQGLv5tNF5gUWq3TLC5JWlqBUCI2NjVkHwJDBPNEQqrt9i
         rf069WWcOmTD+0PiazSe4J/Zw2gcLlUjb1MZrxEKCugHHY2u9ceVd6jREYnrlmOq946V
         ZRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8q62KNR8KHERFuqpvSAxiGiA8ZxtHeualjrSJLOVbs=;
        b=KFXo6ri+3EPuP7KjXBuhKIAsFB0eQCAb6ceFDgXkuWHoFInk7n1K+I6E+juTm3ADjy
         Xmg0tkaJwj/X0/5MyH8wW/+jtGu3LaVWUkH2VvwDYetEtGpINsajpbRlorp5nA/uIR8D
         xCkZlAOvnsxS+yEeXnf8aOoPQ/eT1HikydnwIqSRM+m4xBD44RWz8qxhJbewugxKYCvZ
         zrI8fIVXOCXHi4MIpEiArx6tnqeroNsOsoTL76zOQZftjPsBU8p0baMKX6APntu5bq3g
         lm2sSpS/62s+mZ4pP/Pu5xNTt/DriWso37NpaG1pYhYOAuefbqJnEZLABfG7ubS9Ee6S
         pE4w==
X-Gm-Message-State: APjAAAVbW7b2xsrhfRR03hZdJuMt8Bk6RsMdR6zgrLiFs1SZWzqUDyNf
        vrOpXavdOI31bBsBjE28HLP5hdyR
X-Google-Smtp-Source: APXvYqynJn5ySrm7NaooqjCjYo2fYMF5X3k+WZj76JJMo9zZjxjzbDIBsUVzbqrLrhYX+W9PycEOcg==
X-Received: by 2002:a63:5f0f:: with SMTP id t15mr5663681pgb.272.1551868231062;
        Wed, 06 Mar 2019 02:30:31 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 73sm2494567pfr.55.2019.03.06.02.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 02:30:30 -0800 (PST)
Date:   Wed, 6 Mar 2019 02:30:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/2] t3507: cleanup space after redirection operators
Message-ID: <4eee16cc5a841ac20c9ffcd010c0e1feb88059bf.1551867827.git.liu.denton@gmail.com>
References: <cover.1551867827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551867827.git.liu.denton@gmail.com>
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
2.19.1.6.g4de041ebd8.dirty

