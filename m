From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] docs: asciidoc version tweaks
Date: Wed, 30 May 2012 06:17:58 -0400
Message-ID: <20120530101758.GA13285@sigill.intra.peff.net>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
 <20120529215613.GB17598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 12:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZfyu-0005ny-DX
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab2E3KSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 06:18:04 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab2E3KSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 06:18:03 -0400
Received: (qmail 2798 invoked by uid 107); 30 May 2012 10:18:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 06:18:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 06:17:58 -0400
Content-Disposition: inline
In-Reply-To: <20120529215613.GB17598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198789>

On Tue, May 29, 2012 at 05:56:13PM -0400, Jeff King wrote:

> > > The commit message of 6cf378f0 is not correct in that respect. =C2=
=A0My
> > > ancient 71c020c5 has the right numbers: asciidoc 8.4.1 is the one=
 that
> > > introduced the new inline-literal behavior. =C2=A0Based on my lit=
tle survey
> > > in
>=20
> Yeah, sorry, this is my fault. It came up in discussion but I never
> amended the commit message. The magic number is definitely 8.4.1.

I think 6cf378f0 left a few other loose ends, too. Fixes to follow.

  [1/3]: INSTALL: update asciidoc recommendation
  [2/3]: docs: drop asciidoc7compatible flag
  [3/3]: docs: drop antique comment from Makefile

-Peff
