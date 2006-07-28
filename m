From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: ssh-pull.o depends on ssh-fetch.c
Date: Fri, 28 Jul 2006 11:17:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281117240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jul 28 11:17:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6OTg-0002km-RL
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 11:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWG1JRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 05:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWG1JRt
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 05:17:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:61899 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932599AbWG1JRs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 05:17:48 -0400
Received: (qmail invoked by alias); 28 Jul 2006 09:17:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 28 Jul 2006 11:17:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24378>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 636679f..e8037ad 100644
--- a/Makefile
+++ b/Makefile
@@ -661,6 +661,7 @@ git-%$X: %.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIB_FILE) $(SIMPLE_LIB)
 
+ssh-pull.o: ssh-fetch.c
 git-local-fetch$X: fetch.o
 git-ssh-fetch$X: rsh.o fetch.o
 git-ssh-upload$X: rsh.o
-- 
1.4.2.rc2.g51ee8-dirty
