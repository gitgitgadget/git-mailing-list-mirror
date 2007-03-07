From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support of "make -s" in git-gui: do not output anything of the build itself
Date: Tue, 6 Mar 2007 19:14:10 -0500
Message-ID: <20070307001410.GA26050@spearce.org>
References: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjnS-0001Ru-Sn
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbXCGAOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbXCGAOU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:14:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46895 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030765AbXCGAOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:14:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOjnC-0005eC-Bb; Tue, 06 Mar 2007 19:14:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DBC720FBAE; Tue,  6 Mar 2007 19:14:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41626>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> git-gui/Makefile |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

Thanks.  It is applied to my git-gui tree.

BTW, Junio, I have taken your lead and defined a `maint` and a
`master` branch.  The `maint` branch of git-gui is meant to
corresponding in stability level to that of the `maint` branch
of git.git, meaning the one should always be suitable for direct
merging to the other.

If it is alright with Alex, I'd like to hold off on merging git-gui
into git.git right now.  We just got gitgui-0.6.3 merged, and I'd
like to see at least one version of git ship with a stable tag from
git-gui, rather than an arbitrary commit.  ;-)

-- 
Shawn.
