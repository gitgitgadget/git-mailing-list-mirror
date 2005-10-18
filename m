From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Ignore more generated files
Date: Tue, 18 Oct 2005 16:28:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510181627390.31297@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 18 16:30:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERsRv-0007ww-Pe
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 16:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJRO2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVJRO2R
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 10:28:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4830 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750763AbVJRO2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 10:28:16 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 163F713EE12; Tue, 18 Oct 2005 16:28:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EBF0FB4DCA; Tue, 18 Oct 2005 16:28:15 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D1D78B4DC4; Tue, 18 Oct 2005 16:28:15 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BC97613EE12; Tue, 18 Oct 2005 16:28:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10213>

Since git-status now shows the "other" files, too, bring .gitignore
up-to-date.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

applies-to: c96a7218cfb074d2847d54952c8570acd8bf08a9
555ff41f8df92ebb2cf58cb9797e339175733ef7
diff --git a/.gitignore b/.gitignore
index b34a77a..975e773 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,6 +86,7 @@ git-ssh-push
 git-ssh-upload
 git-status
 git-stripspace
+git-svnimport
 git-symbolic-ref
 git-tag
 git-tar-tree
@@ -106,3 +107,5 @@ git-core-*/?*
 *.deb
 git-core.spec
 *.exe
+libgit.a
+*.o
---
0.99.8.GIT
