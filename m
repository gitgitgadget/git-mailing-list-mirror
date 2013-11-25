From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/2] commit-slab: document clear_$slabname()
Date: Mon, 25 Nov 2013 20:02:00 +0100
Message-ID: <7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
References: <cover.1385405977.git.tr@thomasrast.ch>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl1QU-0004WG-G1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab3KYTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:02:20 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56215 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757333Ab3KYTCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:02:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 309A24D64DE;
	Mon, 25 Nov 2013 20:02:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Hs1qfj5mhEGQ; Mon, 25 Nov 2013 20:02:07 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 7C5CE4D658F;
	Mon, 25 Nov 2013 20:02:05 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.397.g2a3acd5
In-Reply-To: <cover.1385405977.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238331>

The clear_$slabname() function was only documented by source code so
far.  Write something about it.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 commit-slab.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/commit-slab.h b/commit-slab.h
index d4c8286..d77aaea 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -24,6 +24,10 @@
  *   to each commit. 'stride' specifies how big each array is.  The slab
  *   that id initialied by the variant without "_with_stride" associates
  *   each commit with an array of one integer.
+ *
+ * - void clear_indegree(struct indegree *);
+ *
+ *   Free the slab's data structures.
  */
 
 /* allocate ~512kB at once, allowing for malloc overhead */
-- 
1.8.5.rc3.397.g2a3acd5
