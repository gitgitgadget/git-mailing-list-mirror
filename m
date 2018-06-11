Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465211F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeFKWf2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:35:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751968AbeFKWf2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 18:35:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0F436046C;
        Mon, 11 Jun 2018 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528756526;
        bh=x4d1Wac3lniZOkngUrtsQNZvXcYjsbf5hmDpjMZVerE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iXLdkjkJqRzMPU5hWPtv9UOZYtZsshiu8FNDiF2qhYQFlVA8O9SlmYOpHVPVs/+pw
         I8cRzwh4TPsRnxGGOhgDNWyWh+CtCXcBAHFyaA+6DByuFCLA35CG8f6JU5nhixQHTu
         Cm5KJni1y55yGZOi6bK+1B0xZoUWpQAJKj2MQzjC4yxlCAIn/yquBhCNPynNVKS2aN
         OR1Rqc0dJkTlZsmLsgWDATPmYpASoVmJfaJazJBiwrLhEHA6zM74BAgD+bEJgMZv5R
         RGjuC5a72vfJosZGLtJjEKCHUWjKJkx0VEbauVRG0EsAnHOQ2G6VQAigkMBQj7605+
         NkF743zmkZ1+i6l6tiRHn/a9KOWd2JwSKNF0C0C0Q2Qeih6caYcEUWbteru24AvhrR
         yyPjRZrxSLy0cdYhuUeEzNRhU2AtOMkksc90vNWPDlseX8L27bnTUUXmYBT2GbNsEL
         PdqisVCPSB3opqQ8XWoIXcGI0HpN9lYxykTKZCUkUMl8BoOVo/L
Date:   Mon, 11 Jun 2018 22:35:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180611223520.GF38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, The Keccak Team <keccak@noekeon.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20180611192942.GC20665@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 12:29:42PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > =3D=3D Discussion of Candidates
> >
> > I've implemented and tested the following algorithms, all of which are
> > 256-bit (in alphabetical order):
>=20
> Thanks for this.  Where can I read your code?

https://github.com/bk2204/git.git, test-hashes branch.  You will need to
have libb2 and OPENSSL_SHA1 set.  It's a bit of a hack, so don't look
too hard.

> [...]
> > I also rejected some other candidates.  I couldn't find any reference or
> > implementation of SHA256=C3=9716, so I didn't implement it.
>=20
> Reference: https://eprint.iacr.org/2012/476.pdf

Thanks for that reference.

> If consensus turns toward it being the right hash function to use,
> then we can pursue finding or writing a good high-quality
> implementation.  But I tend to suspect that the lack of wide
> implementation availability is a reason to avoid it unless we find
> SHA-256 to be too slow.

I agree.  Implementation availability is important.  Whatever we provide
is likely going to be portable C code, which is going to be slower than
an optimized implementation.

> [...]
> > * BLAKE2bp, as implemented in libb2, uses OpenMP (and therefore
> >   multithreading) by default.  It was no longer possible to run the
> >   testsuite with -j3 on my laptop in this configuration.
>=20
> My understanding is that BLAKE2bp is better able to make use of simd
> instructions than BLAKE2b.  Is there a way to configure libb2 to take
> advantage of that without multithreading?

You'll notice below that I have both BLAKE2bp with and without
threading.  I recompiled libb2 to not use threading, and it still didn't
perform as well.

libb2 is written by the authors of BLAKE2, so it's the most favorable
implementation we're likely to get.

> [...]
> > |=3D=3D=3D
> > | Implementation             | 256 B  | 1 KiB  | 8 KiB  | 16 KiB |
> > | SHA-1 (OpenSSL)            | 513963 | 685966 | 748993 | 754270 |
> > | BLAKE2b (libb2)            | 488123 | 552839 | 576246 | 579292 |
> > | SHA-512/256 (OpenSSL)      | 181177 | 349002 | 499113 | 495169 |
> > | BLAKE2bp (libb2)           | 139891 | 344786 | 488390 | 522575 |
> > | SHA-256 (OpenSSL)          | 264276 | 333560 | 357830 | 355761 |
> > | KangarooTwelve             | 239305 | 307300 | 355257 | 364261 |
> > | SHAKE128 (OpenSSL)         | 154775 | 253344 | 337811 | 346732 |
> > | SHA3-256 (OpenSSL)         | 128597 | 185381 | 198931 | 207365 |
> > | BLAKE2bp (libb2; threaded) |  12223 |  49306 | 132833 | 179616 |
> > |=3D=3D=3D
>=20
> That's a bit surprising, since my impression (e.g. in the SUPERCOP
> benchmarks you cite) is that there are secure hash functions that
> allow comparable or even faster performance than SHA-1 with large
> inputs on a single core.  In Git we also care about performance with
> small inputs, creating a bit of a trade-off.
>=20
> More on the subject of blake2b vs blake2bp:
>=20
> - blake2b is faster for small inputs (under 1k, say). If this is
>   important then we could set a threshold, e.g. 512 bytes, for
>   swtiching to blake2bp.
>=20
> - blake2b is supported in OpenSSL and likely to get x86-optimized
>   versions in the future. blake2bp is not in OpenSSL.

Correct.  BLAKE2b in OpenSSL is currently 512-bit only, but it's
intended to add support for 256-bit versions soon.  I think the benefit
of sticking to one hash function altogether is significant, so I think
we should one that has good all-around performance instead of trying to
split between different ones.

> My understanding is that all the algorithms we're discussing are
> believed to be approximately equivalent in security.  That's a strange
> thing to say when e.g. K12 uses fewer rounds than SHA3 of the same
> permutation, but it is my understanding nonetheless.  We don't know
> yet how these hash algorithms will ultimately break.

With the exception of variations in preimage security, I expect that's
correct.  I think implementation availability and performance are the
best candidates for consideration.

> My understanding of the discussion so far:
>=20
> Keccak team encourages us[1] to consider a variant like K12 instead of
> SHA3.

While I think K12 is an interesting algorithm, I'm not sure we're going
to get as good of performance out of it as we might want due to the lack
of implementations.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlse+SgACgkQv1NdgR9S
9oueOQ//bsCwkEY7k5Oe0xQqyppln23BeIA3CGM0P+FYoEokb7bYic6ay6TU8dRm
I0l/ibirQUbJskCd6NTrgoVul9lM7TKh5aHpz2M37dqHYcwcQVc9TzGlI6pjGHxE
L1XBHNUvZoJlhbzJ3TXqkE3iVGYSasoNI3GM2+M1oCM9pAwbKo4QT9UWASjmPM9K
n+1aL1mpHDznSLRnwUSLXkcNyDpFQ+EQ5Yz2FYh3SZgn8aUkyTPeh1YE/bAxT04L
784zb43rKqLNPIP73OiNJ6nqc3QzhfJH7TRnHWTvRwgQtfoRNiaExmjVWivrNrZw
S/IMxAxuSxpT6NvnwO+TOEftnUk0haeVibwF5Xd68uA3wJet3jEejpXICcxkLdnE
sJpgy19770fNQyNgWIcAxlpj/b8SLbLxZrNpnkLILfGOo54ugZweWqk9ebr6T+dB
zVKcd6T9TQIEtCa0XGz+NR4VnJGBQzZB+hcRiPMGosr7uBio4Ly4CXxPCHLVEM2l
aIaPFhtkUuCh7lU6faB2KE97YeU8LJsqMSjweUiqzkhEnvyLFsceOGRbG4xvYnH2
sEO6uq8venvaGGcbHchguu+MKvY+7xeieTL+COSmmF9D+MuCMmIpLTfbP/hpGM64
reOk/LiD0fohgEgwxxXkUucCN1gVhWyuCKAphBtPK3EQAKBddpA=
=tpCq
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
