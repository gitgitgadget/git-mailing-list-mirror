Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3261F576
	for <e@80x24.org>; Tue, 20 Feb 2018 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBTLaq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 06:30:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33652 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbeBTLaq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Feb 2018 06:30:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 820DE6096E;
        Tue, 20 Feb 2018 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519126243;
        bh=8atPEXa8Q7B51oo423TPD2w762kRIF98QRQF9OcmZlA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CSroyMfG3WXeaR22kQ3t28WOpT3w+KqaxoZAjrEYtfLEDiHVIMDeHs0kffyE4H7Tf
         omWKlJoiDABqGYG3KnEsnUom51w/L4g5TqgjpOGhXx1IxEDMJABJpDZEasIrYyzdkF
         PsBt3m29eSIIC/mjdMQYFzMR6OhiZPHHXwTaamboeNuGWyYQzTkoDcmlGRlWN/2wpT
         9/EZ/azLcxEuqqUETy1ZK1rQYdjfr4lf+xtIT2lEvDKc4ojlE5oJAMq5GtuqHx3ihW
         8rXQxYTJ8iD1ACy2vMQca94nu3jTPWe8lweYo+2t+4g0rJGx8Gf8sBvJ13yXlovmQn
         Mp4h4bSpjen8bNd+KGDCp6h8cUfuToyjusfOIq8vGyRppIck8FAk/AC2vbPm0LPfnO
         2t6YW9AV1OJpVEVfyWWjLOqooiQkDur90N5Yp6lVR+cqZ/wDvNrgnJl7VkfriwxlvO
         DHOQmpf6PV+PVT5b860DbvqrhP73iwVa0nguVDqi2GpyIMstLpR
Date:   Tue, 20 Feb 2018 11:30:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     marmot1123 <marmot.motoki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix misconversion of gitsubmodule.txt
Message-ID: <20180220113036.GG6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        marmot1123 <marmot.motoki@gmail.com>, git@vger.kernel.org
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
In-Reply-To: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 08:51:46AM +0000, marmot1123 wrote:
> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `s=
ubmodule=E2=80=99s`.
> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.

While I agree consistency is good, does this have any effect on the
output?  I think AsciiDoc (and Asciidoctor) produce the non-ASCII
format for output, so this should be a no-op for all known output
formats.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqMBtwACgkQv1NdgR9S
9ouUEw//ZeD7CiZy6hmnD+HntdvLwuX2nrOvvUe1o0/9KxXmNrxKo+KeZ/9jLfJT
RtTyD151cIJnr4njqI6Za9TrEt4ffZJBPV1T8yMMsekgfLnASQADYg1NbXxGJ4mI
IlJosT/TILh/UbRQbT/iDNlJGh5WDuJzqxCUwl4wHbjxC0r1tDRc+M6F6swajWfg
lbWQhbREDzV1ECQ3wsdq1gH+PpMy91+75kdxtvR6UUiUlNpC/v3EEatFjo7eSWWy
G3gVOokGvFy1MF0STyuwmD0ZMzJwqIg++gp6wnYAfCHWErkDmmTlMlednKLVGQ7s
2ZYNBo1c0glkV0f/afnTEF40u/3guNzcamV90Se4v06tWdjZ2HYa5svcPwZY0dKr
/DZDuGaIT+LtNAA1WyX4WOVBWqhn9UzXrA7H/H6oCtGGdePbbtvXH0+73GJnIOKk
PQw13VxDe60YVWb1DqNjtez6XtTcxzkhIz0j8gayP+RawjPLDlWEetfqu4500C+c
7DyZ8bj2ri4SlRNZo4BCP53JFXOxNEA8s9+29SkK2JXQNyaKb+VEyzOxYLRZRW1h
wfnPeFQ9U411Y9uvw5DdAzNGjuHbMuRlaKY99Qch+ymGoXbGyRgy2QjpFZuCX1YX
4uePtncELB6dX2Y30CRBQ+gc+89sDsp2oXLJ95x/Wb+4CYUNR2E=
=PNIr
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
