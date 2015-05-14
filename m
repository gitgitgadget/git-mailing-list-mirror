From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 13:38:29 -0400
Message-ID: <20150514173828.GA7966@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
 <9350a00074264bb847210410a6f6c340@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 19:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysx5n-00077U-GB
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911AbbENRif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:38:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933230AbbENRic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:38:32 -0400
Received: (qmail 14936 invoked by uid 102); 14 May 2015 17:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 12:38:31 -0500
Received: (qmail 25434 invoked by uid 107); 14 May 2015 17:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 13:38:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 13:38:29 -0400
Content-Disposition: inline
In-Reply-To: <9350a00074264bb847210410a6f6c340@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269055>

On Thu, May 14, 2015 at 09:43:56AM +0200, Johannes Schindelin wrote:

> > Yeah, I tried what you wrote earlier in [1], but it didn't work. But I
> > just realized it has misplaced quotes. Doing:
> > 
> >   make ... ASCIIDOC_EXTRA="-a 'litdd=&#45;&#45;'"
> > 
> > seems to work OK.
> 
> Oh darn, I really meant to include this link:
> 
> https://github.com/git-for-windows/MINGW-packages/blob/af36666c829f64847737e783c34ab20402030648/mingw-w64-git/PKGBUILD#L71
> 
> which documents how Git for Windows defines `litdd`.

Hmm, you use the same "stuck" parameter -alitdd=..., whereas it only
worked for me with a space between the "-a" and the attribute. I wonder
if this is from different asciidoctor versions.

My asciidoctor just comes from the Debian package. Looks like it's over
a year old at this point. I should probably be testing with something
more recent.

-Peff
