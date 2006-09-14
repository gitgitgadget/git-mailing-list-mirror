From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 11:52:12 -0400
Message-ID: <20060914155212.GC9657@spearce.org>
References: <20060914142249.GK23891@pasky.or.cz> <46900.194.138.39.52.1158244729.squirrel@www.tglx.de> <45097775.4040005@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 17:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtWD-0005os-IG
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 17:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWINPwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 11:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWINPwW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 11:52:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37782 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750896AbWINPwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 11:52:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNtVY-0006FD-Cc; Thu, 14 Sep 2006 11:52:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4E7020FB1F; Thu, 14 Sep 2006 11:52:12 -0400 (EDT)
To: Andy Whitcroft <apw@shadowen.org>
Content-Disposition: inline
In-Reply-To: <45097775.4040005@shadowen.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27006>

Andy Whitcroft <apw@shadowen.org> wrote:
> tglx@linutronix.de wrote:
> > Petr,
> > 
> >>   just to test the packing improvements we had achieved over the last
> >> year, I have repacked the historical kernel repository and achieved a
> >> significant improvement:
> >> ....
> >>   Since it's a nice place for people to check about how efficient we are
> >> with compressing the repository, perhaps it would be a good idea to
> >> repack the historical repository on kernel.org?
> > 
> > I'll do once I'm back home.
> 
> Is there any reason this isn't a live history.  ie that we don't
> constantly pull linus' master branch into this history to make it a real
> complete history?
> 
> Perhaps that isn't possible ... hmmm.  I guess it might only work if
> linus' repo was actually a grafted version of this history?

Right - the only way to join the two is to graft them together.

Since grafts are a purely local matter anyone can pull both into
the same repository and insert the correct grafts to get a complete
history.  You would just want to publish on the kernel.org website
the correct grafts file, so users don't have to figure it out on
their own.

Since I'm not a kernel developer I haven't even looked to see if
such a grafts file has been published.  :-)

-- 
Shawn.
