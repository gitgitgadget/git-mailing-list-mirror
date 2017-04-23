Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF29207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1045556AbdDWOAE (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 10:00:04 -0400
Received: from mout1.freenet.de ([195.4.92.91]:32840 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754307AbdDWOAD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 10:00:03 -0400
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout1.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d2I3U-0001TH-Oc; Sun, 23 Apr 2017 16:00:00 +0200
Received: from localhost ([::1]:57911 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d2I3U-0003yI-M1; Sun, 23 Apr 2017 16:00:00 +0200
Received: from mx7.freenet.de ([195.4.92.17]:55896)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d2I0w-0000tN-8D; Sun, 23 Apr 2017 15:57:22 +0200
Received: from p200300454467fa4464be414ec96be51f.dip0.t-ipconnect.de ([2003:45:4467:fa44:64be:414e:c96b:e51f]:57829)
        by mx7.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:AES128-SHA256:128) (port 465) (Exim 4.85 #1)
        id 1d2I0v-0003MA-Va; Sun, 23 Apr 2017 15:57:22 +0200
From:   =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
Subject: [PATCH] fix minor typing mistakes
Date:   Sun, 23 Apr 2017 15:56:49 +0200
Message-Id: <1492955809-29018-1-git-send-email-liebundartig@freenet.de>
X-Mailer: git-send-email 1.9.1
X-Originated-At: 2003:45:4467:fa44:64be:414e:c96b:e51f!57829
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks-to: Stefan Beller <sbeller@google.com>
---
 Documentation/git-commit.txt        | 4 ++--
 Documentation/gitremote-helpers.txt | 2 +-
 ci/run-windows-build.sh             | 2 +-
 diff.c                              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ed0f5b9..afb06ad 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -95,7 +95,7 @@ OPTIONS
 
 --reset-author::
 	When used with -C/-c/--amend options, or when committing after a
-	a conflicting cherry-pick, declare that the authorship of the
+	conflicting cherry-pick, declare that the authorship of the
 	resulting commit now belongs to the committer. This also renews
 	the author timestamp.
 
@@ -112,7 +112,7 @@ OPTIONS
 	`--dry-run`.
 
 --long::
-	When doing a dry-run, give the output in a the long-format.
+	When doing a dry-run, give the output in the long-format.
 	Implies `--dry-run`.
 
 -z::
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index e4b785e..4a584f3 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -463,7 +463,7 @@ set by Git if the remote helper has the 'option' capability.
 	GPG sign pushes.
 
 'option push-option <string>::
-	Transmit <string> as a push option. As the a push option
+	Transmit <string> as a push option. As the push option
 	must not contain LF or NUL characters, the string is not encoded.
 
 SEE ALSO
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 4e3a50b..9f89d54 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Script to trigger the a Git for Windows build and test run.
+# Script to trigger the Git for Windows build and test run.
 # Set the $GFW_CI_TOKEN as environment variable.
 # Pass the branch (only branches on https://github.com/git/git are
 # supported) and a commit hash.
diff --git a/diff.c b/diff.c
index 11eef1c..74283d9 100644
--- a/diff.c
+++ b/diff.c
@@ -911,7 +911,7 @@ static int fn_out_diff_words_write_helper(FILE *fp,
 /*
  * '--color-words' algorithm can be described as:
  *
- *   1. collect a the minus/plus lines of a diff hunk, divided into
+ *   1. collect the minus/plus lines of a diff hunk, divided into
  *      minus-lines and plus-lines;
  *
  *   2. break both minus-lines and plus-lines into words and
-- 
1.9.1

