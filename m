Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20721C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D262922513
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAJB6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 20:58:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbhAJB6q (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jan 2021 20:58:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0557060781;
        Sun, 10 Jan 2021 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610243885;
        bh=Qg0iPGZAWJqWdRmlMukbAreL/DDt1XxA300wtgvYzmg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XkXtw2BlOaGTENqHUaeLFqHNTZt1DQPSEe3iQuE+XIXmur3hHmZVWoZsVGRl6MRwW
         6G+8GxJtrKkd5Tf7dowBQ57JBBcvuo/FRi91jiG234pngV06fVQa7Xgk9Cu4fTWNOF
         w179KlsSiPcocmFsXGYbhJ2UPJIvVID9ZxOTGpUQgllJAOIHAIuohy8tM74/NazLFd
         VlmNfhV0ht1I1RTz9I3uypoSZoECHKSCCnmIZ11cuzSKl3A0sUPuf0O4Y1RHgyUaRD
         0I134PWH1qbSGq7+4ywl4WT5zWmg1Ru06OtZROgWtD4cMyempfP9KSwNyCQOJGinYw
         Verop6xKeXGVdxSVTtgZRFIJ0zh3m7rbzHX5uPdeV9ad0o4OgyP0AD+gknRLKS+hTG
         sokhsXKJ/p9Jxp+96qxsgRN7smoEMFxqZ00BdunCUW7XmA7Rp/OsYzbKCJ2t2RjASn
         cKShe4C0gPzKdlfF9RDMGZ66wvQTel5laMHUQwkbJ41nYM8YtrW
Date:   Sun, 10 Jan 2021 01:58:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alan Mackenzie <acm@muc.de>
Subject: Re: [PATCH] docs: add description of status output table
Message-ID: <X/pfKCV3Pz6cNn1h@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alan Mackenzie <acm@muc.de>
References: <X/oAhdZlLwcFRCrR@ACM>
 <20210109220614.759779-1-sandals@crustytoothpaste.net>
 <xmqqim85d0vw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRtGHgpv0ksbfAp5"
Content-Disposition: inline
In-Reply-To: <xmqqim85d0vw.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BRtGHgpv0ksbfAp5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-10 at 01:41:23, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The table describing the porcelain format in git-status(1) is helpful,
> > but it's not completely clear what the three sections mean, even to
> > some contributors.  As a result, users are unable to find how to detect
> > common cases like merge conflicts programmatically.
>=20
> I agree that the addition clarifies, but it is a bit sad that we
> already have a beginning of the explanation; I wonder if we should
> improve the existing description in addition, even if it may not be
> sufficient to eliminate the need for this new paragraph.  Here is
> what we already have:
>=20
>     For paths with merge conflicts, `X` and `Y` show the modification
>     states of each side of the merge. For paths that do not have merge
>     conflicts, `X` shows the status of the index, and `Y` shows the status
>     of the work tree.  For untracked paths, `XY` are `??`.  Other status
>     codes can be interpreted as follows:
>=20
> This introductory text does sort-of hint that there are three
> classes (merged paths, unmerged paths and untracked paths), but (1)
> the order the three classes are described do not match that of the
> table, and (2) the explanation of the untracked paths predates the
> addition of ignored ones to the untracked class, so the description
> is added after the legends as if an afterthought.
>=20
> I am actually tempted to suggest rewriting the whole section,
> starting from the paragraph above and ending at the table, with
> something like this:

Sure, I can reroll with that.  I noticed that we're using a text diagram
instead of a table, so maybe I can fix that up as well in v2, depending
how the output looks.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--BRtGHgpv0ksbfAp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/pfJwAKCRB8DEliiIei
gS5LAQCeR72mqxT3qXxE4rcg91gLH68BQe536EY4chZW24GNbgD/U6IeQFotIrtx
aSOp4KxGJGqDje24aROTwXDUlntBEAs=
=xUGL
-----END PGP SIGNATURE-----

--BRtGHgpv0ksbfAp5--
