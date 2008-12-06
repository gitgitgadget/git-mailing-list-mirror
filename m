From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 1/2] gitk: Mark forgotten strings (header sentence parts in color chooser) for translation.
Date: Sat, 6 Dec 2008 20:48:30 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200812062048.30412.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L93Fn-0006V2-GC
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 20:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYLFTxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYLFTxR
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 14:53:17 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:37052 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYLFTxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 14:53:17 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6JrAMq032698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 6 Dec 2008 20:53:10 +0100
Received: from [192.168.0.101] (e176221017.adsl.alicedsl.de [85.176.221.17])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6Jr82s028585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Dec 2008 20:53:10 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102474>

---
 gitk |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index a5e24e4..39aabb3 100755
--- a/gitk
+++ b/gitk
@@ -10150,26 +10150,26 @@ proc doprefs {} {
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
 		      [list $ctext tag conf dresult -foreground]]
     grid x $top.diffnewbut $top.diffnew -sticky w
     label $top.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
     button $top.hunksepbut -text [mc "Diff: hunk header"] -font optionfont \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
-		      "diff hunk header" \
+		      [mc "diff hunk header"] \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.markbgsep -padx 40 -relief sunk -background $markbgcolor
@@ -10180,7 +10180,7 @@ proc doprefs {} {
     grid x $top.markbgbut $top.markbgsep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
     button $top.selbgbut -text [mc "Select bg"] -font optionfont \
-	-command [list choosecolor selectbgcolor {} $top.selbgsep background setselbg]
+	-command [list choosecolor selectbgcolor {} $top.selbgsep [mc "background"] setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
 
     label $top.cfont -text [mc "Fonts: press to choose"]
-- 
1.6.0.3.517.g759a
