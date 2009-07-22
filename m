From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] List send-email config options in config.txt.
Date: Wed, 22 Jul 2009 23:39:30 +0200
Message-ID: <1248298771-21075-2-git-send-email-ydirson@altern.org>
References: <1248298771-21075-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjXc-0000vv-1U
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZGVVjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZGVVjq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:39:46 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58184 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbZGVVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:39:45 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C9A14940139;
	Wed, 22 Jul 2009 23:39:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A82CF9400F2;
	Wed, 22 Jul 2009 23:39:36 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id F0A0FA004; Wed, 22 Jul 2009 23:39:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.12.g05859c
In-Reply-To: <1248298771-21075-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123779>

Also mention deprecated aliases that do not appear in the send-email
manpage.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/config.txt |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb6832b..6857d2f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1387,6 +1387,50 @@ rerere.enabled::
 	default enabled if you create `rr-cache` directory under
 	`$GIT_DIR`, but can be disabled by setting this option to false.
 
+sendemail.identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of 'sendemail.identity'.
+
+sendemail.smtpencryption::
+	See linkgit:git-send-email[1] for description.  Note that this
+	setting is not subject to the 'identity' mechanism.
+
+sendemail.smtpssl::
+	Deprecated alias for 'sendemail.smtpencryption = ssl'.
+
+sendemail.<identity>.*::
+	Identity-specific versions of the 'sendemail.*' parameters
+	found below, taking precedence over those when the this
+	identity is selected, through command-line or
+	'sendemail.identity'.
+
+sendemail.aliasesfile::
+sendemail.aliasfiletype::
+sendemail.bcc::
+sendemail.cc::
+sendemail.cccmd::
+sendemail.chainreplyto::
+sendemail.confirm::
+sendemail.envelopesender::
+sendemail.from::
+sendemail.multiedit::
+sendemail.signedoffbycc::
+sendemail.smtppass::
+sendemail.suppresscc::
+sendemail.suppressfrom::
+sendemail.to::
+sendemail.smtpserver::
+sendemail.smtpserverport::
+sendemail.smtpuser::
+sendemail.thread::
+sendemail.validate::
+	See linkgit:git-send-email[1] for description.
+
+sendemail.signedoffcc::
+	Deprecated alias for 'sendemail.signedoffbycc'.
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
-- 
1.6.4.rc1.12.g05859c
