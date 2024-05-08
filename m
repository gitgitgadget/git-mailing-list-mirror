Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B1B646
	for <git@vger.kernel.org>; Wed,  8 May 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193769; cv=none; b=Abfn5UzuFHXgl6lmB06YfRNbOvgAKDV4ZKEvWgp8cGT8SfmJk6V/s1/R9X7Guvt5BnU7TgfjYgw7JYzd3JFGPOO0znbT+51bogqGbxKShITLJw1RSpbIWb+6Qi8WeZVr0PVxD9wsAefotLX8QwvydxqDDXCJbat0xLfShtdv2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193769; c=relaxed/simple;
	bh=Z+s6ZWMiXJeC2UAezIBwiLUt55mVt5KT/97mFxI+geI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2dqzNYoxrwmrwYEfhajtEwEo/PFl3xaVnDQ5IDgaWqprFfkI4bSKyWZlJGQVeOoZJE3h3kpbrhMnFtBMsu491x4xcP6iUYEsEdx7rKn1PeNAxQH2ZujEu6yg1C9docTkWD4PidzW1eGXUXn5uc/P9OGm8tix0jzISO0t7Z99+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000200DB.00000000663BC7A3.0000F6F5; Wed, 08 May 2024 18:42:43 +0000
Date: Wed, 8 May 2024 18:42:43 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Krefting <peter@softwolves.pp.se>,
  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
  git@vger.kernel.org
Subject: Re: i18n of git man pages
Message-ID: <ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de>
Mail-Followup-To: Helge Kreutzmann <debian@helgefjell.de>,
	Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
 <xmqqjzk4xlis.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-63221-1715193763-0001-2"
Content-Disposition: inline
In-Reply-To: <xmqqjzk4xlis.fsf@gitster.g>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-63221-1715193763-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Junio,
thanks.

Am Wed, May 08, 2024 at 10:26:35AM -0700 schrieb Junio C Hamano:
> cf.=20
> https://lore.kernel.org/git/cb74f3b-c2e9-947f-8f89-f51e79b17825@softwolve=
s.pp.se/
> https://lore.kernel.org/git/11498572.Kui42GGras@cayenne/

This mentions https://github.com/jnavila/git-manpages-l10n, so I can
point our translator to this source.

This should be shipped somehow, of course, by the distributions.

And the problem mentioned in this post can be solved by carefully
designed compendia, so that translations are reused whenever possible.

Also the "problem" about line numbers and diffs is not problem at all,
if you set up po4a approriately, I'm happy diffing po files all the
time (and git blame remains meaningful as well).=20

Greetings

          Helge
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-63221-1715193763-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmY7x50ACgkQQbqlJmgq
5nAN0Q/7B4W71P5rO6Lhnhj7iefuGAyZ5wF0FLIc4Cyjd0HWEr7MC8pz9N5Jv76l
Rz7zsQh/jEsZWv70lPAbsWH6/uc2PITL4zOiNuUk9eg7Wb4B/aB/RInCh1YP37N5
ffxAcnbCiz+qX1a8EnXDgrlPDzB59bu4vylCU9cVhbUfbTxeDISLxImsBWiXmpVs
4OQQ/xwdl7JZhPisev08SmDNqCB5CdoDpYQD2Cbh3BdhuoXZK/cdQl/GvUEyHwVh
09hliG4bTwoNuHnglF91rvB/2zc3AqrKEPG+3yPvuSyXZrWOE3k/qi9oNq15I2lK
7Se/ddxwSPJiHftk6sNg+3sYShfES9ldQuKYxyZFjPijAnyfKUPgXGnY2Yz+7nts
NHed6jhOs1hesxo8C7E+PYrEK0DcwFb0CS9TBB4RmjY9c8SiM1cR2Bduw0dh/AW8
0K1UPUBERP28zZOB+wtoC/W8IIFA1dyz3ObArBDHvh0+LMJXS1LN+wQCu7rBHe6N
nKWt8KD+2QGYKaI/hu2fYzp9i42HC2kFVKPNMFHuJvFR2tD3FXHRxnLVgS6qlhvG
P4sVt6k8NFXu4Ld49gDmzqKP33yi4MixfncCmSNyr5bJPVdhx+VwpFTkRnu0qxiC
vCZZV0m7HI6cQSB04a8MWXtyvLzjHzOUCAqUgKP+MXADABXUjlk=
=pNu9
-----END PGP SIGNATURE-----

--=_meinfjell-63221-1715193763-0001-2--
