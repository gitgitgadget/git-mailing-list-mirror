Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AF4207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162141AbdDWQUz (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 12:20:55 -0400
Received: from mout1.freenet.de ([195.4.92.91]:37254 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1045839AbdDWQUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 12:20:53 -0400
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout1.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d2KFn-0005u6-84; Sun, 23 Apr 2017 18:20:51 +0200
Received: from localhost ([::1]:56493 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d2KFm-0000n2-3b; Sun, 23 Apr 2017 18:20:50 +0200
Received: from mx9.freenet.de ([195.4.92.19]:39981)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d2KDM-0006vZ-MV; Sun, 23 Apr 2017 18:18:20 +0200
Received: from p200300454467fa4464be414ec96be51f.dip0.t-ipconnect.de ([2003:45:4467:fa44:64be:414e:c96b:e51f]:50923)
        by mx9.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:AES128-SHA256:128) (port 465) (Exim 4.85 #1)
        id 1d2KDN-0002CB-Go; Sun, 23 Apr 2017 18:18:21 +0200
From:   =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
Subject: [PATCH] doc: update SubmittingPatches
Date:   Sun, 23 Apr 2017 18:17:44 +0200
Message-Id: <1492964264-29423-1-git-send-email-liebundartig@freenet.de>
X-Mailer: git-send-email 1.9.1
X-Originated-At: 2003:45:4467:fa44:64be:414e:c96b:e51f!50923
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-use US English spelling
-based on my own experience:
 * add commands used to contribute a patch
 * minor wording change for better readability

Thanks-to: Stefan Beller <sbeller@google.com>
---
 Documentation/SubmittingPatches | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bc8ad00..ac027ba 100644
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
 
@@ -376,6 +376,25 @@ from the list and queue it to 'pu', in order to make it easier for
 people play with it without having to pick up and apply the patch to
 their trees themselves.
 
+
+An oversimplified summary of the commands to run:
+* clone repo
+  $ git clone https://github.com/git/git
+
+* change files in your local repo copy
+
+* commit your changes
+  $ git commit -a
+
+* create '.patch' file for the latest commit
+  $ git format-patch HEAD^
+
+* install 'git-email' package and configure it, f.e.
+    https://www.freedesktop.org/wiki/Software/PulseAudio/HowToUseGitSendEmail/
+  send an email to yourself using your MUA in order to find out the value
+  for the "--smtp-domain" option; look at the 'Received' header option
+  $ git send-email --annotate --smtp-domain=LONGSTRING --to=git@vger.kernel.org --cc=MAINTAINER --smtp-debug=1 NAME.patch
+
 ------------------------------------------------
 Know the status of your patch after submission
 
-- 
1.9.1

