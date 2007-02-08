From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 16:22:59 -0500
Message-ID: <20070208212259.GA1091@spearce.org>
References: <45C9E470.7030609@xs4all.nl> <45C9EB54.3040406@xs4all.nl> <45CADAAA.74058D21@eudaptics.com> <200702082215.50389.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.63.0702082216000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:23:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGjf-0005Qi-Ki
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423410AbXBHVXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423411AbXBHVXQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:23:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34825 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423410AbXBHVXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:23:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFGjF-0003ce-K3; Thu, 08 Feb 2007 16:22:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BDE3620FBAE; Thu,  8 Feb 2007 16:22:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702082216000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39095>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Frankly, I'd rather stay away from such hackeries. For now, we can ship 
> bash, perl and Tcl/Tk with Git, as well as git-gui, can't we? After all, 
> Windows users are used to bloatware. Then, we just hide the command line 
> from them!

I agree.

I'm happy to make changes in git-gui to help users who are trying
to use Git without Cygwin, and are on Windows.  Patches would be
even more welcome of course.  ;-)

Most of git-gui tries to stay away from shell scripts, partly for
this reason, and partly because its Porcelain and shouldn't depend
on the stock Porcelain-ish that comes with Git.  Oh, and shell
scripts on Cygwin aren't speed-demons.  :-)

-- 
Shawn.
