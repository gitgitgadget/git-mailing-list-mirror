From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] unpack-objects: remove unused variable "eof"
Date: Tue, 29 Aug 2006 12:50:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608291250060.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 29 12:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI1BG-0007TW-OM
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 12:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWH2Kud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 06:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWH2Kud
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 06:50:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:62690 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932273AbWH2Kub (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 06:50:31 -0400
Received: (qmail invoked by alias); 29 Aug 2006 10:50:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 29 Aug 2006 12:50:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26200>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-unpack-objects.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index ca0ebc2..0c180b5 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -15,7 +15,7 @@ static const char unpack_usage[] = "git-
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
-static unsigned long offset, len, eof;
+static unsigned long offset, len;
 static SHA_CTX ctx;
 
 /*
@@ -26,8 +26,6 @@ static void * fill(int min)
 {
 	if (min <= len)
 		return buffer + offset;
-	if (eof)
-		die("unable to fill input");
 	if (min > sizeof(buffer))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-- 
1.4.2.g0f6b-dirty
