From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-merge: do up-to-date check also for strategies
	ours, subtree.
Date: Thu, 9 Aug 2007 20:01:26 -0400
Message-ID: <20070810000126.GB10250@sigill.intra.peff.net>
References: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org> <7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHwc-0002DZ-5U
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbXHJABa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbXHJABa
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:01:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3538 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbXHJAB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:01:29 -0400
Received: (qmail 27751 invoked by uid 111); 10 Aug 2007 00:01:35 -0000
X-Spam-Status: No, hits=-0.9 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 09 Aug 2007 20:01:34 -0400
Received: (qmail 10291 invoked by uid 1000); 10 Aug 2007 00:01:26 -0000
Content-Disposition: inline
In-Reply-To: <7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55486>

On Thu, Aug 09, 2007 at 02:11:24PM -0700, Junio C Hamano wrote:

> Right now I do not have time to dig mailing list archive around
> mid March 2006, and I do not recall the requestor's original
> rationale, but I have a vague recollection that we added this
> "no fast-forward check" specifically in response to a user
> request.

Maybe it was the "I'm using a custom merge strategy that might refuse
the merge, but fast-forwards don't even invoke my merge strategy"
request?

-Peff
