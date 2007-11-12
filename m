From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Documentation: Fix references to deprecated commands
Date: Mon, 12 Nov 2007 01:24:10 +0100
Message-ID: <20071112002410.GA21970@diku.dk>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site> <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org> <20071109002001.GB5082@diku.dk> <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 01:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrN6M-0005nn-FD
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbXKLAYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755734AbXKLAYP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:24:15 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:54778 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510AbXKLAYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:24:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 880C5770017;
	Mon, 12 Nov 2007 01:24:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RB1JLxfa3y0B; Mon, 12 Nov 2007 01:24:10 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6C70E770015;
	Mon, 12 Nov 2007 01:24:10 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8DE206DFF77; Mon, 12 Nov 2007 01:23:44 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 4D4C45B8001; Mon, 12 Nov 2007 01:24:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64539>

... by changing git-tar-tree reference to git-archive and removing
seemingly unrelevant footnote about git-ssh-{fetch,upload}.
---
 Documentation/core-tutorial.txt         |    5 -----
 Documentation/git-get-tar-commit-id.txt |    4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

 Maybe also fixing these references would be in order.

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index ebd2492..401d1de 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1090,11 +1090,6 @@ server like git Native transport does.  Any stock HTTP server
 that does not even support directory index would suffice.  But
 you must prepare your repository with `git-update-server-info`
 to help dumb transport downloaders.
-+
-There are (confusingly enough) `git-ssh-fetch` and `git-ssh-upload`
-programs, which are 'commit walkers'; they outlived their
-usefulness when git Native and SSH transports were introduced,
-and are not used by `git pull` or `git push` scripts.
 
 Once you fetch from the remote repository, you `merge` that
 with your current branch.
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 9b5f86f..ef1b19c 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -14,12 +14,12 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Acts as a filter, extracting the commit ID stored in archives created by
-git-tar-tree.  It reads only the first 1024 bytes of input, thus its
+gitlink:git-archive[1].  It reads only the first 1024 bytes of input, thus its
 runtime is not influenced by the size of <tarfile> very much.
 
 If no commit ID is found, git-get-tar-commit-id quietly exists with a
 return code of 1.  This can happen if <tarfile> had not been created
-using git-tar-tree or if the first parameter of git-tar-tree had been
+using git-archive or if the first parameter of git-tar-tree had been
 a tree ID instead of a commit ID or tag.

-- 
Jonas Fonseca
