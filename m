From: freku045@student.liu.se
Subject: [PATCH 7/11] git-fetch: Usage string clean-up, emit usage string at unrecognized option
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <11345130313062-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIgR-0006dV-Ti
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVLMWat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVLMWar
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:47 -0500
Received: from [85.8.31.11] ([85.8.31.11]:50898 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030291AbVLMWal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1CCED4116; Tue, 13 Dec 2005 23:41:00 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001zF-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13603>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-fetch.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

64d3f091f8cfa405ee479f49c4890ae452ac0afd
diff --git a/git-fetch.sh b/git-fetch.sh
index 14ea295..767ca61 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 #
+
+USAGE='<fetch-options> <repository> <refspec>...'
 . git-sh-setup
 . git-parse-remote
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
@@ -34,6 +36,9 @@ do
 	-v|--verbose)
 		verbose=Yes
 		;;
+	-*)
+		usage
+		;;
 	*)
 		break
 		;;
-- 
0.99.9.GIT
