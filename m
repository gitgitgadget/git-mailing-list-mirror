From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-unpack-objects < pack file in repository doesn't work!
Date: Mon, 6 Mar 2006 23:02:55 -0500
Message-ID: <20060307040255.GA29544@spearce.org>
References: <200603070213.02805.blaisorblade@yahoo.it> <20060307022926.GB29180@spearce.org> <7vlkvn54sv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 05:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGTPb-0005sX-Fs
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 05:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWCGEC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 23:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCGEC7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 23:02:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:2747 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752059AbWCGEC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 23:02:58 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FGTPJ-0003zG-Mk; Mon, 06 Mar 2006 23:02:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 72E9420FBAC; Mon,  6 Mar 2006 23:02:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkvn54sv.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17319>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I totally didn't expect that behavior.  But I should have.  It makes
> > perfect sense.
> 
> Good to hear that you two did not lose any data.  I think the
> command should be documented as "not for interactive use without
> understanding what it does" ;-).
> 
> What was the reason you wanted to use it?  I think we should
> have a wrapper command to do what you wanted to achieve, so that
> people do not have to run unpack-objects by hand.

Don't bother.

I wanted to explode a pack because I'm starting work on an Eclipse
plugin for GIT.  I thought I'd try going down the road of letting
the plugin read the repository directly, and write loose objects
directly, but leave pack construction to the native C code.  So I
tried to clone my local GIT repository to a new directory (thus
had no loose objects at all) and unpack it to get loose objects.
That didn't go so well.  :-)

So now I'm currently just playing around with a tiny repository I
created for testing (something like 50 objects total).  Since I have
never packed it everything is loose, and that's working out OK...

I've already got loose object reading working, but thanks to
the trivially simple repository format in GIT (thanks Linus,
et.al.!) that amounted to a trivial Java implementation so its
nothing to really brag about yet.  :-)

-- 
Shawn.
