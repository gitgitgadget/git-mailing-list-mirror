From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] fix comment in strbuf.h to use correct name strbuf_avail()
Date: Sun,  4 Nov 2007 09:02:21 +0100
Message-ID: <11941633412454-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 09:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoaTi-0000kh-Ft
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 09:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbXKDIEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 03:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXKDIEq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 03:04:46 -0500
Received: from mailer.zib.de ([130.73.108.11]:59434 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbXKDIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 03:04:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA482MlO015058;
	Sun, 4 Nov 2007 09:04:42 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA482L1u017411;
	Sun, 4 Nov 2007 09:02:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63361>


Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 strbuf.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Note, the patch is against Junio's pu.

    Steffen

diff --git a/strbuf.h b/strbuf.h
index 9720826..e5cdd1e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -24,11 +24,11 @@
  *
  *    strbuf_grow(sb, SOME_SIZE);
  *    // ... here the memory areay starting at sb->buf, and of length
- *    // sb_avail(sb) is all yours, and you are sure that sb_avail(sb) is at
- *    // least SOME_SIZE
+ *    // strbuf_avail(sb) is all yours, and you are sure that strbuf_avail(sb)
+ *    // is at least SOME_SIZE
  *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
  *
- *    Of course, SOME_OTHER_SIZE must be smaller or equal to sb_avail(sb).
+ *    Of course, SOME_OTHER_SIZE must be smaller or equal to strbuf_avail(sb).
  *
  *    Doing so is safe, though if it has to be done in many places, adding the
  *    missing API to the strbuf module is the way to go.
-- 
1.5.3.4.464.ge1bc2
