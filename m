From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: More formatting with 'git tag -l'
Date: Mon, 29 Aug 2011 23:50:23 +0200
Organization: Gentoo
Message-ID: <20110829235023.31b5ab23@pomiocik.lan>
References: <20110829211018.2ce4ebab@pomiocik.lan>
	<20110829193658.GG756@sigill.intra.peff.net>
	<20110829232011.565ea553@pomiocik.lan>
	<20110829213757.GB14299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/gk7Z9PT/YbtoaTFWsf3BlRi"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9hG-0005Se-7X
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1H2Vsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:48:41 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58195 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab1H2Vsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:48:41 -0400
Received: from pomiocik.lan (unknown [87.204.190.32])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7BDEA1B412B;
	Mon, 29 Aug 2011 21:48:39 +0000 (UTC)
In-Reply-To: <20110829213757.GB14299@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180363>

--Sig_/gk7Z9PT/YbtoaTFWsf3BlRi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Aug 2011 17:37:57 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Aug 29, 2011 at 11:20:11PM +0200, Micha=C5=82 G=C3=B3rny wrote:
>=20
> > > You can do something similar with 'git for-each-ref', which is
> > > probably what you should be using if you are scripting, anyway
> > > (as it is "plumbing" and guaranteed not to change in future
> > > releases). Something like:
> >=20
> > Thanks, that looks great. The only thing I am missing right now is
> > a simple %(body) variant which would strip the GPG signature. I'd
> > really like to avoid establishing a shell oneliner to do that.
>=20
> Yeah, I don't think that's possible with the current code. I don't
> think it would be unreasonable to add "%(tagcontents)" and
> "%(tagsignature)" or something similar, though.
>=20
> Want to try a patch?

I'll take a look at the code tomorrow and see if I can assemble
something useful. Someone will have to design nice names though.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/gk7Z9PT/YbtoaTFWsf3BlRi
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5cCaAACgkQfXuS5UK5QB3EvgQAmuGfMtuNycTUGd9OJ+/YWIGS
SxHZeE5sjVYdAi1FRh8TaBVgsxqriOnwM4HLNSxQiBNm9HGxWEOZ1TsqxTzM5mOn
irttb/UPDu+OlzwETrcOAwNTNiA9DoDqdBMGt3+FSspxr/4zwos1VeH1Rcwx5Ql6
kUaHyadLDCA/nbzjJc8=
=cSSx
-----END PGP SIGNATURE-----

--Sig_/gk7Z9PT/YbtoaTFWsf3BlRi--
