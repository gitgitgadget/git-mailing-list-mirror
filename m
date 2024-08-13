Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE956766
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587506; cv=none; b=NTDN2j/8ceivkShg0wupUKKqkBHnulSR/er+IBSD4HxX6mYD1y+E1POhvNL/Q6DQAdu78bOYRE2gljOZvVqG1upJzMPQpLo3H2FhTQD+c/aYo8R+EHZARkJFJ2yorD7QpjJTvJ2p6/qBAIzGJJFXh9c7Cs4oF78pgwNTSKC1s5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587506; c=relaxed/simple;
	bh=+y86pOTm7WalyCo2yD3LPFWECmt59xdXxvrc20qCKpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DarrIRw4aMmZ/KdYWO0snYeciKTAA2HOvGNLdr2zqg6ik3WEloWc038HW0KMWK5tK64CcuWlMOcqEKGFVnrEIDNfqrW917ga3mjOZADYQID7CneAZYN5MZolM8JA8VoY9zjGHjRqIKWit/So0Dl5/XRt5OhmDH+7GsXqrm21XOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Rug7VblS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Rug7VblS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723587496;
	bh=+y86pOTm7WalyCo2yD3LPFWECmt59xdXxvrc20qCKpc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Rug7VblS/I76d9tP0hyaU9ynOfims7krWE0TzvfKUcS7IAPpKenm5iaPw5c7mZN5+
	 dH0aLgaoo4XnKiFA8oez6b+mc+J4rAeJ3GgcJCdpuhqe0z90bbHgPSbZgNOnriWfzg
	 MGfp3lbIN0Y+soAliPbWR85p6gfeUMn+8CIffifRHKTHGqsC0EYP8R6HRixUs3xh/L
	 N9iqhRDiEgAmr8sohBPn7+DvZLt+v4yUEdj8U/0wNH0XM/JeCqjn+aGu134PDJImxz
	 ZwmxbzrSBbn59fDH83mbaHMOZOPpiisMAp5qoQ3md40Mhgv2K+w8OCE5ljJcKVMjwd
	 9cuodNXGkxti3+kTjaYkeO8i4q1okAsq9+wsZdfbWA7QwpbdqnamBhOUpgBzGCintD
	 oKLA8wVgQF8xZnwUrwfwUyAVdsbuOH9Ezi8oJP8BjZ2fMGfkj0Sq2wqUNMcQ/OmUmc
	 xu6qvCcbpS/4L0VGfwoCmys6iujS/QsA8fdeuHAFTG22Mst3mgr
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 239C4209AF;
	Tue, 13 Aug 2024 22:18:16 +0000 (UTC)
Date: Tue, 13 Aug 2024 22:18:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <Zrvbpt3Fkl8yjesP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
 <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>
 <20240813-sociable-fresh-whippet-3ee335@meerkat>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a88BTxpG2GF/8yj1"
Content-Disposition: inline
In-Reply-To: <20240813-sociable-fresh-whippet-3ee335@meerkat>
User-Agent: Mutt/2.2.13 (2024-03-09)


--a88BTxpG2GF/8yj1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-13 at 15:06:13, Konstantin Ryabitsev wrote:
> On Mon, Aug 12, 2024 at 09:16:56PM GMT, brian m. carlson wrote:
> > Gmail and Yahoo have both set up new requirements for senders[0].  This
> > requires that all senders have SPF and DKIM, and senders sending more
> > than 5000 messages per day have DMARC set up.  One-click unsubscribe in
> > RFC 8058 is also obligatory, as is TLS for sending messages.  These
> > changes came into effect in February 2024.
> >=20
> > I don't believe vger uses DKIM (at least, it doesn't appear to add DKIM
> > headers) and doesn't support RFC 8058 one-click unsubscribe.  Perhaps
> > adding support for those, as well as any other relevant requirements,
> > would improve things.
>=20
> These guidelines are only applicable if vger was the origin of the messag=
es,
> not a forwarder. For forwarders, it is only required to add ARC signature=
s:
>=20
> https://support.google.com/mail/answer/175365?hl=3Den

The article you linked still recommends DKIM.  In addition, the article
I linked doesn't appear to limit itself to non-mailing lists in any way.
It says, "email senders", and a mailing list sends emails.  In fact, it
explicitly mentions "[i]f you manage a forwarding service, including
mailing lists or inbound gateways," so it still appears to cover both
cases and apply to all senders, with only some additional requirements
applying to forwarding services.

In general, adding DKIM (whether or not ARC is supported) _will_
dramatically improve the deliverability of email in general, so it's a
win overall.  Adding one-click unsubscribe would also probably keep some
of those unsubscribe messages from hitting the list since people could
automatically use the functionality of their mail client to unsubscribe.

And from a personal point of view, it is definitely useful for me, as
someone who manages their own mail server, to heavily negatively score
all email without DKIM, but I can't do that because vger doesn't add
any.  That's the only thing preventing me from doing that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--a88BTxpG2GF/8yj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrvbpQAKCRB8DEliiIei
gf/3AQD1hZImfWnsm1sDyeNmGU9olLdxOnv/IS3vTbtih3W6+gD/UWEQBVlpPNzs
P0tX4ISE0QgnR9PJ1BJMqcjtc8VuxA4=
=8PgB
-----END PGP SIGNATURE-----

--a88BTxpG2GF/8yj1--
