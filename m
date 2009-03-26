From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 4/5] Do not set .git as a Team ignore pattern
Date: Thu, 26 Mar 2009 22:34:26 +0100
Message-ID: <6b4495184b92d42059a12af17c54f1951337338a.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
 <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
 <77afc036be3e7704333130c1cd2ab28466a91e67.1238102327.git.ferry.huberts@pelagic.nl>
 <e9605b0b1bda26f568009a42b31220d60692fce6.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxF9-0007np-Sx
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbZCZVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbZCZVed
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:33 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46236 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751766AbZCZVed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:33 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 466F658BDD4;
	Thu, 26 Mar 2009 22:34:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <e9605b0b1bda26f568009a42b31220d60692fce6.1238102327.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114823>

The .git ignore pattern is only valid in the context that it matches
a .git directory that is actually a repository.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 org.spearce.egit.core/plugin.xml |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.core/plugin.xml b/org.spearce.egit.core/plugin.xml
index 77ecebf..ff24ac7 100644
--- a/org.spearce.egit.core/plugin.xml
+++ b/org.spearce.egit.core/plugin.xml
@@ -11,10 +11,4 @@
 		id="org.spearce.egit.core.GitProvider">
 	</repository>
   </extension>
-  <extension
-        point="org.eclipse.team.core.ignore">
-     <ignore
-           enabled="true"
-           pattern=".git"/>
-  </extension>   
 </plugin>
-- 
1.6.0.6
