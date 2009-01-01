From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] bash completions: Add the --patience option
Date: Thu, 1 Jan 2009 17:39:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011739240.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQb4-0007PQ-Mm
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbZAAQjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756353AbZAAQjN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:39:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756266AbZAAQjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:39:13 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:39:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 01 Jan 2009 17:39:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18s5aEM5c8syTVJC3VfzkLypXbvbKzroQSeKQxquY
	+gP3OVmVFq4Rlo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104300>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a046441..b3e1e22 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -777,6 +777,7 @@ _git_diff ()
 			--no-prefix --src-prefix= --dst-prefix=
 			--base --ours --theirs
 			--inter-hunk-context=
+			--patience
 			"
 		return
 		;;
@@ -969,6 +970,7 @@ _git_log ()
 			--parents --children --full-history
 			--merge
 			--inter-hunk-context=
+			--patience
 			"
 		return
 		;;
-- 
1.6.1.rc3.412.ga72b
