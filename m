Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2546C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53882074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UIKbgy5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFJXm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:42:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39224 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbgFJXm0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jun 2020 19:42:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C4A546048D;
        Wed, 10 Jun 2020 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591832515;
        bh=PHpAJX9BiHbOoAOvI0XUH7408j217ZNA0UvIYRI2QgM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UIKbgy5AZJmou15haCUQ6aAoEn732Su90K8hx8K+Ee65wp2VLumf6BFjuEPeed6Zx
         d54l0sO0HXyt8IJR2Uvj894SzET40kTo+nogi2yz6NusmOhSrLWS0tV2I0hUSnVGv9
         hP0AVqb2sYfl3obaBRG0bGcxFAdFtFzHoG8vlMDzCd/2c8pYUZ5ZVpA4H0+U/zi7hf
         A5v9Wc28mLplnIGDrUJ+f3OsTgBRGwbB+k2406ZDGrbWLfgtjJg8RUPMZ7IbH47hdw
         6AZ51Neqqttl+xTcY2pN3sv+CqQSty9prvhRT+ANoQhVQEaW796szopFE2tUEOdnys
         BXBZAfVJLV/LmupU+EzE2NJceDWt1SiHPpKN6KFZdp6QhPdjl5mCMdnDMlK6D8rg5b
         aSXAfmu3A60bfgqXzQAnkS3id0vP7MhHJn0AyyblTXEjI6+J/yc3nQcxjzPButTHHu
         KldWNs4WFFXUqrPw/qv7CUNncDri+p6ySMJiLtC84B/HVe123po
Date:   Wed, 10 Jun 2020 23:41:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200610234150.GV6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aKl9HDSa9q6Cj3fk"
Content-Disposition: inline
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aKl9HDSa9q6Cj3fk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-10 at 21:19:21, Johannes Schindelin via GitGitGadget wrote:
> A growing number of open source projects aims to avoid the branch name=20
> master due to its negative connotation. See [1] for an existing discussion
> on this. The links [2], [3], and [4] describe community-driven ways for
> users to rename their default branches or use template edits to set a new
> default branch name.
>=20
> [1]=20
> https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV=
=3D=3DapdWDg@mail.gmail.com/
>=20
> [2] https://twitter.com/mislav/status/1270388510684598272
>=20
> [3]=20
> https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMaster=
ToMain.aspx
>=20
> [4] https://github.com/ethomson/retarget_prs
>=20
> By necessity, existing repositories require a lot of manual work to move
> away from that branch name, but it should be much easier for new
> repositories.
>=20
> This patch series allows overriding the branch name being used for new
> repositories' main branch. The main way to do this is the new=20
> core.defaultBranchName config option. This first patch was contributed by
> newcomer Dan Goodman-Wilson. Thanks for the contribution!
>=20
> The other patches follow other places where "master" is hard-coded and use
> the new git_default_branch_name() method to consume the config option bef=
ore
> falling back to "master".
>=20
> The last patch updates documentation only after the config option is ready
> to apply to all of these scenarios.
>=20
> This series DOES NOT change the default automatically, but only provides =
an
> opt-in mechanism for interested users. It also presents a way forward for
> such a transition, if and when we decide to do so. Specifically, the new
> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
> test scripts on an individual basis instead of all-at-once.

I've looked over this series, and I have no additional comments beyond
what I've mentioned and what Junio pointed out at the end of the series.
With those provisos, I'm generally happy with it, and glad to see these
patches hit the list.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aKl9HDSa9q6Cj3fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuFvvgAKCRB8DEliiIei
gYeUAQDsJLTfJFY7NffRV6b4P34cNrDOBe/8R/ETPWwnLrHiLQEAjENiEYI3QG/D
LliPprfREfp7uoNsZ41omZTDVU60vwM=
=vFHt
-----END PGP SIGNATURE-----

--aKl9HDSa9q6Cj3fk--
