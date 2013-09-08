From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc: 'replace' merge and non-merge commits
Date: Sun,  8 Sep 2013 13:10:44 +0100
Message-ID: <1378642244-3572-1-git-send-email-philipoakley@iee.org>
References: <xmqqob86g8v4.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 14:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIdp2-0003o7-7K
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 14:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3IHMK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 08:10:28 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:18625 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751259Ab3IHMK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 08:10:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AscIAPtnLFJOl3GZ/2dsb2JhbABbgweDSqtRk3aBIxd0giYBBVYjEAhJOR4GCgmIBsZmkAAHhB0DqVuDITs
X-IPAS-Result: AscIAPtnLFJOl3GZ/2dsb2JhbABbgweDSqtRk3aBIxd0giYBBVYjEAhJOR4GCgmIBsZmkAAHhB0DqVuDITs
X-IronPort-AV: E=Sophos;i="4.90,864,1371078000"; 
   d="scan'208";a="436400145"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 08 Sep 2013 13:10:25 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <xmqqob86g8v4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234236>

Merges are often treated as special case objects so tell users that
they are not special here.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

This updates my in-line patch given in [PATCH v3 07/11]
Documentation/replace: tell that -f option bypasses the type check
($gmane/233997 05 September 2013 23:20) and Junio's comments
($gmane/234001 06 September 2013 00:13) 

Applies on top of pu and Christian Couder's series.

Philip

---
 Documentation/git-replace.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 414000e..f373ab4 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -26,6 +26,7 @@ This restriction can be bypassed using `-f`.
 Unless `-f` is given, the 'replace' reference must not yet exist.
 
 There is no other restriction on the replaced and replacement objects.
+Merge commits can be replaced by non-merge commits and vice versa.
 
 Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
-- 
1.8.1.msysgit.1
