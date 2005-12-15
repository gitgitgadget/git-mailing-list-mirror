From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/3] git-log: Add usage string
Date: Thu, 15 Dec 2005 23:48:26 +0100
Message-ID: <20051215224826.GD14388@c165.ib.student.liu.se>
References: <20051215224350.GB14388@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 23:50:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En1tm-0006LD-EY
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 23:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVLOWs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 17:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVLOWs1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 17:48:27 -0500
Received: from [85.8.31.11] ([85.8.31.11]:63189 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751175AbVLOWs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 17:48:27 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 5932740FF; Thu, 15 Dec 2005 23:59:01 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1En1ti-00049y-00; Thu, 15 Dec 2005 23:48:26 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051215224350.GB14388@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13716>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-log.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

381a6c62ad8e735de6122127c7684e8a14f41676
diff --git a/git-log.sh b/git-log.sh
index b36c4e9..c2ea71c 100755
--- a/git-log.sh
+++ b/git-log.sh
@@ -3,13 +3,13 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-# This one uses only subdirectory-aware commands, so no need to
-# include sh-setup-script.
+USAGE='[--max-count=<n>] [<since>..<limit>] [--pretty=<format>] [git-rev-list options]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
 
 revs=$(git-rev-parse --revs-only --no-flags --default HEAD "$@") || exit
 [ "$revs" ] || {
-	echo >&2 "No HEAD ref"
-	exit 1
+	die "No HEAD ref"
 }
 git-rev-list --pretty $(git-rev-parse --default HEAD "$@") |
 LESS=-S ${PAGER:-less}
-- 
0.99.9.GIT
