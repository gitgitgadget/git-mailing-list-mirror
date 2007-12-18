From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] provide advance warning of some future pack default
 changes
Date: Tue, 18 Dec 2007 13:30:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181329340.23902@racer.site>
References: <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
 <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
 <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
 <7vlk7s38aq.fsf@gitster.siamese.dyndns.org> <20071218111136.GA6266@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712181204500.23902@racer.site> <20071218124808.GA3728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4cXo-0006yz-Rc
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 14:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXLRNbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 08:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbXLRNbI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 08:31:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:56559 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753164AbXLRNbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 08:31:06 -0500
Received: (qmail invoked by alias); 18 Dec 2007 13:31:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 18 Dec 2007 14:31:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+k1TVQov2kRdBQC07/WPfpT/ian1LPMb8quAbGn2
	DuHcXcGlWO83zh
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218124808.GA3728@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68743>

Hi,

On Tue, 18 Dec 2007, Jeff King wrote:

> On Tue, Dec 18, 2007 at 12:06:23PM +0000, Johannes Schindelin wrote:
> 
> > >   - option parsing tweaks (hopefully these should be minor, but it is
> > >     clear that we cannot be 100% consistent while retaining the
> > >     identical previous behavior)
> > 
> > IMHO this does not warrant a version bump.  It should be mostly 
> > behind-the-scenes, after all.
> 
> Yes, it should be, but I think there will be a few user-visible fallouts
> (like "--abbrev $foo" in scripts should now be "--abbrev-default $foo"
> for safety).

But we are on our way to fix this, no?  IOW this warrants not a version 
bump, but an extended feature freeze/bug fix period (like Junio suggested, 
until January).

Ciao,
Dscho
