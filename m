From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:50:56 -0400
Message-ID: <20060928195056.GA3751@spearce.org>
References: <Pine.LNX.4.63.0609281941570.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060928194316.42986.qmail@web51004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1ud-0000pW-CF
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWI1TvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWI1TvM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:51:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2798 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161055AbWI1TvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:51:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GT1uF-0001Cw-3K; Thu, 28 Sep 2006 15:50:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87C7E20FB28; Thu, 28 Sep 2006 15:50:56 -0400 (EDT)
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928194316.42986.qmail@web51004.mail.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28043>

Matthew L Foster <mfoster167@yahoo.com> wrote:
> --- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Thu, 28 Sep 2006, Matthew L Foster wrote:
> > 
> > > It should be possible to export git data, through say a web interface, 
> > > in a such a way that local time order is consistent with commit order.
> > 
> > Why?
> 
> - So exported data is never/rarely in an inconsistent state with respect to commit order and local
> time order (data integrity).

Pick one.  You can't have "never" and "rarely".
 
> - To encourage people to care about/prefer local commit time rather than remote creation/emailed
> time

Why?  In general I don't care about time in Git.  Maybe I care about
when I authored something if my wife wants to know why I was up until
6 am the night before ("Look honey, I was coding until 6:00 am! See
the commit!") but otherwise I don't find time to be that interesting.

Then again I don't find time in the real world that intersting
either.  I'm either where I'm supposed to be or I'm not and I'll
get there when I get there.

> - So people that user repo X, or binaries from repo X, know when bug fix Y/fancy new feature Z was
> committed/merged locally

Track it by version, not timestamp.  Know what commit or tag SHA1
was used to produce that binary.  Ask GIT if the fix is in that
SHA1 ancestory or not.  I've already said that on this thread.
 
> - In many situations "history" is incomplete without local commit time. If a company has a new
> driver they would probably prefer to know when the main kernel repo has it, not when they
> created/emailed it or when a remote repo committed it.

I think they care more about what release of the kernel will have
that driver.  That can easily be determined by the DAG and by
understanding what branch(es) will wind up in the next release and
doing simple math: "Lets see, current release is version 2.6.9000,
so it will be in 2.6.9001."

-- 
Shawn.
