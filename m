Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24611729
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vouwm3X0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ap2XIaii"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EAAC7
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:15:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1AEB53200413;
	Mon, 13 Nov 2023 02:15:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 02:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699859757; x=1699946157; bh=8E
	xUoJovKqoEKhOmLcOO4t8L2sZZ6Rh1hfZBrJfTZfY=; b=Vouwm3X03x7ohzl4dF
	BL/KTxqP9gZirWK14rt3dFfjaEVJaXBQThDd7D9i6o0yt4tJiyMeXzHmhj3dAcFI
	nL+PtKXKflY8ppZ4o7nuwTfEDkr1H54TYHKUYrj78ODYhYsG1nKziE/F8nDFn574
	bbV6TE8XaUuDrO2pxvhaNHQsMAq2jdso16g/ij6lncuT2cXwD7DZaHovJ/gCFMdW
	CGt71qnybFzNMxR+Mq8wijxqiHp03ALK7PEQT4lh/pAIPGOlDFN+iw/rloiPVKOI
	Gihe/syNQtjF6ouKs9cf0fd5k1eYHlWI12JiF74soDPvkQe5jOSvZRyAE4x28WpK
	+cSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699859757; x=1699946157; bh=8ExUoJovKqoEK
	hOmLcOO4t8L2sZZ6Rh1hfZBrJfTZfY=; b=Ap2XIaiibTPy3XRUq0TMCs+im9qTT
	xEc/dKsUj2+uSICE+i16HzAPHaHkPPZJmph3koVc59F95HhUaWsY3HUv/nf3QD4X
	e/Z/mVTD0iPs+hOkT6JnXRV65vwDsLY1D7pjropu1DBe+pZ9mZAGskOHdsUvItdG
	qwgCyLi9zFn3tqaADUndc9d6D/DN8uZMyt4PLnJbSnBoYjjqma+a64J/EP17PiVg
	4vAuNpG6/o3bpc0x7p469Uhp/EOi9T3uQUZY80qq3hSE09EZu3/2NpM6zyFsrEoD
	jTJtb3yA3+lEtst++IdsiHwklCGm3rvWF0VVZf9eVYLxQPNRWWhLJfR5A==
X-ME-Sender: <xms:Lc1RZXiyKecFhfHWHZVnHoNcAnGH1pbNk7hGo27FrCmU30__mkRgHw>
    <xme:Lc1RZUDprsH_8_FYbO1pedWiz3W3cME__JxPrcuL40fi2j3s2ePxD3JOXU4zietch
    Z3R6t-X4NRzp8WRjA>
X-ME-Received: <xmr:Lc1RZXEoaRtg_JcRzxkuDyYylWLY_Ti_DOkZ2S2_SiMyF8zeYr1KKuaeNpJ5nU2e1bExe7sdA7PQYKtyV3Iiox775eTgYkqqnDG3PSEAqPsp6s-q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Lc1RZUQqK7G5pg0KmqfxDRXhU-VyAjryaLyNYliQjp71uMjn0FE6ZQ>
    <xmx:Lc1RZUzbTWL1Ya_3Gk9EWcH3Kv4Arx5LNSMJp80HR-LqodxOnmwhnA>
    <xmx:Lc1RZa5DI2G7J4zBo3eKdR_nYnHuzSu6KrF9babakElzanRU5SDOVA>
    <xmx:Lc1RZRq6-xjkazQH6O-3A3IBbcueB8DFMjz0jPQ2KsFtKg03VlDI-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 02:15:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dff434c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Nov 2023 07:15:20 +0000 (UTC)
Date: Mon, 13 Nov 2023 08:15:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <ZVHNKk9QUtzFR-wp@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
 <41b9dada2e0b2e713328e6a4d31f713a2d3ffa38.1699596457.git.ps@pks.im>
 <xmqqo7g1tb06.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzNm6I/PaHMAun/U"
Content-Disposition: inline
In-Reply-To: <xmqqo7g1tb06.fsf@gitster.g>


--mzNm6I/PaHMAun/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 09:00:09AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +if test -x "$DEFAULT_HTTPD_PATH"
> > +then
> > +	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HT=
TPD_ROOT=3D"\(.*\)"$/\1/p')"
> > +fi
>=20
> With this patch, my test run starts like so:
>=20
>     rm -f -r 'test-results'
>     *** prove ***
>     apache2: Could not open configuration file /etc/apache2/apache2.conf:=
 No such file or directory
>     ...
>=20
> I find the error message leaking mildly annoying, and would suggest
> doing something like the following on top.
>=20
> diff --git c/t/lib-httpd.sh w/t/lib-httpd.sh
> index 0a74922d7f..03493ee72b 100644
> --- c/t/lib-httpd.sh
> +++ w/t/lib-httpd.sh
> @@ -68,7 +68,7 @@ done
> =20
>  if test -x "$DEFAULT_HTTPD_PATH"
>  then
> -	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTP=
D_ROOT=3D"\(.*\)"$/\1/p')"
> +	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V 2>/dev/null | sed -n =
's/^ -D HTTPD_ROOT=3D"\(.*\)"$/\1/p')"
>  fi
> =20
>  for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \

Yup, makes sense. Thanks for the tweak.

Patrick

--mzNm6I/PaHMAun/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVRzSkACgkQVbJhu7ck
PpTCjhAAnGS4DP0c6IrFlvNN/ayavVtiRunWH/KwDKkF8mVBnAtEXfqoySOoHkIY
jsLKTKuJNUDP3qJDdbz5glZ1XvZm9pLkq3AGlf3fKVlJlRi0YW0KRZG1m0NG6Y0c
7HEx5uwuvhhFiozguFSDGefMQ0+vI34TdVzShz1L/lRPrX/uW3OdYg6WAAlDp/SE
dWSDKdpiuHjjr7UqkXTvvM/nwE//C+CJG9JYbAft8+bAjk+kBS9hciXmbqO24CmR
nFb9mQKz/S5TDa436BOwbRlsqnS9pr6jT47itM/+OMpLqW2gRtrf5JTjseR/IPPI
0/pWTeAHIkdxIB7dylN5d+8x0N1F5N79XHVW2n4MzNcSKl9tYS8B3FT3D8uigVxT
nwL0qEUcq+6KyyxY9L44ndfJNehmSHGft+KtUQ7AgHOvIK78s9aJAIg0XeeE6PJQ
U+DVcijiHpVePC2/ojVxaBeKzDHkDRqplMKRR2TFEPL5jTRWrZTgta9RT75zSRIc
Pn20ds/WUfomhuEY4e5CQ+yKjMj1rssH4lsrXYMxqrVZEtBL9QIj6DheB0vZHm1Z
kBTuaAgFSSoyjeTfjf5uQKGe618ZKuDJIbR1peDtr65dP7NmoojnEA2qwyXU2jfO
72QG031VeL8FJb7J0YXLs3Tfg1uwGZdD+nGa4b+o/vrDwkEcOEk=
=eq3v
-----END PGP SIGNATURE-----

--mzNm6I/PaHMAun/U--
