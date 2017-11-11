Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D4E1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 17:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdKKRdA (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 12:33:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751699AbdKKRc7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2017 12:32:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F1A7060475;
        Sat, 11 Nov 2017 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510421578;
        bh=v05cUyF6IeuLf8Hdvy8enW+2wURTJf0mdvLI2d3vk+I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wc5JBjy2dl56KKOcPVsKGuFjwVYyeFtg01Im9TvZMOTGvBPiogccdI/5t37YdisZ+
         VXcctfSHfjkbHLDdCuXqdHA30pB2CeBN409M5Y0wgmR/KRCjwSvJrUyOWgWmtm4KmM
         KwujnbMNhmXbhz4odi+Ue8XHMM9FkTm+UDybG5hO+Gbrx73iF+j8/1NyM0369pE8lm
         ZRTy1KZYdW1F8aZFXM5omVQ3amWs8B2S67gXD0gMrjDYWqTcSihjWabHKTO5Cy3Wiv
         UfusF9mVCWYpU4S90RpTrMKJI9ygZyBgVo5NKTabZDC/Q1eBKYrJf1NVdUkvHAN3LQ
         +gBJwYyGeLvdP/GtT2rwqgA0k3oOcukHoEFmJ66kNSdteQYAywlap4JLO1RsKG7IEy
         8ExYCFB/MRU+2AgwGDby4dxtWJ8G22/HYsTHhZU9ZqpOK7CNbAOghkmHmV+bKr1rHu
         waKL1gcDXC0e+/92IYJKVPXSzwIAPwh4cVXfDOueWs3crw10elo
Date:   Sat, 11 Nov 2017 17:32:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] Remove silent clamp of renameLimit
Message-ID: <20171111173253.idmyypjevwqblica@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
References: <20171110173956.25105-1-newren@gmail.com>
 <20171110173956.25105-3-newren@gmail.com>
 <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
 <CABPp-BGwoduH_T7U4uN5A-h43wREfXdQgV8YCVWf8w5N09cYSw@mail.gmail.com>
 <20171110234210.lojdat5zofhrdlgi@genre.crustytoothpaste.net>
 <CABPp-BHvveKW+UzTZqLq5h0bVUJLPqYpGu0CWQpYjHzzDbEWww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nymalhnep4zf3m2o"
Content-Disposition: inline
In-Reply-To: <CABPp-BHvveKW+UzTZqLq5h0bVUJLPqYpGu0CWQpYjHzzDbEWww@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nymalhnep4zf3m2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2017 at 08:39:11AM -0800, Elijah Newren wrote:
> Thanks for pointing out unsigned_mult_overflows; I was unaware of it.
> I think I'd prefer to not use it though; the fact that I had a case
> that genuinely needed a value greater than 2^31 (at least before my
> performance patches) meant that a slightly bigger repo is going to
> eventually need a value over 2^32, so I think we should just cast to a
> type that can hold it.

That's fine.  I had considered this in the context of 64-bit values, but
I suppose that the likelihood of us hitting 2**64 iterations (and
performing reasonably as well) is unlikely.

> I'm curious why you suggest size_t, though.  I have always associated
> that with an amount of memory that will be used, and there's no
> allocation based on this result.  Was I wrong to make that
> association, or is there another good reason here?

I usually like size_t for values that are unsigned and don't need to be
fixed size because it's usually the largest efficient unsigned type.
However, if you want something to handle items larger than 2**32, then I
agree that it's maybe not a great idea if we want it to work on 32-bit
systems.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nymalhnep4zf3m2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloHNEUACgkQv1NdgR9S
9oue7RAAzY9faWJQ1tcjSAb6aUEvE3ipgPGt/yqA1vdKDPTe8dapq2KlPyxxVFrg
krhas1U+jQ/WY72Uwl3s+VxNz5xnLhe1DHO3DIni74v6UQN0XfYRhdgxAWVltp9H
EKeo9WqYRVr+9qZ9Rx/laTEJ/VBLesZ0/U3iM/M+9wOU1UGkiZBKVNMY/mHhXMt0
nKqev+MJrofx9VgaPL/HRKVHfhgfs35gnAFduEkfiD8ppiQLWZdXBl4VJf5xQFzU
McFrtiB0QufKX/yBa5+SCVz0FJTu030itkuGO4DqnYIxNo9lKkfaWfPMbl49EThb
/ESedFETHafkxvjmq5A14vpuPFPFdMEBMiKdBfSz5Ow2Ko8FJvY8QNus/E+wnf36
oshEHYBO5tj1rp0EbU+BDr5X9JIelmpIgtIc0B5Wo/sHiWeM+SwCxsZDwztaV5/g
Xv7e/bAmBii07WRhZCbaUTl9vhrTO0sbsEgvDHzf/eqcAMujpf3SkB4bMt1+lp+0
80x7NkZ8v+LF2Nz9yFH3n/+cUUXQIAPeLwOC0VJpkjC+0CTllZflzBzc+mk42ChF
PCQ1bMaHZHv/ye/Q+bD7lmM7i946RJ+0rEeLCzEeq7fvglP9z6Qc9GG01BZWVGyW
MIUryviTM85PeCy+HxinFJwVT7e+fF0aHPTqODZD25T+JSwngdE=
=8KCf
-----END PGP SIGNATURE-----

--nymalhnep4zf3m2o--
