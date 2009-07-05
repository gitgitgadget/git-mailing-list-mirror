From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] List send-email config options in config.txt.
Date: Mon,  6 Jul 2009 01:05:28 +0200
Message-ID: <112440b74f47290e55209b23d1bfc66ed2423297.1246834884.git.ydirson@altern.org>
References: <cover.1246834883.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 08:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNi4V-0003Rl-5p
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 08:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZGFGwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 02:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZGFGwv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 02:52:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:53798 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbZGFGwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 02:52:51 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1CABE940031;
	Mon,  6 Jul 2009 08:52:47 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2F1699400CB;
	Mon,  6 Jul 2009 08:52:45 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1C397A004; Mon,  6 Jul 2009 01:05:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <cover.1246834883.git.ydirson@altern.org>
In-Reply-To: <cover.1246834883.git.ydirson@altern.org>
References: <cover.1246834883.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122773>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/config.txt |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2fecbe3..55fa938 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1379,6 +1379,46 @@ rerere.enabled::
 	default enabled if you create `rr-cache` directory under
 	`$GIT_DIR`, but can be disabled by setting this option to false.
 
+sendemail.aliasesfile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+
+sendemail.aliasfiletype::
+	Format of the file(s) specified in sendemail.aliasesfile. Must be
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
+
+sendemail.bcc::
+sendemail.cc::
+sendemail.cccmd::
+sendemail.chainreplyto::
+
+sendemail.confirm::
+	Sets the default for whether to confirm before sending. Must be
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
+	in the previous section for the meaning of these values.
+
+sendemail.multiedit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when '--annotate' is used, and the
+	summary when '--compose' is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
+sendemail.envelopesender::
+sendemail.from::
+sendemail.identity::
+sendemail.<identity>.*::
+sendemail.signedoffbycc::
+sendemail.smtpencryption::
+sendemail.smtppass::
+sendemail.suppresscc::
+sendemail.suppressfrom::
+sendemail.to::
+sendemail.smtpserver::
+sendemail.smtpserverport::
+sendemail.smtpuser::
+sendemail.thread::
+sendemail.validate::
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
-- 
1.6.3.3
