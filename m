Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D6136E37
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718111; cv=none; b=EjjxYHC4BHlBJbGD1fR9iZCWMXlMq6k5B55zqHQYp8yvEgi9G6KWC5zdVR4RU6VrLSje1uBi2k40sWAglDAPrgsES2DNBF2Qgwdzj3piyWyjQuZm9XZenDl01fUxlBBW/504sgovvjwyqH1ZzJb3xCfvdy19GEmu+LkOVrHR1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718111; c=relaxed/simple;
	bh=h1x1EzA3aJEGGzYfyAWUIm89iaULjEuU79ipsGLFW3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ6hOG6r/yL+mgn8Gx27ENjpTD0qvFQ5XO6RH5lYwmcDlEk1Vd/2WZpxwmBcdoVYZNYej33lB/rtff+VhqLf9rOuFvOJ0MHfdusVCyX1o9tW3Pqewx2LyWA3pcrnC6i1NVVkA7WKaD9gcKT+KDdFik1uokQQctXx01BVxpiAksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bLO0aG5x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bLO0aG5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743718100;
	bh=h1x1EzA3aJEGGzYfyAWUIm89iaULjEuU79ipsGLFW3k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bLO0aG5xSgJcj6uaXNGJT80rkDHt50cTjU3Ki9aiB7jOohGGxSWqDJqrcuUAREyk6
	 OVF8XELLngVL3s7BWSuZwH+IED0VmUlr2nVrdXUa0uLy/ovM01pyTGR92tRPa12GD5
	 L508q/FzWUYj2/TKGZCg9zJxF4npL4vR3V5P+7SJt8K/NUXQvKuF6Q39TwbVnEUvEf
	 g0UAr6izbtRmTvNTv7ygafsh9qspPs6j8LVEUi8QfXk6s3EM64G+kR6BVNW8nNo397
	 ISN2yzlQsYODhC58+Py+higoZJ67ekUoHStr95nacVY/bGPtbkMW2hzAuDlblgHgpZ
	 P0KPWbEfcRvji/95oQsdSQy8ma09tyfW/EQXCosXJ8VqQet2s5qoGAg+X2m2PKdE9S
	 T7YCw3d0hjOTWMoP4ogu7AKXnA2S9B6FVLiU69Q+8s83yl0MA2pruTa+mpfcoJukAk
	 O4fkK2IbMfiMkNiXMFxtbh2sc9F0SJAz3s46QCONMvU/im8K3fC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C43B7200BE;
	Thu,  3 Apr 2025 22:08:20 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:08:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marrold <kamailio@marrold.co.uk>
Cc: git@vger.kernel.org
Subject: Re: Git Commit Signing
Message-ID: <Z-8G025UUC3KpRjw@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marrold <kamailio@marrold.co.uk>, git@vger.kernel.org
References: <CAC-Lcd-=_dVmyy0x9N+5ap4h7UQrfkVpJaCtZnoMrkxabVR1dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LE4sQwFD4hnJCmeG"
Content-Disposition: inline
In-Reply-To: <CAC-Lcd-=_dVmyy0x9N+5ap4h7UQrfkVpJaCtZnoMrkxabVR1dg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LE4sQwFD4hnJCmeG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-03 at 20:41:47, Marrold wrote:
> Hi all,
>=20
> I'm attempting to manually verify git commits signed with SSH keys
> using python, however verifying commits consistently fails, no matter
> what I try.
>=20
> The python verification logic has been tested against signatures
> produced with ssh-keygen and confirmed to be working.
>=20
> I suspect I'm constructing the message incorrectly to check against
> the signature. As far as I know, the message should look like this,
> with the gpgsig section removed.
>=20
>     tree ff5ee8caaf2893a79711151b2937130469d83d39
>     parent 3e84a21590a5ad714d168878abc95218d0e42cac
>     author Matthew H <git@marrold.co.uk> 1743454803 +0100
>     committer Matthew H <git@marrold.co.uk> 1743454803 +0100
>=20
>     Commit message
>=20
> Could someone point me in the right direction? I'm wondering if its
> hashed or encoded prior to signing

The message is not hashed or encoded.  It is exactly the same object as
the regular commit except without the `gpgsig` or `gpgsig-sha256`
header.  Note that that header has continuation lines starting with a
space that are also excluded.

So if we take this commit at the tip of my dotfiles:

----
tree 81c2ccabf6c21c811da7c7f1ecc0dd2019ebf2a2
parent 760a2559269f6acccd1d696cbfc2447d33447e1c
author brian m. carlson <sandals@crustytoothpaste.net> 1743470407 +0000
committer brian m. carlson <sandals@crustytoothpaste.net> 1743470407 +0000
gpgsig -----BEGIN PGP SIGNATURE-----

 wr0EABYKAG8FgmfrP2QJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
 LnNlcXVvaWEtcGdwLm9yZ+07Eq2NxeydVlLrWYwgP09Iw8vhBE/bPFShPSulPcqa
 FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJAwAQDtYPttuP1LW9ZqyWuGNM4epDNm
 3IyV2nezfAXxvVkB3wEAsk5U8d3Pq4GHNtE/QMc5FQ0uyI7FThHryBF6HYoLyAY=3D
 =3DZROA
 -----END PGP SIGNATURE-----

vimrc: enable virtual text in Neovim

In Neovim 0.11, virtual text is disabled by default.  Since we'd like to
use it if it's available, enable it explicitly.  If it's not available,
then the option will be ignored.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
----

then the commit body that's subject to verification is this:

----
tree 81c2ccabf6c21c811da7c7f1ecc0dd2019ebf2a2
parent 760a2559269f6acccd1d696cbfc2447d33447e1c
author brian m. carlson <sandals@crustytoothpaste.net> 1743470407 +0000
committer brian m. carlson <sandals@crustytoothpaste.net> 1743470407 +0000

vimrc: enable virtual text in Neovim

In Neovim 0.11, virtual text is disabled by default.  Since we'd like to
use it if it's available, enable it explicitly.  If it's not available,
then the option will be ignored.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
----

There can definitely be extra headers in the commit, so you can't assume
it will always be just those, nor can you assume that the headers
(including the signature header) will be in any particular order.

Do you have an example commit, key, and command line invocation that you
can show us to help pinpoint the problem?  I ask because ssh-keygen
doesn't exactly present the most intuitive interface and it's easy to
make a mistake in invocation.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--LE4sQwFD4hnJCmeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+8G0wAKCRB8DEliiIei
gYUkAQDKWvdNBcLiZgOtlECEIVWL5JZnKLeTwy++EwJ0NAh0/gD6A7oZhQNzXYPk
mxp6f97yQwPcfuKHfuifVAsagwA13Ao=
=cScV
-----END PGP SIGNATURE-----

--LE4sQwFD4hnJCmeG--
