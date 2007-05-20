From: skimo@liacs.nl
Subject: [PATCH 1/1] unpack-trees.c: verify_uptodate: remove dead code
Date: Sun, 20 May 2007 19:26:37 +0200
Message-ID: <11796819972973-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 19:27:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppBL-0001Bt-7Y
	for gcvg-git@gmane.org; Sun, 20 May 2007 19:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbXETR0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbXETR0v
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 13:26:51 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:36583 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807AbXETR0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 13:26:50 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KHQb5W006740;
	Sun, 20 May 2007 19:26:42 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 778C07DD9F; Sun, 20 May 2007 19:26:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47856>

From: Sven Verdoolaege <skimo@kotnet.org>

This code was killed by commit fcc387db9bc453dc7e07a262873481af2ee9e5c8.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 906ce69..cac2411 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -414,10 +414,6 @@ static void verify_uptodate(struct cache_entry *ce,
 			return;
 		errno = 0;
 	}
-	if (o->reset) {
-		ce->ce_flags |= htons(CE_UPDATE);
-		return;
-	}
 	if (errno == ENOENT)
 		return;
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
-- 
1.5.2.rc3.819.gc901
