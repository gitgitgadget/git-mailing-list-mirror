From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 03:35:35 -0400
Message-ID: <20110509073535.GA5657@sigill.intra.peff.net>
References: <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506172334.GB16576@sigill.intra.peff.net>
 <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 09:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJL0L-0002LX-A5
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 09:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1EIHfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 03:35:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41959
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab1EIHfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 03:35:39 -0400
Received: (qmail 5586 invoked by uid 107); 9 May 2011 07:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 03:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 03:35:35 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173200>

On Sun, May 08, 2011 at 02:44:54PM +1000, Jon Seymour wrote:

> > =C2=A04. Users can set GIT_PLUGIN_PATH in the environment if they w=
ant to do
> > =C2=A0 =C2=A0 something fancy (they can also always just set PATH a=
nd MANPATH
> > =C2=A0 =C2=A0 manually if they want, too).
>=20
> If the need for multiple plugin directories were accepted, then I
> wonder if there might not be some advantages for the configuration of
> this path being in git configuration rather than an environment
> variable?

I think in general most users would not need to set this (since after
all, the point of your proposal is to avoid such tweaks), so it may not
be worth troubling about. But it is much simpler to tell users to run:

  git config core.pluginpath /path/to/wherever

than trying to figure out whether they need to use bashrc, cshrc,
whatever Windows uses, etc.

-Peff
