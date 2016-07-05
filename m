Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331C02070C
	for <e@80x24.org>; Tue,  5 Jul 2016 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcGEWpW (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 18:45:22 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56264 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbcGEWpV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 18:45:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E5C99282A8;
	Tue,  5 Jul 2016 22:45:17 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1467758717;
	bh=ARaDZ4MtrFVuunupG1LycQu6CniRFvnTywciTaK8NpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5OASRWrWB5c2cd26KzekbglQhGuKUN0rQnCVH+WUo7JDrHLrxJkqi70oREiVL68J
	 Q595y/WzuF5V85VTIGUxOSJ9JUAc+3+c2Nl5oUqq6PDOtt0S45XVt7wJtAmzZAOoRZ
	 6tUAbq6PBlQopvNIjLNCkJEtQ4Qw/uFMouYLUqSX+3cTrYbDQu2WGyQJISg3BrRfG7
	 NkjRDFXMzJUxDAx4k0ksBewRmpQF6OYVFaKZSkv1Igmp3L5xQ2T31sR7t63BlM7G3B
	 dKkdgRJ2OKyqa6uenDfW/itAFDe9DoLP31jGPER6s0RhPv3irewtqnjEcfzsXO2BJj
	 C9lvHivGWI0mF0vGqYmAyv3w/5K41uEdXtyYoMc0D1fifEsI91btL8C2L2kdyZm7X9
	 zrUWrSeGP5JmTRdNZndf21sSZJIaiXzQ3xr5A/1UF0vy41Wpb0bphZ2Kjbhdus06MK
	 tqgRpHPxxy1ZUqwAh8EbWmE4PGZsfTUgUAMz8hLxTKTJIl4TFxO
Date:	Tue, 5 Jul 2016 22:45:13 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:	kpaxton@paxdesigns.com, git@vger.kernel.org
Subject: Re: Dependencies required for offline installation
Message-ID: <20160705224513.GA143638@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>, kpaxton@paxdesigns.com,
	git@vger.kernel.org
References: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
 <1467741182.14863.6.camel@kaarsemaker.net>
 <CAOkrQryazf=38eUMjcZzByjk=OVNfFGpFKnp5zpyML7yDKhW=A@mail.gmail.com>
 <1467748395.14863.15.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <1467748395.14863.15.camel@kaarsemaker.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-1-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 09:53:15PM +0200, Dennis Kaarsemaker wrote:
> On di, 2016-07-05 at 14:06 -0400, Kevin Paxton wrote:
> > Thank you for the response.
> >=20
> > I apologize. RHEL 6.5, not 5.5.
>=20
> That's less ancient, but still not recommended. When using RHEL, try to
> stay with the latest point release so you get security updates.
>=20
> > Would the same version be applicable to 6.5 as well as the
> > dependencies that you mentioned?
>=20
> Red hat actually ships a version of git with RHEL 6. =C2=A0So the=20
> version will be different (I believe it's a 1.7.something). The
> dependencies should be similar, if not the same.

At $DAYJOB, we build and ship Git with our software, which runs on RHEL
6 and 7.  I'd have to check to be certain, but I'm pretty sure the
dependencies for core Git are the same as Red Hat's version.  We choose
to compile with PCRE because it enables git grep -P, which we use in
development.  If you want git-svn, you'll of course need subversion.

In case you do move back to RHEL 5 (which I don't recommend), be aware
that the libcurl version is old enough that some features (DAV is one,
if I remember correctly) don't work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXfDh5AAoJEL9TXYEfUvaLbS4P/38/SkoGfOzE1ZV6/1jtLMOz
Tt5fLMkSgeeyOtDGIR1X+uWL5CmH7SIYAPHP1pJYHh6n3Uq0LMF0S2NDyjf3uAY7
ExHv0mStaX9igz+a9Rn0bkcAIrejDNwero4zn4wQpNdyE8Fsp8FpSyrPSD0V5APV
l49GAPLJi/kGke6u0aLI0T9KwijT+dk0JmE43HL8/OXRv2c15/Uppkc9HCDEF+J8
JE/1FsK3U+/ADtPjjW5arLZJEmhJpN75QVszXLtxn9Q33/cpzJ2MmPzkgWbjRND9
lH9yFRxi/MVB5u0G6/WVhGttZrFUe+ZB15YlqXj+Gfc97tlt5T8TyDveCw8Dlw3N
lBzFs0G49AVQhvi569yj2Up7aUzW0cpmzMidw2ZzF1vDoWLNl+OwCJK2nJm1Hm8e
FLgHhvKBmyjYf7B6EKlJbo3AUD27CA6ke9PzTdHwl/Oi4RNshA0iTaJcJq5kOtSt
MXUHiM6nLfAlzRjjeYBli9XWEcAJosS8yFmUXExyyHMfRuz8t8xsuErB3Ucmypr7
yAHTdqPGKy3O2Tq3harywJxNe4/oMAnxrgLHbi2NjmsM7ZW2/4kJhIVcrNApJsqS
Jlv11Bisjlc5U2ITVAkc6xUWY/xj1zSYvfo0jM3l5HUDDNufMy3uINf0q7f2laYN
/s2lXY2onBnzchDOFXNX
=jEps
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
