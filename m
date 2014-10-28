From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable
 rule
Date: Tue, 28 Oct 2014 18:12:23 -0400
Message-ID: <20141028221223.GA20722@peff.net>
References: <87mw8iag72.fsf@gmail.com>
 <CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
 <20141026183530.GA18144@peff.net>
 <CAEvUa7nMYn1EJhrX+Yo-T53-tqB80p_ym9i+Ua6PMLqZrAFmQw@mail.gmail.com>
 <20141027051705.GC2996@peff.net>
 <xmqq61f5flz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael <fedora.dm0@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 23:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjF0F-0002gB-2B
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 23:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbaJ1WM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 18:12:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34717 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755492AbaJ1WM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 18:12:26 -0400
Received: (qmail 9529 invoked by uid 102); 28 Oct 2014 22:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 17:12:26 -0500
Received: (qmail 27953 invoked by uid 107); 28 Oct 2014 22:12:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 18:12:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2014 18:12:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61f5flz6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 10:42:21AM -0700, Junio C Hamano wrote:

> >> I believe I can work around the error with an "export _C89_CCMODE=1",
> >> but I thought I'd send the patch since this is the only occurrence of
> >> the problem, and the argument order is inconsistent with other linker
> >> commands in the file.
> >
> > I don't think working around it makes sense. That would fix your case,
> > but nobody else's (though given how long it has been that way without
> > complaints, I suspect any other compilers this picky may have died off).
> 
> I think you meant s/nobody else's/breaks &/;

I meant "using the _C_89_CCMODE workaround does not help anybody else,
because their compiler will not support it; instead we should fix the
Makefile as David originally proposed".

I think we are still agreeing, though. :)

-Peff
