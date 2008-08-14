From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCH] Hide the Git menu and toolbars by default and fix the path of the Git menu
Date: Thu, 14 Aug 2008 22:45:39 +0200
Message-ID: <200808142245.40152.robin.rosenberg.lists@dewire.com>
References: <48A3310A.8080306@gmail.com> <48A483EF.10508@gmail.com> <200808142242.20476.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:48:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjjf-0003Cx-KY
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbYHNUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYHNUqw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:46:52 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:56731 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYHNUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 16:46:51 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 419CF383BE; Thu, 14 Aug 2008 22:46:50 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 2744638207; Thu, 14 Aug 2008 22:46:50 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id B52DE37E44;
	Thu, 14 Aug 2008 22:46:49 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200808142242.20476.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92397>


Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index b809300..a52495b 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -241,12 +241,12 @@
 	    description="Common things to do with Git"
 	    id="org.spearce.egit.ui.gitaction"
 	    label="%GitActions_label"
-	    visible="true"
+	    visible="false"
 	    >
 	    <menu
            id="org.spearce.egit.ui.gitmenu"
            label="%GitMenu_label"
-           path="org.spearce.egit.ui.gitmenu"
+           path="additions"
            >
 	    </menu>
 		<action
-- 
1.6.0.rc2.35.g04c6e9
