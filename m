From: Francis Galiegue <fg@one2team.net>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 02:28:20 +0100
Organization: One2team
Message-ID: <200811060228.21124.fg@one2team.net>
References: <200811060014.57046.fg@one2team.net> <200811060034.48053.fg@one2team.net> <20081105234425.GA2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 02:31:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxtib-0008SR-2Q
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 02:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYKFBaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 20:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYKFBaO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 20:30:14 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:42076 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbYKFBaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 20:30:14 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-121-89.w90-20.abo.wanadoo.fr [90.20.196.89])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id AABDB92C011;
	Thu,  6 Nov 2008 02:29:58 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081105234425.GA2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100207>

[...]
 
> > > > * "git stash": is it supported?
> > >
> > > Not in Eclipse, no.
> >
> > What do you mean by this?
>
> I mean there's no implementation of git stash.  Eclipse doesn't
> support git stash, the notion of the stash, the branch the stash
> is on.  Its not in the Eclipse plugin.
>

While I'm a total newbie to Eclipse, and not that fluent with Java, this looks 
surprising. Is it really Eclipse that is at fault here? Eclipse saves its 
workspace (whatever it means to "save a workspace") when it exits, isn't 
there an interface that you can implement that does "partial" saves, hence 
git stashes?

> > > > * can you "copy" a commit, or even a set of commits, and
> > > > "cherry-pick" them into another branch? Or even rebase a branch onto
> > > > antoher?
> > >
> > > Not in Eclipse, no.
> >
> > Same question... What exactly is the problem with Eclipse wrt this kind
> > of operation?
>
> Its also not implemented in the eclipse UI.

Eclipse has the ability to apply patches AFAIK... Even though this may not be 
equivalent to a git cherry-pick, wouldn't there be a way to extract at least 
the diffs and commit messages and apply?

-- 
fge
