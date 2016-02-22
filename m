From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Mon, 22 Feb 2016 17:18:11 -0500
Message-ID: <20160222221811.GC18522@sigill.intra.peff.net>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
 <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
 <20160221231913.GA4094@sigill.intra.peff.net>
 <20160221234135.GA14382@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:18:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyo8-0001Lk-I2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960AbcBVWSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:18:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:47000 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755475AbcBVWSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:18:14 -0500
Received: (qmail 20403 invoked by uid 102); 22 Feb 2016 22:18:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:18:13 -0500
Received: (qmail 22609 invoked by uid 107); 22 Feb 2016 22:18:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:18:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:18:11 -0500
Content-Disposition: inline
In-Reply-To: <20160221234135.GA14382@river.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286960>

On Sun, Feb 21, 2016 at 11:41:35PM +0000, John Keeping wrote:

> My original sed version was:
> 
> 	sed -ne "/^author /p" -e "/^summary /p"
> 
> which I think will work on all platforms (we already use it in
> t0000-basic.sh) but then I decided to be too clever :-(
> 
> I still think sed is simpler than introducing a new function to wrap a
> perl script.

Yeah, I think that is good (personally I'd use a function anyway, but I
think it is short enough that we could go either way).

-Peff
