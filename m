Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF3B1F829
	for <e@80x24.org>; Sun, 30 Apr 2017 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756980AbdD3PpI (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 11:45:08 -0400
Received: from mout1.freenet.de ([195.4.92.91]:52818 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756975AbdD3PpI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 11:45:08 -0400
Received: from [195.4.92.141] (helo=mjail1.freenet.de)
        by mout1.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d4r21-0001GR-Sy; Sun, 30 Apr 2017 17:45:05 +0200
Received: from localhost ([::1]:45884 helo=mjail1.freenet.de)
        by mjail1.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d4r21-0004Jz-PU; Sun, 30 Apr 2017 17:45:05 +0200
Received: from mx0.freenet.de ([195.4.92.10]:37199)
        by mjail1.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d4qzb-0001Ad-QA; Sun, 30 Apr 2017 17:42:35 +0200
Received: from p200300454467fa13e06c29e09bd4ce99.dip0.t-ipconnect.de ([2003:45:4467:fa13:e06c:29e0:9bd4:ce99]:52820 helo=p200300454467fa4464be414ec96be51f.dip0.t-ipconnect.de)
        by mx0.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:AES128-SHA256:128) (port 465) (Exim 4.85 #1)
        id 1d4qzb-0002jX-Hm; Sun, 30 Apr 2017 17:42:35 +0200
From:   =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
Subject: [PATCH] doc: update SubmittingPatches
Date:   Sun, 30 Apr 2017 17:42:21 +0200
Message-Id: <1493566941-4122-1-git-send-email-liebundartig@freenet.de>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:45:4467:fa13:e06c:29e0:9bd4:ce99!52820
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-use US English spelling
-minor wording change for better readability

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: René Genz <liebundartig@freenet.de>
---
 Documentation/SubmittingPatches | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bc8ad00..558d465 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -51,7 +51,7 @@ If your description starts to get too long, that's a sign that you
 probably need to split up your commit to finer grained pieces.
 That being said, patches which plainly describe the things that
 help reviewers check the patch, and future maintainers understand
-the code, are the most beautiful patches.  Descriptions that summarise
+the code, are the most beautiful patches.  Descriptions that summarize
 the point in the subject well, and describe the motivation for the
 change, the approach taken by the change, and if relevant how this
 differs substantially from the prior version, are all good things
@@ -87,7 +87,7 @@ patches separate from other documentation changes.
 Oh, another thing.  We are picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
 in templates/hooks--pre-commit.  To help ensure this does not happen,
-run git diff --check on your changes before you commit.
+run "git diff --check" on your changes before you commit.
 
 
 (2) Describe your changes well.
@@ -111,10 +111,10 @@ Improve...".
 
 The body should provide a meaningful commit message, which:
 
-  . explains the problem the change tries to solve, iow, what is wrong
+  . explains the problem the change tries to solve, i.e. what is wrong
     with the current code without the change.
 
-  . justifies the way the change solves the problem, iow, why the
+  . justifies the way the change solves the problem, i.e. why the
     result with the change is better.
 
   . alternate solutions considered but discarded, if any.
@@ -122,7 +122,7 @@ The body should provide a meaningful commit message, which:
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
-its behaviour.  Try to make sure your explanation can be understood
+its behavior.  Try to make sure your explanation can be understood
 without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
@@ -261,7 +261,7 @@ smaller project it is a good discipline to follow it.
 The sign-off is a simple line at the end of the explanation for
 the patch, which certifies that you wrote it or otherwise have
 the right to pass it on as a open-source patch.  The rules are
-pretty simple: if you can certify the below:
+pretty simple: if you can certify the below D-C-O:
 
         Developer's Certificate of Origin 1.1
 
-- 
1.9.1

