Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E84020248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfCKDmh (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so2963355pgq.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RpDS5/0/di5rFf5vadj6lCJZy5mpsEbpelKVZGSvqsM=;
        b=mBE8+dNSxpwoYXOxWCku0otuWX5PonVOQTIr2LOVTxlygvSasxljuwoRO+w7BP49ap
         2GqO7BXsrF/m80lNPXRW60WvYwUe/GcImvT4Y4NmGACcL9d7UF1OjzrJ4Lg1hxBPUmlN
         Zom6V26cdtcyNV/dlszp3CekszybP1qhaN1VIhWQGXMdKeROT2bubmbqEtlZkpdPl487
         MKEw6nWTdh6dUTkdYq9kEJPoS0/U81X6XyjbQQoWJkxE83ku24dhtbfZw8BLX/MVB8lB
         vdt3bXewO9CIJ83b8pbrv3TZ61vZeRXCwfmTd0+UTXuf9IILLH3DY0QgfUrYs2jrOl/a
         Hxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RpDS5/0/di5rFf5vadj6lCJZy5mpsEbpelKVZGSvqsM=;
        b=i2geNrsi6Imovwn5qDoTZAH7YWfEclycngn+tLLn9/HqHHcrNX4BaPQ3ESxIuOK6dX
         2X1GdoCp7UalF510+iqtlW8s9MIdKnrFdcCyz17tFRzSlaYDCFpbnRDZXkN/Liyy7u8p
         khhRe5YybWLRw5WaiH7nBdLSFQ0ZmRmtNze5X3FE47HQpn8HCpopKrhGEa8KHpFlhmtC
         a+6Mkm+WhMYJE41tHCvj4uC+khy6hW0TQrNNk3iKvc/qGCaPe5zkhzbMhPXB3sUvW0Lb
         944k81SofFiVDH/BGZ3ydYF3o+X8diuyKjdRKp5rRUEYAzFfr1jRl7IINgtNVo3AEa3Q
         PQjw==
X-Gm-Message-State: APjAAAVEAUJXap9UMjUhHCw9e+85fKrwNJeMEeba78v1gxbz5NIQmnqX
        LjePSA4a603Gw0Ri5Z+vNaKl8/KL
X-Google-Smtp-Source: APXvYqx/Th23Dsv0Yvy52e+YjAzJRLd96n9BIGzxz4E5/amSX/Rvb/diBJNfB+0sC3f7+MvuG69QoA==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr31403563plb.113.1552275756038;
        Sun, 10 Mar 2019 20:42:36 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h9sm632591pgk.22.2019.03.10.20.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:35 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 2/8] t3507: cleanup space after redirection operators
Message-ID: <0929ecc5493f666509903571304cdce81573a6fb.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
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

