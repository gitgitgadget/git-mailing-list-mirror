From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 16:37:07 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910141625170.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAeP-0000Qt-89
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbZJNUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757227AbZJNUhp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:37:45 -0400
Received: from iabervon.org ([66.92.72.58]:52426 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139AbZJNUho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:37:44 -0400
Received: (qmail 8410 invoked by uid 1000); 14 Oct 2009 20:37:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2009 20:37:07 -0000
In-Reply-To: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130335>

On Wed, 14 Oct 2009, Nicolas Pitre wrote:

> On Wed, 14 Oct 2009, Daniel Barkalow wrote:
> 
> > On Wed, 14 Oct 2009, Jay Soffian wrote:
> > 
> > > $ git commit -m "blah"
> > > Cannot commit while not on any branch. Please use git commit -b <branch> to
> > > specify the name of a new branch to commit to, or use git commit -f to
> > > force a detached commit.
> > 
> > The difference is that some experienced users depend on being able to 
> > commit while not on a branch, and want to not get a warning for every 
> > commit while not on a branch.
> 
> I assume that the -f would silence any warning?

I suppose; I don't know if that would be acceptable to the relevant users. 
It would certainly require script changes, but that's not an issue for 
1.7.0, presumably.

I personally normally use the order:

$ git checkout origin/master
(change stuff, test)
$ git checkout -b my-topic
$ git commit

So I only care about detaching, not committing while detached, and I'm not 
the right person to ask.

	-Daniel
*This .sig left intentionally blank*
