From: Brad King <brad.king@kitware.com>
Subject: [PATCH] Documentation/commit-tree: mention -S option
Date: Mon, 25 Mar 2013 15:39:00 -0400
Message-ID: <14b024f9ee5c6319a0ff1f700f52d29b2464764f.1364240065.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 20:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDF8-0000NF-3F
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758877Ab3CYTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:39:14 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:48691 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757999Ab3CYTjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:39:13 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 744309AA7; Mon, 25 Mar 2013 15:39:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219069>

Commit ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) added the
-S option and documented it in the command usage.  Then commit 098bbdc3
(Add -S, --gpg-sign option to manpage of "git commit", 2012-10-21)
documented it in the porcelain manpage.  Use wording from the porcelain
to document the option in the plumbing manpage too.
---
 Documentation/git-commit-tree.txt |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 86ef56e..62f7b53 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -10,7 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git commit-tree' <tree> [(-p <parent>)...] < changelog
-'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...] <tree>
+'git commit-tree' [(-p <parent>)...] [-S<keyid>] [(-m <message>)...]
+		  [(-F <file>)...] <tree>
+
 
 DESCRIPTION
 -----------
@@ -52,6 +54,9 @@ OPTIONS
 	Read the commit log message from the given file. Use `-` to read
 	from the standard input.
 
+-S<keyid>::
+	GPG-sign commit.
+
 
 Commit Information
 ------------------
-- 
1.7.10.4
