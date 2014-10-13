From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] "-x" tracing option for tests
Date: Mon, 13 Oct 2014 17:07:29 -0400
Message-ID: <20141013210729.GA15969@peff.net>
References: <20141010060636.GA15057@peff.net>
 <xmqqd29v4yl1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdmq8-0007iv-VU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbaJMVHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:07:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:58062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbaJMVHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:07:32 -0400
Received: (qmail 16048 invoked by uid 102); 13 Oct 2014 21:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 16:07:32 -0500
Received: (qmail 28462 invoked by uid 107); 13 Oct 2014 21:07:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 17:07:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 17:07:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd29v4yl1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 11:24:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > These patches are pulled out of the prune-mtime series I posted
> > earlier[1]. The discussion veered off and there's no reason that the two
> > topics need to be part of the same series.
> 
> These look all sensible.
> 
> Is your plan to reroll the prune-mtime stuff on top of these?  The
> additional safety those patches would give us is valuable and they
> are pretty straight-forward---I was hoping to have them in the 2.2
> release.

Yes, I've delayed while thinking about the issues that Michael raised.
There are basically two paths I see:

  1. These do not solve all problems/races, but are a solid base and
     sensible path forward for further changes which we can worry about
     later.

  2. There is a better way to provide prune safety, and these patches
     will get in the way of doing that.

I wanted to make sure we are on path (1) and not path (2). :)

I'll try to send out a re-roll tonight.

-Peff
