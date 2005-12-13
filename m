From: freku045@student.liu.se
Subject: [PATCH 5/11] git-applypatch: Usage string clean-up, emit usage string at incorrect invocation
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <11345130311492-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:34:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIgQ-0006dV-V1
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVLMWbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMWav
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:51 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52434 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030299AbVLMWao (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:44 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D2D214114; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001z7-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13602>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-applypatch.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

4aecb38bdf7d1f22bec895d0b3a936ded39bef4d
diff --git a/git-applypatch.sh b/git-applypatch.sh
index a112e1a..214f5c3 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -10,8 +10,12 @@
 ##	$3 - "info" file with Author, email and subject
 ##	$4 - optional file containing signoff to add
 ##
+
+USAGE='<msg> <patch> <info> [<signoff>]'
 . git-sh-setup
 
+[[ "$#" = "3" || "$#" = "4" ]] || usage
+
 final=.dotest/final-commit
 ##
 ## If this file exists, we ask before applying
-- 
0.99.9.GIT
