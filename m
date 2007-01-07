From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: tutorial editing
Date: Sat, 6 Jan 2007 22:38:38 -0500
Message-ID: <20070107033838.GB9104@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 04:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Ors-0000A8-9S
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 04:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXAGDik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 22:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbXAGDik
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 22:38:40 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36533 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbXAGDik (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 22:38:40 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3Orm-0002le-Nv; Sat, 06 Jan 2007 22:38:38 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36123>

Edit for conciseness.

Add a "Making changes" section header.

When possible, make sure that stuff in text boxes could be entered literally.
(Don't use "..." unless we want a user to type that.)

Move 'commit -a' example into a literal code section, clarify that it finds
modified files automatically.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/tutorial.txt |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 79884d9..2fdeed2 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -43,8 +43,7 @@ Initialized empty Git repository in .git/
 
 You've now initialized the working directory--you may notice a new
 directory created, named ".git".  Tell git that you want it to track
-every file under the current directory with (notice the dot '.'
-that means the current directory):
+every file under the current directory (note the '.') with:
 
 ------------------------------------------------
 $ git add .
@@ -59,6 +58,9 @@ $ git commit
 will prompt you for a commit message, then record the current state
 of all the files to the repository.
 
+Making changes
+--------------
+
 Try modifying some files, then run
 
 ------------------------------------------------
@@ -70,19 +72,21 @@ want the updated contents of these files in the commit and then
 make a commit, like this:
 
 ------------------------------------------------
-$ git add file1 file...
+$ git add file1 file2 file3
 $ git commit
 ------------------------------------------------
 
 This will again prompt your for a message describing the change, and then
-record the new versions of the files you listed.  It is cumbersome
-to list all files and you can say `git commit -a` (which stands for 'all')
-instead of running `git add` beforehand.
+record the new versions of the files you listed. 
+
+Alternatively, instead of running `git add` beforehand, you can use
 
 ------------------------------------------------
 $ git commit -a
 ------------------------------------------------
 
+which will automatically notice modified (but not new) files.
+
 A note on commit messages: Though not required, it's a good idea to
 begin the commit message with a single short (less than 50 character)
 line summarizing the change, followed by a blank line and then a more
-- 
1.5.0.rc0.ge16c2
