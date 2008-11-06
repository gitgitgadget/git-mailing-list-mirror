From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 22:18:25 +0100
Message-ID: <200811062218.26428.robin.rosenberg@dewire.com>
References: <200811060014.57046.fg@one2team.net> <20081105234425.GA2932@spearce.org> <200811060228.21124.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 22:19:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyCGa-0001oG-1Y
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 22:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYKFVSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYKFVSb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 16:18:31 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:60644 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbYKFVSb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 16:18:31 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB025972EE; Thu, 6 Nov 2008 22:18:27 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200811060228.21124.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100267>

torsdag 06 november 2008 02:28:20 skrev Francis Galiegue:
> [...]
>  
> > > > > * "git stash": is it supported?
> > > >
> > > > Not in Eclipse, no.
> > >
> > > What do you mean by this?
> >
> > I mean there's no implementation of git stash.  Eclipse doesn't
> > support git stash, the notion of the stash, the branch the stash
> > is on.  Its not in the Eclipse plugin.
> >
> 
> While I'm a total newbie to Eclipse, and not that fluent with Java, this looks 
> surprising. Is it really Eclipse that is at fault here? Eclipse saves its 
> workspace (whatever it means to "save a workspace") when it exits, isn't 
> there an interface that you can implement that does "partial" saves, hence 
> git stashes?

The fault is that it has not been implemented yet, It's not Eclipse's fault. The
plugin simply lacks support for it. You can do that with Git though. I use both
tools side by side.

> > > > > * can you "copy" a commit, or even a set of commits, and
> > > > > "cherry-pick" them into another branch? Or even rebase a branch onto
> > > > > antoher?
> > > >
> > > > Not in Eclipse, no.
> > >
> > > Same question... What exactly is the problem with Eclipse wrt this kind
> > > of operation?
> >
> > Its also not implemented in the eclipse UI.
> 
> Eclipse has the ability to apply patches AFAIK... Even though this may not be 
> equivalent to a git cherry-pick, wouldn't there be a way to extract at least 
> the diffs and commit messages and apply?

Sure. Solving everything that is missing is a matter of actually coding the feature.
Unfortunately we have very little time at our disposal, which is why we welcome
contributions. 

-- robin


-- robin
