From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 02:53:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910160245310.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <alpine.LFD.2.00.0910141926170.20122@xanadu.home> <7viqeha2zv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 02:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myb5c-0003dQ-Av
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 02:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbZJPAvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762705AbZJPAvu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 20:51:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:57826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758874AbZJPAvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 20:51:49 -0400
Received: (qmail invoked by alias); 16 Oct 2009 00:51:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 16 Oct 2009 02:51:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6cQprTQK6dfaFo2sKStvi3yErODbvyBiLBdcnv8
	OC4t9mjq52SWKI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqeha2zv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130444>

Hi,

On Wed, 14 Oct 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Can't the user confusion be dealt with through some means other than 
> > making the tool less flexible?  I don't mind extra help message to be 
> > displayed after a headless commit is made for example.  But trying to 
> > make the tool more friendly should perhaps come from better education 
> > rather than added restrictions.
> >
> > My thoughts only.
> 
> I actually share that but there apparently are people who have given up on
> the education route.

At some point, when you try to teach something that people (i.e. more than 
one person) do not get easily, you cannot do anything but admit that what 
you try to teach is crap.  Obviously you did not have that experience.  
Maybe you are just more picky than me when it comes to who you try to 
teach.  But of course, that does not make what you try to teach less crap.

In this particular case, I cannot help but notice that commits performed 
on a detached HEAD will get lost _unless_ they are somehow put onto a 
named branch eventually.  So the only question is whether you restrict 
flexibility by requiring to name the branch first before committing, 
instead of committing and then naming the branch.

So you are talking about "retaining flexibility" in favor of making the 
tool less user-friendly, when all it would take from the few power-users 
is to name the branch before committing to it, instead of the other way 
round.

You must be kidding me.

Ciao,
Dscho
