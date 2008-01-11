From: Humberto Diogenes <humberto@digi.com.br>
Subject: [PATCH] manpages: linking all mail-related commands
Date: Fri, 11 Jan 2008 20:48:06 -0300
Message-ID: <1200095286-2621-1-git-send-email-humberto@digi.com.br>
Cc: gitster@pobox.com, humberto <humberto@digi.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 01:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUQ0-0006IY-Uq
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762637AbYALAjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762621AbYALAjp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:39:45 -0500
Received: from huguinho.digi.com.br ([201.76.144.70]:3958 "EHLO
	huguinho.digi.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762599AbYALAjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:39:45 -0500
X-Greylist: delayed 3094 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2008 19:39:44 EST
Received: from localhost.localdomain (eddie.digi.com.br [201.76.154.21])
	by huguinho.digi.com.br (Postfix) with ESMTP id BF7C2333184;
	Fri, 11 Jan 2008 20:48:06 -0300 (GMT+3)
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70237>

From: humberto <humberto@digi.com.br>

---
 Documentation/git-am.txt           |    6 ++++--
 Documentation/git-apply.txt        |    4 ++++
 Documentation/git-format-patch.txt |    7 ++++---
 Documentation/git-imap-send.txt    |    5 +++++
 Documentation/git-send-email.txt   |    6 ++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e4a6b3a..fd00fc1 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -144,8 +144,10 @@ names.
 
 SEE ALSO
 --------
-gitlink:git-apply[1].
-
+gitlink:git-apply[1],
+gitlink:git-format-patch[1],
+gitlink:git-imap-send[1],
+gitlink:git-send-email[1]
 
 Author
 ------
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c1c54bf..53fa937 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -189,6 +189,10 @@ If --index is not specified, then the submodule commits in the patch
 are ignored and only the absence of presence of the corresponding
 subdirectory is checked and (if possible) updated.
 
+See Also
+--------
+gitlink:git-am[1]
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f0617ef..0221b6d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -184,10 +184,11 @@ git-format-patch -3::
 	Extract three topmost commits from the current branch
 	and format them as e-mailable patches.
 
-See Also
+SEE ALSO
 --------
-gitlink:git-am[1], gitlink:git-send-email[1]
-
+gitlink:git-am[1],
+gitlink:git-imap-send[1],
+gitlink:git-send-email[1]
 
 Author
 ------
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index eca9e9c..8397dcb 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -48,6 +48,11 @@ BUGS
 ----
 Doesn't handle lines starting with "From " in the message body.
 
+SEE ALSO
+--------
+gitlink:git-am[1],
+gitlink:git-format-patch[1],
+gitlink:git-send-email[1]
 
 Author
 ------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 16bfd7b..9214596 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -143,6 +143,12 @@ sendemail.chainreplyto::
 sendemail.smtpserver::
 	Default smtp server to use.
 
+SEE ALSO
+--------
+gitlink:git-am[1],
+gitlink:git-format-patch[1],
+gitlink:git-imap-send[1]
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.5.3.6
