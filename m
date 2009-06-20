From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-svn documentation: fix typo in 'rebase vs. pull/merge'
	section
Date: Sat, 20 Jun 2009 13:27:15 +0200
Message-ID: <20090620112715.GB10895@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jun 20 13:41:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHywj-0005n7-Dv
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 13:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZFTLlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 07:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZFTLlK
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 07:41:10 -0400
Received: from virgo.iok.hu ([212.40.97.103]:46527 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbZFTLlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 07:41:10 -0400
X-Greylist: delayed 835 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 07:41:09 EDT
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 760755808C;
	Sat, 20 Jun 2009 13:27:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1D919448D3;
	Sat, 20 Jun 2009 13:27:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2E88211F0680; Sat, 20 Jun 2009 13:27:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121941>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ca3fc3d..bb22d8e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -623,7 +623,7 @@ pulled or merged from.  This is because the author favored
 If you use `git svn set-tree A..B` to commit several diffs and you do
 not have the latest remotes/git-svn merged into my-branch, you should
 use `git svn rebase` to update your work branch instead of `git pull` or
-`git merge`.  `pull`/`merge' can cause non-linear history to be flattened
+`git merge`.  `pull`/`merge` can cause non-linear history to be flattened
 when committing into SVN, which can lead to merge commits reversing
 previous commits in SVN.
 
-- 
1.6.2.5
