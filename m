From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 01/13] Docs: send-email: Put options back into alphabetical order
Date: Mon, 13 Apr 2009 13:23:45 -0500
Message-ID: <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQs5-0007qH-T2
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbZDMSZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbZDMSZS
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:25:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:37750 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZDMSZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:25:16 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1130397wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BU8AhsjtBR1PNZ4f6S0+iZ/7K8yKUa7xm8HR8fvUGDQ=;
        b=L8QLJ933uMNSrnRiILZ/HCKHmiThS3kAbrPv/0ur0uFcOhs5G5t5TPkUg+FG162nlO
         tfsY+OTBiR79wVOIl8rGp6ez0b4U9DaxfxgsVuqMXBfAyrJS8LS/gPuuwisq1d1Z6PyE
         jVpAVxjV3ocQ/yKGlYuxFE3AU8ycn+IWVN5Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z+cQ6A/1szmCSM2U6wcedor5EHBwVuWM3ZrDOm8dVWMypcxYnOKI34h2bCqI/a0KAZ
         nzN4bILwrekKU6q5rBGVl3CQ0CwdvUIC2fmr/BqsSU3LY8ruE6QpPvKqM1wxynylv38e
         4/i058BNBkQnOyiJcQaj4LeJzNmOqJHwijQ9M=
Received: by 10.114.26.11 with SMTP id 11mr3298467waz.38.1239647115910;
        Mon, 13 Apr 2009 11:25:15 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:25:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116462>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0b1f183..4db5a09 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -39,6 +39,11 @@ OPTIONS
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
@@ -51,11 +56,6 @@ The --bcc option must be repeated for each user you want on the bcc list.
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
@@ -230,6 +230,12 @@ have been specified, in which case default to 'compose'.
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
@@ -246,12 +252,6 @@ have been specified, in which case default to 'compose'.
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
