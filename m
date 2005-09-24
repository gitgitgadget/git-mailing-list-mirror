From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/4] Update git-daemon documentation wrt. the --verbose parameter
Date: Sat, 24 Sep 2005 16:12:58 +0200
Message-ID: <20050924141258.8423.21470.stgit@machine.or.cz>
References: <20050924141254.8423.80265.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAmI-0002Hw-Jk
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVIXOND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIXONB
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:13:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4036 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750753AbVIXONA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:13:00 -0400
Received: (qmail 8473 invoked from network); 24 Sep 2005 16:12:58 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 16:12:58 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050924141254.8423.80265.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9233>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-daemon.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -7,7 +7,7 @@ git-daemon - A really simple server for 
 
 SYNOPSIS
 --------
-'git-daemon' [--inetd | --port=n]
+'git-daemon' [--verbose] [--inetd | --port=n]
 
 DESCRIPTION
 -----------
@@ -32,6 +32,9 @@ OPTIONS
 --port::
 	Listen on an alternative port.
 
+--verbose::
+	Log details about the incoming connections and requested files.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
