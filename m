Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5322018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcFXTsW (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:48:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751465AbcFXTsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:48:22 -0400
Received: (qmail 31609 invoked by uid 102); 24 Jun 2016 19:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:48:21 -0400
Received: (qmail 22272 invoked by uid 107); 24 Jun 2016 19:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:48:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:48:19 -0400
Date:	Fri, 24 Jun 2016 15:48:19 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 0/4] portable signal-checking in tests
Message-ID: <20160624194819.GB6282@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <576D621F.1030000@kdbg.org>
 <20160624164603.GA13789@sigill.intra.peff.net>
 <576D684A.6030406@kdbg.org>
 <20160624193924.GA6282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624193924.GA6282@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 03:39:24PM -0400, Jeff King wrote:

> Anyway. Here's a series that I think makes things better, and it is not
> too painful to do.
> 
>   [1/4]: tests: factor portable signal check out of t0005
>   [2/4]: t0005: use test_match_signal as appropriate
>   [3/4]: test_must_fail: use test_match_signal
>   [4/4]: t/lib-git-daemon: use test_match_signal

Oh, and I meant to mention: this covers everything I found grepping for
"141" and "143" in the test suite (though you have to filter the results
a bit for false positives).

It doesn't fix the case newly added in the tar series that started this
discussion. I don't want to hold either topic hostage to the other, so
I'll prepare a patch to go on top.

-Peff
