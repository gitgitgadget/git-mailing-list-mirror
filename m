From: freku045@student.liu.se
Subject: [PATCH 4/11] git-am: Usage string clean-up
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <11345130311665-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfY-0006Sp-7z
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVLMWan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVLMWam
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:42 -0500
Received: from [85.8.31.11] ([85.8.31.11]:48338 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030289AbVLMWai (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:38 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B47174103; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001z3-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13595>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-am.sh |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

243b906a6786cd7401285cacaf9ade994ff83db8
diff --git a/git-am.sh b/git-am.sh
index 6ed527c..39f2552 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -1,14 +1,10 @@
 #!/bin/sh
 #
 #
-. git-sh-setup
 
-usage () {
-    echo >&2 "usage: $0 [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>"
-    echo >&2 "	or, when resuming"
-    echo >&2 "	$0 [--skip | --resolved]"
-    exit 1;
-}
+USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>
+  or, when resuming [--skip | --resolved]'
+. git-sh-setup
 
 stop_here () {
     echo "$1" >"$dotest/next"
-- 
0.99.9.GIT
