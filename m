From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git auto-repack is broken...
Date: Fri, 09 Dec 2011 13:34:04 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1112091331370.2907@xanadu.home>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
 <7v4nx9hcmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:34:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5Gt-000089-7J
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab1LISeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 13:34:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43942 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1LISeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 13:34:05 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LVY00CMJ8WKNC80@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Dec 2011 13:33:56 -0500 (EST)
In-reply-to: <7v4nx9hcmv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186660>

On Fri, 9 Dec 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Sat, 3 Dec 2011, Brandon Casey wrote:
> >
> >> Linus's scenario of fetching a lot of stuff that never actually makes
> >> it into the reflogs is still a valid problem.  I'm not sure that
> >> people who don't know what they are doing are going to run into this
> >> problem though.  Since he fetches a lot of stuff without ever checking
> >> it out or creating a branch from it, potentially many objects become
> >> unreferenced every time FETCH_HEAD changes.
> >
> > Maybe  FETCH_HEAD should have a reflog too?
> 
> It is a feature that the objects that were fetched for a quick peek become
> immediately unreferenced and eligible for early removal unless they are
> kept somewhere, e.g. remote tracking refs. What problem are we trying to
> solve?

This is indeed a tangential observation to the expiration delay.  I was 
just suggesting that having a reflog for FETCH_HEAD in the case when you 
fetch a branch with an explicit URL might be handy.


Nicolas
