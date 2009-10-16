From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Fri, 16 Oct 2009 02:43:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910160240440.4985@pacific.mpi-cbg.de>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>  <alpine.LFD.2.00.0910141647390.20122@xanadu.home>  <7vws2xa9lu.fsf@alter.siamese.dyndns.org>  <20091014230934.GC29664@coredump.intra.peff.net>  <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
  <alpine.LFD.2.00.0910151436180.20122@xanadu.home>  <7v1vl45t9k.fsf@alter.siamese.dyndns.org>  <20091015212632.GA13180@coredump.intra.peff.net>  <7v1vl42uid.fsf@alter.siamese.dyndns.org>  <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
 <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 02:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyauU-0008DO-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 02:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZJPAlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755361AbZJPAlW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 20:41:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755244AbZJPAlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 20:41:22 -0400
Received: (qmail invoked by alias); 16 Oct 2009 00:40:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 16 Oct 2009 02:40:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19H5X5DSRZHQTzigGdo6+4hG7QpXkWOdxiJqwSlo9
	WNUzJx/AlcYkDS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130443>

Hi,

On Thu, 15 Oct 2009, James Pickens wrote:

> On Thu, Oct 15, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>     $ git checkout origin/next ;# ditto
> >>     $ git symbolic-ref HEAD
> >>     refs/remotes/origin/next
> >
> > Ok, after reading Daniel's message to remind us that "git fetch" after
> > this will get us into trouble, I agree that detaching HEAD is inevitable.
> 
> Some people liked the idea, so let's not give up just yet.  Here are a few
> things Git could do when a fetch wants to update the currently checked out
> branch:
> 
> 1. Refuse the fetch.
> 2. Update the ref, leaving the user with a work tree and index that don't
>    match their HEAD.
> 3. Detach the HEAD, then update the ref.
> 4. Update the ref, then check it out.

Everything but 1 and 4 would blatantly violate the law of the Least 
Surprise.

And that very much includes what our beloved maintainer proposes.

BTW I appreciate that finally a few users join discussion.  It felt 
awfully lonely for a while.

Ciao,
Dscho
