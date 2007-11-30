From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:17:48 -0500
Message-ID: <20071130011748.GC11683@coredump.intra.peff.net>
References: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuWB-0005C0-4t
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763415AbXK3BRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757173AbXK3BRv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:17:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762686AbXK3BRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:17:50 -0500
Received: (qmail 30923 invoked by uid 111); 30 Nov 2007 01:17:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 20:17:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 20:17:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66593>

On Thu, Nov 29, 2007 at 08:13:04PM -0500, Nicolas Pitre wrote:

> > My point is that (2) is already implemented for every program (shell or
> > no) which understands filename completion, and there is a proposal for
> > taking it away. I would consider that, except I haven't see any claimed
> > advantages except that the hardlinks are awful under Windows.
> 
> Weren't enough complaints about Git having waaaaaaaaaaay too many 
> commands?  Didn't those complaints come about often enough already?
> 
> 	$ git-[tab]
> 	Display all 135 possibilities? (y or n)

Go back and read the thread to which you are responding. I am _not_
arguing against moving those commands to $(libexecdir) where no sane
user will ever see them. That change addresses the issue you are talking
about.

I _am_ arguing against removing them entirely, for those of us who want
to go to the trouble of enabling this (by putting a non-standard entry
into our PATH). Because the issue you are talking about will already
have been dealt with, it is no longer a compelling reason to remove the
hardlinks entirely.

The only reason I have heard to remove them entirely is that Windows
doesn't properly support hardlinks, which I addressed in my other mails
(and to which I have seen no rebuttal).

-Peff
