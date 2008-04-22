From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 17:42:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221741570.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local> <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness> <20080422140440.GC3098@mithlond.arda.local> <480DF1E7.5040900@gnu.org> <alpine.DEB.1.00.0804221607190.4460@eeepc-johanness>
 <480E03A9.3040401@gnu.org> <480E1108.5090701@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:43:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLaI-0000b2-It
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbYDVQmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757380AbYDVQmD
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:42:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:43704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756549AbYDVQmA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:42:00 -0400
Received: (qmail invoked by alias); 22 Apr 2008 16:41:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 22 Apr 2008 18:41:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ikztwrWWiW7WIUM+KgoxArJ4ppF1Ix1Cz8H/KRu
	QZK0rWULJ0ImB1
X-X-Sender: user@eeepc-johanness
In-Reply-To: <480E1108.5090701@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80133>

Hi,

On Tue, 22 Apr 2008, Paolo Bonzini wrote:

> > > > What about changing --mirror to add a push line instead of a fetch 
> > > > line?
> > >
> > > I would not expect --mirror to add a push line when "git-remote add" 
> > > without --mirror does not a push line either.
> > 
> > Let me reverse the question.  When does it make sense to use 
> > "git-remote add --mirror" with the current implementation?
> > 
> > It's not a rhetoric question.  I know when it would make sense to have push
> > refspecs on a remote for which you plan to use "git push --mirror" (and in
> > "next", that is the case if you create the remote with "git-remote add
> > --mirror").  But I'm a total newbie for things that do not fit my workflows,
> > so I don't know when it would make sense to pull from that kind of remote.
> 
> And actually, I just realized that what I expected from --mirror is this:
> 
> [remote "mirror"]
>         url = blah
>         fetch = +refs/heads/*:refs/remotes/mirror/*
>         push = +refs/heads/*:refs/heads/*
>         mirror
> 
> ... so that I can check the state of the mirror with "git log -1
> mirror/master", and still the push refspec is there so that my local remotes
> are not entirely mirrored.

AFAICT this contradicts everything in the original thread resulting in the 
--mirror patch.

Ciao,
Dscho
