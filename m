Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CA4C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B84214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="RR9uQO61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfLKJO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:14:26 -0500
Received: from smtp-4.sys.kth.se ([130.237.48.193]:44030 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfLKJO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 04:14:26 -0500
Received: from smtp-4.sys.kth.se (localhost.localdomain [127.0.0.1])
        by smtp-4.sys.kth.se (Postfix) with ESMTP id 8E61466F3;
        Wed, 11 Dec 2019 10:14:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-4.sys.kth.se ([127.0.0.1])
        by smtp-4.sys.kth.se (smtp-4.sys.kth.se [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id K0jNog2r5bj4; Wed, 11 Dec 2019 10:14:21 +0100 (CET)
X-KTH-Auth: dbosk [158.174.118.36]
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
        t=1576055660; bh=ENtQDgC2xw2h6jJCnnsb1qS5mnzcBOzpCKvGpomptlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RR9uQO618XA0E4C2sis2MDo5AGpbOjY/urajcOUfgscoT3alVXRMTyrQaSowh69gf
         qXepHm9ZuicqLnBfaY7zbRuVzEPjkFtiy8zHi2sOuD4fGJdp7Sp3177DzKpusaTwCY
         +yqCTPGnHdFxkIrMwvFJ4SdPmugw3ao+dGiJLA+k=
X-KTH-mail-from: dbosk@kth.se
Received: from t440s (h-118-36.A465.priv.bahnhof.se [158.174.118.36])
        by smtp-4.sys.kth.se (Postfix) with ESMTPSA id C49711AC4;
        Wed, 11 Dec 2019 10:14:20 +0100 (CET)
Date:   Wed, 11 Dec 2019 10:14:19 +0100
From:   Daniel Bosk <dbosk@kth.se>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: merge branch with updated submodule leaves repo in modified state
Message-ID: <20191211091419.n4uhqq7nfafqds2i@t440s>
References: <20191210194803.emsvjibq3jyjkjrx@t440s>
 <CABPp-BEhZaUxb2qKQLEpkG7+a9zQhYMxmbc=Na+P_RetrWk+1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vkroe7css2psnki"
Content-Disposition: inline
In-Reply-To: <CABPp-BEhZaUxb2qKQLEpkG7+a9zQhYMxmbc=Na+P_RetrWk+1Q@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5vkroe7css2psnki
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 10 Dec 2019 16:51:46 GMT, Elijah Newren wrote:
> Don't know where it falls on the spectrum from bug to unimplemented
> feature, but it's certainly a known issue.  The last time I remember
> discussing this was here:
>=20
> https://lore.kernel.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhR=
kbhJsw@mail.gmail.com/
>=20
>=20
> Hope that helps,

Definitely, thanks a lot for the pointer!

          Daniel

--5vkroe7css2psnki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2vhBQThLHLiJRRDR8X4wAqLXj8gFAl3ws2sACgkQ8X4wAqLX
j8je5A/+MzdVP00OTM6YSNCt7bEFijpwDiWTArncAak20rGHx+zlw8opD0cVqmsM
WeM2iJXX17e75BqxdVehvPlgmWJH1Msi7BauwGhtDhWGfgCSNYWSs5NO4mmNj0B9
q6v5TH6xRDQBJe2ie+Coduq5rNVzcKSZnK5cCnXdZesJxPOwlWWtqcBJGmn0AF27
yQrqSngxYAxPkr4ruUdz9TrxMaiZjt7f4N4wPA45d099pF3ira1o+B7Hpwh4Psnk
1Ot7QclMcidaL/6XnKrprxTIfmPYhrXtFQYT2bUYczXP1WKNr43Nwpo408P5/p51
s4rPs2tIVTSbByMU4Vy89oh9uFh4JqimXihHONTqk1ivkP5pGkbNCsqhQH5+cwqb
YGZJrfSSmMRAqqpo5vgFdElASv2gVJTfuTaUX7IxGwPScv2YmQrmhN4DK9go+lTm
q8TibuHgs6I7+VDc1giJiATzx2z2Y+CwXCJcCtZfSNM9iJKM3K/pJzbaEbIzQHnl
OTjG0EUwroTmui1LtO7rykJtEKlnPcRQMZitov7MkjQfI4XBTnx+HDt+eYnqZsq3
t/qhxNYAXYuINzZq735ah26vCFApahwowcPQk1NudjN80bGKueAGFlWnSIKyCO5+
YKspH7AGAJR8fZMnJ0PNkZ9Rbil6dH6N2JrlO3SMpuAnbfBgYEk=
=BhE5
-----END PGP SIGNATURE-----

--5vkroe7css2psnki--
