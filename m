From: Junio C Hamano <junkio@cox.net>
Subject: [RFT] Cygwin needs NO_C99_FORMAT???
Date: Wed, 02 Aug 2006 15:44:07 -0700
Message-ID: <7vd5biu5ag.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 00:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8PRm-0006ap-Kr
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWHBWoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWHBWoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:44:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28633 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932304AbWHBWoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 18:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802224408.VMOY12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 18:44:08 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24698>

I noticed that t3800 test breaks with git built without this
option.

---
* Tests and feedbacks very much appreciated.

diff --git a/Makefile b/Makefile
index fd45cd1..4f7ae33 100644
--- a/Makefile
+++ b/Makefile
@@ -316,6 +316,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_STRLCPY = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	NO_C99_FORMAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try uncommenting this if you see things break -- YMMV.
