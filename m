From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 15 Sep 2011 10:18:15 +0200
Organization: Gentoo
Message-ID: <20110915101815.172fb47a@pomiocik.lan>
References: <20110901184815.2cd8b472@pomiocik.lan>
	<1314895801-21147-1-git-send-email-mgorny@gentoo.org>
	<20110902163903.GA21768@sigill.intra.peff.net>
	<20110902193931.42593338@pomiocik.lan>
	<20110902175323.GA29761@sigill.intra.peff.net>
	<20110907174044.GA11341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/IHoEq1YxKCLFuDllGJTgp65"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 10:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R477R-00030w-TI
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 10:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1IOIQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 04:16:19 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35826 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab1IOIQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 04:16:18 -0400
Received: from pomiocik.lan (213-238-104-87.adsl.inetia.pl [213.238.104.87])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CE85B1B4019;
	Thu, 15 Sep 2011 08:16:15 +0000 (UTC)
In-Reply-To: <20110907174044.GA11341@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.6; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181446>

--Sig_/IHoEq1YxKCLFuDllGJTgp65
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Sep 2011 13:40:44 -0400
Jeff King <peff@peff.net> wrote:

> On Fri, Sep 02, 2011 at 01:53:23PM -0400, Jeff King wrote:
>=20
> > But there may be other corner cases.  I need to read through the
> > code more carefully, which I should have time to do later today.
>=20
> This ended up a little trickier than I expected, but I think the
> series below is what we should do. I tried to add extensive tests,
> but let me know if you can think of any other corner cases.
>=20
>   [1/5]: t7004: factor out gpg setup
>   [2/5]: t6300: add more body-parsing tests
>   [3/5]: for-each-ref: refactor subject and body placeholder parsing
>   [4/5]: for-each-ref: handle multiline subjects like --pretty
>   [5/5]: for-each-ref: add split message parts to %(contents:*).

Thanks, it works great for me.

I tried multi-line subject + signature too and that works fine.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/IHoEq1YxKCLFuDllGJTgp65
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5xtMgACgkQfXuS5UK5QB2JSgQApNLxrulpBWUn2ExYa5d9Bclm
IVHuEXkhPqS9RYNkxaiHkmM5xCt5f4ZGV4Iu+IBNoZ4Pw68NeYuFoa99Gf7UiVkf
+7+2hHNUtW/vNQGv/+oOu2I8N40tWQPrc4c6rqCo+xr3SUMxmCqJ1cmSMECnUwMu
aUoqjm0Vn2Tkh4UXEJQ=
=otPc
-----END PGP SIGNATURE-----

--Sig_/IHoEq1YxKCLFuDllGJTgp65--
