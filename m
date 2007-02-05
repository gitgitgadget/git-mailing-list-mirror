From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/6] bash: Support --add completion to git-config.
Date: Mon, 5 Feb 2007 15:44:32 -0500
Message-ID: <20070205204432.GE8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhl-0007ZE-OV
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933453AbXBEUoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933447AbXBEUoh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36112 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933451AbXBEUof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhN-0008IO-N6; Mon, 05 Feb 2007 15:44:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7276A20FBAE; Mon,  5 Feb 2007 15:44:32 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38784>

We've recently added --add as an argument to git-config, but I
missed putting it into the earlier round of git-config updates
within the bash completion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7e61780..c410678 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -719,7 +719,7 @@ _git_config ()
 		__gitcomp "
 			--global --list --replace-all
 			--get --get-all --get-regexp
-			--unset --unset-all
+			--add --unset --unset-all
 			"
 		return
 		;;
-- 
1.5.0.rc3.58.g79812
