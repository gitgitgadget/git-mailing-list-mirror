From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 1/4] Documentation: move diff.wordRegex from config.txt to diff-config.txt
Date: Tue, 13 Nov 2012 21:12:44 +0530
Message-ID: <1352821367-3611-2-git-send-email-artagnon@gmail.com>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIe0-0000rr-E8
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2KMPm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:42:58 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37022 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab2KMPm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:42:57 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so5097397pad.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LIGCCElxKuyfRn2vRpaYz4Zhp28BV3G8R+GKVOFpNjc=;
        b=yaK30C0zdWrcCHgXU3zgyb0L8goXKt1CGo+sNkRNXA5bMwCqE3meQAfMOBXZi8B8sE
         6opDat/ZDff1aBLpf/IexeZ1WpTAs6fzw8tUiK5fyHC/EG636+gUHDw2/2/IMqupOmZV
         oAtgk44kFM+QN4TYsehA7lNVU16yB6MlhJ63epb8MVjyI6rcQ1Uknscuio9isMUFHsyw
         Aa14jGPlz1gjek7QpZGmDaaMwGy/CGL39nWhnEgRxgarK4gGgur8JpTc8FOIpcn7x5lw
         dbw1pvBG2FnGYSPsWy+yegeRW37OVEVCwmnQYIKSJSZm3tCULYBF5THRA2sAoaXg4HsC
         Ws/g==
Received: by 10.68.234.167 with SMTP id uf7mr42207236pbc.20.1352821376419;
        Tue, 13 Nov 2012 07:42:56 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id hs2sm3546550pbc.22.2012.11.13.07.42.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 07:42:55 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209620>

19299a8 (Documentation: Move diff.<driver>.* from config.txt to
diff-config.txt, 2011-04-07) moved the diff configuration options to
diff-config.txt, but forgot about diff.wordRegex, which was left
behind in config.txt.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt      |    6 ------
 Documentation/diff-config.txt |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a0544c..e70216d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -962,12 +962,6 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
-diff.wordRegex::
-	A POSIX Extended Regular Expression used to determine what is a "word"
-	when performing word-by-word difference calculations.  Character
-	sequences that match the regular expression are "words", all other
-	characters are *ignorable* whitespace.
-
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 75ab8a5..decd370 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -107,6 +107,12 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.wordRegex::
+	A POSIX Extended Regular Expression used to determine what is a "word"
+	when performing word-by-word difference calculations.  Character
+	sequences that match the regular expression are "words", all other
+	characters are *ignorable* whitespace.
+
 diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
-- 
1.7.8.1.362.g5d6df.dirty
