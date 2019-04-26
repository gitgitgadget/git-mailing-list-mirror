Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5237C1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDZVcu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 17:32:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbfDZVct (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Apr 2019 17:32:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D7E660458;
        Fri, 26 Apr 2019 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556314366;
        bh=G/GGQkm1TB7FInF4ut2KWkBirVQola2ZpCPkTCgEW7s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NFfblTfAd/MilyDOaKTEFtFhJURXZFvCxwgN/3s5xJdcGxIYyZiKpuMh6fRxLgAom
         gvFZhVjWDPm9PKymkCpMAGREmgskq8+IHRsI/Cq39Z2/6/ekm4QTv04i2uCR1PnCv3
         AZmbKy2HB1JouKeY0aUvmcMQrFKqPMrWLanEXAd23CC3zLu3kLe7YeoFx68bKnC1ls
         3wcy79RNlEnyZkJUI1vEhH85v3DliSQNjxmae1I/J7mBL55pM4ipjEG0AdhrvS43+B
         Ln1iPvGdK8TqwH48ADGL9ZrnKxvht6fpzO7UlHn05yHHabyzUJkT0dtEHjySfgudLK
         +b+Cnk7g3L0He0HQ2ARkk8Manvhu0OEh87qk/A84VkBXo1zOWOFJ4izwJEde7FT9OV
         cAqxAXozGXSy9KXqDsLB7MxMvjydZHKnn/QssSjs+1EA/6v6Kc8aoxtINQD2jz5HU7
         jNrXoIPaHfWn4VX826axqYnBBSK2YEXzvyU3VJn0va8sJTqiwl3
Date:   Fri, 26 Apr 2019 21:32:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Fix and extend encoding handling in fast
 export/import
Message-ID: <20190426213241.GP6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20190425155118.7918-1-newren@gmail.com>
 <CABPp-BEsSpFYVto2E998n-UUwD6UcVRVP61VPVg1nEgRUL1UzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aX6oBa4COn3eIhlv"
Content-Disposition: inline
In-Reply-To: <CABPp-BEsSpFYVto2E998n-UUwD6UcVRVP61VPVg1nEgRUL1UzQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aX6oBa4COn3eIhlv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 09:55:11AM -0600, Elijah Newren wrote:
> On Thu, Apr 25, 2019 at 9:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > While stress testing `git filter-repo`, I noticed an issue with
> > encoding; further digging led to the fixes and features in this series.
> > See the individual commit messages for details.
>=20
> Whoops, forgot to cc Brian; I'm curious if my understanding is correct
> about the sha256sum transition plans that the intent in the short term
> is using fast-export & fast-import to transition to-and-from a
> sha256sum repo on the fly; if so, I believe that transition work
> should use the new --reencode=3Dyes option in patch five.

The plan is to convert using fast-import and fast-export, yes, but
on the fly, no. You'll convert your repository up front using
fast-import and fast-export and then conversion will happen on the fly
as needed internally. The latter is a thing I'm working on.

So individual users will want to use the --reencode option, but
internally we probably won't get as far as actually decoding most of the
commit object, so we'll keep the bytes in place.

I do appreciate the CC, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aX6oBa4COn3eIhlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzDePkACgkQv1NdgR9S
9otiTw/+NXORsOZXueIUGqVcBeSSP0A9Ub3ib17pJXpU0zmRnZglh7aDtzfUaZ5n
w31JZ2mHovcrKkai2OM0d4n1gluuB3V3YPuKfzcc45bYEAlKQUKJspOHWUtb6LR7
sEJhg12jwv6YHD1BBEV6iNALz5+f9USwQgfbL8GBcUmlKQ5ZkSwivZE+5c0q1YMF
AA2w7hIpcQg6omDFjuKmOebJk1BZUp0PqhHQ3pt50NCP+8QXz3e0p9E144lXnqSA
EeIQ+3s97shoGCn2Z8cZa2y688ibG4OKlT73uMMeA985UoswyY7ugFTfmvmxgxUF
PCqFwikZ3peRcmgtsKjC8/BD2kHnXURK2x2BuUXQhW3fhLQ+2ID1sDIjJtoaQ/Tx
iSiqDZZ4uj3TF5OPqWDgc4x+7rScY69m3GPqPMJ46UgrN4dy7CDjd/xhymFec8S0
754jLurucfvgWzl92yXMtKyP3PcHQJQNbZpgqbyNkI6WSFdHdjtXMKB4SzDJeRFb
3HFZpS7Z+6nIOE2U/Qs0lPhVly/+Ri0g+M+UuqdDZZSqEoBczMDrGdPfLlzW+bjX
51U9B8NZv65YS8o2yChoHVFEXneSwMxc3F9ILoMCe+L31bMkNU7IDcGukndQCE88
nzJLxrfhbzVpdvE9svPQgam8aTiEU06q/NMkjkx1MROwrQO4Zjw=
=LZ69
-----END PGP SIGNATURE-----

--aX6oBa4COn3eIhlv--
