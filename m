From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/4] Cleanup ui plugin.xml, refer to interface IResource, not Resource
Date: Sun, 25 Jan 2009 19:52:15 +0100
Message-ID: <1232909538-3279-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 25 19:53:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA7C-0004Gp-BD
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbZAYSw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZAYSwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:52:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:1477 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZAYSwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:52:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 276D0147E6F2;
	Sun, 25 Jan 2009 19:52:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cNJHG5gCWuo5; Sun, 25 Jan 2009 19:52:19 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 660E1802664;
	Sun, 25 Jan 2009 19:52:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107081>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index e6e3762..0b18f15 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -170,7 +170,7 @@
             </adapter>
          </factory>
          <factory
-               adaptableType="org.eclipse.core.internal.resources.Resource"
+	       adaptableType="org.eclipse.core.resources.IResource"
                class="org.spearce.egit.ui.internal.factories.GitAdapterFactory">
             <adapter
                   type="org.eclipse.team.ui.history.IHistoryPageSource">
-- 
1.6.1.285.g35d8b
