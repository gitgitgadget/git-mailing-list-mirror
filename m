From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] git-svn: Document the `create-ignore', `propget' and `proplist' subcommands.
Date: Mon, 12 Nov 2007 18:13:19 +0100
Message-ID: <1194887599-5821-1-git-send-email-tsuna@lrde.epita.fr>
References: <1192545412-10929-4-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ircr5-0002WX-UF
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759819AbXKLRNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759800AbXKLRNc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:13:32 -0500
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:65516 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757818AbXKLRNc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 12:13:32 -0500
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 99529CC01A1; Mon, 12 Nov 2007 18:13:19 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.654.gdd5ec
In-Reply-To: <1192545412-10929-4-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64665>

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
I forgot to do this when I added these options to git-svn, my bad, sorry about
that.  I think mentioning the current limitation of the implementation of
propget and proplist is worthwhile, I wouldn't like to be surprised by this.
Moreover, this is the kind of thing that's going to be fixed (or rather
"enhanced" I should say), one day or another.

 Documentation/git-svn.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 488e4b1..0d5406d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -182,6 +182,9 @@ Any other arguments are passed directly to `git log'
 	directories.  The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
+'create-ignore'::
+	Create a .gitignore file per svn:ignore.
+
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
 	command-line.  This command is intended for interoperability with
@@ -193,6 +196,16 @@ Any other arguments are passed directly to `git log'
 	repository (that has been init-ed with git-svn).
 	The -r<revision> option is required for this.
 
+'propget'::
+	Print the value of a property on a file or directory.
+	The current implementation needs access to the SVN repository to
+	perform this operation.
+
+'proplist'::
+	List all properties of a file or directory.
+	The current implementation needs access to the SVN repository to
+	perform this operation.
+
 --
 
 OPTIONS
-- 
1.5.3.5.654.gdd5ec
