From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-format-patch should show the correct version
Date: Thu, 22 Dec 2005 20:38:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222036460.31820@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 20:38:38 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpWGl-0006Ik-E4
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 20:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbVLVTiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 14:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVLVTiY
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 14:38:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20907 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030180AbVLVTiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 14:38:24 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4918D13F9DE; Thu, 22 Dec 2005 20:38:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2FB9C9E3C9; Thu, 22 Dec 2005 20:38:23 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 18B4E9E2AA; Thu, 22 Dec 2005 20:38:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 01A2813F9DE; Thu, 22 Dec 2005 20:38:23 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13965>


We want to record the version of the tools the patch was generated with. 
While these tools could be rebuilt, git-format-patch stayed the same and 
report the wrong version.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

ca85baee8d11e5c4c6de4678fecf311a029c1d7c
diff --git a/Makefile b/Makefile
index d35637c..5dec33a 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,9 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % 
 git-cherry-pick: git-revert
 	cp $< $@
 
+# format-patch records GIT_VERSION
+git-format-patch: Makefile
+
 %.o: %.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
-- 
1.0.GIT
