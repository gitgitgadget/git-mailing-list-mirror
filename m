From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/3] git-whatchanged: Add usage string
Date: Thu, 15 Dec 2005 23:48:38 +0100
Message-ID: <20051215224838.GE14388@c165.ib.student.liu.se>
References: <20051215224350.GB14388@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 23:50:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En1u7-0006Ug-LM
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 23:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVLOWsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVLOWsj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 17:48:39 -0500
Received: from [85.8.31.11] ([85.8.31.11]:63701 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751176AbVLOWsj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 17:48:39 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 867C04102; Thu, 15 Dec 2005 23:59:13 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1En1tu-0004A9-00; Thu, 15 Dec 2005 23:48:38 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051215224350.GB14388@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13717>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-whatchanged.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

1d3bc689dd66918b27432ad868592c9cc557f926
diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index 85a49fc..b170f74 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -1,4 +1,9 @@
 #!/bin/sh
+
+USAGE='[-p] [--max-count=<n>] [<since>..<limit>] [--pretty=<format>] [-m] [git-diff-tree options] [git-rev-list options]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
 rev_list_args=$(git-rev-parse --sq --default HEAD --revs-only "$@") &&
 diff_tree_args=$(git-rev-parse --sq --no-revs "$@") &&
 
-- 
0.99.9.GIT
