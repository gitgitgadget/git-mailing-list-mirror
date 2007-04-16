From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/7] Documentation: minor edits of git-lost-found manpage
Date: Mon, 16 Apr 2007 00:37:10 -0400
Message-ID: <46848.8904684365$1176698265@news.gmane.org>
References: <11766982362087-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy3-0008Sb-Q9
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbXDPEh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbXDPEhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36492 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005YR-H4; Mon, 16 Apr 2007 00:37:16 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982362087-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44578>

From: J. Bruce Fields <bfields@pad.(none)>

Minor improvements to grammar and clarity of lost-found manpage.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-lost-found.txt |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index f52a9d7..e48607f 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -12,23 +12,22 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Finds dangling commits and tags from the object database, and
-creates refs to them in .git/lost-found/ directory.  Commits and
-tags that dereference to commits go to .git/lost-found/commit
-and others are stored in .git/lost-found/other directory.
+creates refs to them in the .git/lost-found/ directory.  Commits and
+tags that dereference to commits are stored in .git/lost-found/commit,
+and other objects are stored in .git/lost-found/other.
 
 
 OUTPUT
 ------
-One line description from the commit and tag found along with
-their object name are printed on the standard output.
-
+Prints to standard output the object names and one-line descriptions
+of any commits or tags found.
 
 EXAMPLE
 -------
 
-Suppose you run 'git tag -f' and mistyped the tag to overwrite.
+Suppose you run 'git tag -f' and mistype the tag to overwrite.
 The ref to your tag is overwritten, but until you run 'git
-prune', it is still there.
+prune', the tag itself is still there.
 
 ------------
 $ git lost-found
@@ -36,15 +35,15 @@ $ git lost-found
 ...
 ------------
 
-Also you can use gitk to browse how they relate to each other
-and existing (probably old) tags.
+Also you can use gitk to browse how any tags found relate to each
+other.
 
 ------------
 $ gitk $(cd .git/lost-found/commit && echo ??*)
 ------------
 
-After making sure that it is the object you are looking for, you
-can reconnect it to your regular .git/refs hierarchy.
+After making sure you know which the object is the tag you are looking
+for, you can reconnect it to your regular .git/refs hierarchy.
 
 ------------
 $ git cat-file -t 1ef2b196
-- 
1.5.1.1.98.gedb4f
