From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 16:43:04 -0400
Message-ID: <20101104204304.GA4641@sigill.intra.peff.net>
References: <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net>
 <20101104183851.GA16865@burratino>
 <20101104185545.GB31016@sigill.intra.peff.net>
 <87d3qkhm3d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6ek-0001Er-3r
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab0KDUm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 16:42:26 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab0KDUmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:42:25 -0400
Received: (qmail 3522 invoked by uid 111); 4 Nov 2010 20:42:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 20:42:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 16:43:04 -0400
Content-Disposition: inline
In-Reply-To: <87d3qkhm3d.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160762>

On Thu, Nov 04, 2010 at 09:26:14PM +0100, =C5=A0t=C4=9Bp=C3=A1n N=C4=9B=
mec wrote:

> > [1] If we are on a quest to remove <rev>{0,2}, this is one other sp=
ot to
> >     do it.
>=20
> That's already included in the patch.

Ah, sorry, I missed that hunk.

> I think this thread already has nothing to do with the purpose of the
> patch, though. I find your suggestion that <commit>{0,2} better conve=
ys
> some information about git-diff's operation modes than [<commit>
> [<commit>]] does (which seems to have been your starting point) rathe=
r
> far-fetched.

I find your version slightly harder to read than the original, which is
why I complained. However, I find both way worse than what Jonathan and
I ended up with.

> So AIUI the patch can still be applied and we/you can then work on
> improving the usage string in other ways -- providing that we agree t=
hat
> the {M,N} notation should go, of course, which we apparently still
> don't?

My main argument against that would be that if we are planning on
changing it to something totally different right now anyway, your patch
will just end up making textual conflicts for Junio to resolve. :)

> In any case this seems to be less and less my itch to scratch, so I'm
> not sure I'm going to be of much help in this discussion. The thing I
> need to know for the CodingGuidelines patch is whether we're going to
> preserve and encourage the {M,N} usage or not (so please let's arrive=
 to
> some conclusion on that matter -- I waited for several days before
> sending the updated version and nobody chimed in, so I assumed nobody
> other than Mark and Sverre really cared). Although, that's actually
> somewhat orthogonal, too -- we can always re-add the {M,N} subsection
> later.

Yeah, sorry to come in late to the discussion. I missed the other threa=
d
entirely. I think getting rid of {M,N} is fine. In general, your
proposed replacement is better. It's just that in this case it seemed t=
o
be obfuscating a subtle point that the original syntax (as ugly and
incomprehensible as it was) called out.

So yes, go ahead with your coding guidelines patch. I'll summarize what
Jonathan and I discussed with a new patch.

-Peff
