From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 1/5] config.txt: 'interactive.singlekey; is used by...
Date: Thu,  5 May 2011 20:48:44 +0200
Message-ID: <1304621328-17184-1-git-send-email-valentin.haenel@gmx.de>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3d2-00061A-2y
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab1EESuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:50:14 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:60231 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab1EESuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:50:11 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45InrV4017252;
	Thu, 5 May 2011 20:49:53 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45Inr35017251;
	Thu, 5 May 2011 20:49:53 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172873>

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
