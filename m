From: Steven Cole <elenstev@mesatop.com>
Subject: [PATCH] Add githelp.sh to Makefile.
Date: Sun, 24 Apr 2005 19:17:36 -0600
Message-ID: <200504241917.36174.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 03:17:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsDb-0003Yd-CE
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVDYBVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVDYBVx
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:21:53 -0400
Received: from taco.zianet.com ([216.234.192.159]:6404 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S262392AbVDYBVv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 21:21:51 -0400
Received: (qmail 76369 invoked from network); 25 Apr 2005 01:21:50 -0000
Received: from 216-31-65-71.zianet.com (216.31.65.71)
  by 0 with SMTP; 25 Apr 2005 01:21:50 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With this recent change:
	Separate the git help command to githelp.sh
We now need to install githelp.sh.  Added same to Makefile.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

Index: Makefile
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/Makefile  (mode:100644 sha1:0bbdbee6b6925b64af476de3cebde9b02f9b03ca)
+++ uncommitted/Makefile  (mode:100644)
@@ -36,7 +36,7 @@
 	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
 	gitapply.sh gitcancel.sh gitXlntree.sh gitlsremote.sh \
 	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpatch.sh \
-	gitmerge-file.sh
+	gitmerge-file.sh githelp.sh
 
 COMMON=	read-cache.o
 
