From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 15:22:37 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910151517070.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151054190.32515@iabervon.org>
 <alpine.LFD.2.00.0910151504510.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyW23-0007WW-PE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 21:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935296AbZJOTXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935288AbZJOTXP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 15:23:15 -0400
Received: from iabervon.org ([66.92.72.58]:59543 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935287AbZJOTXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 15:23:14 -0400
Received: (qmail 22548 invoked by uid 1000); 15 Oct 2009 19:22:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2009 19:22:37 -0000
In-Reply-To: <alpine.LFD.2.00.0910151504510.20122@xanadu.home>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130414>

On Thu, 15 Oct 2009, Nicolas Pitre wrote:

> On Thu, 15 Oct 2009, Daniel Barkalow wrote:
> 
> > I think the description used in CVS and SVN (and, I think, others) is that 
> > you're not at the HEAD revision. I think they both account for the state 
> > where you've checked out the revision by number that's the latest 
> > revision, but you still can't grow the branch because you can't 
> > simultaneously stay on r1000 (as requested explicitly) and add a new 
> > commit.
> > 
> > So maybe the right explanation is:
> > 
> > $ git checkout master; git branch
> > * master
> > $ git checkout origin/master; git branch
> > * origin/master (not at head)
> > $ git checkout 123cafe^5; git branch
> > * 123cafe^5 (not at head)
> 
> I think this is wrong.  Git has multiple heads, and insisting on "not at 
> head" would be extremely confusing.

Maybe "(not at a head)"? Git does have multiple heads, but what's checked 
out isn't one of them, and that's actually the point.

	-Daniel
*This .sig left intentionally blank*
