Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A03FC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18816023C
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBTOLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:11:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52506 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBTOLf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Feb 2021 09:11:35 -0500
Received: from camp.crustytoothpaste.net (unknown [97.105.19.220])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 779B160DF4;
        Sat, 20 Feb 2021 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613830253;
        bh=3kflKeo58yvDC+BYLKZSWM44ly4gLLYBrrOcHIfN7Y4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=l9QNLDXWWFOWI14PmX6nxiyC3wdgx4YjXm7dYvWB+OpHEARoUqqyIUXeg5h/3sD8e
         cQQN4l9vkgFrQaMWSxLcU2Jg3m07sCql35y5SAN5f+ek1pGuHYyh6ed+Bgcdx0c41N
         Z3juMFM5/JAgQoBjT1T+E17ClPdq0Nzc8mEDQwY7P39IDWkMnNq9D2PP1/2RnMNzyU
         ilqnwu0ILATYiGE9ShcdRk544/QsH6KWfAzDz9glRdFQvAFas90zNZabRL7ZJB8KTV
         xuKo666JhqF1q5qfzutjfwRQOMe1s4iipGve313HYlgcGkfW2PvMhc3gNjcdY9Y7g7
         nKcH5akRQDjztOUl5qIw0t+HF0fofrVl5fO549U0PwjDQnMUQf+OfDMMNGOICWyMs/
         bBAOBz1uW7oBCVmuNrgMNnMPDoD9tDJPFWMs+0tcRRQGnZxMUpLzjjiKJNym4SOhR9
         rXhKes0I/ndzdKtyexIGmgTBnc8e8hi5+XM6IF0ZGwGYI7Fn3ad
Date:   Sat, 20 Feb 2021 14:10:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add --no-filters option to git-add
Message-ID: <YDEYaVibMFo1OJZs@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>,
        Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
 <YDA9WjWOjkqlsALc@camp.crustytoothpaste.net>
 <a58d8057-9847-ba57-1bf5-5d27c235d210@collabora.co.uk>
 <c660bf7b-cd59-43d4-a374-11997f0b15d1@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xDkcWKnjSnipxv0a"
Content-Disposition: inline
In-Reply-To: <c660bf7b-cd59-43d4-a374-11997f0b15d1@collabora.co.uk>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xDkcWKnjSnipxv0a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-20 at 09:30:58, Andrej Shadura wrote:
> On 20/02/2021 09:06, Andrej Shadura wrote:
> > On 19/02/2021 23:36, brian m. carlson wrote:
> >> So I think that while this might be a useful escape hatch for users, I
> >> definitely want to see a compelling rationale for it and a big warning
> >> in the documentation and an update to the relevant entry in the Git FAQ
> >> before we accept such a patch.
>=20
> Here=E2=80=99s my proposal for the updated manpage description of the opt=
ion:
>=20
> --no-filters::
>=20
> Add the contents as is, ignoring any input filter that would have been
> chosen by the attributes mechanism, including the end-of-line
> conversion. Note that this option is not intended for interactive use,
> since files added this way will always show up as modified if Git were
> to apply transformations to them, making the situation potentially very
> confusing.
>=20
> And here the FAQ entry extended:
>=20
> It is also possible for perpetually modified files to occur on any
> platform if a smudge or clean filter is in use on your system but a file
> was previously committed without running the smudge or clean filter.  To
> fix this, run the following on an otherwise clean working tree:
> +
> ----
> $ git add --renormalize .
> ----
> +
> Another situation where perpetually modified may appear on any platform
> is when a file has been committed without running any filters (including
> the end-of-line conversion), but the `.gitattributes` file states that
> this file requires a conversion.  In this case, you can either
> renormalize the files if this happened by mistake, or modify
> `.gitattributes` or `$GIT_DIR/info/attributes` as described above to
> exempt the file from the conversion if this was intentional.
>=20
> (I will send an updated patch set when we agree on the wording.)

This seems fine.  Thanks for being open to addressing my concerns, and I
agree that your use case seems like a good one and that this is a
valuable feature.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--xDkcWKnjSnipxv0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDEYaQAKCRB8DEliiIei
gQ53AQDgt1oqqpObMS1fXEV0/STiGNwq4BgjrypSotm6JNxfdgD/fgOOriBP594p
3qlW2JGSxRydS8QcwuhwGExP+xK3CQQ=
=szv1
-----END PGP SIGNATURE-----

--xDkcWKnjSnipxv0a--
