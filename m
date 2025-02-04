Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028486321
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637008; cv=none; b=BHs+1pn9S8qd7xFlw148o2o1NxHCVGMR06AKphjByF7oX5fhhBuW/9eWwfDMKUrWe73/HBZS9aaEkObeINJcq7xdcSH/xyFTDfHhe8gD6rIkzcPtNv41vDZe26sO+o9dAClxRzN5Ve9ITuawboQDbPFYSnM15wvmc5IvFRGabX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637008; c=relaxed/simple;
	bh=YOQXwuVNBbzxBvDvgAqIJ57LnXwK2w472mFKwRMYUjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huV6jrv1t9MOTqKkV/59+HBsBYgPPzL1gRaNBPim7adK0OnD+FA4Cb5RiLDKafHaN1XpqVKPFOw6+BXY1e4qiTTMuI7u/THEb/af+baoddNfn3caZZWl56pJpaAvlaTBhHOwuqefVF5JVCP81DFyF0qE8MW+WnbCw9gR+tHuBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JghqS5bz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JghqS5bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738637005;
	bh=YOQXwuVNBbzxBvDvgAqIJ57LnXwK2w472mFKwRMYUjI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JghqS5bzRPsYY+LvEDTREmbaQFG5jYd1sBJHRM+297sp3K61CCTvx6YJEaLc0IVHC
	 jUStov6P88rXOd2JIT+HgL0iMDc5YDv44MCrX8PMoPb1J0irZyShZQsO4YOVjVRzCi
	 KaefMZideRSn7YByEMNvBzvEZI3AAoIT7BC/w/goNVX0ltD3uMiB6N5EA6L3nLSfC/
	 LTnyrjH7EMQZhcQjtJYqnCK/hnEBMVRO6t75mR1E+eARE9ZNhgoccOTwbHBQQUaCkn
	 y7wadbmKTDjZRYbZmR9Ch7kVhWdIml81E7HW0Db77RCoW+ddRyGHoOyKW6rzQ/WeNw
	 zfIVBvprExOXLOcoLpiZY6HtXTyiwZ/eiwRiSUi5s5xuH1WjMVRAsM1xMfkEMJt5MI
	 vZ7hrA51tCfxRkafIjJ47J8EiaGgZSP4hn5oKSDz+ppz/e853FMfbcSt+Lh0DJOIMC
	 uKDTMvxGV8dHeptcy5tR74tBRQTnAG927HEB2Pr2Z15GF2xgFDl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7A73820067;
	Tue,  4 Feb 2025 02:43:24 +0000 (UTC)
Date: Tue, 4 Feb 2025 02:43:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] thunderbird-patch-inline: avoid bashism
Message-ID: <Z6F-ySoYbDJxJ3xs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
 <CALnO6CAib-p1+1VHMfqo4VGLVvWs63z_xCjkCANJS-NLK5FpdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twF6ZuPZfPeT/Fn9"
Content-Disposition: inline
In-Reply-To: <CALnO6CAib-p1+1VHMfqo4VGLVvWs63z_xCjkCANJS-NLK5FpdQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--twF6ZuPZfPeT/Fn9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-04 at 02:11:19, D. Ben Knoble wrote:
> On Mon, Feb 3, 2025 at 8:55=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > The use of "echo -e" is not portable and not specified by POSIX.  dash
> > does not support any options except "-n", and so this script will not
> > work on operating systems which use that as /bin/sh.
> >
> > Fortunately, the solution is easy: switch to printf(1), which is
> > specified by POSIX and allows the escape sequences we want to use.  This
> > will allow the script to work with any POSIX shell.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  contrib/thunderbird-patch-inline/appp.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I noticed this in Debian bug 772238[0], while looking for any bug
> > reports that I might be able to fix.  It was reported in 2014 and has
> > gone unfixed since then, so possibly this script is seeing relatively
> > little use on Debian and Ubuntu.
> >
> > I have not CC'd any of the authors because nobody's touched this in over
> > 9 years and none of those people are still active.
> >
> > [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D772238
> >
> > diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunder=
bird-patch-inline/appp.sh
> > index 1053872eea..c55c2caa41 100755
> > --- a/contrib/thunderbird-patch-inline/appp.sh
> > +++ b/contrib/thunderbird-patch-inline/appp.sh
> > @@ -31,7 +31,7 @@ BODY=3D$(sed -e "1,/${SEP}/d" $1)
> >  CMT_MSG=3D$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
> >  DIFF=3D$(sed -e '1,/^---$/d' "${PATCH}")
> >
> > -CCS=3D$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/g=
p' \
> > +CCS=3D$(printf '%s\n%s' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*=
\)$/\1,/gp' \
>=20
> Looks obviously correct to me (I once wrote POSIX-compatible echos
> just to see how hard it was [1]), though I find it interesting that
> `sed` can process input lacking a final newline.

That's actually a good point, which means we probably need to put
another newline there.  The shell will have stripped off the newline from
the command substitution, so we'll need to re-add it.

GNU and BSD sed have no problem with this, but POSIX doesn't require
that sed work here.  (Of course, the likelihood that anyone is actually
running this on a system with such a rigid sed is extremely unlikely,
but we might as well fix all of the portability problems.)

I'll try to get a reroll out later this week.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--twF6ZuPZfPeT/Fn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6F+yQAKCRB8DEliiIei
gaX+AP9M+AGjX5Midc/v22AwCAQp+cSTk6378Pnub8nr3+QEHgEAl4ebp1YESVgt
dGHak8RYMMFwr/J2a6wafLYeRfltigw=
=TsoA
-----END PGP SIGNATURE-----

--twF6ZuPZfPeT/Fn9--
