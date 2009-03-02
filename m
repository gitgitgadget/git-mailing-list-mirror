From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 2/3] Documentation: minor grammatical fixes.
Date: Sun, 1 Mar 2009 22:38:36 -0800
Message-ID: <20090302163522.ACBDA17A49@sandstone.whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 02 17:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeB90-0008Ni-5L
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 17:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbZCBQf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 11:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754397AbZCBQfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 11:35:25 -0500
Received: from quartz.whistlingcat.com ([67.223.228.111]:45843 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbZCBQfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 11:35:24 -0500
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id DA798488006;
	Mon,  2 Mar 2009 08:35:22 -0800 (PST)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id B2F2B38E74F0;
	Mon,  2 Mar 2009 08:35:22 -0800 (PST)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id ACBDA17A49; Mon,  2 Mar 2009 08:35:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111947>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/blame-options.txt |    6 +++---
 Documentation/git-annotate.txt  |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 7f28432..df2a7c1 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -74,7 +74,7 @@ of lines before or after the line given by <start>.
 	Detect moving lines in the file as well.  When a commit
 	moves a block of lines in a file (e.g. the original file
 	has A and then B, and the commit changes it to B and
-	then A), traditional 'blame' algorithm typically blames
+	then A), the traditional 'blame' algorithm typically blames
 	the lines that were moved up (i.e. B) to the parent and
 	assigns blame to the lines that were moved down (i.e. A)
 	to the child commit.  With this option, both groups of lines
@@ -90,8 +90,8 @@ commit.
 	files that were modified in the same commit.  This is
 	useful when you reorganize your program and move code
 	around across files.  When this option is given twice,
-	the command looks for copies from all other files in the
-	parent for the commit that creates the file in addition.
+	the command additionally looks for copies from all other
+	files in the parent for the commit that creates the file.
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 0aba022..0590eec 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -3,7 +3,7 @@ git-annotate(1)
 
 NAME
 ----
-git-annotate - Annotate file lines with commit info
+git-annotate - Annotate file lines with commit information
 
 SYNOPSIS
 --------
@@ -12,11 +12,11 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Annotates each line in the given file with information from the commit
-which introduced the line. Optionally annotate from a given revision.
+which introduced the line. Optionally annotates from a given revision.
 
 The only difference between this command and linkgit:git-blame[1] is that
 they use slightly different output formats, and this command exists only
-for backward compatibility to support existing scripts, and provide more
+for backward compatibility to support existing scripts, and provide a more
 familiar command name for people coming from other SCM systems.
 
 OPTIONS
-- 
1.6.1.3
