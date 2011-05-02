From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v2 1/5] config.txt: 'interactive.singlekey; is used by...
Date: Mon,  2 May 2011 15:44:28 +0200
Message-ID: <1304343872-1654-2-git-send-email-valentin.haenel@gmx.de>
References: <20110501045140.GA13387@sigill.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 15:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGtS9-0007UC-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 15:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679Ab1EBNqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 09:46:05 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:38713 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab1EBNqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 09:46:01 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p42Dji5U002106;
	Mon, 2 May 2011 15:45:44 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p42Dji90002105;
	Mon, 2 May 2011 15:45:44 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110501045140.GA13387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172590>

The config variable 'interactive.singlekey' influences also '--patch' mode of
git-add, git-reset, and git-checkout.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 480dd0a..77e4f30 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1296,8 +1296,9 @@ instaweb.port::
 interactive.singlekey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
-	Currently this is used only by the `\--patch` mode of
-	linkgit:git-add[1].  Note that this setting is silently
+	Currently this is used by the `\--patch` mode of
+	linkgit:git-add[1], linkgit:git-reset[1], linkgit:git-stash[1] and
+	linkgit:git-checkout[1]. Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
 log.date::
-- 
1.7.1
