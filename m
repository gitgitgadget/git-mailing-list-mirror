From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 22:45:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910152211590.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
 <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0910152118360.20122@xanadu.home>
 <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 05:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myd5n-0000gz-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 05:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZJPCqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 22:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZJPCqY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 22:46:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39917 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZJPCqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 22:46:23 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRL00DEN6C38GF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 22:45:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130449>

On Fri, 16 Oct 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 15 Oct 2009, Nicolas Pitre wrote:
> 
> > On Fri, 16 Oct 2009, Johannes Schindelin wrote:
> > 
> > > We, the old Gits need to change.  Not the many other people.
> > > 
> > > Remember: you do not know how exactly the clutch interacts with the 2nd 
> > > cylinder of the engine.  And you do not _need_ to.
> > 
> > Really, the detached HEAD concept can't be _that_ hard.
> 
> You are trying to educate the users to use the double-clutch.  Rather than 
> making the double-clutch obsolete.
> That's what I call "BlameTheWrongThing".

I just can't convince myself to share that point of view.  Doesn't mean 
that I'm right though, but that's how I see it given the alternative.

> > > Neither should Git users need to.
> > 
> > What you're asking for, though, is more comparable to asking old Gits to 
> > give up on their clutch and manual gearbox because most American Git 
> > users are expecting automatic transmissions.  Maybe that's not the case 
> > in Germany, but over here automatic transmissions are by far the norm 
> > and a manual gearbox can be obtained only in limited cases if at all.
> 
> Your point being?  You really think Git is already at the stage where it 
> has automatic transmission and all you have to do is hit the gas or the 
> brake?  No, Nico, you are too intelligent to believe that.

No, Git is not at the automatic transmission level, and I _don't_ want 
it to, ever.  That would not be _my_ choice.

> Besides, Git is not even at the stage of a manual gearbox.

Here I disagree.

> Just recently, I had a user request (a very valid one, mind you) where the 
> user does not want to provide a commit message, and wants to just commit 
> all the current changes.  In that particular case, it is very sensible to 
> ask for these things.  It is something utterly simple to ask for. Yet, it 
> is utterly hard with Git, especially if I have to explain it.

I hope this is a bad example.  I just can't imagine how "very sensible" 
you may consider messageless commits.  I've dealt with them too many 
times in my life.

But still, if someone just can't be bothered at all then the 
"workaround" is easy: just use '-m.' or any other meaningless character 
of your choice.  At least _I_ will be able to identify those commits as 
being purposely messageless and make a better informed opinion on that 
committer instead of blaming it on ignorance.

> Maybe the core Git developers should spend a month explaining the core 
> principles of Git to some random software developers, just so all of us 
> get an idea just how wrong we are on the account of how intuitive Git is.

Sorry but I don't share that feeling of hopelessness that seems to 
affect those random software developers you might have tried to teach 
Git to.  Well, actually I do have to deal with hopeless software 
developers once in a while which are simply total idiots, and they 
certainly shine at depicting Git, or any other tool at their disposal 
for that matter, as utter crap.  But fortunately for me, the few people 
to whom I've explained Git so far simply got it in very little time.  
In my opinion, the most important concept to explain first is Git 
branching.  Everything else is kinda secondary.  Worked for me pretty 
well so far.


Nicolas
