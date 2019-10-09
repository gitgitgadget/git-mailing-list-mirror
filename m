Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5541F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 11:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfJILU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 07:20:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbfJILU2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Oct 2019 07:20:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CB8261C5F;
        Wed,  9 Oct 2019 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570620026;
        bh=k4z13gkTczPsb88RAPCDuUciSUz6Eptw6rkQaip2jEA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EMWha5fOFvJzCRgjgsCVjrI7z5yHB4OQHKd72fFbTsR31HCSUzsMZ95/4oT9Ynn6+
         B/YdKcVucI9ANYUZhSUHwpYCZFv+SRK1hO+2eMsPH2GLhAsAzoeVnU3dGEHJNwWuQL
         y4EtdaqEbAk9EtQZxB1bZ0UrJ5Xib7BfYRuSuf8LgdOjraelNtYlvX9YSVHA16CYHl
         htgaEMvq4oOoyPb2YiKCq4s7a/1v3ow96bo0gttM+zL1X2eLsrn62z1oJiB65hfHxE
         cB/3MDDBbeiRLyR4f1koORfX5IfMf7ZD9anQHTCEi0ShqfmePjvg2J7GNfTvwhYf9M
         J32jiMcSOu55t2nmvnVlJkBSESLpCyTIK0dcdZRtw7EPDUsMK3PmDPFsXrTbYe5HbC
         bFfv9vgbKQnWauf99qg5aqzyozVI8Zoxkhj1LeCQfYiid7ixBNbO5vXSJIjSEIPHMP
         H1yulbkt51ojw3iW5uuIPdtVsmJRVBAcMWoWrlLfs3D7UKEagJ6
Date:   Wed, 9 Oct 2019 11:20:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191009112021.h2ywofk2pivdyavd@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
References: <20191008074935.10972-1-toon@iotcl.com>
 <20191009014039.GA10802@szeder.dev>
 <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hygmbz4xlihgngse"
Content-Disposition: inline
In-Reply-To: <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hygmbz4xlihgngse
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-09 at 02:19:47, Junio C Hamano wrote:
> I think we have been happy with (1) a comment at the end of the log
> message that says X worked together with Y and Z to produce this
> patch, and (2) the trailer block that has S-o-b: from X, Y and Z,
> without any need for Co-authored-by: trailer so far, and I do not
> see any reason to change it in this project.
>=20
> If other projects wants to use such a footer, that's their choice,
> but I am fairly negative to the idea to open the gate to unbounded
> number of new options for new trailer lines.  We do not even have
> such options like --acked=3D<acker>, --reported=3D<reporter>, for the
> trailers that are actively used already (and to make sure nobody
> misunderstands, I do not think it is a good idea to add such
> individual options).

If we don't want to add this option explicitly, which I understand, it
may be useful to add an option to add arbitrary commit trailers to a
commit message when creating it.

Git uses a patch-based workflow, where adding trailers is relatively
easy, but for folks using pull request-based workflows without signoffs,
using Co-authored-by can be a great way to note when folks have worked
together on a patch.  An option to git commit such as --trailer would
allow folks to add whatever trailers they wish, including this one,
without us needing to bless particular options.

I, for one, would be excited to see a series which did this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hygmbz4xlihgngse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2dwnUACgkQv1NdgR9S
9otUbg/9GyFElMfuywO9k8qqMHr8arkt1eijwZZa06/QlesIUAr1qe2L9l+FuArd
fZe3cJGy1P2ITYqwvKIlivw8fZfDObApLXhRWC71XW4WCLKxvSzKqAumyU+3nDgn
N+a3TXXPRBB2IX7gf/LdvT1Zq1WzTiJGJK7O3Aln5MQ6LmEGxU07kXM7x3I11HNl
8R/TgMg3UG6dWoZpFQYcP+vjcVFQHUdKm7I/2r/Vdw1SgosOmwtKKJWBEgD+SKsw
nGUzZsUPIjyl8YchxBSW0IwKS7cPNKKxkbAo5+CjYgLznQ/vDAHSlQh94eX6OJ8j
vZo5DRzHzijlzhquQEPghricdtqVvw0pzDnzY/0toBP6KoHglEpanDGoyuHuXcIu
kPmVPoWlcQUrv0oe4DByKqZ5gEf9gGJKW+DaI8WXnO3+vQn1cP5Xzl4pfCM/CwMN
Xb5Z92tvbcCOcLzHXpGu5rgLKQvW2Uqba+KxSvYd5Z/kq5hcVxfkOsMKSRxJYLI8
EGTNOoZCvk/4EWEfbcOPO087KTZ4yXvPpB7mgewHGPEyb0qbPwFS8QWi1J21InFi
NgYYxYHX/Kw2SNBJYy2MPp5CI3NqGJSzWdGSIEO88In77zhvna76sDcHeMJITCPj
C+DEViryLx5g4BwrZFdzHRHyV7L95FlyG+52wbAaLnUzVK6jQF8=
=gewH
-----END PGP SIGNATURE-----

--hygmbz4xlihgngse--
