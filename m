From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] fix daemon.c compilation for NO_IPV6=1
Date: Thu, 28 Sep 2006 20:48:14 +0200
Message-ID: <20060928184814.GA4294@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 28 20:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT0w9-0003mw-Eq
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWI1Sse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWI1Sse
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:48:34 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:8578 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030360AbWI1Ssd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 14:48:33 -0400
Received: from fwd33.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1GT0vt-000752-03; Thu, 28 Sep 2006 20:48:29 +0200
Received: from tigra.home (ZZxmXMZJ8eAV+5LvQ5MS6O8Ke5h1PXWwxK-zVu-p15gCKUkG5GF-wB@[84.160.84.153]) by fwd33.sul.t-online.de
	with esmtp id 1GT0vg-2C9gPI0; Thu, 28 Sep 2006 20:48:16 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 05426277AF;
	Thu, 28 Sep 2006 20:48:14 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GT0ve-00020e-KR; Thu, 28 Sep 2006 20:48:14 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-ID: ZZxmXMZJ8eAV+5LvQ5MS6O8Ke5h1PXWwxK-zVu-p15gCKUkG5GF-wB
X-TOI-MSGID: a2cb3646-f088-4ea5-8382-dcd758ee6211
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28033>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Just a typo.

diff --git a/daemon.c b/daemon.c
index fc3951c..ad84928 100644
--- a/daemon.c
+++ b/daemon.c
@@ -834,7 +834,7 @@ #endif
 
 #else /* NO_IPV6 */
 
-static int socksetup(char *lisen_addr, int listen_port, int **socklist_p)
+static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 {
 	struct sockaddr_in sin;
 	int sockfd;
