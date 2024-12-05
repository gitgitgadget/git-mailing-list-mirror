Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E618FDDA
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440618; cv=none; b=nsz1h0mgWWOPg8GGCYBDX1/Lz4TiWqJ86CKK/3WYPTxyPM2gfYs91B+gUKDTi1yj7JXfTI4+2s00z2WFHjOOsC/ZF956PAWNgPSB/FpXASy69+Z8h3eS9kJ4mpRekDmCDtMp0u5+Z8bATyFDeoHvKiCKV8GPZPEGxcvfa45y+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440618; c=relaxed/simple;
	bh=+qImaWA1LKhJgM53GrUWZjJLPWTARoUcM5zAnlOvmrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSWinhQxxOAc8nPLXSzpVj2YP8gSzjP4W1durNxRBn6gRM5bMp+E8vistXWIr3mqhAxq5lhkxK1yBYLp5KbtzwbwnhqggatU74ZgrFN54bG3d723XoWjHKVJRzCx6EfTz1TEKwYKAVtQuntDqDlns1gpZm4JpyZLbaepKZu8JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UPab8pT1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UPab8pT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1733440608;
	bh=+qImaWA1LKhJgM53GrUWZjJLPWTARoUcM5zAnlOvmrg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UPab8pT14lBaMITS6zOktZD+l4Ox4NbcX86bqbz1WMgw3WAUMYDrmxcs68fVPKmno
	 gBjpdhvTstx/3TBb2g/rgUpiYFYI5Lizs5J4UsAtzNVQdZzsprCRynUkMf7GohaZJe
	 0CUPmS/6REfsQ8HQuF48XYIvLDB/xRahfw8QAAJ+PT50anoTd/YBRJXtXXfMrKlYmk
	 enFqm6rhInFAbaHpVi/gffE8v+Mm0dYwA66iub2Ob8MGC+sUiii8HbMybVGt2fBN8N
	 TRvA1NezAVATRjpW5mreq92QV1Vl7k70QpbFwvQziSh/x2BGbCni+nm9YuXAuMNS0/
	 x3Qd8jeccrcSWUA4mbe432fzV6NG1X6a9RT+0oB3xqFsX1hRazBVC4981Bx0TxIJSI
	 mhCkmWd/Kj1ydupkY5NLo8PcA7E/EMGKI0h+KN/yLe+IkzRlfZAeGejh+c0Kv0Hq7t
	 zXj7tAjFC/jITObM1xOjx9ek2fDEJd4yC92C6wHAgAV44oxyJ8/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CD91820994;
	Thu,  5 Dec 2024 23:16:48 +0000 (UTC)
Date: Thu, 5 Dec 2024 23:16:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "dangling ." <kasperkantz@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Proposal: Allow Customization of Git Merge Commit Message
 Template
Message-ID: <Z1I0XzE6QWlsyZkH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"dangling ." <kasperkantz@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DM4PR14MB4880061D71993B749F44F2EDA7302@DM4PR14MB4880.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X9WFK+EotMrBXL4/"
Content-Disposition: inline
In-Reply-To: <DM4PR14MB4880061D71993B749F44F2EDA7302@DM4PR14MB4880.namprd14.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--X9WFK+EotMrBXL4/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-05 at 17:00:56, dangling . wrote:
> Proposal:
> Introduce an option (e.g., a configuration setting or CLI flag) that allo=
ws users to specify a custom merge commit message template. For example:
>=20
> - A new configuration option:
>   ```sh
>   [merge]
>       messageTemplate =3D "Merge %s into %s"
>   ```
>   Here, `%s` placeholders could represent the source and destination bran=
ches, respectively.

I think in general that such an option would need multiple placeholders.
Just because in English we place the name of the second head before the
name of the first head does not mean that that is true in all languages
or translations.

> - Alternatively, a command-line flag:
>   ```sh
>   git merge --message-template=3D"Merge %s into %s" upstream/main
>   ```

I think this can be done more generally with a `prepare-commit-msg`
hook:

----
#!/bin/sh

COMMIT_MSG_FILE=3D$1
COMMIT_SOURCE=3D$2

case "$COMMIT_SOURCE" in
 merge)
   /usr/bin/perl -i.bak -pe '
   s/Merge remote-tracking branch '\''(.*)'\''/Merge $1/
   ' "$COMMIT_MSG_FILE"
   ;;
 *) ;;
esac
----

That's the approach we would generally recommend here, since it's more
flexible and allows you more customization over the message.  Of course,
you can use sed or Ruby instead (or even ed or ex) if you prefer.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--X9WFK+EotMrBXL4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ1I0XwAKCRB8DEliiIei
gVCuAP9+l4vo3nJxthqPQ10qK3FFXBJ96QdtS9JHZi3VKgbLOAEAmuNO6NCe0x4p
NuVic7R6JcUTt1a3l8zBT7jYwQPwvgk=
=+bvc
-----END PGP SIGNATURE-----

--X9WFK+EotMrBXL4/--
