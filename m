From: jari.aalto@cante.net
Subject: [PATCH] git-cherry.txt: Change symbol marks in graph.
Date: Thu,  2 Dec 2010 07:18:13 +0200
Organization: Private
Message-ID: <1291267093-29855-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 06:18:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO1Yu-0003fb-Mz
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 06:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab0LBFSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 00:18:20 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:35624 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab0LBFSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 00:18:17 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id B85D0EF53B
	for <git@vger.kernel.org>; Thu,  2 Dec 2010 07:18:15 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A07C05AF5DE; Thu, 02 Dec 2010 07:18:15 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 9FF381C6383
	for <git@vger.kernel.org>; Thu,  2 Dec 2010 07:18:14 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PO1Yb-0007lx-Pn; Thu, 02 Dec 2010 07:18:13 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162667>

From: Jari Aalto <jari.aalto@cante.net>

The common commit were marked with a minus sign (-), but that is
usually interpreted as something less or substracted. Use natural
equal sign (=3D). Commits that are not in upstream were marked with plus
sign (+) but a question mark (?) is visually a litle more striking
(erect) in context where all other signs are "flat". It also helps
visually impared to see difference between (* ... ?) as opposed to
similar signs (* ... +).

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-cherry.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index fed115a..f342582 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -19,13 +19,13 @@ the 'git patch-id' program.
 Every commit that doesn't exist in the <upstream> branch
 has its id (sha1) reported, prefixed by a symbol.  The ones that have
 equivalent change already
-in the <upstream> branch are prefixed with a minus (-) sign, and those
-that only exist in the <head> branch are prefixed with a plus (+) symbol=
:
+in the <upstream> branch are prefixed with a equal (=3D) sign, and those
+that only exist in the <head> branch are prefixed with a question mark (=
?) symbol:
=20
-               __*__*__*__*__> <upstream>
+               _*__*__*__*__> <upstream>
               /
     fork-point
-              \__+__+__-__+__+__-__+__> <head>
+              \__?__?__=3D__?__?__=3D__?__> <head>
=20
=20
 If a <limit> has been given then the commits along the <head> branch up
@@ -34,7 +34,7 @@ to and including <limit> are not reported:
                __*__*__*__*__> <upstream>
               /
     fork-point
-              \__*__*__<limit>__-__+__> <head>
+              \__*__*__<limit>__=3D__?__> <head>
=20
=20
 Because 'git cherry' compares the changeset rather than the commit id
--=20
1.7.2.3
