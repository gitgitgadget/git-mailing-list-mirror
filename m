From: Jeff King <peff@peff.net>
Subject: Re: GIT_TRACE_PERFORMANCE and pager
Date: Mon, 29 Feb 2016 16:30:27 -0500
Message-ID: <20160229213026.GB25342@sigill.intra.peff.net>
References: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
 <20160229113924.GC29769@sigill.intra.peff.net>
 <CAP8UFD30fWvFPtSgY_6mVMCeQ9rMR-0EODaKbZdMmz_fo-qfKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:30:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVP2-0006y0-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbcB2Vaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:30:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:51760 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752350AbcB2Vaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:30:30 -0500
Received: (qmail 9436 invoked by uid 102); 29 Feb 2016 21:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:30:29 -0500
Received: (qmail 31277 invoked by uid 107); 29 Feb 2016 21:30:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:30:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 16:30:27 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD30fWvFPtSgY_6mVMCeQ9rMR-0EODaKbZdMmz_fo-qfKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287907>

On Mon, Feb 29, 2016 at 02:46:12PM +0100, Christian Couder wrote:

> > though I guess I'd question whether trace-performance is interesting at
> > all for a paged command, since it is also counting the length of time
> > you spend looking at the pager waiting to hit "q".
> 
> In case of "GIT_TRACE_PERFORMANCE=2 git log -1", it doesn't count the
> time spent looking at the pager because the output is small, so 'less'
> exits immediately, and it could give the impression that
> GIT_TRACE_PERFORMANCE is not working.

Ah, right. I don't use "-F" with less, so mine hangs around until I
quit.

-Peff
