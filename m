From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Mon, 26 Oct 2009 23:22:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910262317430.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <alpine.LFD.2.00.0910141926170.20122@xanadu.home> <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net> <alpine.LFD.2.00.0910142237010.20122@xanadu.home> <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de> <alpine.LFD.2.00.0910152118360.20122@xanadu.home> <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
 <BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2XuK-0002hu-73
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbZJZWTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZJZWTH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:19:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:39094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754195AbZJZWTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:19:06 -0400
Received: (qmail invoked by alias); 26 Oct 2009 22:19:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 26 Oct 2009 23:19:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mRGJsoFXm6HHp+dkyCoJaefKNnIamBSwZnsUVb0
	Aw05KW1BCP6gbO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131277>

Hi,

On Sat, 17 Oct 2009, Sean Estabrooks wrote:

> On Fri, 16 Oct 2009 04:07:23 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Just recently, I had a user request (a very valid one, mind you) where 
> > the user does not want to provide a commit message, and wants to just 
> > commit all the current changes.  In that particular case, it is very 
> > sensible to ask for these things.  It is something utterly simple to 
> > ask for. Yet, it is utterly hard with Git, especially if I have to 
> > explain it.
> 
> Hey Johannes,
> 
> It's actually easy, but maybe hard to find:
> 
> 	$ git commit --cleanup=verbatim -m ""

Of course that leaves out the main part.  But it is simple once you 
know it (I did not): git add -A (we even went out of our way _not_ to name 
the long option --addremove, but --all -- it does not seem to be an 
expressive-enough option name to me, but what does my impression 
matter...)

So I retract my claim that it is utterly hard to do with Git (but not the 
rest).

Ciao,
Dscho
