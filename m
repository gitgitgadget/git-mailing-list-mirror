From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] include signal.h for prototype of signal()
Date: Mon, 26 Jun 2006 10:23:23 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060626082323.GB3646@informatik.uni-freiburg.de>
References: <20060626080912.GA3646@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 26 10:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumNU-0003xj-J9
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWFZIXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWFZIXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:23:25 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:28632 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S964866AbWFZIXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 04:23:24 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FumNP-0006HH-CQ
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:23:23 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5Q8NN712295
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:23:23 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060626080912.GA3646@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22658>

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 connect.c     |    1 +
 merge-index.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

46cd6d04f4531dfaf56f7f1beb4ea6c73f08015e
diff --git a/connect.c b/connect.c
index db7342e..6c5389b 100644
--- a/connect.c
+++ b/connect.c
@@ -3,6 +3,7 @@
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
+#include <signal.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
diff --git a/merge-index.c b/merge-index.c
index 190e12f..91908d8 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,3 +1,4 @@
+#include <signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
-- 
1.1.6.g7d80e


-- 
Uwe Zeisberger

http://www.google.com/search?q=the+speed+of+light+in+m%2Fs
