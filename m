From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 9/9] Document "curl" requirements.
Date: Fri, 22 Jul 2005 17:30:26 -0700
Message-ID: <7vu0im9xel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:32:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7vQ-0000I7-1j
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVGWAar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVGWAar
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:30:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3473 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262260AbVGWAab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:30:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723003025.CDEE8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:30:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Not just libcurl, but now we require curl executable as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 INSTALL |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

b300e6d28fc160ddc6685bde96b6bc9a710e01c3
diff --git a/INSTALL b/INSTALL
--- a/INSTALL
+++ b/INSTALL
@@ -41,8 +41,10 @@ Issues of note:
 	  can avoid the bignum support by excising git-rev-list support
 	  for "--merge-order" (by hand).
 
-	- "libcurl".  git-http-pull uses this.  You can disable building of
-	  that program if you just want to get started. 
+	- "libcurl" and "curl" executable.  git-http-pull and
+	  git-fetch-script use them.  If you do not use http
+	  transfer, you are probabaly OK if you do not have
+	  them.
 
 	- "GNU diff" to generate patches.  Of course, you don't _have_ to
 	  generate patches if you don't want to, but let's face it, you'll
