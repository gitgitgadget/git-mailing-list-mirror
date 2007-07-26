From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 00:00:03 -0400
Message-ID: <20070726040003.GR32566@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com> <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com> <Pine.LNX.4.64.0707260438210.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 06:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDuWe-0005iB-Ac
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 06:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbXGZEAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 00:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXGZEAJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 00:00:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39305 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXGZEAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 00:00:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDuW0-0008Nu-Ry; Wed, 25 Jul 2007 23:59:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 89E5420FBAE; Thu, 26 Jul 2007 00:00:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707260438210.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53760>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 25 Jul 2007, Dmitry Kakurin wrote:
> 
> > On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > > What features is mingw port missing?
> > Well, 'git commit' from a regular cmd prompt does not work.
> > IMHO, That's a pretty serious omission  :-).
> 
> Not true.

Use git-gui.  ;-)  It doesn't need a shell to make commits.

It currently uses the shell for fetch and for merge.  I'm fixing
merge this week.  I'm hoping Daniel's native C fetch will fix
the fetch.

-- 
Shawn.
