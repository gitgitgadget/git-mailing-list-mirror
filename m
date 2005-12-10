From: freku045@student.liu.se
Subject: [PATCH 15/25] git-pull: Don't print an extra new line at the end of the usage message.
Date: Sat, 10 Dec 2005 20:37:58 +0100
Message-ID: <11342434783018-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYm-0002PO-9q
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVLJTiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVLJTit
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:49 -0500
Received: from [85.8.31.11] ([85.8.31.11]:26061 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965062AbVLJTiU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:20 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C84AE4120; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXe-0006zc-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13460>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-pull.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

6123ce84502e443c10c6689966aa51c821775a1a
diff --git a/git-pull.sh b/git-pull.sh
index 3a13984..5a1ae2c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -12,8 +12,7 @@ usage () {
     [<fetch-options>]
     <repo> <head>...
 
-Fetch one or more remote refs and merge it/them into the current HEAD.
-'
+Fetch one or more remote refs and merge it/them into the current HEAD.'
     exit 1
 }
 
-- 
0.99.9.GIT
