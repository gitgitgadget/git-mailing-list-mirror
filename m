From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 17:46:55 -0400
Message-ID: <20160614214655.GA22334@sigill.intra.peff.net>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
 <20160614213453.GA21560@sigill.intra.peff.net>
 <xmqq7fdr8n0o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
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
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:47:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwAp-0004PX-6y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbcFNVq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:46:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:54883 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbcFNVq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:46:58 -0400
Received: (qmail 15322 invoked by uid 102); 14 Jun 2016 21:46:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:46:58 -0400
Received: (qmail 641 invoked by uid 107); 14 Jun 2016 21:47:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:47:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 17:46:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fdr8n0o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297338>

On Tue, Jun 14, 2016 at 02:43:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think the Git project would ever want to say "sharness is the
> > upstream, and we are now just a user of it". But I wonder if we could
> > break down test-lib.sh to keep the Git-specific parts separate, which
> > would make it easier for sharness to pull the other bits as a whole.
> 
> I took a quick look around, and it seems that this is an outdated
> fork made without getting much of the improvement from its upstream
> since it forked.  It does not seem to have lazy prerequisite, for
> example.

Yeah, I don't think it has kept up with our work. My statement above was
"I don't think we'd _ever_ want to consider sharness the upstream, even
if it were up to date", but obviously there would be a lot of work to
even get it there.

-Peff
