From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 03:04:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <alpine.LFD.2.00.0910141926170.20122@xanadu.home> <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net> <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 03:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MybDV-0006XN-FK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 03:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbZJPBCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758789AbZJPBCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 21:02:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:57676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751906AbZJPBCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 21:02:15 -0400
Received: (qmail invoked by alias); 16 Oct 2009 01:01:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 16 Oct 2009 03:01:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zXFY9MrizKJjm4u4VcpSrUKnh9e/e71nGvti8uU
	eYVIUIIpgxmU4v
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130445>

Hi,

On Wed, 14 Oct 2009, Nicolas Pitre wrote:

> On Wed, 14 Oct 2009, Jeff King wrote:
> 
> > On Wed, Oct 14, 2009 at 05:56:52PM -0700, Junio C Hamano wrote:
> > 
> > > Nicolas Pitre <nico@fluxnic.net> writes:
> > > 
> > > > Can't the user confusion be dealt with through some means other than 
> > > > making the tool less flexible?  I don't mind extra help message to be 
> > > > displayed after a headless commit is made for example.  But trying to 
> > > > make the tool more friendly should perhaps come from better education 
> > > > rather than added restrictions.
> > > >
> > > > My thoughts only.
> > > 
> > > I actually share that but there apparently are people who have given up on
> > > the education route.
> > 
> > I am personally undecided on this issue (my "this is the best option"
> > was the best of "a -f switch to commit, an 'expert' config option', or a
> > session-based option to commit").
> > 
> > But we really seem to have reached an impasse with how to proceed with
> > git ui.
> > 
> > People like Dscho are fed up with user complaints about parts of git
> > that can be unfriendly to new users. And I can understand that.
> 
> People like Dscho have to grow a thicker skin then.  There will _always_ 
> be user complaints regardless of how balanced you try to make a UI.

You are seriously misreading my intentions, then.  Or my intelligence.

It is not about growing a thicker skin towards unmerited complaints.

It is about shedding the thick skin when there are merited complaints, and 
some people are just too used to the old ways to understand that some of 
the complaints have _a lot_ of merit.

It is just like with the olden days when only a precious few could drive 
cars, and maintained that it _is_ hard to drive a car, and _not_ everybody 
can do it _because_ you will have a breakdown with the car and you _have_ 
to be able to fix it yourself.

Fast-forward a hundred years.

None of this is true any longer.

None.

Guess what?  In these days, we do not need a hundred years.  Four is 
plenty enough.  We have a lot of Git users who do not understand the inner 
workings of Git.  And why should they need to?

Who are you to say they should?

We, the old Gits need to change.  Not the many other people.

Remember: you do not know how exactly the clutch interacts with the 2nd 
cylinder of the engine.  And you do not _need_ to.

Neither should Git users need to.

Ciao,
Dscho
