From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 16:13:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711291613260.27959@racer.site>
References: <200711181225.52288.johannes.sixt@telecom.at>
 <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at>
 <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site>
 <7vaboxy3va.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711291146090.27959@racer.site>
 <Pine.LNX.4.64.0711291419350.27959@racer.site> <20071129151211.GB32296@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	pasky@suse.cz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixm2A-00011b-IQ
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 17:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497AbXK2QOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758144AbXK2QOA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 11:14:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:57021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751440AbXK2QN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 11:13:59 -0500
Received: (qmail invoked by alias); 29 Nov 2007 16:13:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 29 Nov 2007 17:13:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bNANtqO3bdBym9WrmtIzXXxEtXaEH/pBjT0KIiM
	fyZotetlVpyiJ4
X-X-Sender: gene099@racer.site
In-Reply-To: <20071129151211.GB32296@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66543>

Hi,

On Thu, 29 Nov 2007, Jeff King wrote:

> On Thu, Nov 29, 2007 at 02:21:23PM +0000, Johannes Schindelin wrote:
> 
> > This patch adds a mode to expire only loose, unreachable objects
> > which are older than a certain time.  For example, by
> > 
> > 	git prune --expire 14.days
> > 
> > you can prune only those objects which are loose, unreachable
> > and older than 14 days (and thus probably outdated).
> 
> Does this now make git-prune safe for automatic running?
> 
> I suppose you could still be actively manipulating refs that point to
> very old objects.

That's why I want to have it configurable from git-gc.

Ciao,
Dscho
