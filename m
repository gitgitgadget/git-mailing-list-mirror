From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/4] bugfix for cg-init: ARGV
Date: Sun, 10 Jul 2005 23:53:24 -0400
Message-ID: <20050711035316.22229.64951.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:53:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpML-0008En-JX
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVGKDx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVGKDx0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:53:26 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:1972 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262215AbVGKDxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:53:24 -0400
Received: (qmail 39149 invoked from network); 11 Jul 2005 03:53:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=6pdJF+I7U9FUTI6tk2gndYi7rG6SVNKWpC4MR4R1SPOaFZW9Leev41czuc5Wn9kgIJIH+TrlPPlNomq9uSQFgto42ahlT9X8Td2JIt2Wx7jAFfbADntOA/TPUuvvLQKUx2mmP0vttINB0RA4FxvdFSBtf4fTN+G4gZxdpIcZRrY=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 03:53:21 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bugfix: nasty typo (ARGV instead of ARGS) in my last patch to cg-init.

Signed off by: Bryan Larsen <bryan.larsen@gmail.com>
---

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -33,7 +33,7 @@ while optparse; do
 	fi
 done
 
-uri=$ARGV
+uri=$ARGS
 
 [ -e $_git ] && die "$_git already exists"
 
