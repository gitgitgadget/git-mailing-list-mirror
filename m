From: David Kastrup <dak@gnu.org>
Subject: [PATCH] contrib/emacs/Makefile: Also install .el files.
Date: Sun, 15 Jul 2007 11:46:11 +0200
Organization: Organization?!?
Message-ID: <09ccbeffdf2ca787844d20fdc3e93d323da206f7.1184548803.git.dak@gnu.org>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 03:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAFKT-0005Yo-SM
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759709AbXGPBYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760073AbXGPBYq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:24:46 -0400
Received: from main.gmane.org ([80.91.229.2]:35182 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758288AbXGPBYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 21:24:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAFKD-0002fn-LU
	for git@vger.kernel.org; Mon, 16 Jul 2007 03:24:33 +0200
Received: from dslb-084-061-039-155.pools.arcor-ip.net ([84.61.39.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:24:33 +0200
Received: from dak by dslb-084-061-039-155.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:24:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-155.pools.arcor-ip.net
X-From-Line: 09ccbeffdf2ca787844d20fdc3e93d323da206f7 Mon Sep 17 00:00:00 2001
In-Reply-To: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:AOX2rNZiLfrcwl0hEBdaI0yiCH4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52618>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 contrib/emacs/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index 98aa0aa..92033f0 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -12,7 +12,7 @@ all: $(ELC)
 
 install: all
 	$(INSTALL) -d $(DESTDIR)$(emacsdir)
-	$(INSTALL_ELC) $(ELC) $(DESTDIR)$(emacsdir)
+	$(INSTALL_ELC) $(ELC:.elc=.el) $(ELC) $(DESTDIR)$(emacsdir)
 
 %.elc: %.el
 	$(EMACS) -batch -f batch-byte-compile $<
-- 
1.4.4.2
