From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Making Git easy to use -- without RTFM, was Re: [PATCH] Proof-of-concept
 patch to remember what the detached HEAD was
Date: Tue, 27 Oct 2009 11:33:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271118470.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <alpine.LFD.2.00.0910141926170.20122@xanadu.home> <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net> <alpine.LFD.2.00.0910142237010.20122@xanadu.home> <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de> <alpine.LFD.2.00.0910152118360.20122@xanadu.home> <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
 <BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl> <alpine.DEB.1.00.0910262317430.4985@pacific.mpi-cbg.de> <20091027124156.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 11:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2jKE-0002L3-MB
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 11:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbZJ0Kak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZJ0Kak
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 06:30:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752251AbZJ0Kaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 06:30:39 -0400
Received: (qmail invoked by alias); 27 Oct 2009 10:30:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 27 Oct 2009 11:30:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ooxJpDjjoH+7iqonZrgADyTkgkhEcCP2HoUr9e6
	Z1rNq3/0zWuoRP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091027124156.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131324>

Hi,

[culling the Cc: list, as this subthread is probably irrelevant most of 
the previous members]

On Tue, 27 Oct 2009, Nanako Shiraishi wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> [actually not, Nanako quoted Junio here, I guess]
>
> > I suspect the above is another example of your needing to do a better 
> > job explaining yourself here, but from "just commit all the changes 
> > without saying message", my knee-jerk reaction is "git commit -a -m 
> > 'no message'".
> 
> > You would need to justify why -m 'no message' does not fit the bill 
> > better than just saying "is very sensible to ask for these things", as 
> > I highly suspect that I misunderstood what "these things" are in your 
> > five lines to come up with that "solution" that you are now going to 
> > explain why that is not what the end user wanted.  And in this case, I 
> > do not think it is that me being disconnected from the real world, but 
> > that your explanation is insufficient.
> 
> I'm also curious about the situation when a commit with no message is 
> useful, but unfortunately I don't think I saw you explained clearly 
> enough what this user request wanted to achieve or what "these things" 
> in your message were for us to understand why it is a sensible and valid 
> thing to ask.

I am sure that your creative mind does not need my concrete example to 
come up with a situation where an empty commit message is useful.

Anyhow, here it is: one of my users refused to touch SCMs _at all_, for 
decades.  There was only one choice: have a Git branch with a purely 
linear history that contains the copy of the working tree at the end of 
the day, with whatever changes accumulated over the day, or no history at 
all.

Sure, some people will now argue that it should be easy to educate that 
user to use Git properly.  But that is as naive as it would be to try to 
educate those people so they know how unrealistic educating users is.  
Not because users are not intelligent -- they are -- but because they want 
to spend their time in a more efficient manner than to learn how to 
operate a version control system.

You know, when there is a hurdle half of the people you see cannot get 
over, there are some who make the hurdle half as high, and there are 
others who put more hurdles there and call it a sport.

In this case, I would have preferred to make the hurdle half as high, but 
I think I just have to wait a couple of years; reality will take care of 
things.

Ciao,
Dscho
