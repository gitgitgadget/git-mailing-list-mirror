From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/9] debian/ fixes
Date: Fri, 22 Jul 2005 17:29:24 -0700
Message-ID: <7vu0imbc0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7vd-0000Ll-CJ
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVGWAb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVGWAbO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:31:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13742 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262255AbVGWA30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:29:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723002923.FWAM12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:29:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Ryan Anderson <ryan@michonline.com>
Date: 1121822267 -0400

Make debian/rules executable, and correct the spelling of rsync in
debian/control.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 debian/control |    2 +-
 debian/rules   |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 debian/rules

576a7b14f41e0dc97b45b47b44ba24d4cbe1c789
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, shellutils, diff, rysnc, rcs
+Depends: ${shlibs:Depends}, shellutils, diff, rsync, rcs
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
diff --git a/debian/rules b/debian/rules
old mode 100644
new mode 100755
