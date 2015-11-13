From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: make formatting more consistent
Date: Fri, 13 Nov 2015 00:45:05 -0500
Message-ID: <20151113054505.GA32233@sigill.intra.peff.net>
References: <CACayv=gEGY-JNfu26fOzztXwhV_bkG8pv_iOXLC5L-Mig9f0kw@mail.gmail.com>
 <20151111214106.GA2208@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?0JDQvdC00YDQtdC5INCg0YvQsdCw0Lo=?= <rybak.a.v@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 06:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx7Ag-0004BA-5R
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbbKMFpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:45:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:56955 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbbKMFpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:45:08 -0500
Received: (qmail 15100 invoked by uid 102); 13 Nov 2015 05:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:45:07 -0600
Received: (qmail 21704 invoked by uid 107); 13 Nov 2015 05:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:45:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:45:05 -0500
Content-Disposition: inline
In-Reply-To: <20151111214106.GA2208@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281239>

On Wed, Nov 11, 2015 at 04:41:06PM -0500, Jeff King wrote:

> I know we've discussed this particular spot before, and I think there
> may have been some disagreement about which style was the best. But
> since clearly no patch came out of the last discussion, and since
> an inconsistent set of styles is probably worse than consistent use of
> any of the choices, this makes sense to me as an incremental step.
> 
> If we want to move to all-backticks (for example) later on, we can
> easily do so (or we can leave this as the final state).

Andrey helpfully dug up that thread off-list:

  http://thread.gmane.org/gmane.comp.version-control.git/267990/

If we want to move to backticks, we probably want to also turn on
MAN_BOLD_LITERAL by default, or it's a step backwards for some folks.

As I was the person who suggested backticks back in that thread, and I
do not want to spend the time myself on figuring out if MAN_BOLD_LITERAL
is safe to use everywhere, I somewhat retract my suggestion.

I've queued this patch as-is for now, but I'd be happy to hear other
opinions, or if people want to dig into the MAN_BOLD_LITERAL thing.

-Peff
