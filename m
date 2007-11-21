From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] send-pack: cluster ref status reporting
Date: Wed, 21 Nov 2007 02:39:38 -0500
Message-ID: <20071121073938.GB10742@sigill.intra.peff.net>
References: <20071120111317.GA4120@sigill.intra.peff.net> <20071120111801.GA7814@sigill.intra.peff.net> <7v1wakhxh4.fsf@gitster.siamese.dyndns.org> <20071121073332.GA10244@sigill.intra.peff.net> <7vwsscgie2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukBi-00081m-Lb
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689AbXKUHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbXKUHjl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:39:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2735 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbXKUHjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:39:40 -0500
Received: (qmail 4924 invoked by uid 111); 21 Nov 2007 07:39:39 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 02:39:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 02:39:38 -0500
Content-Disposition: inline
In-Reply-To: <7vwsscgie2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65613>

On Tue, Nov 20, 2007 at 11:36:05PM -0800, Junio C Hamano wrote:

> Heh, at least I've privately queued it at the tip of
> jk/send-pack for review but not merged it to 'next' yet, after
> fixing it up (the last round I also fixed up so that was partly
> why I noticed -- the patch did not apply).

OK, good. I should have noticed because I also ran across the same patch
failure when I did a rebase earlier today, but I didn't consider that
the mistake had slipped out of my repo. :) Sorry for the confusion.

> The idea feels sound, and code under cursory look was fine.

I think it is probably worth applying then. It is slightly more useful
to the user, and I haven't been able to see any downside.

-Peff
