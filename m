Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAE61F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeJIFIz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:08:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49258 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725759AbeJIFIz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:08:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 834E86077F;
        Mon,  8 Oct 2018 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035704;
        bh=APjJkPKMEZ/DjKq6DRg52SbxYHwJvH8//IokLhFUiKs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Of+SxqoTYJQC5CflhThj6YrUQGzrEVxf5j3BPu14zmy3652xExbpJWjf8r1/kNDpM
         QjtbUDcopc8q1JggYG8YVrTFNloVU9aSyA6cUrX0DS8meF1H/+9TL44dWMYbvze65a
         EEJaWGD4mcsf4f3dAzyn+4UTkFh8A+1/oW5D9T9Aiedv7zZqYPi5ELewiu4kV9gg7n
         P+je87cMd5Ojyll4q4AwEulsjEN5GnAKG9vGBnHk1Qbc86BllifrcIVpici/IfELXD
         Z+Xq4adojkcKtsw+LKBFMz9qlMCgxVGHBKT7X+2e0kWdHOwI5jwI0iXE+kGXnINL6k
         ZFhEQV3bINzk54bw4h+8BC/WhfZPugZmH85Tili1l5YNX4vt8gx5thCKI1TAcjqDWx
         6hoHlklzHLTODLqbuHg0QqJNNMJfXIHpcycC9O79LFRYPfgZENZbgMOw/lKYSklZ6j
         ibUIQU5nE8jyYr6rgpPJhclRuJqLGplGqpYCpWrFmdNhmO3phVM
Date:   Mon, 8 Oct 2018 21:54:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] editorconfig: provide editor settings for Git
 developers
Message-ID: <20181008215454.GQ432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20181008202903.100166-1-sandals@crustytoothpaste.net>
 <20181008202903.100166-2-sandals@crustytoothpaste.net>
 <87sh1gcg7z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TiGNc3ldf20CNpkJ"
Content-Disposition: inline
In-Reply-To: <87sh1gcg7z.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TiGNc3ldf20CNpkJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 10:53:52PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> It looks like we can add at least "pm" and "pl" to that pattern:

Sure.  I didn't think we had any of those, but you've just proven me
wrong.  I'll send a v3 shortly.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TiGNc3ldf20CNpkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu70i4ACgkQv1NdgR9S
9otcQg/+MPr/99NtGgvYRsUlQ38P68E43M6L3TwTHtfIaPCpOvwMJRzXmuI69EE8
DYXAaoAwJViVYJfnl6XiXWTmM2vysbA/gQfdptfcKo11esEQohJNM+hiQB8sp7bW
XWYAw0Nadl6eOgP+65wb9DZAX/i1l0aRzHOWdYSi+2oKM/1PXGboX4rWPZfG3KQO
fe3Zfnr3g5ABcwq5C+anGWZDJQCmv3fXHZRy/Q4ed9BB8IP19BOc5Ud4K3yH/yf6
BA/e6AoCvW3s7iUrkp4GbJ62cyCZhEd4HzenGQR+aYsKewtV1Y1N5ejI7FuCJcAs
s+te3gpkprzO1DVVjEZzEBrwuWsfDwUlcoKknfuI10Z5UFUtDPA5446he+vHJpv4
CW4jyvMHfAggOb4TOow/qeW/MgaCkE1U7rrGCFSKsrDVwBz/jtipA1QYfFhrCM4m
5+8tKnDurpwwllWEaBBjAuwwEE5AX48ePZrpnUFTPshSB6U4v7uI58tZP156+MeW
PD4WW53k6sWGnO0zUtClLYtSLcSCR/esYdAnes9hUVS2nRJGSolVDIlBPbRaXNn3
2uSDgdfPJ0hQuEIxtMV6eBEsg176/s81a7BLEzzL+qQIG/qcpTcnNM/wwUzxC9nc
PK7/3EVHeLecjJXdCH+Mv5NSUInTwkzkyrFhktb/khEOKzJm9XQ=
=pHVu
-----END PGP SIGNATURE-----

--TiGNc3ldf20CNpkJ--
