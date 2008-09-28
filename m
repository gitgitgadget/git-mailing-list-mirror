From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 6/8] Docs: Arranged config options in man page
Date: Sat, 27 Sep 2008 20:09:54 -0500
Message-ID: <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-3-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-4-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-5-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:11:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjkov-000293-SJ
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbYI1BKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYI1BKO
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:10:14 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48399 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbYI1BKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:10:11 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1A8i5006937;
	Sat, 27 Sep 2008 21:10:08 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usH017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
In-Reply-To: <1222564196-84202-5-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96926>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |   44 +++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 6b62032..8aa5098 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -196,13 +196,6 @@ This option can be set with sendemail[.<identity>].validate; default to --valida
 
 CONFIGURATION
 -------------
-sendemail.identity::
-	The default configuration identity. When specified,
-	'sendemail.<identity>.<item>' will have higher precedence than
-	'sendemail.<item>'. This is useful to declare multiple SMTP
-	identities and to hoist sensitive authentication information
-	out of the repository and into the global configuration file.
-
 sendemail.aliasesfile::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
@@ -211,38 +204,45 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
-sendemail.to::
-	Email address (or alias) to always send to.
+sendemail.bcc::
+	Email address (or alias) to always bcc.
 
 sendemail.cccmd::
 	Command to execute to generate per patch file specific "Cc:"s.
 
-sendemail.bcc::
-	Email address (or alias) to always bcc.
-
 sendemail.chainreplyto::
 	Boolean value specifying the default to the '--[no-]chain-reply-to'
 	parameter.
 
+sendemail.identity::
+	The default configuration identity. When specified,
+	'sendemail.<identity>.<item>' will have higher precedence than
+	'sendemail.<item>'. This is useful to declare multiple SMTP
+	identities and to hoist sensitive authentication information
+	out of the repository and into the global configuration file.
+
+sendemail.smtpencryption::
+	Default encryption method.  Use 'ssl' for SSL (and specify an
+	appropriate port), or 'tls' for TLS.  Takes precedence over
+	'smtpssl' if both are specified.
+
+sendemail.smtppass::
+	Default SMTP-AUTH password.
+
 sendemail.smtpserver::
 	Default SMTP server to use.
 
 sendemail.smtpserverport::
 	Default SMTP server port to use.
 
+sendemail.smtpssl::
+	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
+
 sendemail.smtpuser::
 	Default SMTP-AUTH username.
 
-sendemail.smtppass::
-	Default SMTP-AUTH password.
-
-sendemail.smtpencryption::
-	Default encryption method.  Use 'ssl' for SSL (and specify an
-	appropriate port), or 'tls' for TLS.  Takes precedence over
-	'smtpssl' if both are specified.
-
-sendemail.smtpssl::
-	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
+sendemail.to::
+	Email address (or alias) to always send to.
 
 sendemail.validate::
     Boolean override for --[no-]validate.
-- 
1.6.0.2.304.g577ee
