From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] completion: also complete git-log's --left-right and
 --cherry-pick option
Date: Wed, 29 Aug 2007 15:15:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291514430.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O.Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:16:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOKd-0006vt-5F
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbXH2OPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbXH2OPj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:15:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:55581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbXH2OPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:15:38 -0400
Received: (qmail invoked by alias); 29 Aug 2007 14:15:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 29 Aug 2007 16:15:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18H1yAPBzMHyyZoDYggN9yOeTEA+irXKErPGW5nCX
	yWzne1tM4zq5G5
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56953>


Both --left-right and --cherry-pick are particularly long to type, so
help the user there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a652c88..5ed1821 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -641,6 +641,7 @@ _git_log ()
 			--all-match
 			--pretty= --name-status --name-only --raw
 			--not --all
+			--left-right --cherry-pick
 			"
 		return
 		;;
-- 
1.5.3.rc7.2.g2d7f
