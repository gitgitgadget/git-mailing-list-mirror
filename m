From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question about "git commit -a"
Date: Thu, 4 Oct 2007 17:26:54 -0400
Message-ID: <20071004212654.GL2137@spearce.org>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdYDs-0007TM-RJ
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbXJDV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757404AbXJDV1A
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:27:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57895 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976AbXJDV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:27:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IdYDY-0007YS-01; Thu, 04 Oct 2007 17:26:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 01AA020FBAE; Thu,  4 Oct 2007 17:26:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710042209410.4174@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60011>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 5 Oct 2007, Nguyen Thai Ngoc Duy wrote:
> 
> > On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
> > > > Am I wrong?
> > >
> > > About it being a majority, yes, I suspect so.
> > >
> > 
> > Maybe in the next survey we should include question "do you usually do 
> > 'git commit' or 'git commit -a'" :-)
> 
> Not meaning to discourage you, but it is a known fact that Linus does "git 
> commit" without "-a" quite often.
> 
> And if that were not bad enough for your plan, I myself omit "-a" 
> regularly.  So you would get a veto from me, too.

Ditto.  I use `git commit` more often than `git commit -a`.

Actually scratch that, I use `git gui` more often than I use `git
commit -a` but the point holds.  I stage things long before I ever
think about what the commit message should say.  Its very rare that
I am committing without staging something first, usually its a one
liner fix for something and the -a just is the shorter way to stage
the change.

Early on in my Git days I didn't grasp how *useful* it is to stage
first.  Now I can't work without it.  At least for any change more
than 1 line.  :)

-- 
Shawn.
