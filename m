From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk screenshots of complex history
Date: Fri, 27 Jul 2007 01:29:34 -0400
Message-ID: <20070727052934.GH20052@spearce.org>
References: <20070727041300.GD20052@spearce.org> <alpine.LFD.0.999.0707262219210.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIOU-0001VG-QZ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbXG0F3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbXG0F3j
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:29:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53252 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbXG0F3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:29:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEIOO-0006dr-D0; Fri, 27 Jul 2007 01:29:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60E7F20FBAE; Fri, 27 Jul 2007 01:29:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707262219210.3442@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53891>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 27 Jul 2007, Shawn O. Pearce wrote:
> > 
> > I just compared my own history to Linus' linux-2.6 history.
> > The kernel team can't hold a candle to this mess.
> 
> Rather on purpose, I might add. I've actually been fairly anal about 
> having people maintain clean histories, to the point where I refuse to 
> pull from trees that don't do a good enough job.

For 4 of our internal repositories I've taken that policy up now
myself, and nobody is allowed to create releases from them except me.
This has helped.  A lot.  So does sensible use of `git rebase -i`.
You and Junio have really sold me on the value of having someone
play a very strict gatekeeper role.  I get better work product from
my coworkers this way too.  They know someone else is looking at
what they are doing and try harder.

But it doesn't help the really old history, nor does it help
the repository these images came from.  I don't own/control that
development.  I just provide git help as much as I can.

-- 
Shawn.
