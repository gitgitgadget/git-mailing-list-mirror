Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CE28EC
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736011159; cv=none; b=MUuywQTpSVRYLq92a6mm9TjeJok0RpJmr4Vx915p+N2UOhAnrANUaflDbEK1dmpODnMHXoUd98ymeuWOPDVmoXN7FdUNFk8E1vW2OHahbFiebc1wsIksDTvHVAg+EhMLk4jHRqOrJIMbfRxx4oU/jtiGiC/qSlO7WJzURF4TC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736011159; c=relaxed/simple;
	bh=3kNEY71WV42w37Dqs9+cdYK7hsvpjl0Odo/hzJE4t8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+G+ZmIrE4u+lV8bRVjkYo4ynjlxJdgbZrOVbHtFVU0NX0EpWQJYMjv19Du/rgHdzPhPkvAqkYfx2vGqlzJCm4+5FMQid/phdv/PcHtI3r2B6pBObFOsh7EPmQNW6brju3bh1kYXO/hetopTLRIGLAVx0wzh6jfnfkgXw0vnCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IRkBFHMf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IRkBFHMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736010790;
	bh=3kNEY71WV42w37Dqs9+cdYK7hsvpjl0Odo/hzJE4t8U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IRkBFHMfdjdmH6v3gx0ZNs3X1z27GEWLmUvBtI3tQSuIWHVJEUitBxhpCdV1QsCuf
	 eH6fOeZn+tXwIXiTSBFcHmiFAlQmIbvGOOF0y5ZkPmPVKvgpnuj2CkmGXHCGFlU3UG
	 7xHKJnmbn0frAmK3Afnb30zKlmtOgne2LzSsTDgxQuI/CFljDzZEl6rwi+27uxvN9e
	 wiXgZ2OyNZDFvhJ9AJJA0Ido9Bd8Ix550M8+cYkM0rwT9o55esDUnATviGnAxvaIMJ
	 us8Lu2YYBCsbUKZJx1OeeQRRx7j+n2SOX0oCzmHdeGh4ekrQbnp1iAQzWNx/YUQQaH
	 GJqSmKhEFGmgm46cJHWt24XHovN0XQ/ARxpNk9Zj1XS9IyCpAYdp0bddhb3d3yB4P5
	 lOnJOelj6Gn3YhmwpJqi+rCqcmJjbD8hWZkZD6zaSBeso+EG3e6LO6omnHV92EJjIS
	 on1lxrt99N3LfHbTjtRb0Sld9VkjkPrto+wYiE/qO5VvY5W9ita
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 83406209B7;
	Sat,  4 Jan 2025 17:13:10 +0000 (UTC)
Date: Sat, 4 Jan 2025 17:13:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Youtian WANG <wangyoutian@msn.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Full absolute path in a commit makes checkout fail
Message-ID: <Z3lsJZt-9N9IWoe-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Youtian WANG <wangyoutian@msn.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <TYCPR01MB1173678128DCC128099726865AB162@TYCPR01MB11736.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QMKAb3UraYtFHjYw"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1173678128DCC128099726865AB162@TYCPR01MB11736.jpnprd01.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--QMKAb3UraYtFHjYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-04 at 14:21:46, Youtian WANG wrote:
> In a commit of a public repo (which might still require a sign in using g=
ithub account, etc, due to possibly the service maintainer's configuration):
>=20
> https://gitee.com/whyyouteach/erg4eye/commit/f5e2c1ea25aaee24868a1790cf59=
ccd0a8288c3c
>=20
> , a file of full absolute path (including the volume, also known as drive=
 letter, in windows operating system) shows up:
>=20
> C:\erg4eye_3\xiangxun23080202=C2=A0
>=20
> ; I'm not sure how that path gets into the repo, as this is a repo for a =
pack of students. Maybe it's due to a 3rd party tool, or a direct upload vi=
a the web page of the git service.  I noticed that in:
>=20
> https://github.com/gitkraken/vscode-gitlens/issues/932
>=20
> , some similar issues appeared involving a vsCode extension for git.
>=20
> I cannot checkout outWith the above described commit; the error message i=
s:
>=20
> error: invalid path 'C:\erg4eye_3\xiangxun23080202'
>=20
> ;
>=20
> My question is:
> 1) Per git design, such full absolute is not allowed as it might be out o=
f repo, right?

This is not a full absolute path as Git stores it.  Git uses the
standard Unix slash character, and only that character, as the path
separator internally, unless you're on Windows.  So this is a single
file in the top-level of the repository called
`C:\erg4eye_3\xiangxun23080202`.

I'm on Linux, and I did this to test, and it works just fine:

----
$ git init test-repo
Initialized empty Git repository in /tmp/user/1000/test-repo/.git/
$ cd test-repo
$ touch 'C:\erg4eye_3\xiangxun23080202'
$ git add C:\\erg4eye_3\\xiangxun23080202
$ git commit -m +
[dev (root-commit) 0d1da07] +
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 "C:\\erg4eye_3\\xiangxun23080202"
----

Now, this clearly won't work on Windows, as you pointed out, but nor
will a file called `aux.h`, and we wouldn't want to exclude that from
working (Linux contains such a file, for instance).  Windows contains a
variety of filenames that are unacceptable for various reasons and users
not using Windows shouldn't be negatively affected because of its
less capable handling of filenames.

I assume you're on Windows, so you could try using WSL to verify that it
works just fine on Linux, provided you do it on a native Linux volume
(and not on a Windows one).

> 2) If it's done by a 3rd party tool which might be buggy, git.exe or the =
git server would bury the problem in the repo history as long as it's not c=
hecked out. As a git hosting service wouldnot bother to check it out, hence=
 it will not be an issue with the server. But once it's cloned and that com=
mit is checked out, an issue would emerge.  Is this understanding correct?

Again, I don't think "buggy" is the right word, but it will remain
hidden until you attempt to check it out _on a Windows system_.  Some
hosting platforms contain checks for paths that are problematic on
various OSes, such as pairs of files that differ only in case, so it may
be caught on push to such a platform as well.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--QMKAb3UraYtFHjYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ3lsJQAKCRB8DEliiIei
gR7xAQCMzsNCF91wRvN2fo0/QwocHqMi+gXJqWulWsr5GuGLjgEArHJuz8xWJyeY
t9HTovdBD4lcloTQGgsagTkq+oQZnAo=
=rf7l
-----END PGP SIGNATURE-----

--QMKAb3UraYtFHjYw--
