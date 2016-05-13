From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t9107: use "return 1" instead of "exit 1"
Date: Fri, 13 May 2016 19:47:04 -0400
Message-ID: <20160513234704.GA20238@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
 <20160513204721.GC15391@sigill.intra.peff.net>
 <CAPig+cQKkkP=Go=w65mGcgqZN6ckz21kG2=KCJS8L+0D3mgC+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 14 01:47:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MnZ-0001pu-Jm
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbcEMXrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:47:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:39508 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbcEMXrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:47:08 -0400
Received: (qmail 25145 invoked by uid 102); 13 May 2016 23:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 19:47:07 -0400
Received: (qmail 23377 invoked by uid 107); 13 May 2016 23:47:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 19:47:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 19:47:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQKkkP=Go=w65mGcgqZN6ckz21kG2=KCJS8L+0D3mgC+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294600>

On Fri, May 13, 2016 at 07:45:42PM -0400, Eric Sunshine wrote:

> > +       >expect &&
> 
> What's this 'expect' file for? Is it leftover gunk from before you
> settled on 'diff --exit-code'?

Oops, yes, that's exactly it.

-Peff
