From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 07/26] Export the new DirCache API to Eclipse plugins using jgit
Date: Mon, 11 Aug 2008 18:07:54 -0700
Message-ID: <1218503293-14057-8-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPP-0006OQ-UL
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbYHLBI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYHLBI0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:26 -0400
Received: from george.spearce.org ([209.20.77.23]:38577 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYHLBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 230C73837C; Tue, 12 Aug 2008 01:08:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 84C54381FD;
	Tue, 12 Aug 2008 01:08:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92042>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/META-INF/MANIFEST.MF |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 388dc18..36f92f2 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -5,7 +5,8 @@ Bundle-SymbolicName: org.spearce.jgit
 Bundle-Version: 0.3.1.qualifier
 Bundle-Localization: plugin
 Bundle-Vendor: %provider_name
-Export-Package: org.spearce.jgit.errors;uses:="org.spearce.jgit.lib",
+Export-Package: org.spearce.jgit.dircache,
+ org.spearce.jgit.errors;uses:="org.spearce.jgit.lib",
  org.spearce.jgit.lib,
  org.spearce.jgit.revplot,
  org.spearce.jgit.revwalk,
-- 
1.6.0.rc2.22.g71b99
