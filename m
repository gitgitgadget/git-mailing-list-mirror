From: Florian Weimer <fw@deneb.enyo.de>
Subject: [PATCH] AsciiDoc fixes for the git-svnimport manpage
Date: Sat, 21 Jan 2006 20:06:19 +0100
Message-ID: <E1F0O43-0002pn-7O@mid.deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Jan 21 20:06:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0O4E-0007j4-Ph
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWAUTG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWAUTG2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:06:28 -0500
Received: from mail.enyo.de ([212.9.189.167]:30695 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751165AbWAUTG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 14:06:27 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F0O49-0002mC-1j
	for git@vger.kernel.org; Sat, 21 Jan 2006 20:06:25 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F0O43-0002pn-7O
	for git@vger.kernel.org; Sat, 21 Jan 2006 20:06:19 +0100
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15002>

Change "SVN:: Perl" to "SVN::Perl", wrap a long line, and clean up the
description of positional arguments.

Signed-off-by: Florian Weimer <fw@deneb.enyo.de>

---

 Documentation/git-svnimport.txt |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

592699f759a61aee33060d91cfe13ff432c147cf
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index db1ce38..63e28b8 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -21,7 +21,7 @@ DESCRIPTION
 Imports a SVN repository into git. It will either create a new
 repository, or incrementally import into an existing one.
 
-SVN access is done by the SVN:: Perl module.
+SVN access is done by the SVN::Perl module.
 
 git-svnimport assumes that SVN repositories are organized into one
 "trunk" directory where the main development happens, "branch/FOO"
@@ -74,8 +74,8 @@ When importing incrementally, you might 
 -l <max_rev>::
 	Specify a maximum revision number to pull.
 
-	Formerly, this option controlled how many revisions to pull, due to
-	SVN memory leaks. (These have been worked around.)
+	Formerly, this option controlled how many revisions to pull,
+	due to SVN memory leaks. (These have been worked around.)
 
 -v::
 	Verbosity: let 'svnimport' report what it is doing.
@@ -100,11 +100,7 @@ with a 40x error pretty quickly.
 If you're using the "-d" or "-D" option, this is the URL of the SVN
 repository itself; it usually ends in "/svn".
 
-<SVN_repository_URL>::
-	The URL of the SVN module you want to import. For local
-	repositories, use "file:///absolute/path".
-
-<path>
+<path>::
 	The path to the module you want to check out.
 
 -h::
-- 
1.1.3
