From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] Documentation: move diff.wordRegex from config.txt to diff-config.txt
Date: Thu,  1 Nov 2012 16:13:48 +0530
Message-ID: <1351766630-4837-2-git-send-email-artagnon@gmail.com>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTsG5-0006qR-2M
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 11:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab2KAKoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 06:44:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61418 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab2KAKoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 06:44:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1650246pbb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+LKQICWyEoAbPQHBMN/JSBIYt5FZqTVKLBw2DIe8m7s=;
        b=rlfFR6PgLi7Y+bDg+o4cnKF8x9ykAKiIYTxcIl0y+AArAVS+le8pDl82SP7vY7awO4
         Po8aaR3xUWR3A/vNZReBvgwPS79TdGnavfmVJ1hwnHztXmkzG4EYdfzfWKz4b99o2wU8
         v8ydeShuWgVB+t++fFhOpnRAeEJvFegd9sQf0FosXd/qaHjJ6m+2SLW4wVUXNOP8SV0B
         k0NYPoKqddN/w9ivK5Mi7PrrMNz9zT6F6d7maF3tm1tbd5AohfE8H3RnpZ3eixKWOtFt
         o+D9QDbNDxDMlt+CByzrczNdgVRP1kD3H3LfJJdoyopqy+1P+hWWmY6vXaJmlMz3rUBM
         DmGA==
Received: by 10.66.74.65 with SMTP id r1mr109905622pav.75.1351766642005;
        Thu, 01 Nov 2012 03:44:02 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id vw4sm3855414pbc.26.2012.11.01.03.43.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 03:44:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208870>

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
index 11f320b..d1de857 100644
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
