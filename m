From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 01/10] Docs: send-email: Put options back into alphabetical order
Date: Sat, 11 Apr 2009 14:08:19 -0500
Message-ID: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsias-0001Gu-OH
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbZDKTIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758189AbZDKTIu
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:08:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:39318 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757875AbZDKTIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:08:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1608959ywb.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=o4sbmqZpgineo3tAJZCtrUVKa73frbqLL2gCAWLkkwI=;
        b=j6dMpzMUvfZRmOemwiRICkkhwVOxHZ6AqcFxx7PBxZuMapGsLwk0eCW6Ug/XNYgOFz
         TxT6vzlIlz5N2trGR0ela5vHczWpOm2OkHJtT60JWigvdcb/9iwm7Kgg+FjVOZBprUZa
         ZXPUtI1cdWwwsMvUIYeb+3GSIxdGUoT5kSaOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=jytTd2x6zjRwY2Zt1rZ8rdtkOnC65HOEByphwiUHudsyVG6MPc8YaPimZigAt02Quh
         4X7PRjfhh/8dDjvCbftOz0UHkpV9RHHujcwFuS6l0iZoYfVJloP6zBtS5ggsHqqIq0Bg
         UVpuyYqTxO3S56oZI0aXxw35XnkhS+yB/927o=
Received: by 10.100.249.10 with SMTP id w10mr4972912anh.3.1239476928513;
        Sat, 11 Apr 2009 12:08:48 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.08.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:08:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116310>

I also wrote a comment block as a warning to trespassers.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0b1f183..595c7ba 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -32,6 +32,10 @@ script
 This format expects the first line of the file to contain the "Cc:" value
 and the "Subject:" of the message as the second line.
 
+/////////////////////////////////////////////////////////////////////////////////////
+//// Within each category (Composing, Sending, Automating, and Administering),   ////
+//// options are to be given in alphabetical order. Please maintain this layout. ////
+/////////////////////////////////////////////////////////////////////////////////////
 
 OPTIONS
 -------
@@ -39,6 +43,11 @@ OPTIONS
 Composing
 ~~~~~~~~~
 
+--annotate::
+	Review each patch you're about to send in an editor. The setting
+	'sendemail.multiedit' defines if this will spawn one editor per patch
+	or one for all of them at once.
+
 --bcc=<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
@@ -51,11 +60,6 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
---annotate::
-	Review each patch you're about to send in an editor. The setting
-	'sendemail.multiedit' defines if this will spawn one editor per patch
-	or one for all of them at once.
-
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
@@ -230,6 +234,12 @@ have been specified, in which case default to 'compose'.
 --dry-run::
 	Do everything except actually send the emails.
 
+--[no-]format-patch::
+	When an argument may be understood either as a reference or as a file name,
+	choose to understand it as a format-patch argument ('--format-patch')
+	or as a file name ('--no-format-patch'). By default, when such a conflict
+	occurs, git send-email will fail.
+
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
@@ -246,12 +256,6 @@ have been specified, in which case default to 'compose'.
 Default is the value of 'sendemail.validate'; if this is not set,
 default to '--validate'.
 
---[no-]format-patch::
-	When an argument may be understood either as a reference or as a file name,
-	choose to understand it as a format-patch argument ('--format-patch')
-	or as a file name ('--no-format-patch'). By default, when such a conflict
-	occurs, git send-email will fail.
-
 
 CONFIGURATION
 -------------
-- 
1.6.2.2.479.g2aec
