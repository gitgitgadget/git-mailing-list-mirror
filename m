From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Use the same tooltip for the track toolbar button as for the team menu
Date: Sun, 19 Apr 2009 12:03:12 +0200
Message-ID: <1240135392-21346-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 19 12:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTtN-0003Yn-5z
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 12:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZDSKDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZDSKDU
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 06:03:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:17775 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbZDSKDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 06:03:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 06FB7147D52B;
	Sun, 19 Apr 2009 12:03:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7uTCUT24Qf2i; Sun, 19 Apr 2009 12:03:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5B419802E0D;
	Sun, 19 Apr 2009 12:03:13 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116892>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 652da75..a94c8bc 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -384,7 +384,7 @@
 		       style="push"
 		       menubarPath="org.spearce.egit.ui.gitmenu/repositoryGroup"
 		       toolbarPath="Normal/additions"
-		       tooltip="Start tracking the selected resources">
+		       tooltip="%TrackAction_tooltip">
 		</action>
       </actionSet>
    </extension>
-- 
1.6.2.2.446.gfbdc0
