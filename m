Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1864C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFF20714
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yCPpLu9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGXBLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:11:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgGXBLe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Jul 2020 21:11:34 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 331AF607A2;
        Fri, 24 Jul 2020 01:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595553093;
        bh=0MbEcYywQ0le3Wk3fFQzFD89uf54rk4c1n9uUC0fnnA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yCPpLu9xYa6n07w7KrczuJJ0ZGX0j8pIP6XCxMT/XY/LyHfyNFqji8WiUV7zMj07G
         jxIs4DWm1Ss3O2rveu1fyDiT8+adJMGKRBbwydDbXqV4JqOGzDVsgwzAN1t/h7ThT0
         Ijtsfvi7VPt8jzvTE3nMjwHrjf8KCdNvrCQevsSodHzQB8NHNn9/1Ns1cRh0AWrPIM
         r7jqCh3yPgSyQ4HpOqODjYQ77RcaCMF0yvxUhxm9WNaZt0t3dpGkr0CWbIvnxFC+xh
         ocrqv86n1ltKGT+1fZNRnPy2GsFtiey9vS2Jnoo+TSEek9oyslHuXD5NbufWrmSEL9
         G8QiQaalJ/e063ays52WU6ZP//i7GB0Q6iOhWC9tZRdeDhbiALj7/OufiRxwPsRwkJ
         J21CrXPYSWv4a0BnIeWjzFNbnTaA9VLmzp2xTQBAzNV581m4jGnJQVCkLfydmlj9Rv
         X7BeT8OZDje6bpVJ9fMFSOALZT2U7C+v6qzKgMdm+zISwF3JC2c
Date:   Fri, 24 Jul 2020 01:11:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 31/39] bundle: add new version for use with SHA-256
Message-ID: <20200724011127.GC1758454@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-32-sandals@crustytoothpaste.net>
 <CAPig+cRWptYRJUpT71jW6_O9UZ1RK=FCbZj-+OkR_5kGqSWScg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <CAPig+cRWptYRJUpT71jW6_O9UZ1RK=FCbZj-+OkR_5kGqSWScg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-23 at 05:31:15, Eric Sunshine wrote:
> Rather than having to worry about updating this each time the format
> changes, perhaps just say:
>=20
>     A Git bundle consists of several parts.

Seems prudent.  The reader probably doesn't care exactly how many parts
there are, and if they do, they can count for themselves.

> I wonder if it would be simpler and cleaner to do something like this ins=
tead:
>=20
>     cat >expect <<\-EOF &&
>     # v3 git bundle
>     @object-format=3Dsha256
>     -[OID] message
>     [OID] refs/head/master
>=20
>     EOF
>     head -n 5 "$D"/bundle1 | sanitize_oid >actual &&
>     test_cmp expect actual
>=20
> where sanitize_oid() is a function which converts a hex OID into the
> literal string "[OID]" (or whatever). I believe I've seen you employ
> such sanitization functions already in these series in cases when you
> want to verify that an OID is present in some output but don't care
> about the actual value.
>=20
> Or perhaps this approach is overkill?
>=20
> Reading further in this patch, I see that you actually do employ this
> technique in a new test you add to t5607, though you don't bother with
> OID sanitation in that test.

Sure, I can do that.

> I worry about passing binary bundle data through 'sed' like this.
> Historically, some 'sed' implementations would drop the last part of a
> file if it didn't end with a newline. Even today, not all 'sed'
> implementations necessarily pass the binary data through unmolested.
> For instance, on Mac OS, 'sed' adds a newline at the end of the file
> if the binary bundle blob didn't end with a newline. Perhaps a more
> reliable approach would be to use Perl to read the entire bundle in as
> a blob, use s/// to munge the @object-format=3D line into the @unknown=3D
> line, and write it out.

Yeah, I was slightly worried about that, but as you mentioned in the
followup email, it's probably fine to just parse the header and verify
we reject that.
--=20
brian m. carlson: Houston, Texas, US

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXxo1PgAKCRB8DEliiIei
gcmZAP4/1xMgKWWdIvV76FJauIUxcPcFsj86ti7thC6K6dIuewEArAvIyg2mLLdf
Rw6pcDrHUVd+x8K80ehQPhtHpPOKTQA=
=ZJU2
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
