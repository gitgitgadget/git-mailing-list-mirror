From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Please remerge git-gui.git into git.git
Date: Mon, 11 Jun 2007 19:10:13 -0400
Message-ID: <20070611231013.GM6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 01:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxt1o-0007BC-O0
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbXFKXKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbXFKXKT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:10:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbXFKXKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:10:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hxt1Q-00089g-ST; Mon, 11 Jun 2007 19:10:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A153820FBAE; Mon, 11 Jun 2007 19:10:13 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49898>

Currently the tree between git-gui.git and git.git:git-gui does
not match, due to a6080a0a44d5ead84db3dabbbc80e82df838533d, aka the
"War on whitespace".

I really want the git-gui tree in git.git to always match the tree
of the 2nd parent of the merge commit, as that is how git-gui's
own GIT-VERSION-GEN script finds the git-gui commit DAG and gets
git-describe to produce a git-gui specific version number, rather
than the git.git version number.

Right now that script is barfing and coming up with "0.8.GITGUI",
which isn't a valid version number, and means nothing to everyone.

So new `maint` and `master` branches are in git-gui.git.

Thanks!  ;-)

-- 
Shawn.
