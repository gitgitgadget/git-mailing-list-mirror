From: Olaf Dabrunz <odabrunz@gmx.net>
Subject: [TopGit PATCH] add section POINTERS to README
Date: Mon,  6 Sep 2010 02:02:54 +0200
Message-ID: <1283731374-2809-1-git-send-email-odabrunz@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olaf Dabrunz <odabrunz@gmx.net>, Petr Baudis <pasky@suse.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 02:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPwo-0000ZJ-Oy
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab0IFAwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 20:52:04 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mailout-de.gmx.net ([213.165.64.22]:56595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755239Ab0IFAwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 20:52:03 -0400
Received: (qmail invoked by alias); 06 Sep 2010 00:52:01 -0000
Received: from p579E9A99.dip.t-dialin.net (EHLO santana.dyndns.org) [87.158.154.153]
  by mail.gmx.net (mp020) with SMTP; 06 Sep 2010 02:52:01 +0200
X-Authenticated: #20497841
X-Provags-ID: V01U2FsdGVkX1/m1sJzhP3mQuELFiCbweJu27H8NWjZ+mKYgXoIzD
	cz6pr7vFY8t/O6
Received: by santana.dyndns.org (Postfix, from userid 1000)
	id 48AB8B881; Mon,  6 Sep 2010 02:51:59 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155510>

Added a pointer to a mail discussing the design for "tg depend rm".

Signed-off-by: Olaf Dabrunz <odabrunz@gmx.net>
---

Uwe Kleine-K=C3=B6nig mentioned that the URL could be included in the
README.

I did not cite the URL from the tg depend TODO item, as tg help
depend would not show the reference.

 README |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/README b/README
index f103d92..9bab4de 100644
--- a/README
+++ b/README
@@ -622,3 +622,13 @@ All commands by default refer to the remote that '=
tg remote --populate'
 was called on the last time ('topgit.remote' configuration variable). =
You can
 manually run any command with a different base remote by passing '-r R=
EMOTE'
 _before_ the subcommand name.
+
+
+POINTERS
+--------
+
+The following references are useful to understand the development of t=
opgit and
+its subcommands.
+
+tg depend:
+  http://lists-archives.org/git/688698-add-list-and-rm-sub-commands-to=
-tg-depend.html
--=20
1.7.1
