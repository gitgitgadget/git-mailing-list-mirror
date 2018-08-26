Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EBD1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 19:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHZXbq (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 19:31:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34734 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbeHZXbq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Aug 2018 19:31:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02CBD60745;
        Sun, 26 Aug 2018 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535312895;
        bh=399+146UjkEr+XZY7tPB4gNCboAF1Q7uobdBl8wlD7g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=W+3uVx/s1ujd2d7HxQlZ+xninVTKQ1icm08/mI4wmMNvdZKF6bAk2QUeLRUMVWfzZ
         ebFzGvEX2js860pvDsYy6vOq2kSn5AmfHqQl64lXxs1gr/tP0CPzfBwVFtPRVKjK9X
         LyFidxDwCzszXrvTypKCbk8RuNZ/7N044BCZGmOAtpFqjP/H7b4x1Fd78Tn+d8X1MF
         XKYupcWstzo1KcDb54kUSWuQiQ8IVe+BEmbc0+JM5OSPPgv9PaGME8cBo/r3FHg3wS
         qkwoh3YZz56RYSm78bA6nl6LuRQP54Zz/mEnD3R4xavMMlb9qA6Vo0vQMk0AI19wTL
         hfrRoks9dtRJaM7neQ5LtvxtUSLyb3wArU7l6E5zepvCIizVDMzLciEvdDd9S+FiA9
         LOu7ksxDDySjjRLI4Onnwcf6dh+T+MpO9QK00JJ6i2DD7o2KPsYe2fWTLLHNzebF9X
         59xG1Kz9kjvXYTMRPqQrb7bl/Bn/xRJBNcXRpZQKFGVCnu1MhkV
Date:   Sun, 26 Aug 2018 19:48:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'pedro rijo' <pedrorijo91@gmail.com>,
        'Git Users' <git@vger.kernel.org>
Subject: Re: [GitHub] Your password was reset
Message-ID: <20180826194810.GB873448@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'pedro rijo' <pedrorijo91@gmail.com>,
        'Git Users' <git@vger.kernel.org>
References: <5b827432100c5_33683fe5790d45b43591aa@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <CAPMsMoCR4J_gLBYCZpNW7JcMmdSGu-jFHpvVkQks7myYte1KeA@mail.gmail.com>
 <001101d43d52$fe25f4e0$fa71dea0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <001101d43d52$fe25f4e0$fa71dea0$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 26, 2018 at 11:39:30AM -0400, Randall S. Becker wrote:
> My first reactions were:
>=20
> 1. Someone is trying a phishing scam on the distribution list. It has hap=
pened before.
>=20
> 2. Someone set up the wrong email address for their GitHub account.
>=20
> I hope it's not #1.

The emails do appear to be coming from GitHub.  I've reached out to
the security team so that they can investigate what's going on.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluDA/oACgkQv1NdgR9S
9osEoQ//QvpJclGPtVt9F1FN7z2i+JsEME888aWvg9GS4RJKjAWzQYo5fHtdTxvA
4tZIev1B7N8MdeM00hHuVdC6TEyopJV7zKNzGBDgqs7SPz6vNJwWOgF8qWLLar5n
OSZnfZCcDIIdplgJkc/WRHc4Ri/jZFqk5itOrKehUjDPWTtziRfbSZnjpJRX1ZNS
r9TMGOh+g4+HGinspxfoEgpaHrhawVuK7C3PPwTKiwiZAPBd6cbaat1QP62gNsoW
t273m//7U1WER5fX7DhNOW7UtgO184FvlLlVO9sLVcpVnzCy5Z1HWtYRg98lUq0T
5henUozSENer8N5NBISCfF1rffSFEQBAmsErRyCdBmthgJ7pkuQYKi92YJGESsLQ
XRA4Mv/+qVxVzsNPo6nhR72QpDvd0ItiGjt8KfzTECG1fvUAH8+iNULU8RPknmQM
jj20rJAA+ZHI04gBWRNYgOkwHaiMP+bLHm/hgHuSj9AAZo/xySAbFhNjF+z5jM8l
NvGz3WP7WCpFDHFsAjGDQ+qZOEnXHMCf6GixyVFy8xrJ/ZFk6CfkqbnX8CZYgpaS
1GXJpyLgvga2c6ND4RjocgHwt7YlUXzTK4acs48yjWdJMK8VPNfNMukadTT/dW0i
V3VxcPj4ThbhoV99b9Psd4eAom8XcwBeeUlLlxvwlGp44tMnFlU=
=k64G
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
