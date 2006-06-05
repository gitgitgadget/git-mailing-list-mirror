From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Fix Documentation/everyday.txt: Junio's workflow
Date: Sun, 04 Jun 2006 22:08:21 -0400
Message-ID: <1149473301698-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 04:09:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn4WX-0000ka-Sg
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 04:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWFECIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 22:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWFECIz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 22:08:55 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59112 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932381AbWFECIy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 22:08:54 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k5528a8l024731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 22:08:42 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k5528N5n019036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 22:08:25 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k5528MiB019035;
	Sun, 4 Jun 2006 22:08:22 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g16a4
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 04 Jun 2006 22:08:49 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21305>

The workflow for Junio was badly formatted.

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/everyday.txt |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index ffba543..6745ab5 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -336,15 +336,20 @@ master, nor exposed as a part of a stabl
 <11> make sure I did not accidentally rewind master beyond what I
 already pushed out.  "ko" shorthand points at the repository I have
 at kernel.org, and looks like this:
-    $ cat .git/remotes/ko
-    URL: kernel.org:/pub/scm/git/git.git
-    Pull: master:refs/tags/ko-master
-    Pull: maint:refs/tags/ko-maint
-    Push: master
-    Push: +pu
-    Push: maint
++
+------------
+$ cat .git/remotes/ko
+URL: kernel.org:/pub/scm/git/git.git
+Pull: master:refs/tags/ko-master
+Pull: maint:refs/tags/ko-maint
+Push: master
+Push: +pu
+Push: maint
+------------
++
 In the output from "git show-branch", "master" should have
 everything "ko-master" has.
+
 <12> push out the bleeding edge.
 <13> push the tag out, too.
 
@@ -390,7 +395,7 @@ service git
         port            = 9418
         socket_type     = stream
         wait            = no
-        user            = root
+        user            = nobody
         server          = /usr/bin/git-daemon
         server_args     = --inetd --syslog --export-all --base-path=/pub/scm
         log_on_failure  += USERID
-- 
1.3.3.g16a4
