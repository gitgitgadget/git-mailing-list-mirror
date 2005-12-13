From: freku045@student.liu.se
Subject: [PATCH 3/11] git-revert: Usage string clean-up
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <1134513031450-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfW-0006Sp-Hb
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVLMWak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMWak
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:40 -0500
Received: from [85.8.31.11] ([85.8.31.11]:48082 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030287AbVLMWah (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:37 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 926F24102; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001yz-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13596>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-revert.sh |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

16ecbff0d2e6cf51ff92f081ad66b5bcc3883e31
diff --git a/git-revert.sh b/git-revert.sh
index 9d499c4..63d201b 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -3,29 +3,20 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2005 Junio C Hamano
 #
-. git-sh-setup
 
 case "$0" in
 *-revert* )
 	test -t 0 && edit=-e
-	me=revert ;;
+	me=revert
+	USAGE='[--edit | --no-edit] [-n] <commit-ish>' ;;
 *-cherry-pick* )
 	edit=
-	me=cherry-pick ;;
+	me=cherry-pick
+	USAGE='[--edit] [-n] [-r] <commit-ish>'  ;;
 * )
 	die "What are you talking about?" ;;
 esac
-
-usage () {
-	case "$me" in
-	cherry-pick)
-		die "usage git $me [--edit] [-n] [-r] <commit-ish>"
-		;;
-	revert)
-		die "usage git $me [--edit | --no-edit] [-n] <commit-ish>"
-		;;
-	esac
-}
+. git-sh-setup
 
 no_commit= replay=
 while case "$#" in 0) break ;; esac
-- 
0.99.9.GIT
