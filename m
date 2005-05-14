From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --author match to git-rev-list and git-rev-tree
 (Documentation)
Date: Sat, 14 May 2005 02:56:18 -0700
Message-ID: <7vpsvu2ksd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 11:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWtNz-00056f-Ej
	for gcvg-git@gmane.org; Sat, 14 May 2005 11:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVENJ4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 05:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVENJ4g
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 05:56:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38122 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262726AbVENJ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 05:56:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514095619.QVIK23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 05:56:19 -0400
To: Zack Brown <zbrown@tumblerings.org>, pasky@ucw.cz,
	torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This documents the --author match to the two commands.
It also fixes git-rev-list documentation, which lacked
descriptions for existing options.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-rev-list.txt |   16 +++++++++++++++-
Documentation/git-rev-tree.txt |    5 ++++-
2 files changed, 19 insertions(+), 2 deletions(-)

--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-rev-list' <commit>
+'git-rev-list' [--author=author] [--max-count=count] [--max-age=unixtime] [--min-age=unixtime] <commit>
 
 DESCRIPTION
 -----------
@@ -18,6 +18,20 @@
 useful to produce human-readable log output.
 
 
+OPTIONS
+-------
+--author::
+	Limit the final output to commits made by the author.
+
+--max-count::
+	Stop after showing the specified number of commits.
+
+--max-age::
+	Stop before showing the commits older than specified time.
+
+--min-age::
+	Do not show the commits newer than specified time.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
--- a/Documentation/git-rev-tree.txt
+++ b/Documentation/git-rev-tree.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-rev-tree' [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
+'git-rev-tree' [--author author] [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
 
 DESCRIPTION
 -----------
@@ -17,6 +17,9 @@
 
 OPTIONS
 -------
+--author::
+	Limit the final output to commits made by the author.
+
 --edges::
 	Show edges (ie places where the marking changes between parent
 	and child)
------------------------------------------------

