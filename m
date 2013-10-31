From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 1/2] Use the word 'stuck' instead of 'sticked'
Date: Thu, 31 Oct 2013 12:08:28 +0100
Message-ID: <1383217709-5518-2-git-send-email-boklm@mars-attacks.org>
References: <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
 <1383217709-5518-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 12:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbq7T-000423-T1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 12:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3JaLIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 07:08:50 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:44764 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab3JaLIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 07:08:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id E40104E75;
	Thu, 31 Oct 2013 12:09:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id USlmBW2H_xHx; Thu, 31 Oct 2013 12:09:04 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 34DF43EC9;
	Thu, 31 Oct 2013 12:09:04 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 2FC6743934; Thu, 31 Oct 2013 12:08:48 +0100 (CET)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383217709-5518-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237119>

The past participle of 'stick' is 'stuck'.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/gitcli.txt                      | 6 +++---
 Documentation/technical/api-parse-options.txt | 6 +++---
 diff.c                                        | 2 +-
 diff.h                                        | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3146413cce0d..c87f0ae88d6c 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -72,11 +72,11 @@ scripting Git:
  * splitting short options to separate words (prefer `git foo -a -b`
    to `git foo -ab`, the latter may not even work).
 
- * when a command line option takes an argument, use the 'sticked' form.  In
+ * when a command line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
    options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
    for long options.  An option that takes optional option-argument must be
-   written in the 'sticked' form.
+   written in the 'stuck' form.
 
  * when you give a revision parameter to a command, make sure the parameter is
    not ambiguous with a name of a file in the work tree.  E.g. do not write
@@ -165,7 +165,7 @@ $ git foo -o Arg
 ----------------------------
 
 However, this is *NOT* allowed for switches with an optional value, where the
-'sticked' form must be used:
+'stuck' form must be used:
 ----------------------------
 $ git describe --abbrev HEAD     # correct
 $ git describe --abbrev=10 HEAD  # correct
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 0be2b5159f1b..be50cf4de35c 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -29,9 +29,9 @@ that allow to change the behavior of a command.
 
 The parse-options API allows:
 
-* 'sticked' and 'separate form' of options with arguments.
-  `-oArg` is sticked, `-o Arg` is separate form.
-  `--option=Arg` is sticked, `--option Arg` is separate form.
+* 'stuck' and 'separate form' of options with arguments.
+  `-oArg` is stuck, `-o Arg` is separate form.
+  `--option=Arg` is stuck, `--option Arg` is separate form.
 
 * Long options may be 'abbreviated', as long as the abbreviation
   is unambiguous.
diff --git a/diff.c b/diff.c
index e34bf971207f..3950e0191067 100644
--- a/diff.c
+++ b/diff.c
@@ -3394,7 +3394,7 @@ int parse_long_opt(const char *opt, const char **argv,
 	if (prefixcmp(arg, opt))
 		return 0;
 	arg += strlen(opt);
-	if (*arg == '=') { /* sticked form: --option=value */
+	if (*arg == '=') { /* stuck form: --option=value */
 		*optarg = arg + 1;
 		return 1;
 	}
diff --git a/diff.h b/diff.h
index e34232501ee8..1c05b3a6bec6 100644
--- a/diff.h
+++ b/diff.h
@@ -244,7 +244,7 @@ extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
 /*
- * Poor man's alternative to parse-option, to allow both sticked form
+ * Poor man's alternative to parse-option, to allow both stuck form
  * (--option=value) and separate form (--option value).
  */
 extern int parse_long_opt(const char *opt, const char **argv,
-- 
1.8.4
