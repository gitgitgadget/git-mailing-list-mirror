From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] fix filter-branch documentation
Date: Wed, 17 Oct 2007 03:22:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710170322000.25221@racer.site>
References: <18197.24051.863751.436705@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhyYX-0007oG-Mo
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXJQCWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbXJQCWe
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:22:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753617AbXJQCWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:22:33 -0400
Received: (qmail invoked by alias); 17 Oct 2007 02:22:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 17 Oct 2007 04:22:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eagFIMlSexpwLQ1lgDYPyVUSI9gqQkH9KTzo853
	Nm3ClZ7F3mZyjq
X-X-Sender: gene099@racer.site
In-Reply-To: <18197.24051.863751.436705@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61315>


The man page for filter-branch still talked about writing the result
to the branch "newbranch".  This is hopefully the last place where the
old behaviour was described.

Noticed by Bill Lear.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index c878ed3..ba9b4fb 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -180,8 +180,7 @@ A significantly faster version:
 git filter-branch --index-filter 'git update-index --remove filename' HEAD
 --------------------------------------------------------------------------
 
-Now, you will get the rewritten history saved in the branch 'newbranch'
-(your current branch is left untouched).
+Now, you will get the rewritten history saved in HEAD.
 
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
-- 
1.5.3.4.1223.ga973c
