From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: What's in git.git
Date: Thu, 3 Aug 2006 00:37:39 -0700
Message-ID: <20060803073739.GB12755@prophet.net-ronin.org>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net> <20060802192922.GA30539@prophet.net-ronin.org> <7virlas9ol.fsf@assigned-by-dhcp.cox.net> <20060803053004.GA10413@prophet.net-ronin.org> <20060803054831.GB10413@prophet.net-ronin.org> <20060803073636.GA12755@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 09:37:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Xm8-0006WK-4U
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 09:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHCHhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 03:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHCHhp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 03:37:45 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:56552 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S932371AbWHCHhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 03:37:45 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1G8Xlz-0003Nc-00; Thu, 03 Aug 2006 00:37:39 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060803073636.GA12755@prophet.net-ronin.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24708>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Of course, and the patch gets munched.  Re-trying as an attachment. :(

-- DN
Daniel

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Save-geometry-ctexth-in-.gitk.txt"

>From 1483a6207ffe8bf216ea3258db7b453857c3e1d6 Mon Sep 17 00:00:00 2001
From: Daniel Nobuto <ramune@net-ronin.org>
Date: Thu, 3 Aug 2006 00:32:01 -0700
Subject: [PATCH] Save geometry(ctexth) in ~/.gitk

Not doing so causes subsequent launches of gitk to "lose" the bottom bits
of the window.

Signed-off-by: Daniel Nobuto <ramune@net-ronin.org>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index ba4644f..5ae28ef 100755
--- a/gitk
+++ b/gitk
@@ -770,6 +770,9 @@ proc savestuff {w} {
 	set wid [expr {([winfo width $ctext] - 8) \
 			   / [font measure $textfont "0"]}]
 	puts $f "set geometry(ctextw) $wid"
+	set geometry(ctexth) [expr {($texth - 8) /
+			   / [font metrics $textfont -linespace]}]
+	puts $f "set geometry(ctexth) $wid"
 	set wid [expr {([winfo width $cflist] - 11) \
 			   / [font measure [$cflist cget -font] "0"]}]
 	puts $f "set geometry(cflistw) $wid"
-- 
1.4.1.1


--k+w/mQv8wyuph6w0--
