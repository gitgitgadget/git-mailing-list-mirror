From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't package the git-gui credits file anymore
Date: Mon, 12 Mar 2007 13:40:31 -0400
Message-ID: <20070312174031.GA15836@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoVi-00077M-VX
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXCLRkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXCLRkf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:40:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49047 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbXCLRke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:40:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQoVV-0002yw-ND; Mon, 12 Mar 2007 13:40:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE16120FBAE; Mon, 12 Mar 2007 13:40:31 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42048>

Since git-gui 0.6.4 the credits file is no longer produced.
This file was removed from git-gui due to build issues that
a lot of users and Git developers have reported running into.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f674e55..eeb502f 100644
--- a/Makefile
+++ b/Makefile
@@ -901,8 +901,7 @@ dist: git.spec git-archive
 	$(TAR) rf $(GIT_TARNAME).tar \
 		$(GIT_TARNAME)/git.spec \
 		$(GIT_TARNAME)/version \
-		$(GIT_TARNAME)/git-gui/version \
-		$(GIT_TARNAME)/git-gui/credits
+		$(GIT_TARNAME)/git-gui/version
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
-- 
1.5.0.3.985.gcf0b4
