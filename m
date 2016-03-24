From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 13:37:31 -0400
Message-ID: <20160324173731.GD6341@sigill.intra.peff.net>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <20160323212213.GA19920@sigill.intra.peff.net>
 <56F3F267.30900@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Stanislav Kolotinskiy <stanislav@assembla.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9CW-0004Cx-2m
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbcCXRhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:37:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:37623 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750828AbcCXRhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:37:35 -0400
Received: (qmail 14950 invoked by uid 102); 24 Mar 2016 17:37:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 13:37:34 -0400
Received: (qmail 14938 invoked by uid 107); 24 Mar 2016 17:37:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 13:37:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 13:37:31 -0400
Content-Disposition: inline
In-Reply-To: <56F3F267.30900@assembla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289769>

On Thu, Mar 24, 2016 at 03:57:59PM +0200, Stanislav Kolotinskiy wrote:

> On 23/03/16 23:22, Jeff King wrote:
> >Not that it matters for this bug, but for my own curiosity, what do you
> >use "send-pack --all" for? I've generally assumed that nobody directly
> >calls send-pack themselves these days, but of course we have no data to
> >support that either way. So I am always interested to hear about unusual
> >use cases.
> Well, here at Assembla we're using send-pack --all for creating forks
> from repos in a quick and efficient way.

I guess a follow-up to my question is: what does "git send-pack" do that
"git push" does not? Again, this is just for my curiosity (the answer
may be "nothing, we just happened to build our scripts around
send-pack", and that is perfectly fine).

-Peff
