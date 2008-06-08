From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/5] git-commit.txt: Add missing long/short options
Date: Sun,  8 Jun 2008 03:36:08 +0200
Message-ID: <1212888972-29039-1-git-send-email-s-beyer@gmx.net>
References: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59qd-0000LG-SR
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbYFHBgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 21:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbYFHBgg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:36:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:38663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755739AbYFHBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 21:36:35 -0400
Received: (qmail invoked by alias); 08 Jun 2008 01:36:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp068) with SMTP; 08 Jun 2008 03:36:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+pOvAntLipqgbVIZVUpdYhBssOl1n67KDeNog/RN
	1ZB+XEJep8jPBr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K59pM-0007Yl-QU; Sun, 08 Jun 2008 03:36:12 +0200
X-Mailer: git-send-email 1.5.6.rc1.21.g03300
In-Reply-To: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84242>

And split the "-c or -C <commit>" item into two separate items.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

so here's the first one ;-)

 Documentation/git-commit.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 40bf63e..a94b4e3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -57,14 +57,16 @@ OPTIONS
 	been modified and deleted, but new files you have not
 	told git about are not affected.
 
--c or -C <commit>::
+-C <commit>|--reuse-message=<commit>::
 	Take existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
-	when creating the commit.  With '-C', the editor is not
-	invoked; with '-c' the user can further edit the commit
-	message.
+	when creating the commit.
 
--F <file>::
+-c <commit>|--reedit-message=<commit>::
+	Like '-C', but with '-c' the editor is invoked, so that
+	the user can further edit the commit message.
+
+-F <file>|--file=<file>::
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
@@ -85,7 +87,7 @@ OPTIONS
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
---no-verify::
+-n|--no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
 	See also linkgit:githooks[5][hooks].
 
@@ -112,7 +114,6 @@ OPTIONS
 	further edit the message taken from these sources.
 
 --amend::
-
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
 	(this includes the usual -i/-o and explicit paths), and the
-- 
1.5.5.1
