From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] imap-send: Add missing #include for macosx
Date: Sun, 12 Mar 2006 11:55:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603121155320.14411@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Mar 12 11:56:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIOEy-0005nF-TL
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 11:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWCLKz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 05:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCLKz5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 05:55:57 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3277 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932149AbWCLKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 05:55:57 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 120A01DCC;
	Sun, 12 Mar 2006 11:55:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 06273B24;
	Sun, 12 Mar 2006 11:55:54 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DA48C1DC7;
	Sun, 12 Mar 2006 11:55:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17509>


There is a compile error without that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

4f24a9d215bca31f40d5b994f59fff012e14086f
diff --git a/imap-send.c b/imap-send.c
index fddaac0..c2fd0fd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,6 +28,7 @@
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
+#include <sys/socket.h>
 #include <netdb.h>
 
 typedef struct store_conf {
-- 
1.2.0.gaa33-dirty
