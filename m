From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] rebase--interactive: remote stray closing parenthesis
Date: Thu, 11 Jun 2009 22:27:55 +0200
Message-ID: <1244752075-15910-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=B6h=C3=A4nn=C3=ABs=20=22Dsch=C3=B6=22=20Schind=C3=ABlin?= 
	<johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 22:28:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEqsf-0004er-R3
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 22:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZFKU2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZFKU2C
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 16:28:02 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60596 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZFKU2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 16:28:01 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEqsP-0007C6-3h; Thu, 11 Jun 2009 22:28:00 +0200
X-Mailer: git-send-email 1.6.3.1
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=AWL,BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121358>

it was introduced in 68a163c9b483ae352fcfee8c4505d113213daa73

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: J=C3=B6h=C3=A4nn=C3=ABs "Dsch=C3=B6" Schind=C3=ABlin <johannes.schi=
ndelin@gmx.de>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 314cd36..f96d887 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -420,7 +420,7 @@ do_next () {
 	NEWHEAD=3D$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
-		message=3D"$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
+		message=3D"$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO" &&
 		git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
 		git symbolic-ref HEAD $HEADNAME
 		;;
--=20
1.6.3.1
