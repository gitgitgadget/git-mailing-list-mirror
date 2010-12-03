From: jari.aalto@cante.net
Subject: [PATCH] git-pull.txt: Add picture to --rebase option
Date: Fri,  3 Dec 2010 10:41:09 +0200
Organization: Private
Message-ID: <1291365669-10439-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 09:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORCi-0004Qe-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab0LCIlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:41:16 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:49801 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0LCIlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:41:15 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id CBA1C8C373
	for <git@vger.kernel.org>; Fri,  3 Dec 2010 10:41:13 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07690AF39C; Fri, 03 Dec 2010 10:41:13 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id C009941BED
	for <git@vger.kernel.org>; Fri,  3 Dec 2010 10:41:12 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PORCX-0002in-Qy; Fri, 03 Dec 2010 10:41:10 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162774>

From: Jari Aalto <jari.aalto@cante.net>

Illustrate what are the effects of the the option.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-pull.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e47361f..25eb6de 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -106,6 +106,18 @@ This is a potentially _dangerous_ mode of operation.
 It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
++
+The effects of this option are:
+------------
+    [initial]
+    o---o---o---A--B   Your work in commit A and B
+
+    [git pull --rebase]
+    o---o---o---*---*--A--B
+                |   |
+                New updates merged in. Your work is rebased
+                on top of them.
+------------
=20
 --no-rebase::
 	Override earlier --rebase.
--=20
1.7.2.3
