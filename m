From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 3/5] Documentation: minor grammatical fixes in git-cat-file.txt.
Date: Sun, 22 Mar 2009 18:00:15 -0700
Message-ID: <1237770017-7168-4-git-send-email-dmellor@whistlingcat.com>
References: <1237770017-7168-1-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-3-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 02:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYZ6-0004Ed-P7
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbZCWBA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756900AbZCWBAY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:00:24 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:39524 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155AbZCWBAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:00:21 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 40663488007;
	Sun, 22 Mar 2009 18:00:19 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 7390338E7583;
	Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 1685C17A5D; Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237770017-7168-3-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114221>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-cat-file.txt |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 668f697..390206e 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -3,7 +3,8 @@ git-cat-file(1)
 
 NAME
 ----
-git-cat-file - Provide content or type/size information for repository objects
+git-cat-file - Provide content or type and size information for repository
+objects
 
 
 SYNOPSIS
@@ -14,19 +15,19 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-In the first form, provides content or type of objects in the repository. The
-type is required unless '-t' or '-p' is used to find the object type, or '-s'
-is used to find the object size.
+In its first form, the command provides the content or the type of an object in
+the repository. The type is required unless '-t' or '-p' is used to find the
+object type, or '-s' is used to find the object size.
 
-In the second form, a list of object (separated by LFs) is provided on stdin,
-and the SHA1, type, and size of each object is printed on stdout.
+In the second form, a list of objects (separated by linefeeds) is provided on
+stdin, and the SHA1, type, and size of each object is printed on stdout.
 
 OPTIONS
 -------
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	the "SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
 -t::
 	Instead of the content, show the object type identified by
@@ -56,8 +57,8 @@ OPTIONS
 	stdin. May not be combined with any other options or arguments.
 
 --batch-check::
-	Print the SHA1, type, and size of each object provided on stdin. May not be
-	combined with any other options or arguments.
+	Print the SHA1, type, and size of each object provided on stdin. May not
+	be combined with any other options or arguments.
 
 OUTPUT
 ------
-- 
1.6.2.1
