From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 01/02] ident.c: Use const qualifier when possible
Date: Sun, 15 Apr 2007 15:51:10 -0300
Organization: Mandriva
Message-ID: <20070415155110.365070d8@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 20:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd9p8-00055o-G2
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 20:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbXDOSvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbXDOSvW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 14:51:22 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47173 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbXDOSvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 14:51:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id EB35918AA6;
	Sun, 15 Apr 2007 15:51:19 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id zjOTDISZ9BK7; Sun, 15 Apr 2007 15:51:15 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4645318A94;
	Sun, 15 Apr 2007 15:51:14 -0300 (BRT)
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44501>


Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 ident.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index bb03bdd..454aace 100644
--- a/ident.c
+++ b/ident.c
@@ -9,7 +9,7 @@
 
 static char git_default_date[50];
 
-static void copy_gecos(struct passwd *w, char *name, int sz)
+static void copy_gecos(const struct passwd *w, char *name, int sz)
 {
 	char *src, *dst;
 	int len, nlen;
@@ -43,7 +43,7 @@ static void copy_gecos(struct passwd *w, char *name, int sz)
 
 }
 
-static void copy_email(struct passwd *pw)
+static void copy_email(const struct passwd *pw)
 {
 	/*
 	 * Make up a fake email address
@@ -172,7 +172,7 @@ static int copy(char *buf, int size, int offset, const char *src)
 
 static const char au_env[] = "GIT_AUTHOR_NAME";
 static const char co_env[] = "GIT_COMMITTER_NAME";
-static const char *env_hint =
+static const char const *env_hint =
 "\n"
 "*** Your name cannot be determined from your system services (gecos).\n"
 "\n"
-- 
1.5.1.1.86.gfd56-dirty
