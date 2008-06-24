From: Jeff King <peff@peff.net>
Subject: Re: apply --recount, was Re: [PATCH v4] git-add--interactive:
	manual hunk editing mode
Date: Tue, 24 Jun 2008 01:09:02 -0400
Message-ID: <20080624050901.GA19224@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806120855.26847.trast@student.ethz.ch> <20080612071311.GA32491@sigill.intra.peff.net> <200806131748.44867.trast@student.ethz.ch> <20080623183840.GA28887@sigill.intra.peff.net> <alpine.DEB.1.00.0806231952360.6440@racer> <20080623195719.GB29569@sigill.intra.peff.net> <alpine.DEB.1.00.0806232204550.6440@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0nF-0005wI-9j
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYFXFJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYFXFJF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:09:05 -0400
Received: from peff.net ([208.65.91.99]:3474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbYFXFJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:09:04 -0400
Received: (qmail 32506 invoked by uid 111); 24 Jun 2008 05:09:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 01:09:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 01:09:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806232204550.6440@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85990>

On Mon, Jun 23, 2008 at 10:16:08PM +0100, Johannes Schindelin wrote:

> I think it was not a flaw, but something to be worried about: 
> 
> http://mid.gmane.org/7v4p87zcv6.fsf@gitster.siamese.dyndns.org
> 
> To spare you following that link: Junio wanted to reuse "git apply 
> --recount" to apply mboxes, where a separator "^-- $" to the signature is 
> quite common, and could be mistaken for a "-" line of a hunk.

Ah, OK. Thanks for the recap, that makes sense to me now.

> However, I think that this issue should not concern us _now_.  As long as 
> --recount is only to be used in "add -i" and "add -e", I think the patch 
> is good as is:

I agree. We can worry about the other when and if somebody decides to
use it that way (but maybe Junio is already planning to do so...).

Thomas, do you want to just re-submit the "--recount" patches when you
re-submit your patch?

-Peff
