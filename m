From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Fri,  1 Oct 2010 22:13:03 +0200
Message-ID: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Darren Hart <darren@dvhart.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 22:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1lyo-0006Bw-5d
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 22:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0JAUNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 16:13:11 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51676 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0JAUNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 16:13:10 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P1lyf-0004eg-NV; Fri, 01 Oct 2010 22:13:09 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P1lyd-0001TL-Vi; Fri, 01 Oct 2010 22:13:07 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157777>

Some people in #linux-rt claimed that you cannot define "--mirror" with
"mirror".

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/git-clone.txt |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index dc7d3d1..5eedfbd 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -128,7 +128,16 @@ objects from the source repository into a pack in =
the cloned repository.
 	configuration variables are created.
=20
 --mirror::
-	Set up a mirror of the remote repository.  This implies `--bare`.
+	Set up a mirror of the remote repository.
+	Using
+
+		git remote update origin
+
+	(or `<name>` instead of `origin` if -o is given) in the resulting
+	repository overwrites the local branches without asking.
+	This implies `--bare`.
+	Without --mirror (but with --bare) git remote update doesn't touch an=
y
+	branches at all.
=20
 --origin <name>::
 -o <name>::
--=20
1.7.2.3
