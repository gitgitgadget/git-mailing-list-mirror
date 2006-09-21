From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 13:09:22 -0400
Message-ID: <20060921170922.GA4375@spearce.org>
References: <20060921162401.GD3934@spearce.org> <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 19:15:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQS3K-0007X1-Ha
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIURJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWIURJb
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:09:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22954 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751361AbWIURJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 13:09:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQS34-0001aJ-SN; Thu, 21 Sep 2006 13:09:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 963E920FB16; Thu, 21 Sep 2006 13:09:22 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27495>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 21 Sep 2006, Shawn Pearce wrote:
> >   Current            Shoulda Been
> >   ---------------    ----------------
> >   git-push           git-push
> >   git-fetch          git-pull
> >   git-pull . foo     git-merge foo
> >   git-pull           git-pull --merge
> >   git-merge          git-merge-driver
> > 
> > in other words pull does the download and doesn't automatically
> > start a merge unless --merge was also given and git-merge is a
> > cleaner wrapper around the Grand Unified Merge Driver that makes
> > it easier to start a merge.
> 
> I must say that I second this.  Although I'm rather familiar with GIT I 
> still feel unconfortable with the current naming and behavior.

The only way I've been able to resolve it internally is to say:

    ``I can pull the changes contained in branch foo into
	  my current working branch by `git pull . foo`.  I'm
	  not merging changes, I'm pulling them.``

Uh, yea....

As a prior user of a popular VCS which was also used by some folks
on LKML and which also had a 'pull=fetch+merge' command I fully
understand why its pull in Git - but I don't like it.

-- 
Shawn.
