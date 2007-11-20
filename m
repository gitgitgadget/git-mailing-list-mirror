From: Jeff King <peff@peff.net>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Tue, 20 Nov 2007 06:13:18 -0500
Message-ID: <20071120111317.GA4120@sigill.intra.peff.net>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com> <20071118182901.GA5939@steel.home> <20071120041620.GA23566@sigill.intra.peff.net> <20071120065021.GA4172@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuR2y-0004R9-6p
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 12:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbXKTLNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 06:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXKTLNW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 06:13:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1642 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbXKTLNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 06:13:21 -0500
Received: (qmail 29269 invoked by uid 111); 20 Nov 2007 11:13:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 Nov 2007 06:13:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2007 06:13:18 -0500
Content-Disposition: inline
In-Reply-To: <20071120065021.GA4172@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65538>

On Tue, Nov 20, 2007 at 07:50:21AM +0100, Alex Riesen wrote:

> > Alex, are you going to rework your "consolidate nonff errors and print a
> > more extended message" patch on top of what's in next (I think it should
> > be much simpler now).
> 
> Do you mean that "Beautify the output of send-pack a bit", Message-ID:
> <20071112221140.GD2918@steel.home>?
> 
> If so, I'm confused. Didn't you already do that in your recent
> "send-pack:" patch series? It looked to me as if you did (except for
> the hint regarding non-ff branches to be updated everything is there).

That is what I meant. In the current code, the errors aren't
consolidated at the end, and as you mentioned, we don't print the extra
message. Two patch series follows (but see comments on each patch).

-Peff
