From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/6] bash: Hide diff-stages from completion.
Date: Mon, 5 Feb 2007 15:44:24 -0500
Message-ID: <20070205204424.GB8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhk-0007ZE-4m
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445AbXBEUoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933447AbXBEUoa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36097 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbXBEUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhG-0008I2-8B; Mon, 05 Feb 2007 15:44:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02ED620FB65; Mon,  5 Feb 2007 15:44:24 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38782>

Apparently nobody really makes use of git-diff-stages, as nobody
has complained that it is not supported by the git-diff frontend.
Since its likely this will go away in the future, we should not
offer it as a possible subcommand completion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c22ff48..c4d433f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -269,6 +269,7 @@ __git_commands ()
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
 		daemon)           : daemon;;
+		diff-stages)      : nobody uses it;;
 		fsck-objects)     : plumbing;;
 		fetch-pack)       : plumbing;;
 		fmt-merge-msg)    : plumbing;;
-- 
1.5.0.rc3.58.g79812
