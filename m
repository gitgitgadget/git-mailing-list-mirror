From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] s/SHELL/SHELL_PATH/ in Makefile
Date: Tue, 14 Feb 2006 00:15:14 +0100
Message-ID: <20060213231514.GA26758@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 14 00:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8mvS-0000WY-C1
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 00:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBMXPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWBMXPm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 18:15:42 -0500
Received: from [85.8.31.11] ([85.8.31.11]:9405 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030269AbWBMXPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 18:15:25 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D65CE40FD; Tue, 14 Feb 2006 00:29:24 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F8muY-0006z4-00; Tue, 14 Feb 2006 00:15:14 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16085>

With the current Makefile we don't use the shell chosen by the
platform specific defines when we invoke GIT-VERSION-GEN.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

86d29e725d299d2bba7404809d81c61d7dab590c
diff --git a/Makefile b/Makefile
index f240e45..d40aa6a 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ all:
 # change being considered an inode change from the update-cache perspective.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
-- 
1.1.6.g4dc8
