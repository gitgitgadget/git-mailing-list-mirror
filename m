From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] Document git-notes
Date: Mon, 16 Jul 2007 00:24:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160024440.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADSo-0001bu-2g
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbXGOXZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbXGOXZL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:25:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:52321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755114AbXGOXZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:25:09 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:25:08 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp044) with SMTP; 16 Jul 2007 01:25:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QsM0HwwnQjKj9bO/C64Wi0i4Sq0KSUe31yFuBJ4
	snGXc5Exgfrdki
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52604>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/cmd-list.perl |    1 +
 Documentation/git-notes.txt |   45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 2143995..f05e291 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -140,6 +140,7 @@ git-mergetool                           ancillarymanipulators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain
+git-notes                               mainporcelain
 git-name-rev                            plumbinginterrogators
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
new file mode 100644
index 0000000..331ed89
--- /dev/null
+++ b/Documentation/git-notes.txt
@@ -0,0 +1,45 @@
+git-notes(1)
+============
+
+NAME
+----
+git-notes - Add commit notes
+
+SYNOPSIS
+--------
+[verse]
+'git-notes' (edit | show) [commit
+
+DESCRIPTION
+-----------
+This command allows you to add notes to commit messages, after the
+fact.  To discern these notes from the message stored in the commit
+object, the notes are indented like the message, after an unindented
+line saying "Notes:".
+
+To enable commit notes, you have to set the config variable
+core.notesRef to something like "refs/notes/commits".  This setting
+can be overridden by the environment variable "GIT_NOTES_REF".
+
+
+SUBCOMMANDS
+-----------
+
+edit::
+	Edit the notes for a given commit (defaults to HEAD).
+
+show::
+	Show the notes for a given commit (defaults to HEAD).
+
+
+Author
+------
+Written by Johannes Schindelin <johannes.schindelin@gmx.de>
+
+Documentation
+-------------
+Documentation by Johannes Schindelin
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.3.rc1.2718.gd2dc9-dirty
