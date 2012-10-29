From: Jeff King <peff@peff.net>
Subject: Re: gitweb
Date: Mon, 29 Oct 2012 03:14:11 -0400
Message-ID: <20121029071411.GA4229@sigill.intra.peff.net>
References: <20121028165647.b79fe3fcb6784c4ae547439e@lavabit.com>
 <20121029052815.GA30186@sigill.intra.peff.net>
 <CANQwDwd6EP94PEFkEcx8gBX1B5+-95qtjGMD6iU3ao8G+rCbLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rh <richard_hubbe11@lavabit.com>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjYI-00024h-ML
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab2J2HOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2012 03:14:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41880 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab2J2HOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:14:14 -0400
Received: (qmail 16373 invoked by uid 107); 29 Oct 2012 07:14:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 03:14:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 03:14:11 -0400
Content-Disposition: inline
In-Reply-To: <CANQwDwd6EP94PEFkEcx8gBX1B5+-95qtjGMD6iU3ao8G+rCbLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208599>

On Mon, Oct 29, 2012 at 08:12:46AM +0100, Jakub Nar=C4=99bski wrote:

> > Jakub, can you confirm the intent and a fix like the one above make=
s
> > things better?
>=20
> Yes, either of those makes things better.

Thanks.

> >                                   (unless highlight does this exten=
sion mapping
> > itself, but then why are we doing it here?).
>=20
> Highlight does extension mapping itself... but for that it needs file=
 name,
> and not to be feed file contents from pipe.

Ah, that makes sense.

Richard, do you want to roll a patch that fixes it?

-Peff
