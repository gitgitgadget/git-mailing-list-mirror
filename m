Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077517A58F
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976526; cv=none; b=RtktJdfFuHYOfIBMJUn/Rb7L1t07OwSkmV47Qeoxhr2JN9zPzdzrPp3rV+yk30gO/iA2G95sJKZ+/t4S0mxxox2skMmfl+Kxxo0lt+Sl8B9m2khcUSg3qK2Kh2/CYmBBuVySoxaiBxzMv46uXiBM73srdwF+4aTjPY8Ku67+3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976526; c=relaxed/simple;
	bh=jQeJ+c9Xu+aEHQh8qbhp+Xu6oizqFCZAY9qg/3n0wEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvkOIgRyBYc2jsNd8ZYuH4PkOi8AvvYmkOYDNdb2i/FeaZUhwaRTx5qjrVEsEON8TlNA0x5BNPfsd8qJoSERGw+un1m3McE43LdDLDDuEuDp+cqgCIGNQeUk6XKpSbldCXr8TzV7MFpoq5GP25jZ1MvMgXJ6JGURJQR9FGG76xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=k3hTcxm6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k3hTcxm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730976518;
	bh=jQeJ+c9Xu+aEHQh8qbhp+Xu6oizqFCZAY9qg/3n0wEQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=k3hTcxm6VesoVS8RKQSYO+V5rcew7aQQCeHBdAu1TvjU9jiG6EgpLu+wImD0ZLfIC
	 QjB3n2vsh6H+nY4o/Uej34hrO1A0fB3t7nza2ydvl7zoRvhkgSI2MSJcdB8DXgmwrw
	 OeCvCdcKbSKVx5p61cmiTXYDLfq8k3nMwZ2f17km5fSC5BFAJoO4M5UwJhUk+59Yq4
	 i0lrs/6DYhb+W9ZZYBr+/TnIE2HXXI5AOOu3jFrKPApEe3WHjJWkAB2jz8EcFZghm/
	 +ZCc8j0XOaLN88Q2nrOvM5HzOzx6Ez4Hve8FB/SABUtVmMwfB8PoLNE/YaPIdXKbz3
	 74qR4qeyk4xRR4b56gw2Dfe4AFVIhs8HYDKBqOLoUv7WFrRYxUHA/NGScWEzyJvRBZ
	 BZcUljlHMgiPUcfeqPPo2acxFk9ctw3BT7lc2ScMHayznxPFpSH0GTUpxpflWdTGlS
	 k2xPY4anmjE/oWCyGV544GqwNQBnYieo/j3MdPYw5sbnp1K9a0S
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 33BA9200B8;
	Thu,  7 Nov 2024 10:48:38 +0000 (UTC)
Date: Thu, 7 Nov 2024 10:48:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yarden Bar <ayash.jorden@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: gpg-ssh signing with AgentForwarding
Message-ID: <ZyybBPigKZ_MlnU6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yarden Bar <ayash.jorden@gmail.com>, git@vger.kernel.org
References: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sYR5J993m4lpHNPF"
Content-Disposition: inline
In-Reply-To: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--sYR5J993m4lpHNPF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-07 at 04:16:34, Yarden Bar wrote:
> Hello Git community,
> Not sure what search terms I haven't used, but I'll try to describe the u=
se-case
>=20
> On my local machine I have a SSH key, and I use AgentForwarding when I
> go out and about to other hosts (dev machines)
> The usual workflow of using the forwarded socket works for pull and push.
>=20
> Where it gets pitch-dark is when I try to use my ssh key to sign git comm=
its.
> Following is my git config on the remote host:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [user]
>     name =3D John Doe
>     email =3D jdoe@jdoe.com
> # on my local machine(gpg-ssh signing works): signingkey =3D
> /Users/jdoe/.ssh/id_ecdsa.pub
>     signingkey =3D WHAT_SHOULD_I_PUT_HERE # on my laptop its the path to
> the public key from Secretive, or just omit it?

I think you want something like this:

  [user]
      signingkey =3D "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0=
SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"

You should use your own key; that's just an example.  Note that you want
the public key (that is, what's in `id_ecdsa.pub`, not `id_ecdsa`).

Once you have the key in the config file like that, with the "key::"
prefix, Git will pull from the agent if necessary.  I do that for
signing commits using GitHub Codespaces, where it's easier to forward
an SSH agent to the remote system than with GnuPG.

This is documented in the `user.signingKey` entry in `git config
--help`, but if there's something there that's unclear or you think the
text could be improved, please say something, and we'll try to get it
fixed.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--sYR5J993m4lpHNPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZyybAwAKCRB8DEliiIei
gbu8AQC8mdYk8G/3mFNuIPHyIRrgDM8Q2pBeBU/DDitBv+FkfwEAoWQKoNJAuhUU
5MqXhekTnJVD1+9hFYVxTN1m9z4CiwA=
=FGlC
-----END PGP SIGNATURE-----

--sYR5J993m4lpHNPF--
