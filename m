From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Include git-bundle and git-unbundle in Makefile.
Date: Thu, 15 Feb 2007 19:19:54 -0500
Message-ID: <11715851973121-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpk-0000rW-5e
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbXBPAUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbXBPAUF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:05 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:39631 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422833AbXBPAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:03 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00A404XAP107@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:19:59 -0600 (CST)
In-reply-to: <11715851973802-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39866>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ebecbbd..c2be7a7 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,8 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh \
+	git-bundle.sh git-unbundle.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
-- 
1.5.0.34.g6afaa
