From: Jeff King <peff@peff.net>
Subject: Re: test &&-chain lint
Date: Fri, 20 Mar 2015 13:59:45 -0400
Message-ID: <20150320175945.GA11844@peff.net>
References: <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
 <20150320013217.GA15302@peff.net>
 <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
 <20150320020851.GC15302@peff.net>
 <20150320022532.GA5502@peff.net>
 <xmqqd244go0h.fsf@gitster.dls.corp.google.com>
 <xmqq384zha6s.fsf@gitster.dls.corp.google.com>
 <20150320172406.GA15172@peff.net>
 <xmqqoannfu84.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:59:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1D6-0005SN-QH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbCTR7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:59:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:35962 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbbCTR7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:59:48 -0400
Received: (qmail 27152 invoked by uid 102); 20 Mar 2015 17:59:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 12:59:48 -0500
Received: (qmail 26107 invoked by uid 107); 20 Mar 2015 18:00:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:00:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 13:59:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoannfu84.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265923>

On Fri, Mar 20, 2015 at 10:34:51AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Your case above is actually better spelled as test_expect_code, but
> > there are more complex one-off cases that I solved using a {} block.
> 
> Just for the record, test_expect_code expects only one possible good
> exit status and it does not allow us to say "0 is OK and 1 is also
> OK, everything else is bad", so it is not quite appropriate there.

Oh, sorry, I misread your test as expecting 1, but it is actually
expecting 0 or 1. Yeah, I agree this is the exact sort of case covered
in my patch 11/25 (and there are only 4 instances in the whole test
suite).

-Peff
