From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Reverse the order of -b and --track in the man page.
Date: Mon, 23 Apr 2007 19:56:45 -0400
Message-ID: <20070423235645.GA197@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 01:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8P5-0004jD-CM
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbXDWX4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXDWX4s
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:56:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36799 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030792AbXDWX4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:56:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id BE87C1FFC003
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 23:56:47 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45384>

Using "-b --track newbranch oldbranch" gives the error:

  git checkout: updating paths is incompatible with switching
  branches/forcing

However, "--track -b ..." works just fine.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4f2e847..918d8ee 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [-b [--track | --no-track] <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
-- 
1.5.2.rc0.1.g2cc31
