From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: diagnose empty HEAD more clearly
Date: Thu, 4 Jun 2015 04:45:06 -0400
Message-ID: <20150604084505.GC5771@peff.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
 <20150603062005.GA20580@peff.net>
 <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
 <20150603081432.GA32000@peff.net>
 <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
 <556FFEB8.4050407@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Qm4-0002qj-7B
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbbFDIpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2015 04:45:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:41012 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751799AbbFDIpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:45:09 -0400
Received: (qmail 17361 invoked by uid 102); 4 Jun 2015 08:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 03:45:09 -0500
Received: (qmail 30056 invoked by uid 107); 4 Jun 2015 08:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 04:45:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 04:45:06 -0400
Content-Disposition: inline
In-Reply-To: <556FFEB8.4050407@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270762>

On Thu, Jun 04, 2015 at 09:31:04AM +0200, Stefan N=C3=A4we wrote:

> > +	if (!rev->pending.nr && !opt->def)
> > +		die("you do not have a commit yet on your branch");
>=20
> I am not a native english speaker but shouldn't this be:
>=20
>   "you do not have a commit on your branch yet"

Both are fine, as is:

  "you do not yet have a commit on your branch"

though I think yours is slightly more clear.

If you are wondering at the reason, "yet" is an adverb modifying "have"=
=2E
So it may come before or after the verb. If we substitute a simpler ver=
b
(that does not need a direct object "a commit") and drop the
prepositional phrase ("on your branch"), we can do either:

  - you do not yet program

  - you do not program yet

If we add back in the prepositional phrase (which is really acting as a=
n
adverbial phrase, modifying the verb here), we can do it in either
order:

  - you do not program yet in the office

  - you do not program in the office yet

But the latter makes it more clear that the "yet" applies to "in the
office".

You can also add back in the object of the verb:

  - you do not yet program computers

but you would not want:

  - you do not program yet computers

because it splits the verb from its object.

</grammar rant>

-Peff
