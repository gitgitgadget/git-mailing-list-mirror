From: Jeff King <peff@peff.net>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 20:08:51 -0400
Message-ID: <20110915000851.GA6238@sigill.intra.peff.net>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org>
 <20110914231427.GA5611@sigill.intra.peff.net>
 <7vd3f2snox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Andrew Ardill <andrew.ardill@gmail.com>,
	Eduardo D'Avila <erdavila@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 02:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3zVm-0004iq-8E
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 02:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab1IOAIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 20:08:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55999
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab1IOAIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 20:08:53 -0400
Received: (qmail 15977 invoked by uid 107); 15 Sep 2011 00:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 20:09:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 20:08:51 -0400
Content-Disposition: inline
In-Reply-To: <7vd3f2snox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181416>

On Wed, Sep 14, 2011 at 04:34:38PM -0700, Junio C Hamano wrote:

> > Is there such a thing as enough coders? :)
> 
> Ever heard of the Mythical Man-Month ;-)?

I thought git was a silver bullet. :)

> I was simply saying that there already are many people who scratch his
> own real itch, and we are short of the bandwidth to review them all.
> It would not help the project at all to add more people who scratch
> some random non-itches that nobody is actually interested in (e.g. an
> entry in an unmaintained "bug tracker" that may list irrelevant and
> stale non issues).

Yeah, that may be. But I don't look at it as "we have enough
itch-scratchers, so we don't need more". I see it as survival of the
fittest. You may post a patch series that needs a lot of help, but
nobody else cares, and it dies off. Or your series may be interesting
enough that it draws attention, to the detriment of somebody else's
series (which may take longer to get reviewed and merged). But natural
selection only works if we have a diverse population to select from.

The downside, of course, is that somebody may end up wasting time going
down a fruitless road. But for a new contributor, hopefully they learn
something in the process.

> >   2. Read the list. People will report bugs. Try reproducing them,
> [...]
> 
> Yes. In the earlier steps in the above, you may find out that the
> report was actually not a bug at all (e.g. old issue that has long
> been fixed, pebcak, or wrong expectation), but even in such a case,
> reporting your finding would help others.

Very much agreed. I think big organizations like mozilla have people who
do nothing but bug triage. We are not that big, but it has proven to be
one area that is easy to break out and distribute to other people.

-Peff
