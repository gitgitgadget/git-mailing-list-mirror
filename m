From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: remove dots in some UI strings
Date: Sun, 2 Sep 2007 14:43:00 +0200
Message-ID: <200709021443.00144.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 17:31:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRrPk-0001nL-1K
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 17:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbXIBPa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbXIBPa6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 11:30:58 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:59147 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbXIBPa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 11:30:57 -0400
Received: from host6-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.6]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.6+NrDeeg1wWcLmO; Sun, 02 Sep 2007 17:30:55 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57340>

Dots in a UI string usually mean that a dialog box will
appear waiting for further input. So this patch removes
unneeded dots for actions that do not require user's
input.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 lib/remote.tcl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index cf9b9d5..99ec1b4 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -159,7 +159,7 @@ proc populate_fetch_menu {} {
 		if {$enable} {
 			lappend prune_list $r
 			$m add command \
-				-label "Fetch from $r..." \
+				-label "Fetch from $r" \
 				-command [list fetch_from $r]
 		}
 	}
@@ -169,7 +169,7 @@ proc populate_fetch_menu {} {
 	}
 	foreach r $prune_list {
 		$m add command \
-			-label "Prune from $r..." \
+			-label "Prune from $r" \
 			-command [list prune_from $r]
 	}
 }
@@ -203,7 +203,7 @@ proc populate_push_menu {} {
 				$m add separator
 			}
 			$m add command \
-				-label "Push to $r..." \
+				-label "Push to $r" \
 				-command [list push_to $r]
 			incr fast_count
 		}
-- 
1.5.3.rc7
