From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH] config.txt: interactive.singlekey is used by...
Date: Sat, 30 Apr 2011 16:54:01 +0200
Message-ID: <1304175241-30550-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 16:54:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGBZL-0005EN-0r
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 16:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1D3Oyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 10:54:44 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:32816 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1D3Oyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 10:54:43 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3UEsRGi030587;
	Sat, 30 Apr 2011 16:54:27 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3UEsQpq030586;
	Sat, 30 Apr 2011 16:54:26 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172522>

The config variable 'interactive.singlekey' influences also '--patch' mode of
git-stash and git-reset.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
---

Perhaps this incredibly useful setting should also be mentioned in manpages of
git-{add,reset.stash}?

Are git-{add,reset.stash} the only commands that the setting influences?

---
 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 480dd0a..7dd9b01 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1297,7 +1297,8 @@ interactive.singlekey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used only by the `\--patch` mode of
-	linkgit:git-add[1].  Note that this setting is silently
+	linkgit:git-add[1], linkgit:git-reset[1] and linkgit:git-stash[1].
+	Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
 log.date::
-- 
1.7.1
