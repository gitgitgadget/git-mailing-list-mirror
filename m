From: Christian Couder <chriscool@tuxfamily.org>
Subject: Bisect: simplify "bisect start" logging.
Date: Tue, 17 Apr 2007 06:40:50 +0200
Message-ID: <20070417064050.fd9dfc99.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfN9-0003tX-1d
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031083AbXDQEck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031085AbXDQEck
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:32:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54603 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031083AbXDQEcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:32:39 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 00ED8B929A;
	Tue, 17 Apr 2007 06:32:36 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44721>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 85c374e..1cd4561 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -116,10 +116,7 @@ bisect_start() {
         done
 
 	sq "$@" >"$GIT_DIR/BISECT_NAMES"
-	{
-	    printf "git-bisect start"
-	    echo "$orig_args"
-	} >>"$GIT_DIR/BISECT_LOG"
+	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
 
-- 
1.5.1.1.821.g88bdb-dirty
