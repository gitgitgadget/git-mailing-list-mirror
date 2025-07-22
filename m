Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198281E
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142501; cv=none; b=jfOaPfm5PhA1xZ6elGEjs27as/HPwwaxT7mB9/T845S6VDNAyYpF37wTY5KRBxlrQVWV4qMbUGJa5BQ1ru97jB0TN8lpGN/7sPN/pM+OVyEgxEBG88AfApsBbY7y2Mt+aukKgkIsJKomxZQ+6PovxbPXk1oimLAYz6dNly6sqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142501; c=relaxed/simple;
	bh=EpDu49gJ83GJFe4OxRZtzrXhEm5xBvbaLNm72RcMJWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOIXbFEtYoQHpi7RxUFe0o5ZzstCurh0I7klgddcdfJ21sgjXGjKeVhcMyKypaMTOwKuUs5gT7ncElEexsqCnTZshv5VZf7iIKNMc+SyZZ4Hqr16NjaC1v9NR3CWHOt/0fjFzk4f3UpqQWRxNyJJAMUy/5ZxBx89EUd1j6JeV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=r2mp30uO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="r2mp30uO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1753142492;
	bh=EpDu49gJ83GJFe4OxRZtzrXhEm5xBvbaLNm72RcMJWY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=r2mp30uOXowDEkyzopzDwDJUK8nL6FzRzilkmDrbLSmeeeH4qbdNrrfnxvnHhz2A+
	 quSOrGxuaI6FGRqnd8jCLL8x+5oohEB33NnYosV/N5cu0SR02QRzzwAfGEZDbPOJU8
	 BjZ7LxtPHnXNdAafsuAXpGMkYkWS2pKcx5mkg0QgmQE3HuqR/CouKycInubei9nNyi
	 fTaZvsYFr3JXnnsWDqlIHgAlAVaUfksyp6TcG/Z49+EkmORAKZrY8EzeMiIYEGtS8j
	 v7FB1NSzMT9elZdK8+UG7ZljusCzdFYog9wsS5e0h4mmRVewsuHEG11Apwib8ZTYz8
	 c4voJuPgtgMgih1QNR1KHhic06mfu531QdOBfh4+2Sx1WPZTgxXuoji8Sq0s6AZoDr
	 0bbpXPLSswQZ841VeEKAa+ePROYzaE5IAIVj6wh5OSz4oRU4fQK6UsdJ9yeY7E0Nwe
	 sla9qo9bfr58Krqa8cTPzlxMlSoBBRi7zzP1eTHIF2al4smS10p
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:2eaf:a208:a152:a406])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6B05020079;
	Tue, 22 Jul 2025 00:01:32 +0000 (UTC)
Date: Tue, 22 Jul 2025 00:01:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: James Gao <thehighmountain25@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: latest (2.50.1) x64 version of Git for Windows
Message-ID: <aH7U26rPYIqbtcwS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	James Gao <thehighmountain25@gmail.com>, git@vger.kernel.org
References: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SyF+C6sGECEZzt+s"
Content-Disposition: inline
In-Reply-To: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--SyF+C6sGECEZzt+s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-21 at 20:34:35, James Gao wrote:
> Hi!
>=20
> I just installed my system, and downloaded latest (2.50.1) x64 version
> of Git for Windows and installed it.
>=20
> I am on Windows 11 Pro, 10.0.22631.
> Git CLI is not getting permission to the folders.
> For example, I cannot run git init - error: couldn't set 'HEAD'
> I cannot git pull or clone or git add
>=20
> It returns me similar errors:
> error: unable to write file
> .git/objects/36/dd1796da4dcbb2f53005b64afeef698cfaf510: Permission
> denied
> error: src/helpers/schedule.ts: failed to insert into database
> error: unable to index file 'src/helpers/schedule.ts'
>=20
> I have tried every single help articles and blogs, nothing is working.
>=20
> I tried running git bash as Administrator, still not working.
>=20
> I am planning to download older versions, but it would be great to get
> it fixed for lts.

I don't see this behaviour on my Linux system, so I suspect this is
something specific to your system or to Windows.  I would suggest trying
to report this on the Git for Windows issue tracker at
https://github.com/git-for-windows/git/issues.

A brief search shows that there are some issues there with this error
message.  For instance, if you're operating on a CIFS/SMB share (that
is, those with the `\\share\` syntax), there's a known issue about that.
It's also known that you should not put your Git repositories in a
folder that's special to Windows, such as Documents, because Windows
imposes additional restrictions on those paths in ways that can break
Git (this is also true of macOS).

Similarly, you absolutely should not place repositories in a directory
managed by OneDrive, Dropbox, or a similar syncing service, since they
often don't work and even when they do, these services can cause
corruption to repositories.  If it's not a regular folder on a regular
NTFS disk, you might try using a regular NTFS disk (such as C) to try to
see if it makes a difference.

If you do report it to the Git for Windows tracker, please search for
both open and closed issues and mention anything that is special about
your repositories and where you're storing them.  Is it a network drive
or folder?  What kind?  Is it a drive other than C?  What storage is it
on?  What file system is it using?  These kinds of answers will help the
maintainer determine the relevant difference about what's not working
and fix it.  I feel very confident that the Git for Windows maintainer
would not have released totally broken software, since they are
thoughtful and diligent, so there's some specific reason it's not
working for you while it is working for others.

Best of luck in solving your issue.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--SyF+C6sGECEZzt+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaH7U2gAKCRB8DEliiIei
gS4nAQCFb+Cwzqz0WYQgWVMjnP3JTRFzKtPh7VxtQMAHdRiQJQD+IvutzxNOPi1E
1ltaV5j6+8BSbpju6judfvSpydq9jQ0=
=b6JG
-----END PGP SIGNATURE-----

--SyF+C6sGECEZzt+s--
