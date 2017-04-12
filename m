Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0DD20960
	for <e@80x24.org>; Wed, 12 Apr 2017 11:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbdDLLsP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 07:48:15 -0400
Received: from mout.web.de ([212.227.17.12]:60023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdDLLsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 07:48:13 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2dj-1cTJRw1Q4x-00ed8x; Wed, 12
 Apr 2017 13:48:11 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] Document how to normalize the line endings
Date:   Wed, 12 Apr 2017 13:48:09 +0200
Message-Id: <20170412114809.31852-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
References: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7E3kuKkkLuNyC9/BfidPxLPxEYN4gaUV+NQezcnBMF/LCEC9bIH
 5DdvxYwllZb/CgqQnrJmc7sh186dJVUjmclxI9TpYx4oNDzi9IODDAbOTKLsei1vOic60ph
 wRh2TQZqovUyQEHCke5WpOxId9xd0xEmDVoLfwZmWcdK/OYSgSe8xNwnifrZYFKKo3mzgJz
 Sf6e6+Dj5jdWTGojL81yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gR5W+O8jSlw=:AHMaTsd4itfaqptKTwkXG1
 YvjaYZPp8S7vGMCQfvyUPGyd/Ny9/5JR2bSvQDapfj2RBi1K89wUdPKGaXIy8zAWy3WMdH0Vz
 d9w7n80yURkv5olweZwtsn/LSXI1SsTPTmoutNf71FffmG/GbeAKnO+1LnZxWg3Sxpu5NuQ08
 9xP6M4YwNh+DU7pUl4BrHB1u1ynBlxXZVY1QFlmq3Xr8R8kwISZfL2Dv2xLId7Tps4Suwblf2
 ppVjVtUf/zT5hndEVHAjF+mZXCt9TQL0zNZAZh892KS2FTR3Yvd/cILtYluVxIxe9CTTn12Sy
 EwPy6pKKxoyiH4TWPnCzr8/Tue97HBlGDsE0bSndUxahBISXKzHwAUY/SShfbgC3RYd5LA7qX
 DKKqKVKjRlvPXdeKVnilzLgbAkuJ1yzyFWuaqjeHPybzmlDdXogo3B8auFxQ5D9HJiVD2XA6o
 bBvZFL+Z5g924X1doHdKUrLkgdzXrxI5A5BNCK3gnEqvd8Km8XXDaQsKtIn1DiYmwsMiPNrjU
 mbCSdkGI8UguA8mWJbUkhCJvj463ea5Z9fKWW1Ga8AFWB6J/zbuFbxIatUajbJ+w7r8NFg2D+
 89VaQHwNqGeuqqV2baemNI+V1/myx5jufEeakfV2bLqD3HSDaYtx9OB/Je0RmTnwuv4SgHsVo
 1zrmLNWzsCt95bOWrqjXRG8QVX1sDGYzuoBdhBQuRu8BYQou0iBYnEnXWevm1PQ99dM29Dw/J
 2+i8TxnboZcLbzfGK4+i7aKZRypxzOep/xQ78rtEMj6fi7+IK0BwyTc07P9uiUT3+lOLfXj1d
 djHh+id
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The instructions how to normalize the line endings should have been updated
as part of commit 6523728499e 'convert: unify the "auto" handling of CRLF',
(but that part never made it into the commit).

Update the documentation in Documentation/gitattributes.txt
and add a test case in t0025.

Reported by Kristian Adrup
https://github.com/git-for-windows/git/issues/954

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt |  6 ++----
 t/t0025-crlf-auto.sh            | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 976243a..3b76687 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -227,11 +227,9 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to force Git to
-$ git reset         # re-scan the working directory
+$ rm .git/index     # Remove the index to re-scan the working directory
+$ git add .
 $ git status        # Show files that will be normalized
-$ git add -u
-$ git add .gitattributes
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index d0bee08..89826c5 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -152,4 +152,30 @@ test_expect_success 'eol=crlf _does_ normalize binary files' '
 	test -z "$LFwithNULdiff"
 '
 
+test_expect_success 'prepare unnormalized' '
+	> .gitattributes &&
+	git config core.autocrlf false &&
+	printf "LINEONE\nLINETWO\r\n"     >mixed &&
+	git add mixed .gitattributes &&
+	git commit -m "Add mixed" &&
+	git ls-files --eol | egrep "i/crlf" &&
+	git ls-files --eol | egrep "i/mixed"
+'
+
+test_expect_success 'normalize unnormalized' '
+	echo "* text=auto" >.gitattributes &&
+	rm .git/index &&
+	git add . &&
+	git commit -m "Introduce end-of-line normalization" &&
+	git ls-files --eol | tr "\\t" " " | sort >act &&
+cat >exp <<EOF &&
+i/-text w/-text attr/text=auto         LFwithNUL
+i/lf    w/crlf  attr/text=auto         CRLFonly
+i/lf    w/crlf  attr/text=auto         LFonly
+i/lf    w/lf    attr/text=auto         .gitattributes
+i/lf    w/mixed attr/text=auto         mixed
+EOF
+	test_cmp exp act
+'
+
 test_done
-- 
2.10.0

