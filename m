From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:00:55 -0500
Message-ID: <20071130010055.GB12224@coredump.intra.peff.net>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <alpine.LFD.0.99999.0711291950590.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuFs-0000zw-Fk
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934301AbXK3BBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934324AbXK3BA7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:00:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2763 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934314AbXK3BA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:00:57 -0500
Received: (qmail 30723 invoked by uid 111); 30 Nov 2007 01:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 20:00:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 20:00:55 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711291950590.9605@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66588>

On Thu, Nov 29, 2007 at 07:52:01PM -0500, Nicolas Pitre wrote:

> > I am still against this step, for the reasons mentioned in the mails
> > leading up to the one you just quoted. I am fine with "does not install
> > hardlinks for builtin-commands on systems that don't support hardlinks"
> > (and of course all such hardlinks are in $(libexecdir)/git-core at this
> > point).
> 
> But only for porcelain, right?  You certainly don't need the dashed form 
> of plumbing commands?

In principle, yes, though one man's porcelain is another man's plumbing,
so determining the correct set is hard (and why bother if they are all
hidden from mere mortals, anyway?).

Perhaps because I am actively working on git, I tend to use a fair
number of plumbing commands for under-the-hood inspection and
experimentation.

-Peff
