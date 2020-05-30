Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06EC433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E6B2074D
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JpCTT4TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgE3QuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 12:50:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38956 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729006AbgE3QuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 May 2020 12:50:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 94C736045A;
        Sat, 30 May 2020 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590857379;
        bh=N8xTtEfqm9/biG/QjGEPKwXJI3Dt4E18VMXajuQOlHs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JpCTT4THOKVGKo21Ho6SHWi8nMHkIIvrdo3V0TepFX/MIDNmnvnxVWAeztMkF8QKF
         PmDj1V5LjD09ZUq77S0Ex5pVQCQdmli6hLlurdJhRfFBq84Hf20Pz/2czwdBYHwe1P
         KFb7z/G8nMm88vwiV04thWByZHyDHwllnj32bW7b1Cn4Z/+i2Rg0PjaYLkZ40NafKN
         4QZisaJPUk14h1o35oibG1/EWZbX85mwG1XFdWTqHgUD1VGyXLR01/hVPbfU6aIcp6
         fRZRfvnSdk0PG9YW6bPwJLSnAMo4gifdiUgYbn6iW3cXfI2TIF2rTdNtNeYciMo4vq
         HKULXF/7EFk+rgMO6M0buvqTANjGmOIf8+IWAErvh3nnUpfo08sgoLmJv0LDXZWGga
         Ad3od/ZMxdqPdnDxi5sOosKM2Wkmq9erMb02S9/rt5/DTV9Lg1YEF9RRoGQ1xCCy/f
         rIReftb+/QPvlUelZtehKCho3IR85vNzCRyMSGQlJfBUpUXU/5h
Date:   Sat, 30 May 2020 16:49:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
Message-ID: <20200530164932.GK1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
 <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
 <20200529223200.GJ1915090@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2005291539080.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GU3/x65mZ6MFE8p3"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005291539080.56@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GU3/x65mZ6MFE8p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-29 at 13:40:03, Johannes Schindelin wrote:
> To be quite honest, I had no idea that it was a pain point, as it did not
> come up on the Git for Windows tracker.
>=20
> Do you have a list of pain points on Windows that you're aware of? I would
> love to get my hands on it to triage, prioritize, and address those
> issues.

No, I don't, but I've seen this particular issue on Stack Overflow
probably four or five times and answered it each time.  I didn't think
to look at the Git for Windows issue tracker, since I just considered it
a difference between how Windows and Linux report symbolic links, not
something that could theoretically be fixed.  Obviously I was wrong.

If I see more Windows-related problems show up on Stack Overflow that
aren't on the issue tracker, I'll send folks your way to report them.  I
want to assure you that I'm not intentionally depriving you of the
information you need to fix problems; in this case, I just didn't think
of it as a thing that could be fixed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--GU3/x65mZ6MFE8p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtKOnAAKCRB8DEliiIei
gQTDAQDiupoEMDgNhd1cbWozlXgu7B+HnC3i2urFCy27Qa/3JQEAyUu10mZAjvcF
xXUy9RgvjzmO1aw2ACHm9+r3ywhzPwo=
=2AoD
-----END PGP SIGNATURE-----

--GU3/x65mZ6MFE8p3--
