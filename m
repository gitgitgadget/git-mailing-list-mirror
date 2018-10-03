Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75C21F453
	for <e@80x24.org>; Wed,  3 Oct 2018 08:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJCPRF (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 11:17:05 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54520 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeJCPRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 11:17:05 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 7EA87335D12;
        Wed,  3 Oct 2018 08:29:42 +0000 (UTC)
Message-ID: <1538555376.1042.3.camel@gentoo.org>
Subject: Re: [PATCH v2] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com
Date:   Wed, 03 Oct 2018 10:29:36 +0200
In-Reply-To: <20180817073441.5247-1-mgorny@gentoo.org>
References: <20180817073441.5247-1-mgorny@gentoo.org>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-KPIhO+zMk07vzieEYh0v"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-KPIhO+zMk07vzieEYh0v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-17 at 09:34 +0200, Micha=C5=82 G=C3=B3rny wrote:
> GnuPG supports creating signatures consisting of multiple signature
> packets.  If such a signature is verified, it outputs all the status
> messages for each signature separately.  However, git currently does not
> account for such scenario and gets terribly confused over getting
> multiple *SIG statuses.
>=20
> For example, if a malicious party alters a signed commit and appends
> a new untrusted signature, git is going to ignore the original bad
> signature and report untrusted commit instead.  However, %GK and %GS
> format strings may still expand to the data corresponding
> to the original signature, potentially tricking the scripts into
> trusting the malicious commit.
>=20
> Given that the use of multiple signatures is quite rare, git does not
> support creating them without jumping through a few hoops, and finally
> supporting them properly would require extensive API improvement, it
> seems reasonable to just reject them at the moment.
>=20

Gentle ping.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-KPIhO+zMk07vzieEYh0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlu0ffFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQpiYRAAoGpXOaIkNghzvbdbRcNiwoERcPXT79MgIx9ATKcL6tQBDCEOEJXDK2ll
6EcIq3m+r+NoWvLhfUNZ6qiWBDbCEJjBkevbEjUHwYyLyimWp0e9vVpd5ZZDGmcD
fYEcDjZiKEKHv9d+D+IJDXqFlSPVm+ujXOGHekkjKA+RPJIIU2vbx4svKxOYiuS/
zcE/C/unKqNu/pD3mkkISzmx+BTD6OsmMlorYNtf4niZ/00KTtyNBdWPOUpwG8N/
BwbnidVGUm3x14Vp/HMk0TJmUlDzlWHX+HpoUKOEWlzG83v3oj+u1pq4Fqa+MBsA
8QoAqW6L4GtM5wqPNoJFF5IY3RBHmIa72CXbPNycbau8/bJXH2r82pMSLJpqwxzc
Oq8/Zepr1NIpIHrMlI7Q37KBCPcF25Vn8n5E7FCe1Z2Dv51o+SCrhC6rTyF86GZy
UoFnvwxiWx4AtNUvApbq/3+0LL1d7vRPZWvm3KZvq3/e7F/Bl90xO2NXWOmlL+Ku
I7+0nvKX7Tzfl0r2bn8XKpCL9iLiMdr4YtVfltFRbfK+2c+JdPbeQ243HcPORPZl
4C+bSK3Q3WgStVAk0O8Lfjr7j9aICN4X7DKCML5EMU9byIrgFNLnBZdpKdmgiMtI
A+j2Fdgndh8D60wIwnGeUxoWucjSDlEb5hVKlYWrLNt26Y4SL/w=
=2fIf
-----END PGP SIGNATURE-----

--=-KPIhO+zMk07vzieEYh0v--

