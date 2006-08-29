From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: fix typo
Date: Tue, 29 Aug 2006 12:51:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608291250460.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 29 12:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI1Bg-0007ZM-4T
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 12:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWH2KvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 06:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWH2KvR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 06:51:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:16104 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932274AbWH2KvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 06:51:16 -0400
Received: (qmail invoked by alias); 29 Aug 2006 10:51:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 29 Aug 2006 12:51:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26201>


We checked NO_SETENV instead of NO_UNSETENV to decide if unsetenv
is available.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 19d62ee..ff1ec6e 100644
--- a/Makefile
+++ b/Makefile
@@ -524,7 +524,7 @@ ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
 endif
-ifdef NO_SETENV
+ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
 endif
-- 
1.4.2.g0f6b-dirty
