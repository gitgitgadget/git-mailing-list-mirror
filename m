Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE9FC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB4B613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhGPTl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:41:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40088 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232792AbhGPTl6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jul 2021 15:41:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CA6060769;
        Fri, 16 Jul 2021 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626464343;
        bh=2csvRIdyHaCf7Bgy2lUuAk4Pjdy0b+wPd5UUy6cRAHQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wfl5gZUoGVTjMdsbEqlu69yQo3mmZXSkomPCV1vTMIPnFVMchlf3ss25nwukfI8I+
         MTW68kAwRh3hN6f7+3XmAU7oCFvQFLbgZuiM/s3J2qcQyYwzXKdXd7TLOaTijQC73h
         hW8IR6jYLrSx2szFXUfteTuzFSiDoQZ8toC2dxwdqGuygqSoAVVy4MasAVY4WZnBH3
         MtwZpmx9R3E8FaTCKuZugQdVKyZw8b2fpMW4VWPeupcka0cwNaLM+PbLUQg9SgX3B+
         RVONfY/ldxGm+Pcz9GhxVutgminNwPxSbTESKbxWTv2/nr7IKXSZCvEiLf0UG9rdC/
         X2//bFuK3bfk7VvZGCPxpJH3dnrGy6srcUtQTrsiCFvfbPeTs603ojSoHlXqVGdnE/
         lDHq+1+G+aqFHTSHvDV1NSAUtyZZcbj8wVfvrE2vgCbZlx8hlDeGdH3pYHfN3MHLZ5
         U4jMm5JUYVjGbV5ViQ07Lz8jv8BQq3Mz+cZNv6WZcEvrM5rSNd4
Date:   Fri, 16 Jul 2021 19:38:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rostislav Krasny <rosti.bsd@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
Message-ID: <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rostislav Krasny <rosti.bsd@gmail.com>, git@vger.kernel.org
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8kw8sJSbQ1wtH5lX"
Content-Disposition: inline
In-Reply-To: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8kw8sJSbQ1wtH5lX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-15 at 21:55:07, Rostislav Krasny wrote:
> Hello,
>=20
> Originally this bug was reported in the Git for Windows project and
> contains two screenshots:
> https://github.com/git-for-windows/git/issues/3321
> Johannes Schindelin (dscho) is convinced that this is not a
> Windows-specific issue. Following is a brief description of this bug
> as I've faced it:
>=20
> After running the "git submodule set-branch --branch master -- ms1"
> I've noticed that the .gitmodules file is encoded with both DOS and
> UNIX End-of-Line characters simultaneously: all original lines use DOS
> EOL characters but the added "branch =3D master" line uses UNIX EOL.

What behavior are you expecting to see here?  Are you expecting Git to
write carriage returns when the file already uses carriage returns?
What about when the file already contains mixed endings?

Are you committing CRLF line endings into the repository, or are they
just created by core.autocrlf=3Dtrue (or some .gitattributes setting)?

Does this cause a functional problem with Git (or maybe another tool),
or is it just aesthetically displeasing?

> Comments of Johannes Schindelin (dscho) in the GitHub bug report:
>=20
> > I don't believe that Git considers its config files free game regarding=
 line endings.
> > Therefore, I think that having DOS line endings in there is already a v=
iolation of Git's
> > assumptions. In any case, this is not a Windows-specific issue, even if=
 DOS line
> > endings are much more prevalent on Windows than on other platforms. Ple=
ase take
> > it to the Git mailing list (send plain-text messages, HTML messages are=
 dropped
> > silently).

It appears the config parsing code handles CRLF when reading by just
turning it into a LF, so without changing the code, it wouldn't be
possible to distinguish between the different line endings.  I don't
know that I agree with Dscho that CRLF line endings are right out, but I
also don't see always using LF line endings to be a problem.

Since I don't use Windows and don't see this problem, and I'm not really
partial to CRLF line endings anyway, I'm not especially interested in
making any changes here, but I'm also not opposed to seeing a patch here
if someone would like to send one to do something different.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8kw8sJSbQ1wtH5lX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYPHgUgAKCRB8DEliiIei
ga9tAP9tTzD3r6nK9GHHgEeD5BchCHpVkO+hlzOiX/MPRcyd4QEAguuEygGmVGUP
r8UVEUriQn15MMJE2amvacII/MuhRgs=
=ttMP
-----END PGP SIGNATURE-----

--8kw8sJSbQ1wtH5lX--
