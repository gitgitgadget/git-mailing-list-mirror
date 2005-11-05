From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] gitk: moving all three panes if clicking on an arrow.
Date: Sat, 5 Nov 2005 20:55:29 +0100
Organization: -no organization-
Message-ID: <20051105195529.GB6081@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 05 20:56:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYU8V-0000bo-8Z
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 20:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVKETzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 14:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVKETzc
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 14:55:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:39394 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932313AbVKETzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2005 14:55:31 -0500
Received: from p54862C68.dip0.t-ipconnect.de [84.134.44.104] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis),
	id 0MKxQS-1EYU8Q2msT-00060a; Sat, 05 Nov 2005 20:55:30 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3) with ESMTP id jA5JtTLg009019
	for <git@vger.kernel.org>; Sat, 5 Nov 2005 20:55:29 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id jA5JtTX9009017
	for git@vger.kernel.org; Sat, 5 Nov 2005 20:55:29 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.84/1163/Sat Nov  5 08:01:23 2005 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11182>

[PATCH] gitk: moving all three panes if clicking on an arrow.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

---

 gitk |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

applies-to: ef3876e50bb5e91a6fb40d4e59df2178c6f40237
078ef4fa295368b5337ad797b27372bbaa19d7fc
diff --git a/gitk b/gitk
index a9d37d9..616a3e2 100755
--- a/gitk
+++ b/gitk
@@ -3178,7 +3178,7 @@ proc clickisonarrow {id y} {
 }
 
 proc arrowjump {id dirn y} {
-    global mainline sidelines canv
+    global mainline sidelines canv canv2 canv3
 
     set yt {}
     if {$dirn eq "down"} {
@@ -3216,6 +3216,8 @@ proc arrowjump {id dirn y} {
        set yfrac 0
     }
     $canv yview moveto $yfrac
+    $canv2 yview moveto $yfrac
+    $canv3 yview moveto $yfrac
 }
 
 proc lineclick {x y id isnew} {
---
0.99.8.GIT

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
