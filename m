From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/2] gitk: fix setting font display with new tabbed dialog layout.
Date: Sun,  1 Apr 2012 23:00:52 +0100
Message-ID: <1333317652-1464-3-git-send-email-patthoyts@users.sourceforge.net>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: <git@vger.kernel.org>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 00:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SESsz-00006H-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 00:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2DAWEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 18:04:12 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:23749 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753601Ab2DAWDj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 18:03:39 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120401220337.MNIC9621.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sun, 1 Apr 2012 23:03:37 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1SESs5-0006pH-Al; Sun, 01 Apr 2012 23:03:37 +0100
Received: from localhost.localdomain (frog.patthoyts.tk [192.168.0.25])
	by fox.patthoyts.tk (Postfix) with ESMTP id E135F20054;
	Sun,  1 Apr 2012 23:03:36 +0100 (BST)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=ZOn3_z7TWmAA:10 a=FP58Ms26AAAA:8 a=DD5-0zZjEv7riEzi2l8A:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194487>

The changes to the dialog window tree broke the preview of the selected
font on the button. This corrects that issue.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 68cd1a1..22270ce 100755
--- a/gitk
+++ b/gitk
@@ -10795,7 +10795,7 @@ proc fontok {} {
     if {$fontparam(slant) eq "italic"} {
 	lappend fontpref($f) "italic"
     }
-    set w $prefstop.$f
+    set w $prefstop.notebook.fonts.$f
     $w conf -text $fontparam(family) -font $fontpref($f)
 
     fontcan
-- 
1.7.9.msysgit.0
