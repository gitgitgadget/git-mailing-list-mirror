Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A07603F
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056345; cv=none; b=tqPIVAImja1sI5X7H5F3PDai31/OIqyXfCYTH/Fp1nKU5ma62ktDefwjVHlUjldQBEZmMUoiq6s1PhF+IXEeZCY6yxc4nkLGTROrEZrL1O1gySMlYDUvADPQ9ug8Wk57yv1NcuqGGgvsMASGIHLndO/ODxGC3ICs/kaRUBSJneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056345; c=relaxed/simple;
	bh=+ef+C3sYsG2BdZ0uD0XEIuZeha65oHyP2P6x16R56TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE8K6IASCoJzrG1D5PwPlqVxREBTeFIiAEcbfUlFbKSErI3OxuEt9gzVmhm8yE4DtrS2OB3ZkmplfIyAHooCMxx6PwB8Vba+MlnxB7v8rTr8cawj+AihwtG5NIeCFLtBcrJ06Nn82tID6FaOqjYhJM6WHCJG34w6+0KJAjiteic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=B4AsbGvb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B4AsbGvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718056336;
	bh=+ef+C3sYsG2BdZ0uD0XEIuZeha65oHyP2P6x16R56TU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=B4AsbGvb5QOVvOYIxtBQ4ewA62321+tobv55Ia+hP6csVvyJxLYsGiJ96QlpJaqHP
	 PIPjXT07eefeuL+GcjYTzzAcWvQ4g6gkH18tQ/xXUvOt/mNgCxEyVvKiAwP6EPlWYW
	 +LWgfehdZkTOaFIArcnaiQ3pyDVVTcvpqsQYYeI0Gq6grtToQdNX9CJ4ULxPMOJ4FV
	 OnDef5p6vTrQ+/sgDLYtujqh+B0MrVu9g6wHYgddo0LyDN7REsxD5PovmdlXb290IU
	 5FNkPSxkReQQa9olc5FyQTGu/UFiyI4vhqyb3CYa6K7pH6yauXboGZeiUGV090F2UP
	 PwHQF3SNszQC5PpAtkHcuNu9lf5CRtKOJYNFDjQkNDdB+7MjuE9deCdFZ0lD0qxeU3
	 ifA/+67hBWpUDgPXtIqojiIkbbYa2Os6hJJZZLOzDpiloDvBkxbeCb3UDvu0GzPLeV
	 B2JmswDHmS33tZOb3BVEWE0DCcjfPQQJ4bEghVkX4VGioZ41lP8
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B3A022639A;
	Mon, 10 Jun 2024 21:52:16 +0000 (UTC)
Date: Mon, 10 Jun 2024 21:52:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
Cc: git@vger.kernel.org
Subject: Re: [Wishlist Bug] git-shell: Support libreadline
Message-ID: <Zmd1joZIqo217TBh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc-Jano Knopp <y--gitbugs@marc-jano.de>, git@vger.kernel.org
References: <tovyij5wnnliqqn443n6ksjrnwgs7xthopxvqlieacix7jjdqg@2mnwgzlpj7fo>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RJ1IOuGy5c5c+qSw"
Content-Disposition: inline
In-Reply-To: <tovyij5wnnliqqn443n6ksjrnwgs7xthopxvqlieacix7jjdqg@2mnwgzlpj7fo>
User-Agent: Mutt/2.2.12 (2023-09-09)


--RJ1IOuGy5c5c+qSw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-10 at 13:42:42, Marc-Jano Knopp wrote:
> Hi all!
>=20
>=20
> I would like git-shell to support libreadline:
>=20
>   https://tiswww.cwru.edu/php/chet/readline/rltop.html

Unfortunately, I don't think we can do that.  libreadline is GPLv3+, and
Git is GPLv2, so it would violate the license to distribute a binary
linked that way.

It's possible that libeditline could be used instead to provide similar
features, though.  If it's important to you that this be implemented,
you can send a patch, or you can see if someone else is interested
enough to do so.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RJ1IOuGy5c5c+qSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmd1jgAKCRB8DEliiIei
gQ6iAQDh1mWqgFTnTyIoCOBiOf5XXqQCkNj5SN9XNd2vBKCvAgEAvzB1EHB+z5HJ
iZKzcFqm7RPoWSe8/jNb7xih7R7NtA0=
=p9uO
-----END PGP SIGNATURE-----

--RJ1IOuGy5c5c+qSw--
