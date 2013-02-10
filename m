From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 10/15] user-manual: Fix 'both: so' -> 'both; so' typo
Date: Sun, 10 Feb 2013 10:10:36 -0500
Message-ID: <4a2262a69bbe83376860eb5868a7ca2494b6e1eb.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZS-0000h4-JR
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760694Ab3BJPL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:27 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:47932 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759119Ab3BJPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:21 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0003OXFIDY270@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:11 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 6BBC6879296; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509061; bh=wDmBYLqYoKYX2pgFZcaNXPAE0qB14X1WQXI1dSNFWxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=dUVX4IaXH/k0sdJEtTVPWzv+sXhzaQEPv3CHKJjJYEnVvoXDYWI1tgwdXXxsI4tbY
 N7hMIExIwjEmGWZS5RKGDBSYJmAhdcVWD6VP6LXb3aVxBml0P5rMXRl9lUdmsf/+qC
 MUhmrZYDApat9ET2BB5k2dhvl2zLGDSeUlhuBFAI=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215913>

From: "W. Trevor King" <wking@tremily.us>

The clause "so `git log ...` will return no commits..." is
independent, not a description of "both", so a semicolon is more
appropriate.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e2e0c86..07e07c1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -782,7 +782,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
 
 Or you could recall that the `...` operator selects all commits
 contained reachable from either one reference or the other but not
-both: so
+both; so
 
 -------------------------------------------------
 $ git log origin...master
-- 
1.8.1.336.g94702dd
