From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Mon, 29 May 2006 05:14:23 -0400
Message-ID: <20060529091423.GD29500@spearce.org>
References: <20060529085738.GB29500@spearce.org> <20060529090045.GW13513@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 11:14:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkdpY-0005Zd-Mj
	for gcvg-git@gmane.org; Mon, 29 May 2006 11:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWE2JOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE2JOa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 05:14:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60315 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750790AbWE2JO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 05:14:29 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkdpQ-0000VX-7B; Mon, 29 May 2006 05:14:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 77C6F20E445; Mon, 29 May 2006 05:14:24 -0400 (EDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060529090045.GW13513@lug-owl.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20939>

Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Mon, 2006-05-29 04:57:39 -0400, Shawn Pearce <spearce@spearce.org> wrote:
> > When using -m on the command line with git-commit it is not uncommon
> > for a long commit message to be entered without line terminators.
> > This creates commit objects whose messages are not readable in
> > 'git log' as the line runs off the screen.
> 
> Uh? Just put it in quotes and press the Enter key when applicable.

I realize that.  But I feel that it looks rather ugly on the command
line, in the resulting message, and is difficult to do well all of
the time.

For one thing the first line is offset due to the stuff preeceding
it on the command line, even if you put the -m" on the next line.
For another it goes nicely with my prior patch of allowing multiple
-m flags on the command line and merging them into a single commit
message by treating each option argument as its own paragraph.

Maybe its just me but I've generally found `fmt` does a nice job
of line wrapping my text.  I'm writing this email out in vi with
no thought to line wrapping and will let `fmt` clean it all up for
me before I sent it.  I do the same thing with all of my commit
messages; except git-commit won't let me do it from the command line.

This patch was trying to do that...  but I suspected some folks
would not like the idea very much.  :-)

-- 
Shawn.
