From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 2/4] doc/clone: Pick more compelling paths for the
 --reference example
Date: Sat, 22 Jun 2013 10:46:25 -0400
Message-ID: <79c2444a4fc73cbf699f571351780ce59f5d8785.1371911897.git.wking@tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 16:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqP5K-0003Nh-DY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab3FVOqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 10:46:34 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:50188 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab3FVOqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:46:33 -0400
Received: from odin.tremily.us ([unknown] [72.68.80.60])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOS007WOUDJCT10@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Jun 2013 09:46:32 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9A146A3D87D; Sat,
 22 Jun 2013 10:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371912391; bh=YCWc2O4eCOhhduh9a+av5aBx/j4LodeVGXGTduqoy88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=imhHTfIX10DVvoAgrgI8Qk7Xoz6payaGD/Hbq5UnK4FWFX1ZVqa1EM615+v8Kq1CY
 uQ7UyRuuqNQT/tCTEjCaOM4mcDTXdJt9sYjVcN9oducOM0tMQFUMlqHZSpkKfczcKB
 4boRGJmp5zpa5NpUiAHu6g7gT9jquOEDXP4dC1ys=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371911897.git.wking@tremily.us>
In-reply-to: <cover.1371911897.git.wking@tremily.us>
References: <cover.1371911897.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228709>

From: "W. Trevor King" <wking@tremily.us>

There may be times when using one of your local repositories as a
reference for a new clone make sense, but the implied version-bump in
the old example isn't one of them.  I think a more intuitive example
is multi-user system with a central reference clone, and the new paths
hint at this use case.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-clone.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index cec6fc1..bf05ada 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -257,10 +257,10 @@ $ git show-branch
 * Clone from upstream while borrowing from an existing local directory:
 +
 ------------
-$ git clone --reference my2.6 \
-	git://git.kernel.org/pub/scm/.../linux-2.7 \
-	my2.7
-$ cd my2.7
+$ git clone --reference /git/linux.git \
+	git://git.kernel.org/pub/scm/.../linux.git \
+	my-linux
+$ cd my-linux
 ------------
 
 
-- 
1.8.3
