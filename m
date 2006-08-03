From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] fix git-revert command-line options
Date: Thu, 3 Aug 2006 17:42:23 +0200
Message-ID: <200608031742.23170.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 17:38:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fGh-0007eZ-Rg
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWHCPhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWHCPhp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:37:45 -0400
Received: from fe-3a.inet.it ([213.92.5.105]:3557 "EHLO fe-3a.inet.it")
	by vger.kernel.org with ESMTP id S964799AbWHCPhn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:37:43 -0400
Received: from dial-up-mi-12.lombardiacom.it ([::ffff:212.34.225.12]) by fe-3a.inet.it via I-SMTP-5.4.4-546
	id ::ffff:212.34.225.12+XYSi5hBjT67; Thu, 03 Aug 2006 17:37:41 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Message-ID: <20060803153742.109978@dial-up-mi-12.lombardiacom.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael <barra_cuda@katamail.com>
---
 git-revert.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index 2bf35d1..195c3ba 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -22,14 +22,14 @@ no_commit= replay=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
-	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
+	-n|--no-c|--no-co|--no-com|--no-comm|\
 	    --no-commi|--no-commit)
 		no_commit=t
 		;;
 	-e|--e|--ed|--edi|--edit)
 		edit=-e
 		;;
-	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
+	--n|--no-e|--no-ed|--no-edi|--no-edit)
 		edit=
 		;;
 	-r|--r|--re|--rep|--repl|--repla|--replay)
-- 
1.4.1
