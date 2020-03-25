Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52202C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0620775
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LCqTRwzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCYLDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:03:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCYLDv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 07:03:51 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8CFAD60478;
        Wed, 25 Mar 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585134230;
        bh=Dx08KIO07kNM0MDk+uhD+WwNfoPt2Ujm3Vz+ncYHiy4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LCqTRwzzShdGodZyrRFVurXnwBxWEaMxWil6hE8wKUSAwstnaIg4RKf4B6z49tPOc
         +W0JtpUO3hRHQlFVZaJApuxhV02O6MxseMZKYTDSLzjVGlm0kkKHhOpwAbIZLo5yt0
         Q6a++jgceclStJr/D6P60UmI0L81pOAKspnhEQOZk+dhU37G89EF9vuw/XmqyJBg7M
         8+el8C+ynYyLF2G2IbqnDCveUkrslSAgbxKaECSS5ZAfGIC3rQ/e2VE8TOfJ5QEbTb
         7IiQr2LFH0ZeYtT5dEvyzf9iLZGkfaHxvPcX68FvWA/vgCltQgjzB/nE3iUICjOaKV
         AGAkJHH280oOWFrq+4EoFAm7nFtGIlhhvQSq5Dfq74dijFRGdR0DPStrkniXmzB5D/
         moGeK5vnUo76ozHqQ70JIPirrQ1pHHU3F6WlBEwUuQvXj/pbtccptLlh8c/uMCG+k6
         hGMbCense0Z38VIfzl4y3bEWFwiljPs5wb2b1toqqvppo9Cu+Rq
Date:   Wed, 25 Mar 2020 11:03:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] docs: add a FAQ
Message-ID: <20200325110328.GK6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <20200325013434.219775-1-sandals@crustytoothpaste.net>
 <20200325013434.219775-2-sandals@crustytoothpaste.net>
 <CAN0heSofpxFW81=sB+4ukx9S0JOJo_XuKDTBSkTy_-QK+jDz0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <CAN0heSofpxFW81=sB+4ukx9S0JOJo_XuKDTBSkTy_-QK+jDz0Q@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-25 at 06:23:49, Martin =C3=85gren wrote:
> On Wed, 25 Mar 2020 at 02:37, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Note that the long lines for certain questions are required, since
> > Asciidoctor does not permit broken lines there.
> > ---
>=20
> Missing sign-off.

Thanks, will fix.

> > +You can also just enter your password when prompted, or you can place =
the
> > +password (which must be percent-encoded) in the URL.  The latter optio=
n is not
> > +particularly secure and can lead to accidental exposure of credentials=
, so it is
> > +not recommended.
>=20
> So should we even mention it? Or should we use the "it is sometimes
> (erroneously) suggested" construct?

I'll rephrase this to make it a little more obvious that this is a bad
idea.

> > +Most hosting providers use a single SSH account for pushing; that is, =
all users
> > +push to the `git` account (e.g., `git@git.example.org`).  If that's th=
e case for
> > +your provider, you can set up multiple aliases in SSH to make it clear=
 which key
> > +pair to use.  For example, you could write something like the followin=
g,
> > +substituting the proper private key file:
>=20
> Would this be in `~/.ssh/config`?

Ah, yes, we should tell that to the user.

> > ++
> > +----
> > +# This is the account for author on git.example.org.
> > +Host example_author
> > +       HostName git.example.org
> > +       User git
> > +       # This is the key pair registered for author with git.example.o=
rg.
> > +       IdentityFile ~/.ssh/id_author
> > +       IdentitiesOnly yes
> > +# This is the committer for author on git.example.org.
>=20
> Looks like you did s/account/committer/ instead of s/author/committer/?

So I did.

> > +
> > +[[last-commit-amend]]
> > +I've made a mistake in the last commit.  How do I change it?::
> > +       You can make the appropriate change to your working tree, run `=
git add
> > +       <file>` or `git rm <file>`, as approrpiate, to stage it, and th=
en `git
>=20
> typoed "appropriate"

Will fix.

> > +[[restrict-with-hooks]]
> > +How do I prevent users from making certain changes with hooks?::
>=20
> I read this as:
>=20
>   How do I prevent users from making "certain changes with hooks"?
>=20
> As opposed to your intended meaning:
>=20
>   How do I (with hooks) prevent users from making certain changes?
>=20
> I'm not suggesting the latter as a "fix" for this "problem" though,
> since it's a bit clumsy. How about adding a comma:
>=20
>   How do I prevent users from making certain changes, with hooks?
>=20
> Or maybe just dropping those last two words.
>=20
> Please trust your judgement on whether this is a problem, and if so, how
> to go about addressing it -- I know you have lots of such judgement.

How about, "How do I use hooks to prevent users from making certain
changes?"  That seems to both read smoothly and avoid the misplaced
modifier.

> > +Cross-Platform Issues
> > +~~~~~~~~~~~~~~~~~~~~~
>=20
> I think you meant to use "--" as everywhere else instead of "~~". This
> is not a subsection of "Hooks".

Ah, yes.  Apparently my fonts are so small that these are hard to
distinguish with bright white on grey.  I typically use the
Setext style in my own documents, but that isn't what we do in Git.

> > +To do so, you can specify a linkgit:gitattributes[5] pattern with with=
 the
>=20
> "with with"

Ah, normally Vim flags those things.  Will fix.

> > +[[windows-diff-control-m]]
> > +I'm on Windows and git diff shows my files as having a `^M` at the end=
=2E::
> > +       By default, Git expects files to be stored with Unix line endin=
gs.  As
> > +       such, the carriage return (`^M`) that is part of a Windows line=
 ending
> > +       results is show because it is considered to be trailing whitesp=
ace.  Git
>=20
> "results is show"? "is shown"? Perhaps with a comma after "shown" for
> better reading flow (IMVHO).

This should be "is shown".  I'm not sure if a comma after "shown" is
grammatical here as it stands, but I think we could write "is shown,
since" and that would be okay.  I'll check a reference and rephrase if
necessary.

> > +       defaults to showing trailing whitespace only on new lines, not =
existing
> > +       ones.
>=20
> > +We also recommend setting a link:gitattributes[5] file to explicitly m=
ark which
>=20
> s/link:/linkgit:/

Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXns6gAAKCRB8DEliiIei
gVWOAP9pKzAhIhdQzr7Fz8jpq+76e+ou/dCpl2TFNRk6WgihRgD/SdBytpXxcAm2
o0UFybDCa4geo1aRaxLWek2f9ni4QQE=
=N6+X
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
