From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] fix "test: 2: unexpected operator" on bsd
Date: Sun, 12 Feb 2006 19:03:16 +0100
Message-ID: <20060212180316.GA3322@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 19:03:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8LZY-00081Y-Nj
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWBLSDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWBLSDa
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:03:30 -0500
Received: from devrace.com ([198.63.210.113]:18707 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750801AbWBLSD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:03:29 -0500
Received: from tigra.home (p54A06C50.dip.t-dialin.net [84.160.108.80])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1CI3Hv5067775;
	Sun, 12 Feb 2006 12:03:18 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F8LZ6-0005f4-00; Sun, 12 Feb 2006 19:03:16 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F8LZ6-0000rl-5H; Sun, 12 Feb 2006 19:03:16 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16002>

---

 t/t0000-basic.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4ce9a3f9fe30e091411811a905cccbffcb45ee58
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index bc3e711..c339a36 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -33,7 +33,7 @@ then
 fi
 
 merge >/dev/null 2>/dev/null
-if test $? == 127
+if test $? = 127
 then
 	echo >&2 'You do not seem to have "merge" installed.
 Please check INSTALL document.'
-- 
1.1.6.gd46b
