From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Tue, 18 Dec 2007 07:48:08 -0500
Message-ID: <20071218124808.GA3728@sigill.intra.peff.net>
References: <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home> <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712172212110.8467@xanadu.home> <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com> <7vlk7s38aq.fsf@gitster.siamese.dyndns.org> <20071218111136.GA6266@coredump.intra.peff.net> <Pine.LNX.4.64.0712181204500.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bsB-0001A0-B5
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbXLRMsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXLRMsM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:48:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3652 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbXLRMsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:48:11 -0500
Received: (qmail 19311 invoked by uid 111); 18 Dec 2007 12:48:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 18 Dec 2007 07:48:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2007 07:48:08 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712181204500.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68742>

On Tue, Dec 18, 2007 at 12:06:23PM +0000, Johannes Schindelin wrote:

> >   - option parsing tweaks (hopefully these should be minor, but it is
> >     clear that we cannot be 100% consistent while retaining the
> >     identical previous behavior)
> 
> IMHO this does not warrant a version bump.  It should be mostly 
> behind-the-scenes, after all.

Yes, it should be, but I think there will be a few user-visible fallouts
(like "--abbrev $foo" in scripts should now be "--abbrev-default $foo"
for safety).

-Peff
