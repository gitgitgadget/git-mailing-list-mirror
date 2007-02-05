From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/6] bash: Hide git-resolve, its deprecated.
Date: Mon, 5 Feb 2007 15:44:30 -0500
Message-ID: <20070205204430.GD8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhl-0007ZE-7Z
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbXBEUof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933447AbXBEUoe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36106 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933450AbXBEUod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhL-0008IG-OH; Mon, 05 Feb 2007 15:44:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7EB6620FB65; Mon,  5 Feb 2007 15:44:30 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38786>

Don't offer resolve as a possible subcommand completion.  If you
read the top of the script, there is a big warning about how it
will go away soon in the near future.  People should not be using it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dcf5e4b..7e61780 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -297,6 +297,7 @@ __git_commands ()
 		reflog)           : plumbing;;
 		repo-config)      : plumbing;;
 		rerere)           : plumbing;;
+		resolve)          : dead dont use;;
 		rev-list)         : plumbing;;
 		rev-parse)        : plumbing;;
 		runstatus)        : plumbing;;
-- 
1.5.0.rc3.58.g79812
