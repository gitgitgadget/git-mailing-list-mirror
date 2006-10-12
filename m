From: Ray Lehtiniemi <rayl@mail.com>
Subject: [PATCH] [PATCH] gitk: Handle spaces in filenames
Date: Thu, 12 Oct 2006 09:03:39 -0600
Message-ID: <11606654193188-git-send-email-rayl@mail.com>
References: <452E5510.9090002@arces.unibo.it>
 <11606654193083-git-send-email-rayl@mail.com>
Cc: Ray Lehtiniemi <rayl@mail.com>
X-From: git-owner@vger.kernel.org Thu Oct 12 17:09:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY27q-0001Mj-19
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 17:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWJLPFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWJLPFb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 11:05:31 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7466 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932566AbWJLPFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 11:05:30 -0400
Received: from pd5mr4so.prod.shaw.ca
 (pd5mr4so-qfe3.prod.shaw.ca [10.0.141.168]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J71006NS365MO30@l-daemon> for git@vger.kernel.org; Thu,
 12 Oct 2006 09:03:41 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd5mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0J7100MFJ3651AN0@pd5mr4so.prod.shaw.ca> for
 git@vger.kernel.org; Thu, 12 Oct 2006 09:03:41 -0600 (MDT)
Received: from ray.lehtiniemi.com ([68.147.121.172])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J7100ITS364JXM0@l-daemon> for git@vger.kernel.org; Thu,
 12 Oct 2006 09:03:41 -0600 (MDT)
Received: by ray.lehtiniemi.com (Postfix, from userid 1000)
	id A2E2750EFE6; Thu, 12 Oct 2006 09:03:39 -0600 (MDT)
In-reply-to: <11606654193083-git-send-email-rayl@mail.com>
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.rc2.ge19ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28783>

---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index ebbeac6..3196719 100755
--- a/gitk
+++ b/gitk
@@ -4324,7 +4324,7 @@ proc gettreediffline {gdtf ids} {
 	}
 	return
     }
-    set file [lindex $line 5]
+    set file [lrange $line 5 end]
     lappend treediff $file
 }
 
-- 
1.4.3.rc2.ge19ff
