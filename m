Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6716F908
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864886; cv=none; b=e51w7RknVg+59MHJ+ENEtcchw0vkiNtpZibaHq7TJRTxkOVgHKUhCYyhaQvGODfakgo/zgsh2HzNc+DJtKs764znjXL0qSm4PMh/SpqBWYEsyHXGnL8SEZ25tLXutS2KxESSWKmWLZ2RSgMFZk2JILU4ygO9jZmnnhgThP7cEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864886; c=relaxed/simple;
	bh=Z59ci9ye7F9B/8xx0ZXz4kuVyme9iDeHwGZLNo/vVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xff6xXgozPRm2nFpf/TTrsaB4Kvu0sN1XyoD/juaSbVr0ZDAR7iL4G13vRrRq+CdpQUWpa2k5UWMZWqZiYSlXLVFlHHTDmIKn4wDQXJTBM/BxWjeM9z5jxAhXsWCCSqQPKYnz9HixpMzC6CSgNoGtGS0plkXgywuJhLJsJI8C1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T08W6kNx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T08W6kNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719864882;
	bh=Z59ci9ye7F9B/8xx0ZXz4kuVyme9iDeHwGZLNo/vVcQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T08W6kNxNxPRAAmesGN5NcxDgFqce6d2YOFiyD7A9uQeDWMhwp8DtnMvrq74WsxUH
	 4Eu09WF+40t7SayonxOlol2A7NIdVNouSWbPfH3HoIuni6TT2T9LjVnJNOTm2LSHN+
	 NsufmnSEdXzMiDtUjlM0q3B0digWSlFKtgNm7zTmA/CkR4v0MCLspousETXNXCOhAx
	 6JmtGGlRxMJMOW1fUQJXd8YB+XZVVVimQgchroNgnx9UUiJPt144Vji2FRDbfidrF4
	 HjCuU81DuyHxRQg/usiU0M6S/7PXgJVctPmqqvQrws98zeLDNtuiHTYQkfKPo/PMMs
	 Qk6YkwvHcsK2UNR+0ttPj0NsRjijDBrUf8aVMS8bClPLst3AWUMycrSmn8FDw24kG6
	 BwN1Q+plIuplOmNffAiSeMXHfngqf8VSdtWP/c6D3Hqee9uN7sZTfeP3vKHfLrOTu+
	 lx5o2tBY+XMaNkTrEdong8Qn2l+qC/d+C5616WVhWW2GaCPEr+K
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7266420992;
	Mon,  1 Jul 2024 20:14:42 +0000 (UTC)
Date: Mon, 1 Jul 2024 20:14:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alec Sanders <aws022@bucknell.edu>
Cc: git@vger.kernel.org
Subject: Re: Trouble with Gaia binary files
Message-ID: <ZoMOLz--NK_U6sst@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alec Sanders <aws022@bucknell.edu>, git@vger.kernel.org
References: <CA+Gods=0N9yYZ2tMSiV2GRO2uwpQTvvWB=Gcv9CfS4XrMYWN=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kki9hNMFOyJVQ09o"
Content-Disposition: inline
In-Reply-To: <CA+Gods=0N9yYZ2tMSiV2GRO2uwpQTvvWB=Gcv9CfS4XrMYWN=A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Kki9hNMFOyJVQ09o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-01 at 15:34:04, Alec Sanders wrote:
> Hello,
>=20
> I am running into an issue with Git and Gaia files
> This error persists when I perform a git checkout or git merge.
> The error is as follows
>=20
> error: Your local changes to the following files would be overwritten
> by checkout:
>=20
> *Insert filepath here*
> Filepath directs the user to the project folder and within it, Assets,
> Gaia User Data, Sessions, ... , Terrain data, etc
>=20
> Please commit your changes or stash them before you switch branches.
> aborting

This message isn't particular to any given type of file.  What it means
is that your files are modified in the working tree and the operation
you want to perform (a checkout or a merge) will modify the working
tree.  Because doing that operation would destroy data, Git asks you to
do something specific to make your working tree clean before you can do
that operation.

I'm not familiar with Gaia, but in the case that you're using Git LFS,
this could be caused by using Git LFS incorrectly, whether by you or
someone else, that can lead to files being perpetually marked modified.
If a file is tracked as a Git LFS file (that is, the file type is listed
as `filter=3Dlfs` in `.gitattributes`), but someone has checked in the
file without installing or enabling Git LFS (that is, as a regular
file), then the file will end up always modified.

That happens because if the file is updated in the working tree, Git
tries to run the clean filter to turn it into a pointer file, and since
that differs from what's in the repository (which is the full file), Git
marks it as modified.  Attempting to check out or reset the file causes
the same thing to occur, resulting in the same situation.

In any event, if you _do_ want to keep the changes, you should run `git
stash` to stash the changes, and then checkout or merge.  If you _don't_
want the changes and you are really certain you want to destroy all of
them, you can run `git reset --hard` (this really does destroy them, so
be careful).

If you have the Git LFS problem I mentioned above, `git reset --hard`
will not fix the problem.  In such a case, you will need to do `git add
--renormalize .` and then `git commit` to fix the state of the branch.
You'll need to do this to every affected branch.  You can also run `git
lfs fsck --pointers BASE..HEAD` (substituting `BASE` and `HEAD`) in your
CI system, which will exit nonzero and print an error if someone does
this again.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Kki9hNMFOyJVQ09o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoMOLgAKCRB8DEliiIei
gYRzAP9Ug92TL8ibgcFGghLX4TiFLoKKkI5E4kVGLolZLbC7nAD+LMkYNiOINTrV
K4kc0v7ZCauw3ZG3stsQ9Ujj4lve1wU=
=f2JG
-----END PGP SIGNATURE-----

--Kki9hNMFOyJVQ09o--
