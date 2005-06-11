From: Sebastian Kuzminsky <seb@highlab.com>
Subject: patch to remove cg from cogito
Date: Fri, 10 Jun 2005 23:30:58 -0600
Message-ID: <E1DgyaA-0004Pt-RV@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 07:24:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgyU6-00019d-ET
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 07:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFKF3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 01:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVFKF3D
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 01:29:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:24301 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261281AbVFKF26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 01:28:58 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc12) with ESMTP
          id <20050611052858012000td04e>; Sat, 11 Jun 2005 05:28:58 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DgyaA-0004Pt-RV
	for git@vger.kernel.org; Fri, 10 Jun 2005 23:30:58 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cogito wants to install an executable named "cg", but that's already taken
by cgvg <http://uzix.org/cgvg.html>.  I guess if people dont mind git
conflicting with that other git, probably no one will mind this either...
Just thought I'd put this out there:


 b/Makefile |    2 +-
 cg         |    7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)


diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -61,7 +61,7 @@
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
-	cg cg-admin-ls
+	cg-admin-ls
 
 LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xnormid
 
diff --git a/cg b/cg
deleted file mode 100755
--- a/cg
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-cmd="$1"; shift
-( [ x"$cmd" = x"--help" ] || [ x"$cmd" = x ] ) && exec cg-help
-
-exe="cg-$cmd"
-exec $exe "$@"


-- 
Sebastian Kuzminsky
