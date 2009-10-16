From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 04:07:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <alpine.LFD.2.00.0910141926170.20122@xanadu.home> <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net> <alpine.LFD.2.00.0910142237010.20122@xanadu.home> <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de> <alpine.LFD.2.00.0910152118360.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 04:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MycF7-0001n1-8S
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 04:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659AbZJPCF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 22:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZJPCF2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 22:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:35101 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752131AbZJPCF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 22:05:27 -0400
Received: (qmail invoked by alias); 16 Oct 2009 02:04:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 16 Oct 2009 04:04:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sJ1Nw962s7zS4oldDrtF42N6d5uZAv6Wn8XSxdE
	3movkRPW9alsVA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0910152118360.20122@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130447>

Hi,

On Thu, 15 Oct 2009, Nicolas Pitre wrote:

> On Fri, 16 Oct 2009, Johannes Schindelin wrote:
> 
> > We, the old Gits need to change.  Not the many other people.
> > 
> > Remember: you do not know how exactly the clutch interacts with the 2nd 
> > cylinder of the engine.  And you do not _need_ to.
> 
> Really, the detached HEAD concept can't be _that_ hard.

You are trying to educate the users to use the double-clutch.  Rather than 
making the double-clutch obsolete.

That's what I call "BlameTheWrongThing".

> > Neither should Git users need to.
> 
> What you're asking for, though, is more comparable to asking old Gits to 
> give up on their clutch and manual gearbox because most American Git 
> users are expecting automatic transmissions.  Maybe that's not the case 
> in Germany, but over here automatic transmissions are by far the norm 
> and a manual gearbox can be obtained only in limited cases if at all.

Your point being?  You really think Git is already at the stage where it 
has automatic transmission and all you have to do is hit the gas or the 
brake?  No, Nico, you are too intelligent to believe that.

Besides, Git is not even at the stage of a manual gearbox.

Just recently, I had a user request (a very valid one, mind you) where the 
user does not want to provide a commit message, and wants to just commit 
all the current changes.  In that particular case, it is very sensible to 
ask for these things.  It is something utterly simple to ask for. Yet, it 
is utterly hard with Git, especially if I have to explain it.

Maybe the core Git developers should spend a month explaining the core 
principles of Git to some random software developers, just so all of us 
get an idea just how wrong we are on the account of how intuitive Git is.

Ciao,
Dscho
