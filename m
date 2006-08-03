From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] fixed variable declaration in gitk
Date: Thu, 3 Aug 2006 17:42:44 +0200
Message-ID: <200608031742.44349.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 17:38:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fHZ-0007rZ-Hx
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWHCPiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWHCPiF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:38:05 -0400
Received: from fe-7a.inet.it ([213.92.5.113]:62949 "EHLO fe-7a.inet.it")
	by vger.kernel.org with ESMTP id S964800AbWHCPiE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:38:04 -0400
Received: from dial-up-mi-12.lombardiacom.it ([::ffff:212.34.225.12]) by fe-7a.inet.it via I-SMTP-5.4.4-546
	id ::ffff:212.34.225.12+tKguh0m4Y6t; Thu, 03 Aug 2006 17:38:02 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Message-ID: <20060803153802.756931@dial-up-mi-12.lombardiacom.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael <barra_cuda@katamail.com>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index ba4644f..5acaadf 100755
--- a/gitk
+++ b/gitk
@@ -4901,7 +4901,7 @@ proc domktag {} {
 
 proc redrawtags {id} {
     global canv linehtag commitrow idpos selectedline curview
-    global mainfont
+    global mainfont canvxmax
 
     if {![info exists commitrow($curview,$id)]} return
     drawcmitrow $commitrow($curview,$id)
-- 
1.4.1
