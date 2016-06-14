From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 17:34:53 -0400
Message-ID: <20160614213453.GA21560@sigill.intra.peff.net>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>,
	Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	Alexander Sulfrian <alexander.sulfrian@fu-berlin.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Konstantin Koroviev <kkoroviev@gmail.com>,
	"Mark A. Grondona" <mark.grondona@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Maxim Bublis <b@codemonkey.ru>,
	Richard Hansen <rhansen@rhansen.org>,
	Roman Neuhauser <rneuhauser@suse.cz>,
	Simon Chiang <simon.a.chiang@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:35:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvzF-0002m5-99
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcFNVe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:34:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:54845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751119AbcFNVe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:34:57 -0400
Received: (qmail 14767 invoked by uid 102); 14 Jun 2016 21:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:34:56 -0400
Received: (qmail 455 invoked by uid 107); 14 Jun 2016 21:35:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:35:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 17:34:53 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297334>

On Tue, Jun 14, 2016 at 09:34:17PM +0200, Christian Couder wrote:

> Version 1.0.0 of Sharness [1] -- the test harness library derived from
> Git's test lib -- is released.

Cool. Git's test harness is something I really miss having in other
projects. I'm glad this project exists. :)

> This release contains many upstream fixes and improvements from Git
> and a lot of specific user contributed features [2].

It looks like it takes some manual work to massage upstream improvements
into Sharness.

I don't think the Git project would ever want to say "sharness is the
upstream, and we are now just a user of it". But I wonder if we could
break down test-lib.sh to keep the Git-specific parts separate, which
would make it easier for sharness to pull the other bits as a whole.

I dunno. I guess it would depend on how invasive the patches were, but I
would not be opposed to such a thing. I suspect the separation might
actually make our test setup more clear.

-Peff
