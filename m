Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64708C33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3682D2075A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G8obx4fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgAHCzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:55:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgAHCzP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Jan 2020 21:55:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1EDE60482;
        Wed,  8 Jan 2020 02:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578452114;
        bh=rCw1jHuqRRDvqZOdWGSYIX9se35Dog73k7vukH8bcEg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G8obx4fxA5vHRxsjSI8rEEvI58aPR54U73UtOPRKne8Q0DRLDyoNoKFR/mxThlepQ
         6rmb4Yb6hfYkZN3g6CYCx6a43oKlL5N2Xroul6NGbdCzRMed0MFB4iwZHUz8Dtvb7B
         Y9vP0+MCJZiXGv0HFDpAH2Z3kQV8UuYqScFUfk/wzCOAnx/YHyJP3uY7BkHmkw0yml
         SFsy63EUxw6mIhvyHLVBVFQgIihwcMYDLfl/WS/2XwPmXLav6r9WfBnr6+SqPJ+YE/
         zqwqBXjYAplnxFF0iD/j0dbRTkMWlCKxyYD+gMRbzOHA8hLDr0wcg29uv8BF0ZRPaU
         vFNyiMjKbo+4rFAVnrfXe0MILhZXUfYStxDkwRn1plWXKNEgldns16mpbf3Z8NAsoO
         zPKiyETqLKSM/bAkWrqMoY/dZzTs4dA22C3p6AI//0hCUtPEbo/kuDVZdDPgpZLN9A
         CBqsY8Yg0aIZWJnrpqy3nb/S9OEGSgCxHTNBTsQ7RMh2Aw+ecDv
Date:   Wed, 8 Jan 2020 02:55:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
Message-ID: <20200108025509.GM6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
 <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
 <20200107013401.GI6570@camp.crustytoothpaste.net>
 <xmqqlfqj6y5n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline
In-Reply-To: <xmqqlfqj6y5n.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-07 at 16:15:16, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I can see the argument that this makes it a little harder for mechanical
> > processing across versions, but I suspect most of that looks something
> > like "sed -i -e '/^squash! /d' COMMIT_EDITMSG" and it probably won't be
> > affected.
>=20
> With the left-anchoring, the search pattern will no longer find that
> line if "squash!" is commented out, but people tend to be sloppy and
> do not anchor the pattern would not notice the difference.  Perhaps
> the downside may not be too severe?  I dunno.

Sorry, I was perhaps bad at explaining this.  In my example, it would no
longer remove that line, but the user wouldn't care, because it would be
commented out and removed automatically.  So while the code wouldn't
work, what the user wanted would be done by Git automatically.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4VRI0ACgkQv1NdgR9S
9os4AQ//bNKadUfDyyzncIS+heXz3LNyerzvW3FA9chhsa+DSZ9BLpM0JTD3Zxfb
emk9fphqntUXr92p/4K5iwAo5TFJ/B9VLn8bHZJ7l9ejcqMYgC9piJuMHOz3D+6N
Q85cvCyh767CQLUhWVLSS6Pdf3qpklIyFiSj39iqD7XxDfiU28GU/RQ4Ib5vb/Ho
H8PiEWHEPlaV08+0xL241Osx+haRJ5v4CmL6m10b4+akMEY0AAeGhVJBZW/m8Bn4
SPzq8aubbYyCp+aFgFiFYiSXMKHlyk1IS9s0hrpuJWtU2D2kbsd1aLe1qcx32+6D
XtyIu9dZGr0etS8X7mK8Apvt+ygreD4MQLfvR4h0jKX5+LudyFKyGB472tMSsSVw
+VKMZb7Vpb6VkSvk9XCqslv9ePmNLDvybGZb+XG4yrdiYio5dZ5emRvD5Q9am6Ts
WMoavwV/Ycyy6sGyV/o4ZUAgnMX4EKPnS1Gq3RLiHJaCpxFeqmq+fnGrPPcK9EXT
PG76Ni25OWhzDXuj6V2SAagkj04HRbFgYAVHoxSinepowiWoKZhmOmCHnlMDXTJT
ARv61UMXAufRu0nEl/EoMmxObpQkee2r/jh/I6QnMCAAkLrfq5kL7w0mY3+RNxVl
jDZI2vGq5urrwntwNRh14t5U2Bjc52OkANylrpwgq98kfvU05Oo=
=YRrB
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--
