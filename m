From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] RelNotes: mention checkout/branch's --track option, too
Date: Sun, 23 Mar 2008 12:35:37 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231235230.4353@racer.site>
References: <7vprtl92jj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 12:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdOUu-0001Fk-8A
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 12:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbYCWLfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758884AbYCWLfj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 07:35:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:47731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755787AbYCWLfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 07:35:38 -0400
Received: (qmail invoked by alias); 23 Mar 2008 11:35:36 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp057) with SMTP; 23 Mar 2008 12:35:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bujheB6ibFpmis3O98xVw8pLHxUxIv5dhvy4lxZ
	xhIhTL/+q333Lc
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprtl92jj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77881>


checkout and branch recently learnt to track local branches when
branch.autosetupmerge = always, but they _also_ learnt to do that when
asked explicitely with the option "--track".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/RelNotes-1.5.5.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.5.5.txt b/Documentation/RelNotes-1.5.5.txt
index 14beed4..18ff82b 100644
--- a/Documentation/RelNotes-1.5.5.txt
+++ b/Documentation/RelNotes-1.5.5.txt
@@ -79,8 +79,9 @@ Updates since v1.5.4
  * "git branch" (and "git checkout -b") to branch from a local branch can
    optionally set "branch.<name>.merge" to mark the new branch to build on
    the other local branch, when "branch.autosetupmerge" is set to
-   "always".  By default, this does not happen when branching from a local
-   branch.
+   "always", or when passing the command line option "--track" (this option
+   was ignored when branching from local branches).  By default, this does
+   not happen when branching from a local branch.
 
  * "git checkout" to switch to a branch that has "branch.<name>.merge" set
    (i.e. marked to build on another branch) reports how much the branch
-- 
1.5.5.rc0.190.gb64f
