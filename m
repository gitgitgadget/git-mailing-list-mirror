From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Remove unnecessary forward declaration of unpack_entry.
Date: Mon, 21 Aug 2006 03:10:36 -0400
Message-ID: <20060821071036.GB26029@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 09:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF3vn-0004nH-JZ
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 09:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWHUHKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWHUHKk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 03:10:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:30185 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965001AbWHUHKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 03:10:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GF3vh-0002KS-EB; Mon, 21 Aug 2006 03:10:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BE0BA20FB7D; Mon, 21 Aug 2006 03:10:36 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25784>

This declaration probably used to be necessary but the code has
been refactored since to use unpack_entry_gently instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index bb9fa8b..b1c88de 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1075,9 +1075,6 @@ static int packed_object_info(struct pac
 	return 0;
 }
 
-/* forward declaration for a mutually recursive function */
-static void *unpack_entry(struct pack_entry *, char *, unsigned long *);
-
 static void *unpack_delta_entry(unsigned char *base_sha1,
 				unsigned long delta_size,
 				unsigned long left,
-- 
1.4.2.g0dcb
