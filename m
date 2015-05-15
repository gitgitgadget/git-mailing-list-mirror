From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Fri, 15 May 2015 00:01:24 -0400
Message-ID: <20150515040124.GA15942@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
 <20150515025223.GB4665@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri May 15 06:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt6oa-0001ZF-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 06:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbbEOEB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 00:01:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59019 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750953AbbEOEB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 00:01:27 -0400
Received: (qmail 15322 invoked by uid 102); 15 May 2015 04:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 23:01:27 -0500
Received: (qmail 30836 invoked by uid 107); 15 May 2015 04:01:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 00:01:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 00:01:24 -0400
Content-Disposition: inline
In-Reply-To: <20150515025223.GB4665@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269123>

On Fri, May 15, 2015 at 02:52:24AM +0000, brian m. carlson wrote:

> Using Asciidoctor 1.5.0, it seems to work properly for me without
> subs=normal.  So perhaps we should just update the version used for the
> site.  I realize the Debian version is out of date; I've already filed a
> bug.

I checked that it was broken on the site, but I didn't check to see how
ancient the version there was. And it is rather old. I've opened a PR[1]
to bump that.

> I opened issue 1344[0] for this.  However, it looks like we can write
> <refname>@+++{+++<date>+++}+++ instead of <refname>@\{<date>\} and it
> will work correctly in both processors.  That looks to be a workaround,
> as ugly and verbose as it is.

Yeah, I guess that works. But man, is it ugly. I'd love it if we can get
backslash-escaping in asciidoctor. Thanks for opening the issue.

-Peff

[1] https://github.com/git/git-scm.com/pull/545
