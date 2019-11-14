Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298E91F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNCwv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:52:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbfKNCwv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Nov 2019 21:52:51 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5061B6052F;
        Thu, 14 Nov 2019 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573699969;
        bh=L4z7d43tEL2S7pxfLWZAbWhfa3olGDR2H5lr5Xlcy3Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EZQL1bKXYaVxso2dXCsWRnElx2gMFfHahkThXmENuE8TExf0A4wep+uDKRnyqHsEB
         LjIwYeB5akOSRhzEIR3n12d1ZZqRVD0yAVK0aKWnmWwh1IrD9mcZAtte8rr07u8/FD
         QsH56RjrE7YBE50JppHxGjKvDPrlDtA6KVOiiC/nwHTB31wd1FNhg9ZJlKyu1GtpIW
         uYMEmHjwCLwr7yI8ua44mP6v4wtRCA5K5FAjwFwuREeW4hprsZsrjkBbc9cWKNosh9
         pbN57YLirgDXy/UXGML2JtRPDC48BS+Nzz7JhTTbEQLmQuH2k826gFf9jfO4CkZm0+
         hjVHbAM6N2Rl4yKBPmlVW5J9ygbADVDBxNu9+7y7LrfMBLcp20DK1ai5LN4xEANWr6
         myL57TjgplWHZYaUUokyNGEcA468tLfH17rr7q1WNv/+qzJn7W+AdIXdAyLeAFyuc5
         KR8bGPXQKwccU8lOVUsbArUcf2DcDdTX9PV23ndFOxjDcI1tjI0
Date:   Thu, 14 Nov 2019 02:52:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Marius Raht <mariusraht@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: Check if commit is existent via http-protocol
Message-ID: <20191114025244.GC9216@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marius Raht <mariusraht@gmail.com>, git@vger.kernel.org
References: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-13 at 13:14:00, Marius Raht wrote:
> Hi there,
>=20
> for the development of a git client on a SAP System we need to make sure
> that a specific commit is existent in a specific branch. For that we have=
 to
> ask the git server for the related information via the http protocol. The=
re
> are two option from my point of view to achieve this:
>=20
> 1) You can request a specific list of commits of a branch by index (e.g. =
"1
> to 30 <sha1 of branch>" would send the first 30 commits from the server to
> the client of the branch "master"
> 2) You send a request to the git server to verify that a specific commit =
is
> within a specific branch=C2=B4and the response is something like "TRUE" o=
r the
> sha1 of the branch the commit belongs to (branch of the time the commit w=
as
> created).

I think there may be a misunderstanding of the design of the Git HTTP
protocol.  It's essentially a stateless version of the regular Git
protocol which provides data transport (and as a side effect, ref
discovery).  It isn't designed to be an API that can be queried
remotely, and so it intentionally supports an extremely limited set of
functionality.

Git supports a massive number of ways to query data, and there's just no
way to efficiently and securely support all of those methods natively
over an API.  In fact, some operations Git can perform are potentially
expensive, and exposing an API to perform those is a security problem
(due to DoS attacks).

Some of that functionality is available in various Git hosting solutions
through their own APIs, but as far as I'm aware, there aren't any which
perform this operation (which is essentially "git merge-base
--is-ancestor").  If you want this functionality in a particular
platform, I'd encourage you to reach out to the provider of that
platform to ask them if they'd implement it.  However, I don't think
we're likely to implement it in Git's HTTP protocol.

Other contributors are welcome to chime in if anything I said seems
incorrect or off base.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3MwXwACgkQv1NdgR9S
9ot/zBAAmItJ/Q87tnFz4VyiytzFpkZ4vPn+LbXPK1h8wIh1Qug/lJraCNmRyfis
hExkyxxxLFdzpT5j2k2pvXyIBH0aijM1xMO9uOqrHrUdPM3JfIJuvdl8TNEUVz73
4PP/VgjNobF+O7yt3p1qlm0DWPq2/+JjsWZI39HrB/frMnCLTY+c3YRTIE0VCJm2
PGpbluocwX2RWhmI1Bgt108dMvoFHLH8x1zgZjztubPSSB09ysXPulL49SfWwM1f
OuWvKtBxTNmnePgwq8uJP9w2AJ7hdNMJzrRJc//zhJ/QMRTblyKJv8SOFsaa2I7j
zfgd5HxclNKV7GaKEltJt34URbEBgrsXC7Eo2d5fpKg+jUec0f42xJTmL4VpBQaW
sSgVrHhzTN8U05DDHf92dK6L4njDl2857jW7rjFzbvPHWDW2cLHtdBqb4VJQBVzr
G2m38Klbasnm9m5gw3n3yDfzQXhrnmkW4DKlOfdEcB4AXJ0w7LKmDU7AzmfgE5fT
a/k/KqOW8h5sYqLLZPV2qYe0otJQLUgntA4YXdss5t6OjtxEDhJ2mtCiIKGzUh7F
Sj1oshuemfvVunZ4I2JWA5D39KcizdlbA7bTsQSZwd6wndeahheETiw3SQhigdEw
H7GdU+MqQH+N09Nfwe0BOKu/prKK+TzT6aZ/l5Rej934a+OqV7M=
=jH2N
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
