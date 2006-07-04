From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t8001-annotate: fix a bash-ism in this test
Date: Tue, 4 Jul 2006 01:04:24 -0700
Message-ID: <20060704080424.GA31612@soma>
References: <11519766021208-git-send-email-ryan@michonline.com> <11519766033852-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 10:04:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxftX-00071l-JO
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGDIE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGDIE1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:04:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:21918 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750965AbWGDIE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 04:04:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5C1E57DC021;
	Tue,  4 Jul 2006 01:04:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  4 Jul 2006 01:04:25 -0700
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <11519766033852-git-send-email-ryan@michonline.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23268>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t8001-annotate.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 70e2ad2..3a6490e 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -8,8 +8,8 @@ PROG='git annotate'
 
 test_expect_success \
     'Annotating an old revision works' \
-    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") == 2 ] && \
-     [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") == 2 ]'
+    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") -eq 2 ] && \
+     [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") -eq 2 ]'
 
 
 test_done
-- 
1.4.1.g4148
