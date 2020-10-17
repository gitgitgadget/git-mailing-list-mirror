Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03F6C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CD9207BB
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438885AbgJQUia (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 16:38:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438845AbgJQUia (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Oct 2020 16:38:30 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 940C66044F;
        Sat, 17 Oct 2020 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602967108;
        bh=s2zYujfHSKHWymwj1siVEizDr1SKasEAqSixM8cUH/U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sti2QutQ3vZoPq64S/ic99MYWSTdn09ZRSErHnEZcRUnEeF4lt4Qd5/lUimOcBRvn
         7sp08gZhl0aEZUa03xjKJPoydl+r0HmFjnhR4iROeAMcGYPX+1d40PZ6cwNu0kgFRO
         M8I2TsOtI40N2VoNDjxaiQKE2NFgq/Rp6NDTJaUdGHbODfvNq6CG12NTlkusmVtTaS
         GpBnd7VAXo7CmQAOCVQAtNgqVjv9kPX5u3Er9C14oiouP5hCBeoAj5lAMze9yoDgAc
         MZk7AzWIX8N4pestQOXWEcAr/9rbyT9CLCi3ae18ckcJBRg4entW1o6ShgrLFLm4FE
         olNVaACqyaDLwgAfSetJYxlKccDVIuUBdFnKnJr6MECAGh9+jpm/0vQE/lscf2/0Mj
         pj7mSGCMF/HhV3LEprYqR9UiM0uZmzjaTMvdyB/NFlALD9rEX98+CS1C14MIWtvTkb
         x1eaVxgnC560H5SUXPqSdcSTEXYsWJJHU7B87yqhu11l0/SfUgD
Date:   Sat, 17 Oct 2020 20:38:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sri Harsha Akavaramu <harsha.akavaram@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: about git hooks
Message-ID: <20201017203822.GG490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sri Harsha Akavaramu <harsha.akavaram@gmail.com>,
        git@vger.kernel.org
References: <CANZ9uZyL=+LNS-+2p3ukSPg_UXxjfcjD8QPVF4p0NF5-+eYMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <CANZ9uZyL=+LNS-+2p3ukSPg_UXxjfcjD8QPVF4p0NF5-+eYMYA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-17 at 14:24:10, Sri Harsha Akavaramu wrote:
> Hi git,

Hey,

> I just wanted to know something about git hooks.
>=20
> we use GitHub enterprise and I'm the owner of the GitHub.
> I'm trying to understand that I want to pose the pre-commit and
> post-commit rules on all the developers by default and is there a way
> to pose git hook restrictions on all developers on default.
>=20
> I came to know when reading with the documentation we cant push hooks
> to source control. Then what is the best preferred way to pose
> pre-commit things on all developers using the repository?

This is a great question, and it's kind of answered in our FAQ[0].  The
short answer is that you don't.

It's possible for any user to simply bypass pre-commit hooks with
--no-verify without being noticed, and there are a lot of good reasons
to do so.  For example, if I need to make a large set of changes, I may
make a large number of temporary commits, one each time I make a change
that works.  Those commits won't meet anybody's set of standards and
therefore won't pass the hook, and I'll need to clean them up later, but
that helps me organize my development process in a useful way.  The hook
here would just be an annoyance that gets in the way.

You may wish to provide hooks and an install script for the benefit of
the user who wants them, but anything that runs on a developer system
cannot be an effective control.

The right way to add checks that need to apply to all users is to use
either a pre-receive hook or a CI system, plus code review.  That lets
your tooling verify things like commit message formatting, code
formatting, tests, and other things you'll want to check before merge.
The code review, besides being a best practice for finding bugs and
problems before merge, also prevents developers from neutering the CI
system by disabling it from working properly.

That's the way that most organizations handle these problems, and
generally it works pretty well.

[0] https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-HowdoIusehooks=
topreventusersfrommakingcertainchanges
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4tWPgAKCRB8DEliiIei
gft7AP42baLhid2QGPHuYSGDQr4bTGWZlOmfhzMSu5k/WsrhWAEA7mlOoMbUBKPc
jWLw1TxLF3Sj16iMQbyIvDy8O7dmzwI=
=UqyN
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
