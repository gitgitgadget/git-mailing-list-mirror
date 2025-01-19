Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8A4A21
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737303708; cv=none; b=qG0dktCHjukwKQMzxcapV6jTwizF+1rUDfEBw1zrxkH2OTGusnLlXD6i6eXFX3wCz+rHVP1EWGjR7ltxo0c44ikAtMZqfBOQs1EjknyQI7ef7pt4tM6Vm3dejcLFRFo+9+3skjjiXY81cBtmrDWfYsc26dI4936+TJ/YcZnnBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737303708; c=relaxed/simple;
	bh=tAZP5z0d0X/atgiJebwxZPhRlyFilVs27TmX4hl61v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvAYeEeym1LuuN/M+iEKJm1Er10yCYLdV+5/0L8lawc2hocGbH3PmUv7Ou128cm16BTfjyWVtZX3n1VRrVcM+7tT0jQG/doEnFUGF1fmV4FkZKLkQWBoskLd+5J+vrWbGtTK/tPegbkLT7GZzJb7G80oJe3g0WRqBjydRVEla/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DbQ7f1Iy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DbQ7f1Iy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737303703;
	bh=tAZP5z0d0X/atgiJebwxZPhRlyFilVs27TmX4hl61v8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DbQ7f1IyocIV7RyTpd1i7w0xSTEMjNllmbxWYHtsGeR7zTYnnCDmdvV0uV3smuomN
	 sk7TuJVSXDsal0MxZndBbqRoVKspZxcMtVsAeAymtQ8tBcSPRVTCDzQWAFekru27A1
	 /XJfTtgfOTnRVcOxWNMwuxSxd9+59qzh+6q98g68u8UP/9ZwGCUSzemDmSDGze6ExW
	 nu5eQlTypS1KilW3w2GjVk7X942neExqlFAM4Vi+WkTZcpGuQGzw9U/hC4uzu/FxoA
	 OwPQL2wQiJSW2tKWso7w82LXHxSvfgNuId+HLwErGO2KwYzOhu23wZAeZ896ds25Mq
	 4jiBrkNbxOCoGYQmbScldAO/VnyA+H40jnjjKPW7U5nnZydumxHfqe+3XM0iyal8Oj
	 8FsUnu0khn3Uu38uP4O4n5AaHvoAjt2AiLnsKbswsE9knQSsRJ2KK9blMR1IdOAVQU
	 f8nvrtETMMQ0kTtuD4CpcFroLKcYDXj/r5Pu+Vq5q6MKGmXT0cO
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AC50120033;
	Sun, 19 Jan 2025 16:21:43 +0000 (UTC)
Date: Sun, 19 Jan 2025 16:21:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Al Grant <bigal.nz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Rebase
Message-ID: <Z40mlmfnUOXI2ghd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Al Grant <bigal.nz@gmail.com>, git@vger.kernel.org
References: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oz63mVm42KbNHm7z"
Content-Disposition: inline
In-Reply-To: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oz63mVm42KbNHm7z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-19 at 05:29:09, Al Grant wrote:
> Hello,
>=20
> I am looking for some assistance rebasing please.
>=20
> I have a feature branch which has the many recent commits and a main
> branch which has not had a commit for a long time. I want to make the
> code in the feature branch the code in the main branch.
>=20
> I think a rebase is the command I need, but the exact steps I am not sure=
 of.
>=20
> I did try this:
>=20
> 1. Sync both branches with remote (github)
> 2. git checkout feature
> 3. git rebase main

If you just want to make the branches completely identical, you can do
this:

----
$ git checkout feature
$ git update-ref refs/heads/main $(git rev-parse --verify refs/heads/featur=
e)
----

That will make `main` the exact same commit as `feature`.  Note that you
don't want to be on the destination branch (in this case, `main`) when
you do the `git update-ref` call because that will result in the index
being out of sync with the commit.

You could also do this:

----
$ git checkout main
$ git reset --hard feature
----

That will update `main` and the working tree to be completely identical
to `feature`.  Please note that it will also completely and
irrecoverably destroy changes in any modified files in the working tree,
so you may prefer the first option, which is a little safer.

In either case, if there are changes in the `main` branch which are not
in the `feature` branch, this will remove them.  What I gave you above
will make them completely identical in every way, including in terms of
history.

If you want to preserve some of those changes, then you do need a
rebase, and the commands you gave are correct.  You will then need to
resolve the merge conflicts in each conflicting commit and continue the
rebase each time.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--oz63mVm42KbNHm7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ40mlgAKCRB8DEliiIei
gdXuAP4sTQBRqIa5gqjilV9bGhPXSG3INhuAkUJoVanHqXboygD8DlDrJeloFpTh
CYemhG5pqTjf/9NGKQc2MIAFej9zZgI=
=6/aS
-----END PGP SIGNATURE-----

--oz63mVm42KbNHm7z--
