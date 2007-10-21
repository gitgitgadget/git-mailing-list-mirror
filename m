From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option.
Date: Sat, 20 Oct 2007 23:29:53 -0400
Message-ID: <20071021032953.GC14735@spearce.org>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org> <20071021032427.GB8545@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRVz-0001Eg-QW
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXJUD37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbXJUD37
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:29:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58448 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXJUD36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:29:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjRVX-0007i7-55; Sat, 20 Oct 2007 23:29:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEEA020FBAE; Sat, 20 Oct 2007 23:29:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071021032427.GB8545@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61874>

Jeff King <peff@peff.net> wrote:
> On Sat, Oct 20, 2007 at 10:06:53PM -0400, Shawn O. Pearce wrote:
> 
> > I actually had to do `git config alias.upsh push` just to keep
> > myself from screaming every time I made a small typo and Git gave
> > me a screenful of "helpful reminders".
> 
> Yeah, somebody should really work on bash completion...

  $ git pu<TAB><TAB>
  pull     push

By the time I type out "pus" and hit tab I've already typed out
the name "push ".  Except I frequently find myself getting the
u before the p, which can't complete.  Of course with the above
alias in place "git u<TAB>" completes out uniquely to "git push "
(between bash completion and the alias expansion).

But that alias isn't there for my bash tab completion.  Its there
exactly because otherwise "git upsh" gives me 31 lines of useless
(to me) output without it.

-- 
Shawn.
