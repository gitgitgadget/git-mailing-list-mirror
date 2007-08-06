From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 5/5] documentation: use the word "index" in the git-commit man page
Date: Mon,  6 Aug 2007 00:34:02 -0400
Message-ID: <6996.37848088077$1186374891@news.gmane.org>
References: 20070805222527.GB12168@fieldses.org
 <11863748422001-git-send-email->
 <1186374842108-git-send-email->
 <11863748422754-git-send-email->
 <11863748423686-git-send-email->
 <1186374842283-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@pig.linuxdev.us.dell.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 06:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHuIn-00086f-FW
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbXHFEea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXHFEe3
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:34:29 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38248 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbXHFEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:34:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHuI7-0001mS-0x; Mon, 06 Aug 2007 00:34:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <1186374842283-git-send-email->
Message-Id: <d30e77a3798bf9ccaec1efc5f2c7f01d47c35c5c.1186373089.git.bfields@pig.linuxdev.us.dell.com>
In-Reply-To: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
References: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55112>

From: J. Bruce Fields <bfields@pig.linuxdev.us.dell.com>

As with git-add, I think previous updates to the git-commit man page did
indeed help make it more user-friendly.  But I think the banishment of
the word "index" from the description goes too far; reinstate its use,
to simplify some of the language slightly and smooth the transition to
other documentation.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-commit.txt |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..f07a330 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,26 +15,26 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Use 'git commit' when you want to record your changes into the repository
-along with a log message describing what the commit is about. All changes
-to be committed must be explicitly identified using one of the following
-methods:
+Use 'git commit' to store the current contents of the index in a new
+commit along with a log message describing the changes you have made.
 
+The content to be added can be specified in several ways:
 1. by using gitlink:git-add[1] to incrementally "add" changes to the
-   next commit before using the 'commit' command (Note: even modified
+   index before using the 'commit' command (Note: even modified
    files must be "added");
 
-2. by using gitlink:git-rm[1] to identify content removal for the next
-   commit, again before using the 'commit' command;
+2. by using gitlink:git-rm[1] to remove files from the working tree
+   and the index, again before using the 'commit' command;
 
-3. by directly listing files containing changes to be committed as arguments
-   to the 'commit' command, in which cases only those files alone will be
-   considered for the commit;
+3. by listing files as arguments to the 'commit' command, in which
+   case the commit will ignore changes staged in the index, and instead
+   record the current content of the listed files;
 
-4. by using the -a switch with the 'commit' command to automatically "add"
-   changes from all known files i.e. files that have already been committed
-   before, and to automatically "rm" files that have been
-   removed from the working tree, and perform the actual commit.
+4. by using the -a switch with the 'commit' command to automatically
+   "add" changes from all known files (i.e. all files that are already
+   listed in the index) and to automatically "rm" files in the index
+   that have been removed from the working tree, and then perform the
+   actual commit;
 
 5. by using the --interactive switch with the 'commit' command to decide one
    by one which files should be part of the commit, before finalizing the
-- 
1.5.3.GIT
