From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui i18n status?
Date: Sat, 1 Sep 2007 00:29:24 -0400
Message-ID: <20070901042924.GE18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 06:30:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRKcR-0007e9-AP
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 06:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXIAE33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 00:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbXIAE33
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 00:29:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60175 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbXIAE33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 00:29:29 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRKbt-000781-KW; Sat, 01 Sep 2007 00:29:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A41D20FBAE; Sat,  1 Sep 2007 00:29:24 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57250>

Now that git-gui 0.8.2 is out and git 1.5.3 is just around the corner
I am starting to think about bringing the git-gui i18n work into the
main git-gui tree, so we can start working from a common codebase.

Looking at the repository on repo.or.cz it looks like it needs to
be merged/rebased onto 0.8.2.  There is a trivial merge conflict,
but there are some more subtle ones caused by the movement of
the library directory initialization down lower in git-gui.sh.
For example translations won't be initialized if we have an issue
with the output of git-version and want to prompt the user.

What is the current plan?  Should I be looking at the master branch
of git://repo.or.cz/git-gui/git-gui-i18n.git for pulling?  Or are
folks expecting that this series will be cleaned up before I pull it?

-- 
Shawn.
