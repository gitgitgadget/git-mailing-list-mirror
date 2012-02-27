From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] send-email: document the --smtp-debug option
Date: Mon, 27 Feb 2012 17:22:53 +0100
Message-ID: <1330359773-16759-1-git-send-email-zbyszek@in.waw.pl>
References: <87ehtiu5dg.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: greened@obbligato.org,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 17:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S23OS-0005MN-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 17:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab2B0QZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 11:25:30 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55263 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab2B0QZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 11:25:29 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S23OB-0007Oe-CO; Mon, 27 Feb 2012 17:25:27 +0100
X-Mailer: git-send-email 1.7.9.2.378.g4d260
In-Reply-To: <87ehtiu5dg.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191628>

The option was already shown in -h output, so it should be documented
in the man page.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Suggested-by: David A. Greene <greened@obbligato.org>
---
David Greene wrote:
> I don't think --smtp-debug is documented in the man pages.  Was that =
a
> deliberate decision or an oversight?

 Documentation/git-send-email.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 327233c..3241170 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -198,6 +198,10 @@ must be used for each option.
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtp=
user'),
 	then authentication is not attempted.
=20
+--smtp-debug=3D0|1::
+	Enable (1) or disable (0) debug output. If enabled, SMTP
+	commands and replies will be printed. Useful to debug TLS
+	connection and authentication problems.
=20
 Automating
 ~~~~~~~~~~
--=20
1.7.9.2.378.g4d260
