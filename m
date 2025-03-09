Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06D14885B
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741560509; cv=none; b=odvnxfboIcccHTo9xCrtSahN/oim2Rj5iWLipseJ8xjriezJ9ozZf+4l4OSktzXmataBYO6u4vmByIqRt0kWsN/bLvLbTY5IN+R70/IWttbVaTQVSVmPp9g5mQCWkIaDd1L51vQjEXVhPFvdMCy5rE4GuGjJZr0q4kJmE0jWL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741560509; c=relaxed/simple;
	bh=AYkSPqnGynKO2HWgiEzDnxY4n0t5u24YZ71yklAqUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp9lcUnNtrIf+v/VlWriWFlgr+FYvQEO1ZW74A+RFvk8u54F2hd7uIkZprUuJCQdEIH8ZkbVijzHTPkQlbMKSfkxrZs3ZpwmuTBIR9NTrx2SCafftnFswNl+riOfB0OVgtBcdbFgOAJoXmY1anjRorIh0smL8sPFK9EjYLL++zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=w8p/OJfL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="w8p/OJfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741560028;
	bh=AYkSPqnGynKO2HWgiEzDnxY4n0t5u24YZ71yklAqUuo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=w8p/OJfLSP6OL/VAL/9Hb3iexPmiyJwnIMwejmHJcfng1j/O4oG61SDZE/LPXNsQM
	 RwZnYdVgrIjNmpSOMuvffxnxKGiUws/sg8+cpOUzUeooKyX8dx+zMHFupMpRB9gDTy
	 u6hUpUIZrxGVLttXyu5FwMU/UH11O/d0rwooovfdr+fUwyGdgIjhKJaqOTzA+ss9QP
	 TugmpItwlV31P1s7MPOo19OsKhsS4GDAkLj0ZtzpUWsKAAlEf6o15rw5kitA+J9r3r
	 nzoZkYUjYYdcKdSRbnHwHIgTimRZeXfUX/f4c2Qd1eoaCWQruzXgsqThLkegwYZXQN
	 ogW982h+k1i7gHaI4RlmP4OEXfT7MJlYx2k8Zm++Qw1WuGTsYJbTMHCfPXNNWUoSou
	 fulsI2uCD9I5WfKqyMkmhn9E5RxkpTs4uqm0rtcm4Vs6Po/EASVxvmrvlPRn6Tbh4e
	 GoBO88c4QYT2cb05XJmvvjQQdH37GH1C9mWjwBb9arzhoxHQ1eM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 712EC20031;
	Sun,  9 Mar 2025 22:40:28 +0000 (UTC)
Date: Sun, 9 Mar 2025 22:40:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: add a blank line around block delimiters
Message-ID: <Z84Y2mmenFVqDU-v@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
References: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/YRj4DOlZcnoS01A"
Content-Disposition: inline
In-Reply-To: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/YRj4DOlZcnoS01A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-09 at 19:45:11, Jean-No=C3=ABl Avila via GitGitGadget wrote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>=20
> The documentation is using the historical mode for titles, which is a
> setext-style (i.e., two-line) section title.
>=20
> The issue with this mode is that starting block delimiters (e.g.,
> `----`) can be confused with a section title when they are exactly the
> same length as the preceding line. In the original documentation, this
> is taken care of for English by the writer, but it is not the case for
> translations where these delimiters are hidden. A translator can
> generate a line that is exactly the same length as the following block
> delimiter, which leads to this line being considered as a title.
>=20
> To safeguard against this issue, add a blank line before and after
> block delimiters where block is at root level, else add a "+" line
> before block delimiters to link it to the preceding paragraph.

This seems like a reasonable thing to do.

>     The issue arose with a Chinese translation where the length of the
>     paragraph turned out to be smaller than the original English and to j=
ust
>     fit the number of hyphens of the following block starter.

I was wondering what language you were referring to in the commit
message, but I can definitely imagine how Chinese would cause this
problem since there tend to be fewer Unicode code points than in
languages that use alphabets or abugidas.  Thanks for satisfying my
curiosity.

>     An a longer term, I'm wondering how converting all the asciidoc files=
 to
>     the modern style (i.e. atx-style, with variable "=3D" characters in f=
ront
>     of the line) would be perceived by the community.

I feel like Junio may not love it due to the churn, but I'm fine with
it, assuming that it continues to work with Python Asciidoc, which my
testing shows that it does.  (I know it works with Asciidoctor, which I
use.)

I think if you can articulate a good reason which is well explained in
the commit message (and honestly, I find that it's hard to remember how
to do the underlining beyond the top 2 title levels, which may be
compelling enough), then it will probably be fine.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--/YRj4DOlZcnoS01A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ84Y2gAKCRB8DEliiIei
gYm0AP9N2+tEJKPDgd2Y1S5oOg1JlAJrzEseMi7qMyX4DqaNIgEA+ch0vmrFg/Lz
Cupil4D5uceuR56WKAxE+j01rXqvtA0=
=sQUg
-----END PGP SIGNATURE-----

--/YRj4DOlZcnoS01A--
