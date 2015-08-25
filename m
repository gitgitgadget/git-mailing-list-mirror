From: Jeff King <peff@peff.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 14:54:14 -0400
Message-ID: <20150825185414.GA10895@sigill.intra.peff.net>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net>
 <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gabor Bernat <bernat@primeranks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:54:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJMT-0005Jh-VA
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbHYSyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 14:54:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:49947 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370AbbHYSyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:54:17 -0400
Received: (qmail 15421 invoked by uid 102); 25 Aug 2015 18:54:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 13:54:16 -0500
Received: (qmail 6582 invoked by uid 107); 25 Aug 2015 18:54:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 14:54:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 14:54:14 -0400
Content-Disposition: inline
In-Reply-To: <20150825185210.GA10032@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276560>

On Tue, Aug 25, 2015 at 02:52:10PM -0400, Jeff King wrote:

> Yeah, that would probably be a good solution, assuming there is a
> portable "how many seconds" (I do not relish the thought of
> reconstructing it based on the current hours/minutes/seconds).

A little googling came up with:

    awk 'END { print systime() }' </dev/null

which probably (?) works everywhere. I feel dirty just having typed
that, though.

-Peff
