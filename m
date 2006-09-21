From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 19:12:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609211908580.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060921162401.GD3934@spearce.org> <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 19:21:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQS6K-0008Si-DF
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWIURMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWIURMh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:12:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:56249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751362AbWIURMh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 13:12:37 -0400
Received: (qmail invoked by alias); 21 Sep 2006 17:12:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 21 Sep 2006 19:12:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27496>

Hi,

On Thu, 21 Sep 2006, Nicolas Pitre wrote:

> On Thu, 21 Sep 2006, Shawn Pearce wrote:
> 
> > I think its probably too late to change the UI[*1*] but I think
> > it is definately an issue for folks learning Git.  Calling push
> > push, fetch fetch and fetch+merge pull is probably a design flaw.
> > IMHO it probably should have been something like:
> > 
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

Originally, I wanted to shut up about this issue. But since there are two 
voices against the current naming, I want to speak for it.

When I was introduced to CVS, _I_ found the _CVS_ names misleading. I 
thought that cvs update would throw away my changes.

So let's face it, a single name cannot possibly convey the meaning to that 
many people, and therefore, it is _necessary_ to have a nice short 
introduction, after which users actually know that git-pull is a fetch + 
merge. Once you know it, what can possibly go wrong? ;-)

Ciao,
Dscho
