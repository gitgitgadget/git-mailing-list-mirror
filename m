Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4021F404
	for <e@80x24.org>; Thu, 15 Mar 2018 01:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeCOBFq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 21:05:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35896 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751390AbeCOBFp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 21:05:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE31760426;
        Thu, 15 Mar 2018 01:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1521075944;
        bh=e+X6YwnBbZLf0Qwd4HL0LWvIXTY8RjaUqwY/QZwYIXA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=U40ieyKFL/ooLPW7zdF0R1O+6GU3RCMBtdI6v824TZ5eRNnDZ0UqEyN81BphOP0ZM
         utRIblOipSLsFBRtIpOrUBYYs+h7N+LfAk0PI+v76NdIL/rzRVTHsAw5e1pE65JMbY
         TvYalYsAlNjjgSrYyl+C5K0qT2xjV525hqXj+/ATyjf8QMYfkcomA22cnoelgyNVtz
         pZhJS0cLZTzUCa1EzrVk+PnfQnouLKrQqhuCKQEbhTzKuPqDmJ71mltvSSOt2FS/o+
         ebJhGQvjj/NYWXDF7WmPCRoPnPJ2cyNw27PEisoFvp/M4L8ViN8HmY3cuRO4PKlw0k
         2E4x7J9vT99KvzXGHKo/xTElaQqoO2ZUVPeW9WZcb65L7nrrY53hGPd8+e5AIeBmKE
         hoGYEVLH/oLlxbeNzx9mm00mHMpCnrjU5eAfJ4hELfgh1vIkgyab431g1wQ2kRnMzq
         tV12QuK4GRkDOrEUCLsqoeoT3SeXctVQF95A8qnTGxxcBq04y/x
Date:   Thu, 15 Mar 2018 01:05:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/36] object_id part 12
Message-ID: <20180315010538.GC330384@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
 <xmqqtvtizjq9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <xmqqtvtizjq9.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 09:48:30AM -0700, Junio C Hamano wrote:
> As always, thanks for working on this. =20
>=20
> After this series, what jumps at me out of output from
>=20
>     git grep -e '[^0-9A-Za-z_][24]0[^0-9A-Za-z_]' -- '*.[ch]' \
> 		':!*sha1*' ':!contrib/' ':!compat/'
>=20
> are code that parses the incoming patch in apply.c (where the full
> blob object names used for binary patches are assumed to be in
> SHA-1), builtin/pack-objects.c (where it has to know the current
> file format of a packfile intimately) and diff.c (where it clips the
> length to which the blob object names on the "index" lines are
> abbreviated to).  Changing 40 in the last one to "the hex length of
> the currently deployed hash" should be relatively uncontroversial.

I have patches that hit several of these places, but not diff.c.  I'll
probably pick that piece up next.

By the way, thanks for a useful regex.  It's a little bit different
than what I've been using, but provides a nice overview.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqpxuIACgkQv1NdgR9S
9osNBhAAjpQOCBpfmdxQh7jUfqcYe81KWhjLLT44sXj0EJOouqy4lWkiuOnzckP9
CZ4AL1XVgYZ7AaultsXG3eld+XjZlchdIwXaOzUYfjMX3D27vJRranh/WZzuVTzG
vT1bvZeqLM7idrg+L9aaLWKE8lfJ6/jbIItyazBuL3ywpcCE50kQwjOP2EfxJhOj
Bxo8EKAfA1RBgOxJN9REbPLXsWi3JbNlIZq+QlUNcnkaAU2ynIaMQWR5CvC6BW1s
MIwOyMUlLRWjNqgc8ltvCRITG1EUDw1liFSfs/t9bSTQRfaZzlzytpMI87J/h53Y
FJVMqzKRQqtiQKEyoQJWnTmxPsR5SZEvkKcD/X1TLREczvzTY8J1sFYuylEnryDa
ORtFbzZ6OsIrxSlxfDBIXJYID1RA7/tUBCYidUzOC04nCMSLS/aef9lSg4glHXGR
QfeRVyzaFiPCKwnmkwroBCx2OfCzXBf/igCrEIi/XARGN6Db0lfS0Gq3HZF6U7nn
q822nagfRdbNVaMkVqOApMUT7zri5oSRlJLW+8Ts984ksuaHiOj6qVq/1vS500uq
5qlqm6vDsUsIoC275XDLh5Wx48k+RQ70rrJeUIf4p0UKzBbrZSegeRtBrQxpXF2j
dSFteJ6rz5LHa2Cue0ZKJCsaL/K5ubyRpiNxBIO7om0a5OpoxEE=
=evXN
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
