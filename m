Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3578420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 00:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeLNAd6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 19:33:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbeLNAd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Dec 2018 19:33:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:34d2:59b6:3b53:e993])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3782760100;
        Fri, 14 Dec 2018 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1544747635;
        bh=oNoLxnPICu2a/nWDJOmU7zOO7PHLtsQQKjjfKUb4Yys=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bFRdaw8k3NNjWYAk6Qnd8JApiB7LVwtkEcD7sRNcoYXAtyc/ESiXeVFND4uSB0tFL
         YGGRZQEARJnWfmYO3yyhCByVc1WLDAJvT4cUCcsoutaaJ27iWCXpAqS4zIsyzCFBNb
         Vtfm9nZ2dapW7DfBrHPxubQFBkjG5y0WvfjUvYUWtPW1hNNEcMyGQ8OSWcYbT+r7Tl
         ZHsw8DX49aZe1jBs/7djoF9IX77csVNQLtSvIxEXsgfJ7RPVQAB70eY3wVyZSOVeVy
         VfsStrx2GYq6pwIX+iEL+W6uhkb/Br5LrzW/aAInFeh4JfknIyWD0dBv16Cka4Vlco
         wbTeoIARdISFuDoCKUU+vYpJd4MZQ0N+PNPlEh6wNrEqmvd7yM95b+qvzo5+DqZYMK
         kR/6U3AWhE2I5xUIr91Tx7ss6UYIiMe1QEsc21S4RFqjSP3jGqHbkCKa9mqqaJk+Ir
         BMTofEWYckbHimN5JuTB/sBjFG+8wVi94BGNplNa72hww3bs1zZ
Date:   Fri, 14 Dec 2018 00:33:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
Message-ID: <20181214003350.GS890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.100.git.gitgitgadget@gmail.com>
 <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aNCdKw9zdX/rqzEJ"
Content-Disposition: inline
In-Reply-To: <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aNCdKw9zdX/rqzEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 04:14:28PM -0500, Mike Rappazzo wrote:
> On Thu, Dec 13, 2018 at 3:48 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > > > The current situation is definitely a problem.  If I am in a worktr=
ee,
> > > > using "head" should be the same as "HEAD".
> >
> > By any chance, is your file system case insensitive?
> > That is usually the source of confusion for these discussions.
>=20
> This behavior is the same for MacOS (High Sierra) and Windows 7.  I
> assume other derivatives of those act the same.
>=20
> On CentOS "head" is an ambiguous ref.  If Windows and Mac resulted in
> an ambiguous ref, that would also be OK, but as it is now, they return
> the result of "HEAD" on the primary worktree.

I'm pretty sure that we want HEAD to be only written as "HEAD". It's
known that systems with case-insensitive file systems sometimes allow
"head" instead of "HEAD" because the ref is written in the file system.

I think the improvement we'd want here is to reject HEAD being written
as "head" on those systems, but in a global way that affects all uses of
HEAD.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aNCdKw9zdX/rqzEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwS+m4ACgkQv1NdgR9S
9ot4QBAAr2oZtL59L/rwa1nAxE4BPPNy65HXt54hrfRb++nQiOGoGeTiFlPl+gKt
5W1LZBO3Q26PN/aVs4e9s74KurKfVAjuUYy7Jumo/rNlz0BnqjkrLW3ZN3wUjNQT
eHRvDMRONmjmVLGFhAPzwgRUqO/avZkX1bJgfH3VRUbmtkmyXX70m4vyvHcuKLTP
bttUluEKyyAEuUNTB598ACItLWtYQLJDRN/b+2fy9SZab4/iNiouV2HILQEWv06t
NHlUegVJiK+cJx3MNacxLHtn90ga20z7Ec1S+lScZL0oS5xAw0woQDe23hFQM/Vo
tZVxxUFwl8LdsAVCe6nPcLPvHAEgmPRU5kIydsL//TpcoUQZFcSaDurQvQsqmvju
cV2Q4tv42PvbSzIpuVJ29X+yh/YOAt3Tm7+gs2GLzTD2lGjiYSesycm2YK/I0FfY
AY6PmlAqIiiCXp1a5qBmrsi+Y75MjqsX55jI6bxlOvvDXRMw0uA5UneMO3zjS9ig
hpZJis6dwIPKDgEubIWaWwAyUu/OsbXwDde2nGHF5PBQa0z9SG4OOPrs2jR9juMA
I7FzepOpl3dpVBFC8UHZTdYZBAW0dUm7Iu3iHNCBZfaEBckTpQ8Bvlw/ztteUqX6
iZT2t7PVacuX+JEwfhZcGf7OI4vXHWEUboiJG1U+6dVj6hU01Ao=
=Ux0V
-----END PGP SIGNATURE-----

--aNCdKw9zdX/rqzEJ--
