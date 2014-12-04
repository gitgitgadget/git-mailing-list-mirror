From: Jeff King <peff@peff.net>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 4 Dec 2014 15:55:27 -0500
Message-ID: <20141204205527.GA19953@peff.net>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de>
 <20141204095557.GE27455@peff.net>
 <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
 <548087F8.1030103@drmicha.warpmail.net>
 <CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:55:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwdR0-0006u9-K7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbaLDUzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 15:55:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:48518 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753165AbaLDUza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:55:30 -0500
Received: (qmail 19918 invoked by uid 102); 4 Dec 2014 20:55:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 14:55:30 -0600
Received: (qmail 9338 invoked by uid 107); 4 Dec 2014 20:55:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 15:55:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 15:55:27 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260799>

On Thu, Dec 04, 2014 at 06:21:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > That is one of the many reasons why I proposed to have a dictionary=
 of
> > the main technical terms for each language before we even localise =
git
> > in that language. In an ideal word, we would provide a simple solut=
ion
> > for looking these terms up both ways. I don't think we're going to =
have
> > localised man pages any time soon, are we?
>=20
> I think that's a great idea, and one that's only blocked on someone
> (hint hint) sending patches for it.
>=20
> It would be neat-o to have something to make translating the docs
> easier, i.e. PO files for sections of the man pages. There's tools to
> help with that which we could use.
>=20
> But there's no reason for us not to have translated glossaries in the=
 meantime.

By the way, there has been fairly significant volunteer effort put into
translating Pro Git (e.g., <http://git-scm.com/book/de/v1>). I have no
idea if the terms they use are similar to the terms we use in the
localized messages. It might make sense to:

  1. Coordinate with those translators to make sure that the glossary
     terms are consistent.

  2. Figure out how to harness those translators for manpage work. Why
     did Pro Git get so much volunteer translation done, and the
     manpages didn't? Did they advertise to the right people? Have an
     interface that made it easier for non-technical people to get
     involved?

-Peff
