From: jari.aalto@cante.net
Subject: [PATCH] git-pull.txt: Mention branch.autosetuprebase
Date: Fri,  3 Dec 2010 10:20:54 +0200
Organization: Private
Message-ID: <1291364454-9849-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 09:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQtE-0006C8-S0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab0LCIVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:21:04 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:56796 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab0LCIVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:21:03 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id B4E69EC01D
	for <git@vger.kernel.org>; Fri,  3 Dec 2010 10:21:00 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0499D75893; Fri, 03 Dec 2010 10:21:00 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id AA23A27D86
	for <git@vger.kernel.org>; Fri,  3 Dec 2010 10:20:59 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1POQsy-0002ZK-4V; Fri, 03 Dec 2010 10:20:56 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162771>

From: Jari Aalto <jari.aalto@cante.net>

In "Options related to merging" mention also related option
branch.autosetuprebase in git-config(1).

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-pull.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e47361f..7b4caac 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -98,8 +98,9 @@ include::merge-options.txt[]
 	fetched, the rebase uses that information to avoid rebasing
 	non-local changes.
 +
-See `branch.<name>.rebase` in linkgit:git-config[1] if you want to make
-`git pull` always use `{litdd}rebase` instead of merging.
+See `branch.<name>.rebase` and `branch.autosetuprebase` in
+linkgit:git-config[1] if you want to make `git pull` always use
+`{litdd}rebase` instead of merging.
 +
 [NOTE]
 This is a potentially _dangerous_ mode of operation.
--=20
1.7.2.3
