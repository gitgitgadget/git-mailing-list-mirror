Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128D1E3772
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963403; cv=none; b=K5HVVJzg4yNVHEDSWln9NclHg9Te7CZTF6as8qq4J0MEpz5TnQQznTLGrlPLWuQ6SoNzz/TleA1C6JUD+XwLeymXCJ2rcCJvRisBh5lgSWc/oC3vE/d7DwF3tv3vEiGhLPrwoFWbWcTz3cghlpeAjfbkWzAwjXCCWvIk0KnvGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963403; c=relaxed/simple;
	bh=lIMlryyJZi1potddQelesrTDkXbLWRFPFKsv4U7ns3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBT6U1P4FEQMf5IR6Lq2nXvqv4yBjbvy/W6mlfeyUHgg01/DQH8UkWj2+FbSQrE7MbEFjoEDmaSHCj9A7VlfDLysr8gnlzOdQBGsWiPJLkntT6wRExa0tGtqOsWuT2o0GmEWuAZrUp11kmX8IGd8YPZwuK2ivEf8yfDfVSZkHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ewe2N257; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ewe2N257"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752963394;
	bh=lIMlryyJZi1potddQelesrTDkXbLWRFPFKsv4U7ns3c=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ewe2N257Aoe3ctXTwA7xKZedK5HUVb2bFUtpHXiQw2CuNMJRmKoMluHY+ACdm4K3L
	 ghasO7NV+DZLeV514CLN+s62V2KwDQ26BTIBBZjFItu/L8QSFmSjpzihSSbchW/YbM
	 TlWVO1YoYEiNWESMysYLMLadif19rcIngrLe+Yz1dPM0v9Dug6Sc44B+tc2sb65d8K
	 L06ZJdYEMuzN1jaxUzT+KS54+i2TeH/1koMe4KEvh3i8CRoSHlYfs6rY4SJnByzZKm
	 CVMBXuYukJ6WyRAL6KHclQJHL2HqRnfsDjtAbG+/LvOxv1XHo0zSI3ko1dv7gf7fVe
	 Lxl/4kYe0tnKrrvPtv922KRmi6Benw2XB8Wl1DSDnM2sE63SzACjyssRt6jPgPO33L
	 eu6DpPBdzGe497Pb1na43LTEMMNuXZwJhcHhPs/Oj5ikuPRy8rn1lBxFc6Dz+Z62rk
	 kEXO8T6wv2r+bOmAM/f5NDnMcf/Vq8aqjOni25nBpY2tpjvRXlQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cbf1:866b:6e23:73a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0D6B52007A;
	Sat, 19 Jul 2025 22:16:34 +0000 (UTC)
Date: Sat, 19 Jul 2025 22:16:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Frederickson <ericfrederickson68@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A Question from a Hopeful Future Contributor
Message-ID: <aHwZQFtMS2fk5FID@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Frederickson <ericfrederickson68@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yu6LxLmg72csLTc4"
Content-Disposition: inline
In-Reply-To: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Yu6LxLmg72csLTc4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-18 at 22:26:31, Eric Frederickson wrote:
> Hello everyone,

Hi,

> I hope that this message finds you well! I'm a software developer and pas=
sionate
> git user, and I'd like to try my hand at contributing to the project. I'm
> sending this message in order to ask Junio and the team if there's anythi=
ng that
> would be particularly useful / appropriate for me to start looking into o=
n that
> front. (Reading through the last few "What's cooking" messages, I didn't =
see
> anything that jumped out at me as needing a new contributor, which is why=
 I'm
> asking in a separate message instead of replying to one of those.)

It's great to hear that you want to contribute.

> (Some notes on my skills: working on docs or tests is always a favorite f=
or me,
> so things in those areas would be a great time. Also comfortable with low=
-level
> code, and any kind of scripting. Note too that academic background centers
> around programming language design and parsing related stuff, so I've got=
 some
> fluency in those areas that I could hopefully apply well to the project i=
f ever
> needed.)

We have a Git FAQ because I answered questions on Stack Overflow and got
tired of answering the same question again and again, so if you want to
add any common problems there, that's of course welcome.  (Now, to be
clear, people did not stop asking those questions, but I had prepared
text and a link to provide to them, and then people _knew_ that we had a
FAQ and could refer to it.)  If there's anything that you think is
poorly documented and colleagues or people online have trouble with, we
would absolutely love for that documentation to be improved.

One thing I did to get started some years ago is to grep through the
codebase for TODO statements and to pick something that seemed simple
enough to do, and then send a patch.

If there are small functions that you think would benefit from unit
tests, we now have the framework for that that we lacked until recently.

If you see things in the tests marked test_expect_failure, then that
means that's a TODO test: it should pass, but it presently does not, and
that can sometimes be a source of good things to work on.  Some of those
things are kind of big (especially a lot of the submodule TODOs), but
sometimes they're small and approachable.

Hopefully one of these options bears fruit for you, and please don't get
discouraged if you wander into something that ends up being very
complicated at first.  We have lots of those in our codebase and with
time, you'll also feel more confident in tackling those.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Yu6LxLmg72csLTc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHwZQAAKCRB8DEliiIei
gSvMAP47+8F90VM+5NGgm3W52PONiy3Tlk9s581oEQwTqtzltAD9ESfZ3Nc+ENpv
vrOpAdciwaoX5Itd/TkwJc1ABDNSqw0=
=v+rq
-----END PGP SIGNATURE-----

--Yu6LxLmg72csLTc4--
