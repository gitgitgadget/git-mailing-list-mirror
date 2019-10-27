Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F901F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJ0So5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 14:44:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54010 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbfJ0So4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 14:44:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 846B760458;
        Sun, 27 Oct 2019 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572201895;
        bh=JSq1N8ODN35aUk7RyPO5PFBYqAxqqZDrgZMt4Blwc8Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ktPkV/K7xgUXO/G0lOhNBf/rC1gbSuRc74oMkGdjWzh29yhM/xCIlIXodsDvp83Dm
         cGHUc4JTv+JNqf0KFOYYejzx92aRNT7LowkdieH/t+EbIno46SItQdvtM2oECLeDDu
         Kkqtze8KHsP5AslBL2ywFHGxtzNjdvG22UDm2ev6tL6Q+ISK0cOtcQqe8JobzlltzC
         Um3W4dfCeSyLW/xK0WrO3SshaxuSy1ecDEep8+9VYYWQtTYzEOW/9tazx1A3zqmK7V
         mBWlfhdXeDPqOTNwfcO1OhveLW5Vy9jd7RUZWth0e8u3HA91eDmmKrbu0k2JL1tNpY
         RcMqI1OefzXtlOWXQXymJ1ue0g7J9b6jrmOKzacJX6pPxtlLhVxNiP9fV1Vymky14Y
         vgzf2ULiCFYzJkB1Q3/BiNsjjnrYdBCiD6YKJlADlQ1yUd3wcH1L77J5Gi9HIo6c6c
         yrYDFQzR9GMgcFhPZP1bPgAA6cm7kKcj0ArY5ENS1HRAsLLgqvr
Date:   Sun, 27 Oct 2019 18:44:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 2/3] mailinfo: collect commit metadata from mail
Message-ID: <20191027184449.55pk5ga4cjxaxpej@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
 <20191022114518.32055-3-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4hqdc3dbe5csdao"
Content-Disposition: inline
In-Reply-To: <20191022114518.32055-3-vegard.nossum@oracle.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t4hqdc3dbe5csdao
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-22 at 11:45:17, Vegard Nossum wrote:
> diff --git a/t/t5100/meta-meta0001 b/t/t5100/meta-meta0001
> new file mode 100644
> index 0000000000..1db7e9f715
> --- /dev/null
> +++ b/t/t5100/meta-meta0001
> @@ -0,0 +1,23 @@
> +commit 763f9b1cfd69ade5e22dcdcdc35d144697675a93
> +tree 43a6b213a2891b5a863775771cab0c0dba3730dc
> +parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
> +author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
> +committer Vegard Nossum <vegard.nossum@oracle.com> 1571599909 +0200
> +gpgsig -----BEGIN PGP SIGNATURE-----
> + Version: GnuPG v1
> +=20
> + iQIcBAABAgAGBQJdrLYmAAoJEAvO9Nj+mLpY5zIQAJkdnnZMrCVme64r43M/KMm0
> + W1fmdeXiIMrI7i0McBdAsQ/KQ5yD4HBvaJWCyI0/g6IeLgVBf9//9xq4Y32iqsKn
> + XRut2Pk3H3Az0WfUlpLpDJUgzz7er8t/glaKnESb94XR/ac59tEELbePh+bXsFLH
> + 3+v8Y78zeHJd6ZLKrKmLyq/9ZaJQR+9xmGdKzZdnwM+8seE4aOhM1VtA8ik68Tn6
> + Tbaofp1jbsXcyY4nBG9GxK14wnb/8OZmQlH4J40LsZT4KDWQNWighGig8ude7SJa
> + 6FJXWJPLfOB6r2ThiJUnrf/UXeHbvYUWITiYoWOxEVb6c7RfNLqDbbGF9VQfTD0n
> + SEFO5NqOs6KofaYzALprtgpMrqksRHeLc7Ouh9xgLyLZLx/669I9lo8M1aQ7RJMy
> + V1KDG6sYbFrgy4gQ/4xqXj3NpBmMb/VcjOnCj3j040wo8q7hlpzb6ev5lcqAFEuP
> + y1owwhljMjqAdGIBw6sLVn2on+6gEQuIjbkoapBktPDw7xEpOKe9rzTGcWRRyANs
> + Z+pMWbn8c6TKonokNjERy0iPnu2t2j8x1YpqKdjY+oq8ApNZFMlU1U+UtXFfuLw5
> + ZKR5DtmXxWzvd+nKBenjzXyOt33v5eq4I/WMfATauXBgFu75mbfiKIFVD5VeMfxq
> + DoiIqvLtW+DDUkH99zXm
> + =3D2APb
> + -----END PGP SIGNATURE-----

First, let me say that I'm pleased to see this series.

It would be nice if we could use the test user and test keys, since this
test data isn't going to work for SHA-256 and I'll need to generate
suitable test data for this test as part of porting it.  I won't be able
to forge a signature using your personal key.

If you wanted to generate that data yourself instead, you're welcome to
rebase your changes onto the transition-stage-4 branch from
https://github.com/bk2204/git.git and run the testsuite with
GIT_TEST_DEFAULT_HASH=3Dsha256 to see where it fails.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--t4hqdc3dbe5csdao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl215aEACgkQv1NdgR9S
9otahA/9Ev7uEZ7bkmgrrgFUYOMlM86/prrWcL3J67Wws7NjR5IgEx/ReiRngrDl
4sq3/q5tZ7fZkL9oisoJI5orJNxJT1qj6imf4F8/nWQINeCn1ymGnJDmWWSagF5m
gsIQI3VfGZBW/7pgsv5j0N554RzJZFnW4ipDco9YLO2uifluGLlZGRnkQ6atDUj/
PfVqdMxykEjgsxbKoheBPv9aC09jkY7G8XCdvh2oIWhJs7gncvtGJnhDM9Z68fAP
UPVJi6W8Nc/CJQkw/fRkqPun0V2uovipS4SAB70HNCCVWj7xUEBn9zBbVBnatYNo
GmzzvFCWXFPLxlHTiRe26GLXEDxNYlupFNqfBXdpJ1sYgU66oRdDWCuVnGl79K+z
tnJdaEFnAOOF/pxb3n9JEvO2F9sJRhl9jknNQhNtFdl1LymFx3QZaZFw2NK0DyiA
J21JkMzd9dk1oh2/mEK65vl+wnxC3fjLKwAQaeEfy/qtSIDr49Ztc3ZSWSxVEo5x
33Jed9bIjETCS3rMQsiQypWE635sPJGs0Fj8zR/KOZ13ILLvMYwtSz54joNeqRnP
eE5Veuqjf+5yZa0hB+tx5vslC3s2a1+QsZMsa9wNny0AtFwAZKGaFmqMq8fMRrDY
J0JGpJlZRb5jBp1TuL3Ew63iKFy1Jdu0C+lLYNCeTeCvbf6mD2U=
=H6zx
-----END PGP SIGNATURE-----

--t4hqdc3dbe5csdao--
