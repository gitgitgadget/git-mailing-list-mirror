Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196180603
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450678; cv=none; b=UY8TgfMkbNjJa7Pw8SwMHLJNm8a7IXl9HRX1y7UoKQGpQPyV8v8BsaeB7nbbFj84jj51dAUx7MgYx5HSK+OvQgbBJ3jh7ekhv0q5NCOi06NvQm/yz12tYM1/6sI1Roklr0gQ5I46GztjrUVZxdEJ4PCCwovGELOsazoYef3YXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450678; c=relaxed/simple;
	bh=Frhyv9EZJD81eICY5BHVl7OQBXoz3LT7hG1VzC1y7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT47CEOu51O4vNT1l5D3hXImIojX3zBZf2bmwkwGd1MKND8YNRgyHI8z+Zwc9aROfMykMsyRtpfgalVTGG3mTcYP7OYf3ockERUdrRXoJ7V7ZFaCrSDjCMcbZoyTl3XN86+HqU2v6W5k7VWFlvIoDbdE5RnSM5rgeG12XxbyGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kGX7Skuc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kGX7Skuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1717450223;
	bh=Frhyv9EZJD81eICY5BHVl7OQBXoz3LT7hG1VzC1y7wQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kGX7SkucrJdm98Yj1T5/h1gJ/3NVHtj27vSO4rhWMW4AJFnIGCPJZq6bX9kk7pe4p
	 OnCczVCFftgQ4r2k6H3/RAgnxh5Dd+HDftxkOPzA3mARmu15oPbj8lI2KBe2UCkd4x
	 UioVMaTp8EbWIC19tQjT2B1mxKrZ5bUpzl4U5mHInQmL+YiwODOxssPKxy8CGOGYNV
	 l7/tkk3GSiiZzyGhzrS166072C08u4GJ6jT/Y50v2ep9ETEJ8pFSLWlm6xp9Z5EOxO
	 xMek8qP7LoWZ+T22qk41R+OCUO52FqirBY4j4ezS4cZmhw8qTYvj8/PoEj/JJ30+uP
	 wXzcRH2LHg4fE2b1M7HjzZqYdPs+E7WfnpPYj+5L3N9lY7OpqOwd9tXsBALbd6vY7k
	 NePh889sXMlbAPl6U2+5SbaXUw7MBM15ZvQJqhZbs94UGenPIV+TWkCg7NIv41bxLX
	 SIqbX5P0fy+LWQXUdPOTY8I1g8LQVy6txzDNNnPxnoRtZ722cQy
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 14EC726390;
	Mon,  3 Jun 2024 21:30:23 +0000 (UTC)
Date: Mon, 3 Jun 2024 21:30:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Arundas T C <arundas.tc@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git pull --ff-only errors when git merge --ff-only passes
Message-ID: <Zl417UT7n4-FQ2xj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Arundas T C <arundas.tc@gmail.com>, git@vger.kernel.org
References: <CAKRNJbAnUBmR5MHY=uSF1A3docO-uxWG4agWuFZEyPUnduyWHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va/A2ug7Ux4/5XFC"
Content-Disposition: inline
In-Reply-To: <CAKRNJbAnUBmR5MHY=uSF1A3docO-uxWG4agWuFZEyPUnduyWHw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--va/A2ug7Ux4/5XFC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-03 at 06:28:41, Arundas T C wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> 1. In a remote repository, have a commit that's only in remote at the
> tip of the current branch in local.
> 2. In the local clone of this repository, edit some files and have
> unstaged changes.
> 3. In local, run `git pull --ff-only`.
>=20
> What did you expect to happen? (Expected behavior)
>=20
> Fast-forward the local branch to match the remote branch, similar to
> `git merge --ff-only`. Handle any merge conflicts the same way that
> `git merge --ff-only` does.
>=20
> What happened instead? (Actual behavior)
>=20
> error: cannot pull with rebase: You have unstaged changes.
> error: Please commit or stash them.

This indicates that you've set pull.rebase, so a `git pull` does a fetch
and a rebase.

> What's different between what you expected and what actually happened?
>=20
> It errored out because of unstaged changes, even though doing `git
> merge --ff-only` will correctly do what's expected. See below.
>=20
> Anything else you want to add:
>=20
> After doing `git fetch`, I can do `git merge --ff-only` and this
> fast-forwards the branch as expected. Isn't `git pull --ff-only`
> basically the same as doing these two (fetch and merge)?

`git merge` doesn't do a rebase.  It does a merge, which can sometimes
be done with a dirty tree.  `git pull` _normally_ does a fetch and a
merge, but in this case, you've asked it to do a fetch and a rebase,
which has different constraints.  The result will almost certainly be
identical (since it's just a fast-forward), but rebases typically don't
allow you to have a dirty working tree.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--va/A2ug7Ux4/5XFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZl417AAKCRB8DEliiIei
gUtuAQDfYjY42NMiQxWsbHQXAAGUBhuVpxN4CEy5Jco4FHi6nAD8DfOU9LQv//+1
++2BRi/nm5WUuGgeCV27XoMhv/1KpAg=
=4w3a
-----END PGP SIGNATURE-----

--va/A2ug7Ux4/5XFC--
