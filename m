From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 6/9] Docs: send-email: Remove unnecessary config variable description
Date: Tue, 30 Sep 2008 07:58:29 -0500
Message-ID: <1222779512-58936-6-git-send-email-mfwitten@mit.edu>
References: <20080929174445.GA6015@coredump.intra.peff.net>
 <1222779512-58936-1-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-2-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-4-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-5-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Sep 30 14:59:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkepY-0005Cu-BZ
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYI3M6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYI3M6q
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:58:46 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52216 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752593AbYI3M6p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 08:58:45 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8UCwgiS010326;
	Tue, 30 Sep 2008 08:58:42 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-2.mpls.qwest.net [97.116.104.2])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8UCwWOP010491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Sep 2008 08:58:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222779512-58936-5-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97109>

The config variables are mentioned within the descriptions of the
command line options with which they are associated.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |   91 +++++++-------------------------------
 1 files changed, 16 insertions(+), 75 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 6b62032..0d6ac4a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -24,7 +24,8 @@ OPTIONS
 The options available are:
 
 --bcc::
-	Specify a "Bcc:" value for each email.
+	Specify a "Bcc:" value for each email. Default is the value of
+	'sendemail.bcc'.
 +
 The --bcc option must be repeated for each user you want on the bcc list.
 
@@ -85,9 +86,9 @@ The --cc option must be repeated for each user you want on the cc list.
 	all that is output.
 
 --[no-]signed-off-by-cc::
-        If this is set, add emails found in Signed-off-by: or Cc: lines to the
-        cc list. Default is the value of 'sendemail.signedoffcc' configuration
-        value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in Signed-off-by: or Cc: lines to the
+	cc list. Default is the value of 'sendemail.signedoffcc' configuration
+	value; if that is unspecified, default to --signed-off-by-cc.
 
 --smtp-encryption::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
@@ -97,22 +98,13 @@ The --cc option must be repeated for each user you want on the cc list.
 --smtp-pass::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-	the password.
-+
-In place of this option, the following configuration variables
-can be specified:
-+
---
-		* sendemail.smtppass
-		* sendemail.<identity>.smtppass (see sendemail.identity).
---
-+
-However, --smtp-pass always overrides these variables.
+	the password. Default is the value of 'sendemail.smtppass',
+	however '--smtp-pass' always overrides this value.
 +
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
---smtp-user or a configuration variable), but no password has been
-specified (with --smtp-pass or a configuration variable), then the
+'--smtp-user' or a 'sendemail.smtpuser'), but no password has been
+specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
 user is prompted for a password while the input is masked for privacy.
 
 --smtp-server::
@@ -128,24 +120,15 @@ user is prompted for a password while the input is masked for privacy.
 --smtp-server-port::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25 and ssmtp port
-	465).
+	465). This can be set with 'sendemail.smtpserverport'.
 
 --smtp-ssl::
-	Legacy alias for '--smtp-encryption=ssl'.
+	Legacy alias for '--smtp-encryption ssl'.
 
 --smtp-user::
-	Username for SMTP-AUTH. In place of this option, the following
-	configuration variables can be specified:
-+
---
-		* sendemail.smtpuser
-		* sendemail.<identity>.smtpuser (see sendemail.identity).
---
-+
-However, --smtp-user always overrides these variables.
-+
-If a username is not specified (with --smtp-user or a
-configuration variable), then authentication is not attempted.
+	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
+	if a username is not specified (with '--smtp-user' or 'sendemail.smtpuser'),
+	then authentication is not attempted.
 
 --subject::
 	Specify the initial subject of the email thread.
@@ -191,18 +174,12 @@ The --to option must be repeated for each user you want on the to list.
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
 +
-This option can be set with sendemail[.<identity>].validate; default to --validate
+Default is the value of 'sendemail.validate'; if this is not set,
+default to '--validate'.
 
 
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
@@ -211,42 +188,6 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
-sendemail.to::
-	Email address (or alias) to always send to.
-
-sendemail.cccmd::
-	Command to execute to generate per patch file specific "Cc:"s.
-
-sendemail.bcc::
-	Email address (or alias) to always bcc.
-
-sendemail.chainreplyto::
-	Boolean value specifying the default to the '--[no-]chain-reply-to'
-	parameter.
-
-sendemail.smtpserver::
-	Default SMTP server to use.
-
-sendemail.smtpserverport::
-	Default SMTP server port to use.
-
-sendemail.smtpuser::
-	Default SMTP-AUTH username.
-
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
-
-sendemail.validate::
-    Boolean override for --[no-]validate.
-
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.6.0.2.304.gdcf23.dirty
