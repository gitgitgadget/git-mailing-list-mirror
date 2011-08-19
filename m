From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 20:37:34 -0700
Message-ID: <20110819033733.GB2993@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
 <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 05:37:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuFuA-00086y-TC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 05:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab1HSDhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 23:37:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57616
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1HSDhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 23:37:37 -0400
Received: (qmail 28067 invoked by uid 107); 19 Aug 2011 03:38:17 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 23:38:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 20:37:34 -0700
Content-Disposition: inline
In-Reply-To: <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179669>

On Thu, Aug 18, 2011 at 03:54:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Until this patch, doing something like:
> >
> >   git config alias.foo log
> >   git config pager.foo /some/specific/pager
> >
> > would not respect pager.foo at all.
> 
> Is it a good thing? Looks too confusing and I am having a hard time to
> decide if this is "just because we could" or "because we need to be able
> to do this for such and such reasons".

I don't have a particular use for it myself. However, I don't see what's
confusing about it. Would would you expect the above commands to do with
respect to paging? I think the behavior after my patch does what users
will expect, whether they have configured pager.foo, pager.log, or
nothing.

-Peff
