Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC2C1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeH3GlI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:41:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38574 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbeH3GlI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Aug 2018 02:41:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB85F60428;
        Thu, 30 Aug 2018 02:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535596875;
        bh=AhvyAOdPg9rMo1hcnvPg2WQ5yBqiUNTA9ydyXhLOfg4=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dCAAeyRwwnOuV0XGYPsj1+vUtogmwMg+FH4aAsV/BtQcb3E24eRH6rj5EBC1zcAix
         PEAI8K4gFDo5fu1Dm/2kb4cw6P/bAfARbO/q7fj8AmGZz+oFxPjM+yFSqxH2erHGEr
         Y82ne0/w7hfKpOnwNNSTLauZEa2vYpgJxaNqHCUleFXm76Us7i3bgOfqV32AIH0wV9
         vHvDtRjj9tIdiempkPOod2Q7C6IXv+LgSqvttH9FyNCb/PUk9WW7ua2gN2u22eyJFt
         PmY4WuqMu+iwNC4kAy+1Ty824xlRgfzjwR7EpoWL2op5AA/A8EUEYhcJKq9HOYbK0+
         rsy1av9TITBYbpK08VpWpbVARiStxMxFFxlw0pUCyFMse/6fXcwYyM6rI4POH1Wmj5
         Cat6dybUqyODGQhq1cXfT6Ot7nEHz189R7o1Ane/zZJOQXvTY3MHRK/D2vY9NMDVfn
         X+imkpK21Z5PDUUvhEzuYS0XOehA1FbYHPkULRtTeBAniwc1xsi
Date:   Thu, 30 Aug 2018 02:41:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] Base SHA-256 algorithm implementation
Message-ID: <20180830024109.GK432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <874lfdecoa.fsf@evledraar.gmail.com>
 <20180830022151.GI432229@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <20180830022151.GI432229@genre.crustytoothpaste.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 02:21:51AM +0000, brian m. carlson wrote:
> On Wed, Aug 29, 2018 at 11:37:25AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > It seems to me that aside from t/helper/test-hash-speed.c and
> > t/t0014-hash.sh everything being added here modifies existing files with
> > many authors, and would thus also need their permission to re-license as
> > anything except GPLv2.
> >=20
> > Or do you mean whatever fixes/changes you did to libtomcrypt (living in
> > sha256/block/ in this series) you consider e.g. LPGL instead of GPL?
>=20
> Yes, that's what I mean, specifically the code in sha256/block.  libgit2
> is GPLv2 with a linking exception, I believe, but either way I'd be fine
> with it.
>=20
> It wasn't my intention to offer code I didn't wholly author, so thanks
> for clarifying.

I should clarify further: I obviously didn't wholly author the code.  I
do, however, have permission to license it under alternative terms,
since the original was public domain.  I apologize for my
mischaracterization of the situation.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHWUUACgkQv1NdgR9S
9oslBA//aZw9QWGnpvbZO/Sz4MkzFij1FgANHYKAfAT17keFBzf3MyYVe8eO1BQJ
thst4dxxP46xy/r9GAz+R6NoIx+Pc9imOBhl3XS4TtMEs/zUmtIFgG8kzbXZnrGH
b18J5YVthvhUSV8gKGL2QkmZBJ4hZSOJZeaN+8R3xPGS0imLYhVzKbWfSlvpAQGz
D0kITX3Jk79Zofg2qfTph4H5wdKYPuF4Ae7JFrayceqSWpM1SnM1GuXP524PaUy3
10CklMg4596JXqSQkMqGon697XXoySPd1DLzqrcEiZnQy9Js6pVi2v4rFXL5kD+M
aoLbtxd+krJdy23N/lCrBzVmd0/Tbwn3bs2xZC2FxFgQ2bUQAnhRGKIk3X324fcp
/Lxy+hL7ro8xPRKVnLNZLvjbpHGk9rr1OYrNs8ucnE6rG992QeuNgBt6q3gHP+N7
T0e32ZWyLkh7zosmSvamkoThWnc1fGfY0CjWeed9IBcGpMjpmnL5LsZPzTSg+LgY
F4w4d1h4jSkXqAWCYhKtEmw15D8c1WYpsPCRJBwWyd9qIgG2t2kvzkEv3mOgwDk8
owmhRNeRlcVGZFkFnMMncNwssfPAqMfy+O3/iSO0G/BJNIbayWk2lJnzXz0nig/2
obhxtcq7SK0Njpy0y/md0FmCjG1ranIQNR+kvQHwBTYiithzv4I=
=A16O
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
