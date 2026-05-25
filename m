Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C81F4CB3
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779747504; cv=none; b=VO1fJ1EdNfpQ9YspfY6O3mrx/xiU559pCeaSM7wAPKzphN0oUm1331zcP0nMhcNnag0+0HnrjCgVwd/voLdWOCAqh8tzBE7fGtRQS+5YB5Nckfj/b+szMxfnlIIdOb+HaDx/YZShjYZH7qGim16onSmi8snkm+C6x68E3kfGPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779747504; c=relaxed/simple;
	bh=QQvbRAAJMCC74Dfhc2J/0Dto8bSkYMPSb1CVtkpWbdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA/f3GYTJYYfs9PIhJs4GWdbr5bGQGN2Oq4ayykjt+3HzkKV/lqOIX99TriqX7Ga98l6TcjrZen0UPK8RZyuPqab4FxbmrIeEb/eRFAjugPJXsuEv1nam1CyTGT0byr1+cU7iB/bO9mis8wj5MX7iVPA7h9M8ALCZBP1pMR7b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YkgpPka5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YkgpPka5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1779747501;
	bh=QQvbRAAJMCC74Dfhc2J/0Dto8bSkYMPSb1CVtkpWbdo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YkgpPka51zaoP0zqrnn/vzKVAMpdzIai015G0pCl70cKSAsUZUgjZCB5qDoUN9BKP
	 Qn154aYtKaNakC4el0xJNsYbisZG6cdL0/evsKEIQY7+1hhXXb1l0ldnGZhEuuFWR3
	 4ah5jXRVgKdA22nYMZAVABfqvE9IMzFxokvxvI35bTji7lYDIbv2cj5fdtSYsEr7sz
	 TpsnEOR2JWPtbYCY42WY0sGsmJLO7B1MP+F+ZRNUlO551wEfae2ckGviiijTOuXU5X
	 fNmyzsZrsex6MmFO6ddSjB1M3Oy8YkL96qQ7ULJb3rFG1ZBjwzejZTBWBF0hYMTH0l
	 7oUiwtSmwwjENRGH5fW9qWnbRfZ0+P6bBhA/JMbWf0ICAEPD1lhKD9zNnu2nSfc46j
	 HJVJVvhnL2bzeu6gqfRZTdkt1b551h7UCSyja5zRc/xQEuXDUG+c+VamD/PdQ2L6L8
	 qQxJyRNqzIthZ0BZfvDU0yBCiR/3Xx5E6JLOL4QuMrhLBa4pwnp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4762:abe:10d6:485])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 352162007E;
	Mon, 25 May 2026 22:18:21 +0000 (UTC)
Date: Mon, 25 May 2026 22:18:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Amogh Dambal <amoghdambal1@gmail.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org
Subject: Re: Expected test suite behavior
Message-ID: <ahTKq_zCmEDJpoN5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Amogh Dambal <amoghdambal1@gmail.com>, Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
 <20260525072711.GE2737798@coredump.intra.peff.net>
 <23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ficy+Klwt70wF0oJ"
Content-Disposition: inline
In-Reply-To: <23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ficy+Klwt70wF0oJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-25 at 22:01:23, Amogh Dambal wrote:
> `GIT_TEST_OPTS=3D--verbose` was very illuminating. I captured STDOUT/STDE=
RR:
> `make test GIT_TEST_OPTS=3D--verbose &> git-test-verbose-fail.tmp`, which
> shows that almost every test fails `check_config` because a `git init` is
> creating a `.git/config` file whose executable bit is set:

What are the OS and file system on the host?  We tend to see
executable bits set when NTFS, FAT, or other Windows-adjacent file
systems are used on Linux and you're mounting `$(PWD)` into the
container as a volume.

> --
> Initialized empty Git repository in /root/git/t/trash
> directory.t0001-init/plain/.git/
> plain/.git/config is executable?
> not ok 1 - plain
>=20
> [...]
>=20
>=20
> However, I'm not able to reproduce this, e.g. directly using the local bu=
ilt
> binary seems to work fine:
>=20
> mkdir -p /tmp/debug && cd /tmp/debug
> /root/git/git init plain
> ls -alhrt /tmp/debug/plain/.git
> root@ec94ab1b260e:/tmp/debug# ls -alhrt /tmp/debug/plain/.git
> total 24K
> -rw-r--r-- 1 root root   92 May 25 21:26 config
> drwxr-xr-x 3 root root 4.0K May 25 21:26 ..
> drwxr-xr-x 4 root root 4.0K May 25 21:26 refs
> drwxr-xr-x 4 root root 4.0K May 25 21:26 objects
> -rw-r--r-- 1 root root   23 May 25 21:26 HEAD
> drwxr-xr-x 4 root root 4.0K May 25 21:26 .

Git doesn't use `/tmp` for most files in the tests.  Those are stored
under `t/`, so you'd want to create your test directory there.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ficy+Klwt70wF0oJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoUyqsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1V8Yfq3ml9OGGyFOnwxKZNl7C+zXiz3Ow7+d23ihgjh
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAsAAQCbT5pz7IujoogUa6WVHcXKpC1e
lj0jMha5zEfM4xwudwD/fuRnIj3QE/UdKDkscxkczjaCJCnhNhdKv/mJqJDUZgk=
=LC9x
-----END PGP SIGNATURE-----

--ficy+Klwt70wF0oJ--
