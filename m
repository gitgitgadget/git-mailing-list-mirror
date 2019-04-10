Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB9020305
	for <e@80x24.org>; Wed, 10 Apr 2019 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDJWm7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 18:42:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfDJWm7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Apr 2019 18:42:59 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D70E460458;
        Wed, 10 Apr 2019 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1554936177;
        bh=YmVa/dDjSEa00g2FvdEvMAjNlykd3rADt+6RJF2/I8E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dzRMHuAWUtJKLd0EiDwzLCbwb3XlMxncvBObguBkxenwvn2AjOclIyz/4yXg2Q89R
         waUIyAdg53z7YB2IbVyhvBvoxHi2MjGDObybbHXJwi5nK7orifdtXxIPb6AgzajyjA
         HVE8EYSxzGxscA8A815OdQKnRPk/y4TZWdT/M6qWHE/nLG9znz3Yi7XcTn/YlfL0cq
         I7EVvcxLfyVUCgDPWuuRbP+uq2w0ndI/wWDQ0Iy05usFu1z/lfL4s+MFu3Pvx9qUh+
         eo6biPcA88CI/eqwL8tOUn9WhPW5yLit1qLBZScqzdsNSsg449qqtSpCu+j4oiXjet
         JwobvTXbg0w7VJ+Scm2yJtZIqGpfaEkhrTMG6XJGSS/uR1+LYimWO91V7lzpqsicSR
         UMZZGv5O/C7wma+w0q1OABKqknDA7Q1OyUgqUhZTMmfaQWLPgN+297jrj/FUPUwvdi
         76Ii2FFlqSf9Ze4UaG8ephnik4eXy8aoFk9Uxg25ai1kgVUvp1j
Date:   Wed, 10 Apr 2019 22:42:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
Message-ID: <20190410224250.GJ12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
 <20190409215856.GD92879@google.com>
 <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
 <668fc68f-4d94-39e8-256d-55229472761f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6U88vdWm8UqIXvc"
Content-Disposition: inline
In-Reply-To: <668fc68f-4d94-39e8-256d-55229472761f@gmx.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w6U88vdWm8UqIXvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 10:40:51PM +0200, Heinrich Schuchardt wrote:
> Sounds reasonable. But including the tests requested nothing I could
> easily shoulder.
>=20
> Just a quite different thought:
>=20
> 'auto' should discover a safe transfer encoding. Why does 'auto' not
> discover that a patch contains carriage returns and should be base64
> encoded (see subroutine apply_transfer_encoding())?

Because nobody thought of it. The original rationale for "auto" was to
replace "8bit" with something sane that worked due to long lines as an
alternative to forcing people to choose it themselves.

And as the commit message says:

  Choose quoted-printable instead of base64, since base64-encoded plain
  text is treated as suspicious by some spam filters.

I'll try to see if I can write something up to handle this better. If
quoted-printable works, I'll pick that; otherwise, I'll choose base64.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--w6U88vdWm8UqIXvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlyucWoACgkQv1NdgR9S
9osRyxAAuWNU/CEqptGp9Eex+6LE4hHxk3qaVAaprLXJWJOqFvt1r7IyRcrc8VE5
5carFpPIFbu7u9EaZeBwULePagMJyO/h6B4b0oLEiOWjHGAtSKkjSubS/DeneptV
Q5wLpJmviPRTIeGgjEWim+s1ZItOfYQlapnLfiO/HknZ6aWrb3+ThuaF6/WedxMm
6x2HMUHJmDVVBKH+iuzTkAsBFCMmmh7r8NcaQozV+V4qxXN4OmOzI/+dfhgRf5yH
0t1Y6don4wNjVmovRoauT68D9ne5HrHblaCbkLOAdA9JT7EGIgZzO6SaijjVCAU2
3OJUWDq9szuMJPnNmXp6cIof5mhSpOwvlBgym18ogSHV+mPnNFuEXepgTxS0JrRv
0tfgSAI3Jknq8w+mGx8VsiZD6pYV7lQIJGm6LSu9+EXrmPDbvCDMxwpryP4CtGwM
Mks7ZHJRelpcUVc7d+l/JBTt4DWWbyW2Mtv/j4QPlkOmTDVgtB7ZsTpFsTirnXQ5
uypM4ah3VS934KsFf57C3bd+jgU+5yQbwSgVOz8BYAP5wgHHfmimb0o5Dr6vWH8r
k1c9VquetSoZ2t2MH5X+9QqktAWpvBlV0VNAyQzm9L4XjTVLsCL+KsaFH+2jtI2u
UhCuMTf/LjNAbiIbmDNGOKYQ4bUd47p24mYpifvaPV9PooYAICE=
=zruD
-----END PGP SIGNATURE-----

--w6U88vdWm8UqIXvc--
