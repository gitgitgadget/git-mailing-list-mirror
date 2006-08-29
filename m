From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Remove uneeded #include
Date: Tue, 29 Aug 2006 13:02:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608291302090.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 29 13:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI1Me-0001ik-Nj
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 13:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWH2LCh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 07:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWH2LCh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 07:02:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:46757 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751196AbWH2LCh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 07:02:37 -0400
Received: (qmail invoked by alias); 29 Aug 2006 11:02:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 29 Aug 2006 13:02:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26202>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 peek-remote.c  |    1 -
 receive-pack.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/peek-remote.c b/peek-remote.c
index 2b30980..87f1543 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include <sys/wait.h>
 
 static const char peek_remote_usage[] =
 "git-peek-remote [--exec=upload-pack] [host:]directory";
diff --git a/receive-pack.c b/receive-pack.c
index 2015316..78f75da 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -2,7 +2,6 @@ #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
-#include <sys/wait.h>
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-- 
1.4.2.ga16ff-dirty
