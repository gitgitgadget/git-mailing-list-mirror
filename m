From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Style nit - don't put space after function names
Date: Wed, 30 May 2007 02:13:42 -0400
Message-ID: <20070530061342.GC12738@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 08:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHRP-0000vV-3H
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXE3GNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbXE3GNq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:13:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45457 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbXE3GNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:13:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtHRH-0003es-Ft; Wed, 30 May 2007 02:13:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 26E0720FBAE; Wed, 30 May 2007 02:13:42 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48744>

Our style is to not put a space after a function name.  I did here,
and Junio applied the patch with the incorrect formatting.  So I'm
cleaning up after myself since I noticed it upon review.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a3637d7..3093ac9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -531,7 +531,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	return 0;
 }
 
-int open_pack_index (struct packed_git *p)
+int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
 	int ret;
-- 
1.5.2.869.g6b3ba
