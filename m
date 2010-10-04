From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] Documentation/git-clone: describe --mirror more verbose
Date: Mon,  4 Oct 2010 11:51:18 +0200
Message-ID: <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <4CA99E43.1000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren 'Some People' Hart <darren@dvhart.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 11:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hhr-0007K7-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab0JDJve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:51:34 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab0JDJve (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 05:51:34 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2hhl-0004Td-Es; Mon, 04 Oct 2010 11:51:33 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2hhk-0006CV-6e; Mon, 04 Oct 2010 11:51:32 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <4CA99E43.1000204@drmicha.warpmail.net>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158022>

Some people in #linux-rt claimed that you cannot define "--mirror" with
"mirror" only.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Darren 'Some People' Hart <darren@dvhart.com>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/git-clone.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index dc7d3d1..524a080 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -128,7 +128,12 @@ objects from the source repository into a pack in =
the cloned repository.
 	configuration variables are created.
=20
 --mirror::
-	Set up a mirror of the remote repository.  This implies `--bare`.
+	Set up a mirror of the source repository.  This implies `--bare`.
+	Compared to `--bare`, `--mirror` does not only map local branches of
+	the source to local branches of the target but all refs (including
+	remote branches, notes etc.) and sets up a refspec configuration such
+	that all these refs are overwritten by a `git remote update` in the
+	target repository.
=20
 --origin <name>::
 -o <name>::
--=20
1.7.2.3
