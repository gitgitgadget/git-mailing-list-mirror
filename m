From: freku045@student.liu.se
Subject: [PATCH 11/11] git-repack: Usage string clean-up, emit usage at incorrect invocation
Date: Tue, 13 Dec 2005 23:30:32 +0100
Message-ID: <11345130321353-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfY-0006Sp-Q9
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVLMWao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVLMWan
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:43 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51922 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030296AbVLMWal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A12DA411A; Tue, 13 Dec 2005 23:41:00 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfI-0001zV-00; Tue, 13 Dec 2005 23:30:32 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13600>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-repack.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

8b8f12ef2bdb33a0695a82c9f7a4f4eed112ad25
diff --git a/git-repack.sh b/git-repack.sh
index 430ddc5..1fafb6e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
+USAGE='[-a] [-d] [-l] [-n]'
 . git-sh-setup
 	
 no_update_info= all_into_one= remove_redundant= local=
@@ -13,7 +14,7 @@ do
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
 	-l)	local=t ;;
-	*)	break ;;
+	*)	usage ;;
 	esac
 	shift
 done
-- 
0.99.9.GIT
