From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] git-send-email.txt: move --format-patch paragraph to a proper location
Date: Sat, 27 Dec 2008 09:50:30 +0100
Message-ID: <1230367830-6114-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 27 09:51:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGUtl-0003Vn-EC
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 09:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYL0Iud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 03:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYL0Iuc
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 03:50:32 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3406
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYL0Iuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 03:50:32 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id EC6A4801BF66;
	Sat, 27 Dec 2008 09:50:30 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGUsQ-0001bA-0Y; Sat, 27 Dec 2008 09:50:30 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103991>

When introducing --format-patch, its documentation was accidentally ins=
erted
in the middle of documentation for --validate.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 Documentation/git-send-email.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 1278866..b69846e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -197,12 +197,6 @@ Administering
 --[no-]validate::
 	Perform sanity checks on patches.
 	Currently, validation means the following:
-
---[no-]format-patch::
-	When an argument may be understood either as a reference or as a file=
 name,
-	choose to understand it as a format-patch argument ('--format-patch')
-	or as a file name ('--no-format-patch'). By default, when such a conf=
lict
-	occurs, git send-email will fail.
 +
 --
 		*	Warn of patches that contain lines longer than 998 characters; thi=
s
@@ -212,6 +206,12 @@ Administering
 Default is the value of 'sendemail.validate'; if this is not set,
 default to '--validate'.
=20
+--[no-]format-patch::
+	When an argument may be understood either as a reference or as a file=
 name,
+	choose to understand it as a format-patch argument ('--format-patch')
+	or as a file name ('--no-format-patch'). By default, when such a conf=
lict
+	occurs, git send-email will fail.
+
=20
 CONFIGURATION
 -------------
--=20
1.6.1.307.g07803
