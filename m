From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Kill $COPTS in favour of $CFLAGS
Date: Fri, 5 Aug 2005 00:52:16 +0200
Message-ID: <20050804225216.GH24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 00:58:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oe9-0000u2-IF
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 00:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVHDW4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVHDWxv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:53:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49677 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262727AbVHDWwR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:52:17 -0400
Received: (qmail 6181 invoked by uid 2001); 4 Aug 2005 22:52:16 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As proposed on the mailing list previously, remove the seemingly obscure
$COPTS usage in favour of a default $CFLAGS value, which is a more usual
usage.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 3e90b732f2c1c5d6b3b460be0c17cd24f3932ced
tree 51f9664dbc8e3b72b9941e5ccf8de867c3fb35b1
parent f0487fa4109c37dc67439c40ad894ec73433f471
author Petr Baudis <pasky@suse.cz> Fri, 05 Aug 2005 00:47:34 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 05 Aug 2005 00:47:34 +0200

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -34,8 +34,8 @@
 
 GIT_VERSION=0.99.3
 
-COPTS?=-g -O2
-CFLAGS+=$(COPTS) -Wall $(DEFINES)
+CFLAGS?=-g -O2
+CFLAGS+=-Wall $(DEFINES)
 
 prefix=$(HOME)
 bindir=$(prefix)/bin
