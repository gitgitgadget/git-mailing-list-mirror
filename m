From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 10:12:11 -0500
Message-ID: <20071129151211.GB32296@coredump.intra.peff.net>
References: <200711181225.52288.johannes.sixt@telecom.at> <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at> <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site> <7vaboxy3va.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711291146090.27959@racer.site> <Pine.LNX.4.64.0711291419350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	pasky@suse.cz
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 16:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixl45-0005p8-RD
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 16:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbXK2PMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 10:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXK2PMO
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 10:12:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2111 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbXK2PMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 10:12:13 -0500
Received: (qmail 19780 invoked by uid 111); 29 Nov 2007 15:12:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 10:12:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 10:12:11 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711291419350.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66540>

On Thu, Nov 29, 2007 at 02:21:23PM +0000, Johannes Schindelin wrote:

> This patch adds a mode to expire only loose, unreachable objects
> which are older than a certain time.  For example, by
> 
> 	git prune --expire 14.days
> 
> you can prune only those objects which are loose, unreachable
> and older than 14 days (and thus probably outdated).

Does this now make git-prune safe for automatic running?

I suppose you could still be actively manipulating refs that point to
very old objects.

-Peff
