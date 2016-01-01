From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/14] shortlog: use skip_prefix_icase to parse "Author"
 lines
Date: Fri, 1 Jan 2016 03:53:17 -0500
Message-ID: <20160101085317.GD20715@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229072746.GD8842@sigill.intra.peff.net>
 <CAPig+cTxRbASyLhQH_WZDLX_RTY4t=F-QJeo5Uc5zWUxF1jvZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 09:53:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEvSe-00063X-H3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 09:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbcAAIxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 03:53:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:47633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751253AbcAAIxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 03:53:20 -0500
Received: (qmail 13940 invoked by uid 102); 1 Jan 2016 08:53:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:53:20 -0500
Received: (qmail 14891 invoked by uid 107); 1 Jan 2016 08:53:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:53:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jan 2016 03:53:17 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTxRbASyLhQH_WZDLX_RTY4t=F-QJeo5Uc5zWUxF1jvZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283251>

On Thu, Dec 31, 2015 at 01:47:21AM -0500, Eric Sunshine wrote:

> On Tue, Dec 29, 2015 at 2:27 AM, Jeff King <peff@peff.net> wrote:
> > Because we must match both "Author" and "author" here, we
> > could not use skip_prefix, and had to hand-code a partial
> > case-insensitive match. Now that we have skip_prefix_case,
> 
> s/skip_prefix_case/skip_prefix_icase/

Thanks. I originally called it the former, and thought I had managed to
fix up all of the references, but clearly didn't run "git log --grep".

> > we can use it. This is technically more liberal in what it
> > matches (e.g., it will match AUTHOR), but in this particular
> > case that that's OK (we are matching git-log output, so we
> 
> s/that that's/that's/

Fixed, thanks.

-Peff
