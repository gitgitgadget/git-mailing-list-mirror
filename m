From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-send-email.txt: clarify which options take an argument.
Date: Tue,  7 Apr 2009 19:24:32 +0200
Message-ID: <1239125073-4422-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqvdpg8knl.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 19:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrF6b-0007nM-Kd
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbZDGR13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbZDGR12
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:27:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:55429 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbZDGR11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:27:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n37HOmBx010580
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Apr 2009 19:24:49 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LrF2T-0007DO-6c; Tue, 07 Apr 2009 19:24:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LrF2T-00019t-49; Tue, 07 Apr 2009 19:24:45 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <vpqvdpg8knl.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 07 Apr 2009 19:24:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115967>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-send-email.txt |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 10dfd66..0b1f183 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -39,13 +39,13 @@ OPTIONS
 Composing
 ~~~~~~~~~
 
---bcc::
+--bcc=<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
 +
 The --bcc option must be repeated for each user you want on the bcc list.
 
---cc::
+--cc=<address>::
 	Specify a starting "Cc:" value for each email.
 	Default is the value of 'sendemail.cc'.
 +
@@ -68,24 +68,24 @@ and In-Reply-To headers will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 
---from::
+--from=<address>::
 	Specify the sender of the emails.  This will default to
 	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
---in-reply-to::
+--in-reply-to=<identifier>::
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email
 	instead of this if --chain-reply-to is set (the default)
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---subject::
+--subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---to::
+--to=<address>::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the 'sendemail.to' configuration value; if that is unspecified,
@@ -97,7 +97,7 @@ The --to option must be repeated for each user you want on the to list.
 Sending
 ~~~~~~~
 
---envelope-sender::
+--envelope-sender=<address>::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. If you use the sendmail binary, you must have
@@ -105,12 +105,12 @@ Sending
 	the 'sendemail.envelopesender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---smtp-encryption::
+--smtp-encryption=<encryption>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
 	'sendemail.smtpencryption'.
 
---smtp-pass::
+--smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
 	the password. Default is the value of 'sendemail.smtppass',
@@ -122,7 +122,7 @@ or on the command line. If a username has been specified (with
 specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
 user is prompted for a password while the input is masked for privacy.
 
---smtp-server::
+--smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
 	specify a full pathname of a sendmail-like program instead;
@@ -132,7 +132,7 @@ user is prompted for a password while the input is masked for privacy.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
---smtp-server-port::
+--smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25 and ssmtp port
 	465). This can be set with 'sendemail.smtpserverport'.
@@ -140,7 +140,7 @@ user is prompted for a password while the input is masked for privacy.
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
 
---smtp-user::
+--smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtpuser'),
 	then authentication is not attempted.
@@ -149,13 +149,13 @@ user is prompted for a password while the input is masked for privacy.
 Automating
 ~~~~~~~~~~
 
---cc-cmd::
+--cc-cmd=<command>::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to::
+--[no-]chain-reply-to=<identifier>::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -163,7 +163,7 @@ Automating
 	entire patch series. Default is the value of the 'sendemail.chainreplyto'
 	configuration value; if that is unspecified, default to --chain-reply-to.
 
---identity::
+--identity=<identity>::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
@@ -174,7 +174,7 @@ Automating
 	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
---suppress-cc::
+--suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
 +
@@ -211,7 +211,7 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 Administering
 ~~~~~~~~~~~~~
 
---confirm::
+--confirm=<mode>::
 	Confirm just before sending:
 +
 --
-- 
1.6.2.2.449.g92961.dirty
