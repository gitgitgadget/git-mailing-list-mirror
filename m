From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: call "similarity index" just "score".
Date: Sat, 28 May 2005 21:21:27 -0700
Message-ID: <7vvf52r7aw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 06:19:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcFGZ-0004zv-1o
	for gcvg-git@gmane.org; Sun, 29 May 2005 06:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVE2EVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 00:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVE2EVb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 00:21:31 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:53893 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261228AbVE2EV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 00:21:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529042128.FOKE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 00:21:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It really is an internal "score" number and will not necessarily
stay "similarity index" forever.  Document so that Porcelain can
be prepared to see numbers to follow the status letter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/diff-format.txt |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -36,7 +36,7 @@ That is, from the left to the right:
   (6) sha1 for "src"; 0{40} if creation or unmerged.
   (7) a space.
   (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
-  (9) status, followed by similarlity index number only for C and R.
+  (9) status, followed by optional "score" number.
  (10) a tab or a NUL when '-z' option is used.
  (11) path for "src"
  (12) a tab or a NUL when '-z' option is used; only exists for C or R.
------------------------------------------------

