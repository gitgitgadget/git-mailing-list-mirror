From: freku045@student.liu.se
Subject: [PATCH 10/11] git-rebase: Usage string clean-up, emit usage string at incorrect invocation
Date: Tue, 13 Dec 2005 23:30:32 +0100
Message-ID: <11345130323512-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfa-0006Sp-FE
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVLMWar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLMWaq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:46 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51410 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030295AbVLMWal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 7D5724119; Tue, 13 Dec 2005 23:41:00 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfI-0001zR-00; Tue, 13 Dec 2005 23:30:32 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13601>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-rebase.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

e5739c10c7fb47d091cf774941da6e4b4629f350
diff --git a/git-rebase.sh b/git-rebase.sh
index 638ff0d..8a5f44a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
+USAGE='<upstream> [<head>]'
 . git-sh-setup
 
 # Make sure we do not have .dotest
@@ -19,7 +20,7 @@ you still have something valuable there.
 fi
 
 # The other head is given.  Make sure it is valid.
-other=$(git-rev-parse --verify "$1^0") || exit
+other=$(git-rev-parse --verify "$1^0") || usage
 
 # Make sure we have HEAD that is valid.
 head=$(git-rev-parse --verify "HEAD^0") || exit
@@ -36,7 +37,7 @@ esac
 # If the branch to rebase is given, first switch to it.
 case "$#" in
 2)
-	git-checkout "$2" || exit
+	git-checkout "$2" || usage
 esac
 
 # If the HEAD is a proper descendant of $other, we do not even need
-- 
0.99.9.GIT
