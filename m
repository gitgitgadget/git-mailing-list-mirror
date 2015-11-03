From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff-highlight: make a few improvements
Date: Tue, 3 Nov 2015 17:07:23 -0500
Message-ID: <20151103220723.GF22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztjjp-0002bg-R4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 23:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbbKCWH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 17:07:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:52341 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755107AbbKCWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 17:07:26 -0500
Received: (qmail 3655 invoked by uid 102); 3 Nov 2015 22:07:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:07:25 -0600
Received: (qmail 29222 invoked by uid 107); 3 Nov 2015 22:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 17:07:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 17:07:23 -0500
Content-Disposition: inline
In-Reply-To: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280827>

On Mon, Nov 02, 2015 at 09:05:30PM -0500, Jonathan Lebon wrote:

> These patches bring a few improvements to the contrib/diff-highlight
> Perl script. The major improvement is done in patch 3/4, which improves
> diff-highlighting accuracy by implementing a recursive line matching
> algorithm.
> 
> Please note that I have limited experience with Perl, so there may be
> better ways to do things. (Let me know if that is the case!)

I forgot to mention in the rest of my review: thank you for working on
this, and for making a nice clean series. It was very pleasant to read.

I think the output overall is nicer. I am concerned with the performance
implications. I see this as a stopgap until we have a true diff inside
the hunks, but if we can overcome the performance implications, I think
it's worth applying in the meantime.

-Peff
