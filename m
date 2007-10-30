From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 09:46:27 -0400
Message-ID: <20071030134627.GB21342@coredump.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net> <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org> <7vlk9lm2e5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Andy C <andychup@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrQa-0002WO-O7
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbXJ3Nqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXJ3Nqa
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:46:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbXJ3Nq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 09:46:29 -0400
Received: (qmail 745 invoked by uid 111); 30 Oct 2007 13:46:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 09:46:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 09:46:27 -0400
Content-Disposition: inline
In-Reply-To: <7vlk9lm2e5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2007 at 01:29:22AM -0700, Junio C Hamano wrote:

> If it always gives the same results in practice, obviously
> nobody can even notice.
> 
> However, merging this series to 'pu' breaks rebase-merge test
> t3402 among other things.

Yes, sorry, I meant to mention the test breakage in the cover letter
(which I think is just related to the size/score normalization). This is
not really meant for applying, but more for "this is taking me a lot
longer than I hoped, so here is what is happening and you might be
interested to comment." I'm not even sure it's pu material. :)

I will continue to refine it as I mentioned in the mail to Linus, but I
am open to suggestions.

-Peff
