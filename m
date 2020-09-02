Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFFC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9341520758
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 23:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EFoZiOXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIBXXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:23:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgIBXXR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Sep 2020 19:23:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D76A60129;
        Wed,  2 Sep 2020 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599088996;
        bh=xn5ael9FVFJMxvfX2vOUMutcN+FV43g7sWa3hQn1eRo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EFoZiOXic9zgVnjItOighvvhotDVXi8PKIhWYz7TtUY1s1hds8zxLufIVXEOPgd4B
         WI1SRaJ7s4WYKvR9yDboIgPepaYlvC2hGsga+91sZh0YAqTYCyr1dVdSHcdXXWQwQQ
         iv3D4mGI3s0N5W0skddz4RcsNG7lUKiBib1AFwO7GTuhL+LBNLWkIE386qVFd/dwvr
         86pl9PmRZKvqhiGtfI3xYodh0KUDt4YWnrkQIXOG9n+fZ5954/KRPpTtb8q5diOzcS
         a1Yao6vHXfeCYEj7wrexPkcsjxMreCYl3RENLUKp4JC5f4zRdG9Bk5/Egr7snYYSxE
         aUiqEtn8D41v0USLn0LxuwoUk6pTzwLwu6CfttKnuYTw6QZvVXCz8YlDL/7a78mTHB
         H2PsLP82vyKD7anYlk3ksShx+e8fkFRAo7rk1/Manyh/dsNwoIiORGXqFRp9lk0zWP
         UmvTljUIV+SdtDFG81+myVyk6GX8VEub8juTpZGagcNNMskT/PC
Date:   Wed, 2 Sep 2020 23:23:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmFmYcWC?= Grzybowski <aguyngueran@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Repo state broken due to mismatched file name casing during merge
Message-ID: <20200902232309.GE241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmFmYcWC?= Grzybowski <aguyngueran@gmail.com>,
        git@vger.kernel.org
References: <CANG6M-ri1uvEPCcssP=Q0iM25Vhr5QZ220zUUhMdH4AVR9OLSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <CANG6M-ri1uvEPCcssP=Q0iM25Vhr5QZ220zUUhMdH4AVR9OLSw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-02 at 16:26:27, Rafa=C5=82 Grzybowski wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> mkdir repo
> cd repo
>=20
> git init
>=20
> "sample file" > file.txt
> git add file.txt
> git commit -m "Added file.txt"
>=20
>=20
> git checkout -b other_branch
> echo other file > other_file.txt
> git add other_file.txt
> git commit -m "Added other_file.txt"
>=20
> git checkout master
> echo Other file > Other_file.txt
> git add Other_file.txt
> git commit -m "Added Other_file.txt"
>=20
> git merge other_branch
> git status
>=20
> What did you expect to happen? (Expected behavior)
>=20
> A clean state, no unstaged changes.
>=20
> What happened instead? (Actual behavior)
>=20
> There is always an unstaged file other_file.txt which case changes if
> I try to discard and the unstaged change stays.
> If I try to delete the file, I get two unstaged file removal changes.

Git always preserves the case of files internally.  However, the default
configuration on Windows does not.  When you performed this merge, you
ended up with two files, but it's not possible to write both of them
into the working tree.  Since they are not the same, when Git checks the
status of one of the files, it finds it to be modified.

The solution here is to do "git rm --cached Other_file.txt" followed by
a commit.  That removes the file from the index but doesn't touch the
working tree.  In Windows 10, you can also set a directory to be case
sensitive, which should fix this if you do a "git checkout .".

This isn't a bug in Git; Git doesn't know about file name encodings, and
even if it only handled Unicode file names, it's impossible to correctly
perform locale-insensitive case folding, so Git doesn't even try.
--=20
brian m. carlson: Houston, Texas, US

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1ApXAAKCRB8DEliiIei
gXUxAQC8Iuv0bQ8I/hrWys8Yw2TkGjJADIO/J1KYoxtFjjKHtgEA5l02MpZVXppf
4XCe+7Swb4YJ9ri9Mh9Ou3gLb1PHggA=
=UeIs
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
