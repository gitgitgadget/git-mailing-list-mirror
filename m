Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E13C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D3C20768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dvDW8UZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNU2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:28:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgHNU2o (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 16:28:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 29CB360456;
        Fri, 14 Aug 2020 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597436923;
        bh=KX15lqdnIU/Sc+ziKhqkjmjm8oBQv1UiVMNDtckG46A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dvDW8UZYdYaaGYd26/rdWAW/3ylQ5LrnzsidXzdOpbePLLrLr5nZTKIHgr+nFuR6e
         QzAqaNN++MnjvjmTI8nzQLNt12f292axYxE9j4Hnt6Fm4qyQM6Ci+aYuyfc91hZmpU
         Bncu8tPHxwY/9N2X5QgzlK9S2x7qBmkUH2DdQlj5PK/ISX/UGJxjAaqzJlVD6QDb/9
         Ab1sPSkZMb1zXmwTm/ZwsDpO9kDxqP8xqO1UJOsZIhS3q1jM5wNGptamyfwF57o58Z
         mQYSizP2nchuvhk8A/VpVBDA+qGq1WXYgOZVFaBmyL6BEDM0RrhBKxaoWuD55rARfk
         R1iU5aQjYIKkdXuM5W9p/Gdzr/QQV3ei2r2pMq7Fprnp62OSeTZF1reC2qlwC6xNbK
         QC0XUKqye3owJJ9RmmhW2xjTJeWc+UcNQBpmqhyXeQJh20LI+MhMgY+GbjQ9RfGR8E
         DUfVI/MX94QieMtKxLtWyNQVoNgjgYQWE1xUXmcgYQY3ikJ8J1W
Date:   Fri, 14 Aug 2020 20:28:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] more SHA-256 documentation
Message-ID: <20200814202838.GO8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da9oBGf5DLtF9ehv"
Content-Disposition: inline
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--da9oBGf5DLtF9ehv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 12:21:41, Martin =C3=85gren wrote:
> Hi brian,
>=20
> On Fri, 14 Aug 2020 at 00:49, brian m. carlson <sandals@crustytoothpaste.=
net> wrote:
> >
> > As was pointed out recently, some of our documentation doesn't properly
> > reflect the new support for SHA-256.  This series updates the pack and
> > index documentation to reflect that these formats can handle SHA-256,
> > and updates the transition plan to reflect what we've implemented and
> > what the next steps are.
>=20
> Thanks, this looks great. Now we're making clear what it is we intend to
> be doing.
>=20
> What about these additional patches on top? These are based on my
> understanding, but hopefully they're not *too* wrong. I'm a bit hesitant
> about the final patch and it would be interesting to know what you
> think.

I think Stolee has a series so that the final patch isn't necessary, and
other than the things he mentioned in this thread, I think these would
be fine on top.
--=20
brian m. carlson: Houston, Texas, US

--da9oBGf5DLtF9ehv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzbz9gAKCRB8DEliiIei
gf6tAP9b2LuXl/wCaEId38ezs7JZd8liL9OAFl1aNjhvL9foZwEAo+lKOk0v/Zdm
1ih0EqSht4c82bPDNxkeAm92W/6aPA8=
=uMch
-----END PGP SIGNATURE-----

--da9oBGf5DLtF9ehv--
