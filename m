From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/4] Use explicit bundle name in UIText to aid IDE integration
Date: Wed,  8 Apr 2009 17:51:30 +0200
Message-ID: <1239205891-28236-3-git-send-email-robin.rosenberg@dewire.com>
References: <1239205891-28236-1-git-send-email-robin.rosenberg@dewire.com>
 <1239205891-28236-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra69-0003ue-6p
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbZDHPvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbZDHPvr
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:51:47 -0400
Received: from mail.dewire.com ([83.140.172.130]:6931 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbZDHPvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:51:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F1B5E14915DD;
	Wed,  8 Apr 2009 17:51:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmY+aLSX1YsY; Wed,  8 Apr 2009 17:51:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id AA54C14915DB;
	Wed,  8 Apr 2009 17:51:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1239205891-28236-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116091>

When the bundle name is specified as a raw string Eclipse will pick up
the location of the uitext.properties file and display the actual string
value when hovering over UIText declarations. It also allows direct
navigation to the uitext.properties string from a declaration.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/core/CoreText.java        |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index d81a008..46a7ef6 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -106,7 +106,6 @@
 	public static String PushOperation_taskNameNormalRun;
 
 	static {
-		final Class c = CoreText.class;
-		initializeMessages(c.getPackage().getName() + ".coretext", c);
+		initializeMessages("org.spearce.egit.core.coretext", CoreText.class);
 	}
 }
-- 
1.6.2.2.446.gfbdc0
