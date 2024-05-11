Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493C1CD00
	for <git@vger.kernel.org>; Sat, 11 May 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715458127; cv=none; b=DUbC+s/rB76QhbBhaiPQgfm5yqJcW071jW/qKNV/otFdIu/QCzbe+9gjgtKtjc3LQ3mztLNRUNsgv/98ROov5TmiBoTwQOxcfLpN9VYJvlJLBXSHNyanlyo7mfiK4GESN9/Dvo3s6itKVgkFa9HmApCmqEfYZL8T/q+cHLtP/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715458127; c=relaxed/simple;
	bh=oOG6rKvksA7bwNB5AkXRe19p4YAwleUAURWn4EpC1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9rpbdgzWIW40M8QWuqEP0150oaprkj+1tWJn5lBgk1CI6qyWfA+RM7zap86GFmEoMSutcAgVTLLJoXufNghyLxY18ixu2+PE7Tt1hSm/NrxPZ9Bcu3qWIZGW2UtmmZBMf0nyi9Svx53BHT2zmFtUUyMzA0YtH5N3Y+rXcnbL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayiS1Llw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayiS1Llw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45870C2BBFC;
	Sat, 11 May 2024 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715458127;
	bh=oOG6rKvksA7bwNB5AkXRe19p4YAwleUAURWn4EpC1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayiS1Llw3fXHj3X4i+THB7PKkLWPCbQgnkHcvzXx9qbebiTxMmThwse0geNJop3bR
	 tVcpHbGEGtByuAysQve57yKiIEga8xmSu92Ri0D9rc6apoiVLrmwoVmyfshk/hlE7v
	 G5KYhsDe025w3nlgvCH8I7K3A0O8iJ6iAoRBJ31UwWNBP5vnJktCESVApHYD4xOQ02
	 2aD5O4rIa1B7K9llp0KIIKBZphFxEMLc2V7a/Md2iXVY8aXrFsXVBCBD4I/oc65AFU
	 9qnr5S2owYQeYKHYJ1FQL9kczEyAZAPgjt4GzH9zzHe0FT6K1GHjKLqNqq6fR31ODT
	 UnlfUdT8H2hNQ==
Date: Sat, 11 May 2024 22:08:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
Message-ID: <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
 <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="do7lfqq52sdnoxqm"
Content-Disposition: inline
In-Reply-To: <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>


--do7lfqq52sdnoxqm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
 <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>

Hi Phillip,

On Sat, May 11, 2024 at 04:01:18PM GMT, Phillip Wood wrote:
> sequencer.c. If we go for the "write new trees and use those in the merge"
> approach then we'd need to change do_pick_commit() to create the trees and
> we'd probably want to change do_recursive_merge() to take trees rather th=
an
> commits. We'd also need to add a new pathspec member to struct replay_opts
> to pass the pathspec around.

I've been thinking this evening that since
`git format-patch ... | git am -3` works so well, and since the behavior
of cherry-pick -- path isn't so obvious (we're discussing different
strategies), maybe we should just not do it.  I fell in love with am -3.

:-3

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>
A client is hiring kernel driver, mm, and/or crypto developers;
contact me if interested.

--do7lfqq52sdnoxqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmY/0EsACgkQnowa+77/
2zLqog/+Nw0ejqfmOLPJI94OfMR+E8c57QBbn8MFy8ohpDYw4fp1nxKQkO7bbw1H
lIkhwIWiQkk+1Tgr82sF5S7O05gqt9Cx83EiPP44xCsSClpjQBRLqJ0cFrP0guk/
YEdVpIHLYd0Z7bNMSImlEnTorPQHKKMVs6nejIXVNlsb7Z7Y2qEc5ohR6+MgrmGL
EHIvTV91sv+xR3BDFt0s+r1tcWhuKMUaeJAUSMYk8QMrLmcHVAlenR7iACroYBGq
zQ6RuvZJ/4uDkbD2HzuXvxyJdb10OBYLU/bU7P0vOMOxlW+oN+iieX1TslKkPFW1
2Z9HKK9HOoqOdaNwneupbEKj9szq0YgL0ybRsvW6Ey8m2ANvm+Ui37Fz2i8tAlCU
5FR7nkG4OxKVxiiesIFD22Dps/bfxY4Wb2n1XV9caKgOBuxplL7yKcOH6g8oP7VK
35AU6d3AGVmiYsyrCaNvFjFuWyZH3Z25rou2LpM6is1pX4zmIKgPYTnyNDfQW6y4
vlNdtjmNnDEPucmU0caRbVKzpqhDAfgonrmmHqGG0wriR6bW8E9+CtVDEZECfGWd
D1Olog7woaoty6QrKpgcVpDMvwstKKGbQTPUQ4wZF8hVyJEsmAeAHdn5jpPA6kFp
jUSkClFBzd9dZ7Fy7sswEO6uAaboSRfVMCucK1zcq8tDxMcJdJA=
=hsNy
-----END PGP SIGNATURE-----

--do7lfqq52sdnoxqm--
