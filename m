From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] glossary: add 'reflog'
Date: Tue, 3 Jul 2007 21:28:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707032128020.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 03 22:28:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ozQ-00079d-D3
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002AbXGCU2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbXGCU2a
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 16:28:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:52095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756751AbXGCU23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 16:28:29 -0400
Received: (qmail invoked by alias); 03 Jul 2007 20:28:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 03 Jul 2007 22:28:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aR08KO+kaA9JI6TFSSusfMJ1bJui1NZVRdXss2a
	fKDNpNi/zqboey
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51533>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/glossary.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index e903abf..3f7b1e4 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -330,6 +330,12 @@ This commit is referred to as a "merge commit", or sometimes just a
 	denotes a particular <<def_object,object>>. These may be stored in
 	`$GIT_DIR/refs/`.
 
+[[def_reflog]]reflog::
+	A reflog shows the local "history" of a ref.  In other words,
+	it can tell you what the 3rd last revision in _this_ repository
+	was, and what was the current state in _this_ repository,
+	yesterday 9:14pm.  See gitlink:git-reflog[1] for details.
+
 [[def_refspec]]refspec::
 	A "refspec" is used by <<def_fetch,fetch>> and
 	<<def_push,push>> to describe the mapping between remote
-- 
1.5.3.rc0.2640.g59df9-dirty
