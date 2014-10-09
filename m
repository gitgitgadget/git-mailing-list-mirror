From: Jeff King <peff@peff.net>
Subject: Re: git-archive doesn't support --date= option for %ad & %cd
 format:<string>'s
Date: Thu, 9 Oct 2014 15:27:43 -0400
Message-ID: <20141009192742.GC415@peff.net>
References: <CAMsgyKaHoZtAidWKD_YTggt_Xo0J7krFKHr2eFeg3XJ6H0bBXQ@mail.gmail.com>
 <20141009192428.GB415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJNM-0003qK-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaJIT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:27:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:56913 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbaJIT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:27:44 -0400
Received: (qmail 913 invoked by uid 102); 9 Oct 2014 19:27:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 14:27:44 -0500
Received: (qmail 27323 invoked by uid 107); 9 Oct 2014 19:27:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 15:27:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2014 15:27:43 -0400
Content-Disposition: inline
In-Reply-To: <20141009192428.GB415@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 09, 2014 at 03:24:28PM -0400, Jeff King wrote:

> On Thu, Oct 09, 2014 at 11:19:36AM -0500, Derek Moore wrote:
> 
> > PRETTY FORMATS' format:<string> documentation says, "%ad: author date
> > (format respects --date= option)", and similarly for %cd.
> > 
> > But git-archive does not support the --date= option for changing the
> > date format in $Format:%ad$ or $Format:%cd$ substitution strings.
> 
> Correct. You can use %ai, %aD, etc to pick a format. But...
> 
> > Relatedly, I want a short RFC date, not a short ISO date, but there is
> > only --date=short, which is ISO.
> 
> If you start adding new formats, we are likely going to run out of
> reasonably-memorable letters.
> [...]

I meant to add in here: ...so an external "--date" option does not seem
like that bad an idea. I think calling it "--date" is probably a
mistake, but something like "--subst-date-format" or something might
make more sense.

-Peff
