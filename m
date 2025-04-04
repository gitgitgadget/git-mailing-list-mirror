Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E212E62B4
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751893; cv=none; b=KYfRcxXNhXaWVPCuehZAafdtyZWWnAZiesyPWxEkGWWNvvoUzIXyKsDA8S5gZMz5AlEwwr/oV9J+us3WGDwrnEWPKmepqQLp7afICfiZu95SSgk7AsmsqNbl3NNNOubULjJ1ucBmdsTbKGx1CsCfYvjgwiXilTsWA8uv7wymXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751893; c=relaxed/simple;
	bh=/hgZQeg4rEwN0ja8wK/lMiwKm4MYtkmX0lugTPcE2Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5S19aX8Ls0qv6yL507zpaWj4wuW5bDw64tZeRb1caPfs1W7LxncS4aDHNp4Ftnp9uI+dHyo39iU5h6TLkMrPPxvnIkp1oCQwPGfd3QXo/wtTYGLzEJa+TeOGIfnE4VTMe2AMfHCLKiYXE0JbhCC/tCixpUllhG9QLYmqK3LrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QrUDXiaS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QrUDXiaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743751888;
	bh=/hgZQeg4rEwN0ja8wK/lMiwKm4MYtkmX0lugTPcE2Yk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QrUDXiaSGtkfBKRj/NGJvOoPrL2/yzgMX1y3p4UO6BA2IR6wnPPkJYdgVaFRHuHTS
	 mqJLQcIHa62nh40C0FRQ/nxP9sUnQl8P7d8uSJAzbHZoZnFFq2Zx6nXWDGufD2XhVc
	 xjj34Hh4K1FZZX27LcKql7cK/JF5Wg8ksWQM6oKYoUccxAA6SwfcpUGFCAwQMebVpG
	 sMqvBH8JlXXLaHM2P/c9OZCisrSjHwa4kPMPWtLLtCV9GcYnT32Hcykb0adRkDB1+i
	 IJbt0Mv8I7B4jXIiQ06AKUxAeaTN3YryTxN5zfaslMadm8tgDT1e3FlqJLhezgZzuF
	 EK5v5Dn7HQfy/eVni5+ip1LXfDmfRmEmsZpF971s01h2oXwvddYtnQno6z1HvJosre
	 p9YiwZWUd7n2PO5LQBpH5ou63IX+ZrNKqNFLZTg/LyZwhIPFIJu7FYLmr0McadKTHy
	 nU191NPLsD5j9ZWXWBKkA8BYfzOUo+rgVddXBaqS9CmD4Du3wID
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7DC2020102;
	Fri,  4 Apr 2025 07:31:28 +0000 (UTC)
Date: Fri, 4 Apr 2025 07:31:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrej Zhilenkov <azhilenkov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Update symlinks after changing core.symlinks
Message-ID: <Z--Kz4jsRzm4VSZd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrej Zhilenkov <azhilenkov@gmail.com>, git@vger.kernel.org
References: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
 <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net>
 <Z-8K9ZIt4j_UMNZm@tapette.crustytoothpaste.net>
 <CAArAzAr+YPwVXJo8mjkyQG8uWv=wt89tYyp6TL-rNzvwVYm9YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ED9sk9dUhVhIPGHi"
Content-Disposition: inline
In-Reply-To: <CAArAzAr+YPwVXJo8mjkyQG8uWv=wt89tYyp6TL-rNzvwVYm9YA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ED9sk9dUhVhIPGHi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-04 at 05:51:21, Andrej Zhilenkov wrote:
> Just recently started working with symlinks in git and I've found that
> in Git for Windows they are disabled by default
> (https://gitforwindows.org/symbolic-links.html).

Yes, that's true.  On Windows, symlinks require elevated privileges to
create by default unless you're in Developer Mode (which I highly
recommend for Git users and developers).  That's the main reason they're
disabled by default: because they simply can't be created in many cases.

> It's possible to just change the setting in system config or override
> it in global config, but it's probably safe to assume that the average
> Windows user will have them disabled.

I think it depends.  If you're working in software development, you
really should have them enabled and many users will, but I agree some
users may not (say, because they're in a corporate environment and
they're not permitted).

> And if your repo needs them, it's probably more reasonable to ask the
> user to enable symlinks in a local config, not global.

Ah, there I disagree.  I think if you have privileges to create
symlinks, you probably want them to always be enabled, and if not, you
don't really have a choice and they'll be disabled.  My experience with
using repositories with symbolic links is that typically they don't
function at all (or, if the maintainer has taken great care, only with
greatly reduced functionality) if the symlinks are missing.  I think
Git's repository is by far the exception here.

> Maybe there are similar cases but on Unix when users would want
> `core.symlinks` disabled globally and be enabled on a per-repo basis
> but I can't imagine why.

I have certainly seen cases on Unix systems where symlinks didn't work.
For instance, they don't work on FAT-based file systems, and I have also
seen a Linux distro that tried to restrict symlink creation to work only
when the creating user owned the destination file, which breaks Git's
symlink functionality (I quickly demonstrated this "security" feature
could be trivially bypassed).

However, I don't think there's generally a situation in which you'd
_want_ it to be disabled globally.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ED9sk9dUhVhIPGHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ++KzwAKCRB8DEliiIei
gcoKAP9kZl1ouozUCsu+fMHXak683Ik0ENnek/LWzD9n51yFmgEA3ReJoxQr4viF
lXRQJ9hGjFpWsClqhERdcW445ky9mQQ=
=ViIl
-----END PGP SIGNATURE-----

--ED9sk9dUhVhIPGHi--
