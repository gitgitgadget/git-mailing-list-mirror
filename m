From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] Documentation: move diff.wordRegex from config.txt to diff-config.txt
Date: Sun, 11 Nov 2012 22:29:04 +0530
Message-ID: <1352653146-3932-2-git-send-email-artagnon@gmail.com>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXasf-00055R-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab2KKQ7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:59:18 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59164 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2KKQ7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:59:17 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2391580dak.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 08:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LIGCCElxKuyfRn2vRpaYz4Zhp28BV3G8R+GKVOFpNjc=;
        b=pSuVP3sBgiAFNzcqGkWxvQZrUGZ/JcjpEneblNtNQ0tSZLBui9p34p/fw+LW2PK6MH
         jjsJLijAdmTDQdwownLMuC+rnGB5riO8GIZJ/6tAEpSN/ZDgK68HYOq8GNekJVWIwHy6
         lPov7bPR4aKpQUusyHp1b+LhR036Rql7wnmYCm62R7b0zWFCsmWGH9Ix46HlKjZuF7EP
         Cw/79eBkEfteeIc4RBZlJaxH7LOckKaCLmRLuNoD/oE8as2cV4AU50TtxccgafjZe3BJ
         /pIXnqyj+XgFYtICq9GzoOJ6KM9W6Jquy61ppE6h1ELm0auCYDm2gWf8mg5ZGrYJj5no
         VEhw==
Received: by 10.68.239.198 with SMTP id vu6mr44554006pbc.109.1352653157185;
        Sun, 11 Nov 2012 08:59:17 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id s1sm2824079paz.0.2012.11.11.08.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 08:59:16 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209410>

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
