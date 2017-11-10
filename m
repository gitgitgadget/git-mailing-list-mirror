Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC1E1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbdKJXmV (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:42:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753960AbdKJXmU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 18:42:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F8FF60475;
        Fri, 10 Nov 2017 23:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510357337;
        bh=JP0KFCXmB73wE7i2v0DonZmi/+1L0VqhTRYrU/edkWY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lxiEzuLbb3hpeTsR6c08IepO2gCl8uVvrKOZHThyKoWVS6W8dn7VoIHHiOzmDc09H
         SiPoGHRK2a7h3L5wmKKYP4eh5v2RTPHX8sxBhIEsONLGGDF5+dzvXoRXnIk1Oeo0Dh
         O9kjGY3Gc1UweGn+OBcxSF5g+zUeJAMpP8M8aF+jx198JSFO/zUl7q8HiCbEHQOzt0
         WBVUaJnt/nimZrZey43cCGXViVpnsKZvxiwZh6FwNnSrDgSPdpp37djS6knLxzUxR+
         29bMeDN05jSIXwv+3tXLB+H/205Tsf84K9TWUO6yI1PiqtTCTUuJjK2OdUSY7UEkAh
         9WtRTtNkd0Bo/B8A63VEOB/8hOwP5+B/x26x7EVEkTK97uBHU4DYl3QXzs4FmRZVkV
         gie8Wwh0VH2SjnD/wftIOQs3YJ9ie7Cf4E6SSGLATwHtAmLMEsoDreFbrHjt9AvzaM
         xvu++fwUsOlDk3olMoo0cXPzfKqdfFUXgN7zNtmPJY+bBO/jjGf
Date:   Fri, 10 Nov 2017 23:42:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] Remove silent clamp of renameLimit
Message-ID: <20171110234210.lojdat5zofhrdlgi@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
References: <20171110173956.25105-1-newren@gmail.com>
 <20171110173956.25105-3-newren@gmail.com>
 <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
 <CABPp-BGwoduH_T7U4uN5A-h43wREfXdQgV8YCVWf8w5N09cYSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opquyub4p3ov53wn"
Content-Disposition: inline
In-Reply-To: <CABPp-BGwoduH_T7U4uN5A-h43wREfXdQgV8YCVWf8w5N09cYSw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--opquyub4p3ov53wn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 10:36:17AM -0800, Elijah Newren wrote:
> Thanks for taking a look!
>=20
> On Fri, Nov 10, 2017 at 10:26 AM, Stefan Beller <sbeller@google.com> wrot=
e:
> > From a technical perspective, I would think that if
> > (num_create <=3D rename_limit || num_src <=3D rename_limit)
> > holds true, that the double-cast condition would also be always true?
> > Could we just remove that last check?
>=20
> Not necessarily.  For example, if num_create =3D rename_limit-1 and
> num_src =3D rename_limit+2, then the first condition will be satisfied
> but the second won't.  If it was && rather than ||, then the second
> condition would be superfluous.
>=20
> > Or phrased differently, if we can cast to double and extend the check
> > here, do we have to adapt code at other places as well?
>=20
> Good point, and yes.  Perhaps I should have re-ordered my patch series
> because I came back to it later and realized that the progress code
> was broken due to overflow/wraparound, and a patch 3 fixed that.
>=20
> Further, the later patch used uint64_t instead of double.  While
> double works, perhaps I should change the double here to uint64_t for
> consistency?

I'm wondering if maybe you want to use size_t.  If you end up using an
unsigned type, you might be able to leverage unsigned_mult_overflows to
avoid having to write this by hand.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--opquyub4p3ov53wn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloGOVIACgkQv1NdgR9S
9ouJGhAAtGiQmjHthoYDkXDjmYYEp45edNcUxn3WMtu5Kyo+a5L3e3Epj+yNRP2w
Awx16ntnZ2pAwaMTIaWZ9SdFa54EjfzVy0r3GMNNkzBh7LChLngMl23vaw7eilqX
nzHTRSaVSLAc7Z3IpQj6iKdPY5Ng1JqC0gPV1PGHVFdWUJsDAYWLgNSrkPkQZS3Z
gLHPz/YLAS3efNUSW/Io0lOPhgXv2ionGcTp0R2WfA1J46BbAok/8CvO/K/J6fGl
9W9tBq+Glkg/6cYgWd5S40BXQRt7EWSL2QaW79XteR1nRl18vLRxj1LQbXzG90XQ
hkAEjIW2bctgcklAVeKaBv7R4ZMA7Lr1ddOSHvpdPNVsdTRy3nkiNUSSzGhNNMkb
5nHEOBQiaQGfJ3cixaPwbSgs+gLeSu+K4fOKGQqD3ih+xKe75du3/7wQCFckZPAE
WDYj6u1dfxmlVdpviZaH4WXPxiczshQipYcjGC5SAiMmBV6pR9whj7m/iqnW86Zp
8EXzC5NbuPJ+Pcaf14eyVChUx+ttPe0fuF9chnlqsUzABP+MVR09v7XKqDFIpYpX
Hh2IuZgluKAUrHAaCQikQ3vsUZl54Lv9xLUZMLpowTi4NYhnajE04mneE5aRNsjS
cIvtrWuchJGpOtMM83dyJ2SIPT05oOqWDBn8jFxvD3ZLmM0xLyI=
=ZI/h
-----END PGP SIGNATURE-----

--opquyub4p3ov53wn--
