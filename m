Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442EC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B5361090
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 22:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhDNW5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 18:57:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhDNW5M (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 18:57:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 023EC60744;
        Wed, 14 Apr 2021 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618440980;
        bh=R877vS6ajl6npOIV9fHq3xqvOP+ZuQYatjzOWXQuTb4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZdYRlzk4w0NSHxxZVG5URdaKyx6czad9dXtzCbfpIKtE/YoBrflixfA1cR5HI5C3d
         JHMZR2/1Va1ombE7BfFeVUMPLKLp4s3jCIkoznKy/Ro9hiE3r1YsNw5VE5HMqUKHZm
         4BJv4zB/c89tuwFZCaH8hvXzY8eUDmfYQIWK8CJAbiaSf/tzCQbUY51jQJStnY7Guk
         +WX8Nl4uAEMFomFOWkNiQ8P9D4mnrYygQQCNJAkT0s2HVALIS5rn+sOoMjdSL4LaXm
         rySft9bkmPeDLN8eQGLDD7h7SEVSUdrF8FJbX+9e8OqYNRpXYjrYkqhC5UTGl7AvnW
         an8MZHG5ibn6rvwzniR58/bSK/iRbczbyq5MiRD4naDtZQzZCa7zrj+Y/IWDVdyKLP
         zKPJSoX4EFL3cbFjlB+BZ8dJ9pOX4EkPed/xSznrlgp81nPkbvX/lqVM0ecYgGYvaY
         YZ4iRi1/TIZi3pvB7b3kXWsIRI2fIGT6/0V/yus+blGc9IhX0yK
Date:   Wed, 14 Apr 2021 22:56:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Gore <Jason.Gore@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
Message-ID: <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnwpT3kXoArf9tHH"
Content-Disposition: inline
In-Reply-To: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qnwpT3kXoArf9tHH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-14 at 17:17:46, Jason Gore wrote:
> I'm unsure of whether this issue is Windows-specific but at the very leas=
t I suspect this is a change of behavior that would affect all platforms.
>=20
> In July 2020 I reported an issue I initially encountered in 2.27 that sti=
ll seems to be present in 2.31.1.windows.1: https://github.com/git-for-wind=
ows/git/issues/2732
>=20
> Since I haven't seen a response on the issue and it still occurs I decide=
d to email this list as well.
>=20
> Package managers such as PNPM tend to create very long filenames due to s=
ymlinking. Having git not enumerate these ignored directories is essential =
to leveraging any sort of clean behavior (both for performance and for warn=
ing output) as we did before version 2.27. Our repo clean functions went fr=
om taking a few seconds to over 10 minutes due to this change in behavior.

It looks like there were some changes to the dir.c code between 2.26 and
2.27 which may have impacted clean.  I'm CCing Elijah Newren who wrote
those patches and in any event would be more familiar with that code
than I am.

I've taken the liberty of pulling in your testcase from that issue and
converting it to work in POSIX sh on a Linux machine.  If the path is
not sufficiently long for your needs, you can bump the value of the variable
"last" below.

----
#!/bin/sh

git init test-repo
cd test-repo
longname=3D"directory"
touch "$longname.txt"
last=3D400
for x in $(seq 1 $last); do
  mkdir "x$longname$x"
  mv directory* "x$longname$x"
  mv "x$longname$x" "$longname$x"
done
git clean -ffdxn -e directory$last
----

When it fails, it will complain that it wasn't able to open the
directory.  It still exits zero, however.

I haven't bisected this, so I don't know if those patches are related to
the problem or not.  I'm a little short on time today to investigate
further, but hopefully this can get someone on the right path with a
modified version and git bisect run if nothing else.

> I've also had repeated problems sending you this email as your email serv=
er seems to reject any email with a URL in it (per the github link above.)

I don't think that's the problem, since this email came through just
fine.  It's more likely that your email was being bounced for HTML,
which isn't allowed on the list.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--qnwpT3kXoArf9tHH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHdzDgAKCRB8DEliiIei
gcJJAQCdALWpIgCybMk07BSJLEf+9SytDygQal1+g4UMXi3x0gD/QF1feKZMVJRA
4WwmRD+RHpeWLQpDQHsvkAGN2TWRJwU=
=0y89
-----END PGP SIGNATURE-----

--qnwpT3kXoArf9tHH--
