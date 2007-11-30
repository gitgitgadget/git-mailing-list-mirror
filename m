From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:53:15 -0500
Message-ID: <20071130015315.GA13369@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <alpine.LFD.0.99999.0711291950590.9605@xanadu.home> <20071130010055.GB12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292013580.9605@xanadu.home> <20071130012536.GA12615@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292029420.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixv4T-0005G2-9A
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933072AbXK3BxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763761AbXK3BxS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:53:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2301 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762344AbXK3BxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:53:17 -0500
Received: (qmail 31164 invoked by uid 111); 30 Nov 2007 01:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 20:53:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 20:53:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711292029420.9605@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66599>

On Thu, Nov 29, 2007 at 08:33:39PM -0500, Nicolas Pitre wrote:

> So what you want is for the dashed hardlinks to exist _inside_ the 
> libexec directory, even if most people won't "see" them due to that 
> libexec directory not being in the shell path, right?
> 
> If that is what you mean then I personally don't care at all.

That is exactly what I mean.

-Peff
