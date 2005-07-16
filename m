From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: adjust cvsimport command line.
Date: Fri, 15 Jul 2005 20:54:04 -0700
Message-ID: <7vy887o17n.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 05:54:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtdkn-0001Yy-C6
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 05:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVGPDyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 23:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVGPDyI
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 23:54:08 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56778 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262160AbVGPDyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 23:54:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716035405.YXUZ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 23:54:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 15 Jul 2005 14:40:41 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The cvsimport example in the cvs migration document was still
using the old syntax for target repository after new and
improved cvsimport-script was merged.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/cvs-migration.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b29d86237da6af317cd0053aa9c8ebd72455c113
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -63,7 +63,7 @@ Once you've gotten (and installed) cvsps
 any more familiar with it, but make sure it is in your path. After that,
 the magic command line is
 
-	git cvsimport -v -d <cvsroot> <module> <destination>
+	git cvsimport -v -d <cvsroot> -C <destination> <module>
 
 which will do exactly what you'd think it does: it will create a git
 archive of the named CVS module. The new archive will be created in the
