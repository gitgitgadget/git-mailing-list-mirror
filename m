Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B28D1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 20:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeDNUAD (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 16:00:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54850 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751192AbeDNUAC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Apr 2018 16:00:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8A2C6042D;
        Sat, 14 Apr 2018 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1523736001;
        bh=jL0OD4ERXTZliWHavI60wKNNNOCpgfZwskxqM7Zbky8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jv+4McRzUyoH2eEytIjSVL8K3jI6yD1a0k7rwXs/M+saaLWEMOamaneYaMsENWgt3
         6QpZpVFI445XzLQQ5R+UbpUnY5GSpU8uKEla1Q9m4qaAfxdiD9H/xm3hKpNBISh2R7
         +mf4v2QNoL11ZBfKI6W2ZXuWBJAoShqwvzon8yZIpCjeeaikdeqfKEtKuAEf53mcu2
         fWM41GmWn/3z/xyMDdFxxOdO9wO/0ZQ9M5cD606OdwMMvsgDtgUMyWWJJAwSHz7kUy
         iBOLZJYDUH5MHlh66cXJ3/MJofh+2JBK5rgUEg+jSynVpg68YaTqWafKAtvNgVGuc+
         XOJjcpkY2iOgoiSKjQ1ZPxR5uxz5D2kCooZQQnGx6d4Obw5s6OjtTtrhcF3Rn2sHt9
         C5X9aQt+RfBkUQQolLZKsOMHHD44d0q4MzCqS0f2OkWOswkugKE2bWrjjNjrWCuc9n
         OgoTboGEZkXXBbus7NaKG2Fs0rZg53BNnK2eRSnYN+0dz8yakcT
Date:   Sat, 14 Apr 2018 19:59:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180414195954.GB14631@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ben Toews <btoews@github.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 04:24:27AM -0400, Eric Sunshine wrote:
> How confident are we that _all_ possible signing programs will conform
> to the "-----BEGIN %s-----" pattern? If we're not confident, then
> perhaps the user should be providing the full string here, not just
> the '%s' part?

This is not likely to be true of other signing schemes.  In fact, other
than OpenPGP, PEM, and CMS (S/MIME), this is probably not true at all.
I know OpenBSD's signify has no wrappers (except a mandatory "untrusted
comment:" line at the beginning).  There wouldn't be a way to match such
a signature unless we implemented prefix or regex support.

It's currently possible to hack other signatures in with wrappers if
they wrap the actual signature in OpenPGP-like armor; someone (I believe
Eric Wong) has gotten this to work with signify.  I only mention signify
because other than OpenPGP and CMS, it's the only scheme I've seen
people use with Git.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrSXboACgkQv1NdgR9S
9ovnORAAqtNXLzmmBNETfL8qrcEudZNPB/nBjtJ9fIZkLqGhueBWfWprlwNGhdoS
etQTBlJr5S7hh9Ig/yZSC0SBqsM9NpiALZE0vz3lHqyTenmRhtfCFyri7QZOeH1T
RWyW3XQIsszLahXn2C9fyDLhORlNNQbw6s5q5AwCzvaP+PC1BYESDDBOjNUvZVph
rTn8jhp6Rd87QyIbOGt+S2FDHnwIGVnfpxRFB7EaeQTcHpKZ/6BCS7pbG4kIfDOl
z9zesrK8Or2bf7CNvzDP3tv0Foe6qLsFHDzlegPb/qu1YxhCd4sg5V17Txz5Q5kx
jVSclfOZn/CdbKv1/PNyMTWdM8u3x3g1+wLVlDamB9YS9nJjeaLuqMTVdiKWx1WD
JOon51nskT/9FJDhpwZkVRYSb1jckvigCfYM5aqcse1yhHUbPbm5WzqX1p4XDmcW
Q+HWfFrojBM1rN8vMWa7IONYWFq/PBXo86rF01aOuuGMuVkLyVQVAIy9TUnN6RDP
m+cVgNGL+Grg+MlbeFG1lVkV7hH8paRtrMDeUVRYXErJzVISKVxiNwbxNkWltuv0
skNfEOpF9FoeLAYf9pxdqZDTdlFtCgV9fVvIEEYmItSBW50bFFsBh5Ny1pOB//7Y
lwKNUmMZmaGtHQUetLjsm1re64wqZQQiTUmXNaHV95v8Q30mF4k=
=FEft
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
