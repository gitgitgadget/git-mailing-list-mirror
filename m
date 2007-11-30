From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 23:10:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711302306580.27959@racer.site>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net>
 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
 <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se>
 <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
 <20071130212500.GB25946@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 00:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyF0h-0001Yn-Iz
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 00:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbXK3XKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 18:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808AbXK3XKo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 18:10:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755569AbXK3XKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 18:10:43 -0500
Received: (qmail invoked by alias); 30 Nov 2007 23:10:42 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp008) with SMTP; 01 Dec 2007 00:10:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dDv9eeaidst6lVRZ0GrvOM1/6ELsUclMWFO3rlL
	gcBmXIVw9nz7R5
X-X-Sender: gene099@racer.site
In-Reply-To: <20071130212500.GB25946@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66666>

Hi,

On Fri, 30 Nov 2007, Jeff King wrote:

> On Fri, Nov 30, 2007 at 12:01:13PM -0800, Junio C Hamano wrote:
> 
> > I already can see exchanges in the user community after such a change
> > you propose would happen:
> > [...]
> >  Jeff: If you really like that, here is a hidden trick.  Add
> >        /usr/libexec/git-core/ to your PATH.
> 
> What if I promise not to tell anyone? :)

By the same reasoning you can invade an unsuspecting country, saying that 
everybody will be better off afterwards.  But the risk is high, not 
because of the probability, but because of the cost to pay if it does not 
work out.

Really, I'd rather have this be done right.  So I am quite happy with 
Junio being "girly" (which I would have called cautious and nice-to-users, 
as well as considerate, though).

In the end I would be so much happier not to have hard links at all, 
and it seems that all the "easy" SCMs out there are quite well off without 
hard links, too.

To me, it is mighty annoying anybody brings up that "144 commands" 
argument Linus was referring to, and if there is _any_ way to shut up 
those bikeshedders, I am all for it.

But if that is not possible, so be it.

Ciao,
Dscho
