From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t960[34]: mark cvsimport tests as requiring perl
Date: Tue, 18 Nov 2014 14:15:10 -0500
Message-ID: <20141118191510.GA28114@peff.net>
References: <20141118172231.GA16387@peff.net>
 <20141118172932.GA31672@peff.net>
 <20141118185622.GG6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:15:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqoFD-0004fI-CB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbaKRTPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:15:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:41873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753952AbaKRTPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:15:12 -0500
Received: (qmail 25918 invoked by uid 102); 18 Nov 2014 19:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 13:15:12 -0600
Received: (qmail 20141 invoked by uid 107); 18 Nov 2014 19:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 14:15:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 14:15:10 -0500
Content-Disposition: inline
In-Reply-To: <20141118185622.GG6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 10:56:22AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > It would probably make sense to have these scripts just
> > skip_all if NO_PERL is set, but I opted to follow the pattern
> > set by t9600, etc. If somebody feels like spending time refactoring the
> > cvsimport test harness, be my guest.
> 
> Wouldn't it be a matter of the following, plus (optionally) dropping
> the existing PERL prerequisites on cvs tests?
> [...]
>  t/lib-cvs.sh | 6 ++++++

Yeah, I think so. I was worried that lib-cvs was used by the other CVS
tests (like t9200, and t940x), but it seems to be cvsimport-specific.
If you do go this route (and that is fine with me), maybe it is worth
changing the filename to make that more clear.

-Peff
