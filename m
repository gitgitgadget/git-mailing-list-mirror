From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Typofix an error message in pack-check.c
Date: Thu, 07 Jul 2005 15:12:20 -0700
Message-ID: <7vmzoyp8or.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:16:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqees-0005GG-FU
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVGGWPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGGWN4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:13:56 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38143 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262365AbVGGWMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 18:12:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707221222.LJTC7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 18:12:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current error message does not make any sense.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 pack-check.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c3818dc056d1a603e15fe3f862849eddaee2a7c3
diff --git a/pack-check.c b/pack-check.c
--- a/pack-check.c
+++ b/pack-check.c
@@ -58,7 +58,7 @@ static int verify_packfile(struct packed
 			continue;
 		}
 		if (check_sha1_signature(sha1, data, size, type)) {
-			err = error("cannot packed %s from %s corrupt",
+			err = error("packed %s from %s is corrupt",
 				    sha1_to_hex(sha1), p->pack_name);
 			free(data);
 			continue;
------------
