From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix the build script to make jgit.jar, jgit.src non-executable
Date: Thu, 16 Oct 2008 12:57:53 -0700
Message-ID: <1224187073-13009-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZ00-0006DF-3G
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 21:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYJPT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYJPT5z
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 15:57:55 -0400
Received: from george.spearce.org ([209.20.77.23]:48753 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYJPT5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 15:57:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7ABD738360; Thu, 16 Oct 2008 19:57:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DAA5F3826E;
	Thu, 16 Oct 2008 19:57:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.711.gf1ba4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98406>

Silly copy and paste error included these unncessary chmods.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 make_jgit.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index a15f73f..2969e6e 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -95,7 +95,6 @@ java org.spearce.jgit.pgm.build.JarLinkUtil \
 	-include org.spearce.jgit/bin2 \
 	-file META-INF/MANIFEST.MF=$T_MF \
 	>$O_JAR+ &&
-chmod 555 $O_JAR+ &&
 mv $O_JAR+ $O_JAR &&
 echo "Created $O_JAR." &&
 
@@ -103,7 +102,6 @@ java org.spearce.jgit.pgm.build.JarLinkUtil \
 	-include org.spearce.jgit/src \
 	-file META-INF/MANIFEST.MF=$T_MF \
 	>$O_SRC+ &&
-chmod 555 $O_SRC+ &&
 mv $O_SRC+ $O_SRC &&
 echo "Created $O_SRC." &&
 
-- 
1.6.0.2.711.gf1ba4
