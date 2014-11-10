From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Mon, 10 Nov 2014 01:30:35 -0500
Message-ID: <20141110063035.GA7677@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
 <xmqqtx28b6z6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XniUr-0002ks-LO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbaKJGai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:30:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:38597 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751238AbaKJGah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:30:37 -0500
Received: (qmail 15366 invoked by uid 102); 10 Nov 2014 06:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 00:30:37 -0600
Received: (qmail 32510 invoked by uid 107); 10 Nov 2014 06:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:30:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 01:30:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtx28b6z6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 09:48:29AM -0800, Junio C Hamano wrote:

> Michael Blume <blume.mike@gmail.com> writes:
> 
> > Works for me, thanks =)
> >
> > I'm curious now, is there an automated build of git running on a mac
> > anywhere? There's a mac mini running jenkins in my office and it's
> > possible I could convince someone to let me set up a git build that'll
> > e-mail me if there's a test failure.
> 
> I am not aware of a Macintosh person who regularly runs tests, but
> if there were, we hopefully will hear from them soonish ;-).

I think there are several people who run the tests on OS X fairly
regularly (I note that another fix for the t1410 problem has already
materialized :) ).

However, I think it is nice when test failures are caught early, before
you have merged topics (to master or elsewhere). That helps isolate the
failures to their particular topics.

I know you "make test" before pushing out the results of any integration
you do. And I recall that for a while (and maybe still?) you even did so
on VMs of a few common platforms. OS X is notoriously irritating to run
in a VM, but would you be interested in a network-accessible install
that you could push to and "make test" on as part of your routine?

If what Michael is offering cannot do that, I am sure I can get GitHub
to set something up.

-Peff
