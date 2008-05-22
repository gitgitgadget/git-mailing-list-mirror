From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: Mark some strings for translation
Date: Thu, 22 May 2008 11:41:30 +0200
Message-ID: <200805221141.30776.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu May 22 11:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz7Gr-00080S-R4
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 11:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936476AbYEVJiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 05:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934364AbYEVJh6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 05:37:58 -0400
Received: from smtp.katamail.com ([62.149.157.154]:34911 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S936467AbYEVJh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 05:37:56 -0400
Received: (qmail 9654 invoked by uid 89); 22 May 2008 09:36:54 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO ?80.104.57.85?) (barra?cuda@katamail.com@80.104.57.85)
  by smtp1-pc with SMTP; 22 May 2008 09:36:53 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82609>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 998a051..e95b744 100755
--- a/gitk
+++ b/gitk
@@ -9271,31 +9271,31 @@ proc doprefs {} {
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
     button $top.bgbut -text [mc "Background"] -font optionfont \
-	-command [list choosecolor bgcolor {} $top.bg background setbg]
+	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg]
     grid x $top.bgbut $top.bg -sticky w
     label $top.fg -padx 40 -relief sunk -background $fgcolor
     button $top.fgbut -text [mc "Foreground"] -font optionfont \
-	-command [list choosecolor fgcolor {} $top.fg foreground setfg]
+	-command [list choosecolor fgcolor {} $top.fg [mc "foreground"] setfg]
     grid x $top.fgbut $top.fg -sticky w
     label $top.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
     button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfont \
-	-command [list choosecolor diffcolors 0 $top.diffold "diff old lines" \
+	-command [list choosecolor diffcolors 0 $top.diffold [mc "diff old lines"] \
 		      [list $ctext tag conf d0 -foreground]]
     grid x $top.diffoldbut $top.diffold -sticky w
     label $top.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
     button $top.diffnewbut -text [mc "Diff: new lines"] -font optionfont \
-	-command [list choosecolor diffcolors 1 $top.diffnew "diff new lines" \
+	-command [list choosecolor diffcolors 1 $top.diffnew [mc "diff new lines"] \
 		      [list $ctext tag conf d1 -foreground]]
     grid x $top.diffnewbut $top.diffnew -sticky w
     label $top.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
     button $top.hunksepbut -text [mc "Diff: hunk header"] -font optionfont \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
-		      "diff hunk header" \
+		      [mc "diff hunk header"] \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
     button $top.selbgbut -text [mc "Select bg"] -font optionfont \
-	-command [list choosecolor selectbgcolor {} $top.selbgsep background setselbg]
+	-command [list choosecolor selectbgcolor {} $top.selbgsep [mc "background"] setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
 
     label $top.cfont -text [mc "Fonts: press to choose"]
-- 
1.5.5.1
