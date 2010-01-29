From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:43:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb0V9-0005OR-SR
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab0A2Xnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178Ab0A2Xnn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:43:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36588 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0A2Xnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:43:42 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX1000B08KT3FC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 18:43:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138402>

On Fri, 29 Jan 2010, Junio C Hamano wrote:

> Any comment on my previous rewording patch ($gmane/138369)?

A bit too verbose (even if it can be configured out) and frightening I'd 
say.

> "Note: '%s' isn't a local branch head: creating a detached HEAD\n"
> "If you want to create a new branch from this checkout, you may do so\n"
> "(now or later) by using -b with the checkout command again. Example:\n"
> "  git checkout -b <new_branch_name>\n", new->name);
> 
> A major difference I think is that I avoided a jargon (detached HEAD), and
> chose not to say why the input was interpreted as a request to switch to
> that state.

To the contrary, I think it is about time we use proper Git jargon.  
Otherwise how can we expect people to relate to the documentation where 
that jargon is indeed used?  Even on this very mailing list we refer to 
that state as a "detached HEAD".  And Google gives precisely the right 
info with "detached HEAD" while any other verbiage might not.

And just saying that "you're not on any branch anymore" is still leaving 
the user wondering why.  At least with the "isn't a local branch head" 
the user has 2 clues: it has to be a _local_ branch and a branch _head_ 
not to create a detached HEAD.  So I still prefer the above rewording.

> Oh, of course, I also added advice.detachedHEAD to squelch it ;-)

That is indeed an excellent idea.


Nicolas
