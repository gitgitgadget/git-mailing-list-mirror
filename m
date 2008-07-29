From: Steffen Prohaska <prohaska@zib.de>
Subject: [FOR DEBUGGING] Stop installing BUILT_INS
Date: Tue, 29 Jul 2008 07:17:27 +0200
Message-ID: <1217308647-23673-2-git-send-email-prohaska@zib.de>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de>
 <1217308647-23673-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhbg-0003sK-6x
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbYG2FRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYG2FRp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:17:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:37222 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYG2FRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:17:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5HShh027289;
	Tue, 29 Jul 2008 07:17:33 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5HSha025345;
	Tue, 29 Jul 2008 07:17:28 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217308647-23673-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90569>

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
