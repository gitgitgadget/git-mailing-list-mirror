Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B14E1F461
	for <e@80x24.org>; Wed, 15 May 2019 22:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEOWzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:55:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfEOWzo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 18:55:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F1B1560443;
        Wed, 15 May 2019 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557960942;
        bh=1MWsxa1DLGETYm8IOYXSbH/4dWIiVo8GpcO6LbT9d5Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s49ozMRM5h3sF8CAsTCOkfMRjT700C4bny5/DDRoDwJs2LbKDmIOo2/aB48DGZz0w
         usQ6CXuM8IKSKjt9ovG/z3Ijx1KU2Qi0ah7XRtNZ+T1HEnCTYfgi01q73KMQkK+/uq
         QjkHoFtQEhvpjNhdMwT4O8DoKgawrxFh4HX+5H/bLtn41zE2tmxqXNL4XnBL2hDBbV
         BBYwAh0CmK9KRab4Kq4fw3llYw5p96AVqFSF+j5q1eVJlQaKUWwFfGTLd4LFYRPsJ4
         qvNukjc1X0g+sVyBui+V3/Oyco/V2kJXpkQweEEbOpjvW2rtG/yvsyF2kIC6NfVTHa
         x0qc7QXgomjBavYXwXr3kNPZcEPHEYlttURXZKfC/RtqGXxmBU2M4mT+Gw8DpydV1S
         pf3kdxXFicAwOtkyk464pApyAPo1HA0c8qwnjvNx199lwDvrQS3+piMsIayOinlqn8
         IwAczLVXtqEK0k795vglOxIdNYgCGm+4iidghA6+M72nYWQ2cV2
Date:   Wed, 15 May 2019 22:55:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/7] rebase: add support for multiple hooks
Message-ID: <20190515225537.GL7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-4-sandals@crustytoothpaste.net>
 <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Content-Disposition: inline
In-Reply-To: <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 07:56:49PM +0700, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 7:24 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > -       close(cp.in);
>=20
> In the old code, we close cp.in...
>=20
> > +int post_rewrite_rebase_hook(const char *name, const char *path, void =
*input)
> > +{
> > +       struct child_process child =3D CHILD_PROCESS_INIT;
> > +
> > +       child.in =3D open(input, O_RDONLY);
> > +       child.stdout_to_stderr =3D 1;
> > +       child.trace2_hook_name =3D "post-rewrite";
>=20
> maybe use "name" and avoid hard coding "post-rewrite".
>=20
> > +       argv_array_push(&child.args, path);
> > +       argv_array_push(&child.args, "rebase");
> > +       return run_command(&child);
>=20
> ... but in the new one we don't. Smells fd leaking to me.

Ah, good point.  Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzcmOkACgkQv1NdgR9S
9oub6A/+IRbsEYT75HYeHxJKjMGuSLB2RjQ4TXadBNgfAMtDexnpjHnA9KqAxgkl
DNM0a/qIF4KXC8d4jw7eoZ+x1+evZqKUYb6RQ5xp99aHG5Ce1IGaj4vsP0NLoTYV
+ha0iqjo1h8B8i01muRTS+353sTvbprpivK9NgbZi6LZxm+AJWWc6Qi6QSMI624h
G4vLpowFskLXFna26Iznxf8ymaubvCgHcM07k9JNT2B7pzQsLgXZ6gncJhmFcY3D
TG4C4D3w0aRr6AcqJy5kvkK8RWUcGX2ZBgH/s0gIekygj1lKDfVmMXVkxvxDPcgN
U2yyo2UjW8PW51dwXRwuE8HfsRPjgw2zrFL57hlWMv/YzPvz/x2+27IJJSRDjc/j
qMGQSHKQ1AZDvl72CFihdMbTj5wxMHOmc/u2be+6YuvD6apmJO9GZDLNc7CuGW5Y
XAqEKKVCwSahoQ4kALhx+Z34RQp3Z7RgwY3g6i2kWCKr2E4dQuhMni303bEChDL/
XftrliT/Ya+NLdgoKXIF+4sI0qHn72zHKsxLyXwDxB1+N0/Gr2mN5GTAxy5XFvnU
7pJrOUr5ASB0qEISfCvEdQBXErZRwa8B5WkRwNazkzGL8vmrW05XCfIIaqB2NbvZ
ZRtIEAHObJsHD5D1Z0zXprvhfea1/Wj6q22sW+aiTfdo6Q9I/Vk=
=fEEg
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--
