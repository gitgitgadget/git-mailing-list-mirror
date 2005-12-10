From: freku045@student.liu.se
Subject: [PATCH 20/25] git-reset: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434791103-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYe-0002PO-11
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVLJTiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVLJTiV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:21 -0500
Received: from [85.8.31.11] ([85.8.31.11]:23245 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161051AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 949424126; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-000700-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13454>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-reset.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

33cc93a9e686c0daa64e430bf44b441809fd1025
diff --git a/git-reset.sh b/git-reset.sh
index 72ef303..58600fc 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -2,7 +2,7 @@
 . git-sh-setup
 
 usage () {
-	die 'Usage: git reset [--mixed | --soft | --hard]  [<commit-ish>]'
+	die 'usage: $0 [--mixed | --soft | --hard]  [<commit-ish>]'
 }
 
 tmp=/var/tmp/reset.$$
-- 
0.99.9.GIT
