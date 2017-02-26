Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3442022D
	for <e@80x24.org>; Sun, 26 Feb 2017 17:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdBZRjV (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 12:39:21 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41150 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750967AbdBZRjR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Feb 2017 12:39:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f8da:200e:3546:3090])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD32C280AD;
        Sun, 26 Feb 2017 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488130694;
        bh=3q1L0bGlaZ1rfayDS0wK3VKzW2NhhH6gvJYTbCTOn08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0sIOO6+AO3YduEPLjUSDo0wsg5O81ON16DxtyXhPNr0QsZWJC0KMrvt0kT991WAui
         0gMibv2irjy25aJ1uDQW2ED1uYfKqBpyZv6Iq6M2/IkzL4ht3LkirztodY1+0cBUTN
         cmXte+CwaSVhRnsEkAS0a/Ekp42x84K/TvR/RBovuFt6+TU3DVyuNkeNcvbsltCJ8X
         GErwVUOvs87A2u0oFOoYMz7UDoO5MvmlLnMuvorPcb9V7pW1pyP1qv5T/qhcZcTvAN
         FNMoOt/7z1519KmaeAEmguGYgP2N6xKAntgBIeJzmcNo1HOc5DaFM6Ne1p9d7hbkAi
         vq4C5ZiYCmDVFz2TlWf4++TqgGOOjH/SYeUtkBfUsNpHHLZbho/6A0Y1wdqkPVAr+5
         +YQjmZatkayHqIHRgen1ARD5K+vezV353eoVcSsWMTEMzR40Bu9evnfD7qKQ+6HJKQ
         W5a/Z1+KutrHyJOX1CovHMvcnPim3DqpxWSdnY+xmUoB03WtvPk
Date:   Sun, 26 Feb 2017 17:38:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Cooper <git@lakedaemon.net>
Cc:     ankostis <ankostis@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
Subject: Re: SHA1 collisions found
Message-ID: <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>, ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
References: <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dvjgmhllrx5bdeqp"
Content-Disposition: inline
In-Reply-To: <20170226001607.GH11350@io.lakedaemon.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dvjgmhllrx5bdeqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 12:16:07AM +0000, Jason Cooper wrote:
> Hi,
>=20
> On Sat, Feb 25, 2017 at 01:31:32AM +0100, ankostis wrote:
> > That is why I believe that some HASH (e.g. SHA-3) must be the blessed o=
ne.
> > All git >=3D 3.x.x must support at least this one (for naming and
> > cross-referencing between objects).
>=20
> I would stress caution here.  SHA3 has survived the NIST competition,
> but that's about it.  It has *not* received nearly as much scrutiny as
> SHA2.
>=20
> SHA2 is a similar construction to SHA1 (Merkle=E2=80=93Damg=C3=A5rd [1]) =
so it makes
> sense to be leery of it, but I would argue it's seasoning merits serious
> consideration.
>=20
> Ideally, bless SHA2-384 (minimum) as the next hash.  Five or so years
> down the road, if SHA3 is still in good standing, bless it as the next
> hash.

I don't think we want to be changing hashes that frequently.  Projects
frequently last longer than five years.  I think using a 256-bit hash is
the right choice because it fits on an 80-column screen in hex format.
384-bit hashes do not.  This matters because line wrapping makes
copy-paste hard, and user experience is important.

I've mentioned this on the list earlier, but here are the contenders in
my view:

SHA-256:
  Common, but cryptanalysis has advanced.  Preimage resistance (which is
  even more important than collision resistance) has gotten to 52 of 64
  rounds.  Pseudo-collision attacks are possible against 46 of 64
  rounds.  Slowest option.
SHA-3-256:
  Less common, but has a wide security margin.  Cryptanalysis is
  ongoing, but has not advanced much.  Somewhat to much faster than
  SHA-256, unless you have SHA-256 hardware acceleration (which almost
  nobody does).
BLAKE2b-256:
  Lower security margin, but extremely fast (faster than SHA-1 and even
  MD5).

My recommendation has been for SHA-3-256, because I think it provides
the best tradeoff between security and performance.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--dvjgmhllrx5bdeqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlizEoIACgkQv1NdgR9S
9osIfhAAhMypTzvraHB11FWdiVZ6CAVE4/WbYCziJbdsweW6kGsfqKYdhj4LDPx1
jIVa4eqCeIcsEtQnL/KLX9eIMo6GTmFgJ1ITenhavjL6wEBbrNyAqxdkqzPSHIVp
G6mCsvpahZ3nnEHVoxvyh4hSUKSdT0GwcZK6cDambBpPz89y/Pwu7ufp5lKrIRSv
x8ytfLEP3DH2bOH7/dKPsuaKogslpkHdHu956ud6MyRgzwo6hG8Cw6wYF642i2Ys
fHWB1cze5kwx4D8eH39mRKmmMvEKhkuSrRULgZtlzxCwmt9d+nYkISwMjoOuxKGp
K3rYMW3nUg2GQOoipKrw6fLhps9mJdpXa5bjI+PtJutA0tSYoLDNTFnJF7RLAb3j
ocROmzXK0ouCAV/npfozz5DAbCKjZ5/9r53dpcBzMRgPfOedU3/65I6/6WtgJdk7
ocbPaJCaJP0LxH/b8pZfg5y1OjCd5Mxm5jnr05yhJ6Q58wW7DO9BGmD/nE4D50LF
E/TItHjBnIxXVgxl83Cigmj3kBcdbZk9Go1BgSCFaEn7+I41x0KG8AXHKQ4G/gAX
Nhrv4NOGy5TTWSKbgQxBxFpfunvw6u+sAtDMSIEEVA/SPw+A9MpT6a0lj+BtAZ06
/VeuUIRuGuZ9NKnqfg9xXKgnocgXgdUpU9l8MEjUZkTI2d+yJqA=
=bDIM
-----END PGP SIGNATURE-----

--dvjgmhllrx5bdeqp--
