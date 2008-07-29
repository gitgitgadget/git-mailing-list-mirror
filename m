From: Steffen Prohaska <prohaska@zib.de>
Subject: [FOR DEBUGGING] Stop installing BUILT_INS
Date: Tue, 29 Jul 2008 07:19:44 +0200
Message-ID: <1217308784-25408-2-git-send-email-prohaska@zib.de>
References: <766FEC61-619E-4A13-A21B-0734D83074C5@zib.de>
 <1217308784-25408-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNheY-0004Zv-DO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYG2FUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYG2FUk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:20:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:38294 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbYG2FUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:20:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5JjbA028005;
	Tue, 29 Jul 2008 07:19:50 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5Jiq3026059;
	Tue, 29 Jul 2008 07:19:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217308784-25408-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90572>

---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b2bc0ef..e416ec7 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,7 +1366,7 @@ endif
 		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
 		cp "$$bindir/git$X" "$$execdir/git$X"; \
 	fi && \
-	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
+	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" ;) } && \
 	$(RM) "$$execdir/git$X" && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
-- 
1.6.0.rc0.79.gb0320
