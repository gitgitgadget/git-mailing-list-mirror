From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: export NO_SVN_TESTS
Date: Fri, 7 Jul 2006 13:26:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607071326030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jul 07 13:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoTl-0007QS-GN
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWGGL0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWGGL0d
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:26:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:21450 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932104AbWGGL0c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 07:26:32 -0400
Received: (qmail invoked by alias); 07 Jul 2006 11:26:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 07 Jul 2006 13:26:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23432>


Without this patch, it really is not sufficient to define NO_SVN_TESTS
in config.mak or the Makefile.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e5e536a..2aa0123 100644
--- a/Makefile
+++ b/Makefile
@@ -708,6 +708,7 @@ # However, the environment gets quite bi
 # with that.
 
 export NO_PYTHON
+export NO_SVN_TESTS
 
 test: all
 	$(MAKE) -C t/ all
-- 
1.4.1.g2e7c-dirty
