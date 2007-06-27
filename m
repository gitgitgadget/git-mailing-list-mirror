From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Use a spinbox for setting tabstop settings
Date: Tue, 26 Jun 2007 21:51:35 -0400
Message-ID: <118290910058-git-send-email-mdl123@verizon.net>
References: <18048.36797.283166.952377@cargo.ozlabs.ibm.com>
 <11829090952211-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Jun 27 03:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Mhc-0006Gj-32
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbXF0BwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbXF0BwL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:52:11 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:49590 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778AbXF0BwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:52:06 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.74])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JK9008DPUIAI0Y4@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 26 Jun 2007 20:51:47 -0500 (CDT)
In-reply-to: <11829090952211-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.2.2.282.g9826
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51000>

The tabstop must be a smallish positive integer, and a spinbox is the
accepted UI control to accomplish this limiting rather than the text
entry box previously used.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index c06d327..2d6a6ef 100755
--- a/gitk
+++ b/gitk
@@ -6972,7 +6972,7 @@ proc doprefs {} {
     pack $top.ntag.b $top.ntag.l -side left
     grid x $top.ntag -sticky w
     label $top.tabstopl -text "tabstop" -font optionfont
-    entry $top.tabstop -width 10 -textvariable tabstop
+    spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
 
     label $top.cdisp -text "Colors: press to choose"
-- 
1.5.2.2.282.g9826
