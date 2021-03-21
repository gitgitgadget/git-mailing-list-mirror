Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AABC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF796194F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCUB2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 21:28:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45290 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhCUB2S (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Mar 2021 21:28:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 47DD26048E;
        Sun, 21 Mar 2021 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616290067;
        bh=zdT1lvT8IoMDCLGca4tQXz1IUXRvAZBKv9O22ttTGTA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=F0p0S5bVCEjF/hcOwC6vHrEyPZjg4T4woUhgK+RbeQNjyOfJxn+0zTvgyFgSj6kT1
         wylzNB6EJn7diDvUS7T0mNwNL7g1Ir4uQXpePpJ6qzin3VQpBcZdRzCBuIVJekZkMT
         u0nJ5UFoPeP3D+2k9v1BVwjBdFBlu1WwImIL0iaFhMvrEPQi9sL1f8Nuf5L0HDYFWl
         fcg5TYxD7PkrtIsWMyHPTa+cay1j4Af41DaSessTZDQwVkadk4/7l30GxwKktoZufL
         s32EiclvbDvWjvld8nQQddZgk+B2irn4NatmBcbpx1xraLUlG01neTHWFeL0xENbKi
         C1QvEq+9ynNWaoJjzYKCJThadZUdoc6ftYcM8xpwgRMROsz6m2QF0bYrpjFvoWTA/x
         wVn6ZW2qxJh+qf0bgEga5DugipqVPfimmFtL0FVONuj9i24yMoDPvFzicJyd6PKD5+
         1CevbMJ62jr3f9ssFvloQw4yoU8w9AKMLPNXruEgtcOUZIZfCYt
Date:   Sun, 21 Mar 2021 01:27:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
Message-ID: <YFahDtIkSmpLD2oZ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Georgios Kontaxis <geko1702+commits@99rst.org>
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
 <8735wpz699.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WZgUSzCUfrfbcvXF"
Content-Disposition: inline
In-Reply-To: <8735wpz699.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WZgUSzCUfrfbcvXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-21 at 00:42:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Mar 21 2021, Georgios Kontaxis via GitGitGadget wrote:
>=20
> > From: Georgios Kontaxis <geko1702+commits@99rst.org>
> >
> > Gitweb extracts content from the Git log and makes it accessible
> > over HTTP. As a result, e-mail addresses found in commits are
> > exposed to web crawlers. This may result in unsolicited messages.
> > This is a feature for redacting e-mail addresses from the generated
> > HTML content.
> >
> > This feature does not prevent someone from downloading the
> > unredacted commit log and extracting information from it.
> > It aims to hinder the low-effort bulk collection of e-mail
> > addresses by web crawlers.
>=20
> So web crawlers that aren't going to obey robots.txt?
>=20
> I'm not opposed to this feature, but a glance at gitweb's documentation
> seems to show that we don't discuss how to set robots.txt up for it at
> all.
>=20
> Perhaps having that in the docs or otherwise in the default setup would
> get us most of the win of this feature?

I'm going to guess that the two features are orthogonal.  robots.txt is
great for communicating to well-meaning actors what you do and don't
want crawled.  For example, one might ask a web crawler not to crawl
individual commits because that creates excessive load on the server.

This option is about preventing email harvesting, usually for the
purposes of sending spam.  Spam is email abuse and all reasonable people
know it's unacceptable, so by definition the people doing this are bad
actors and are not likely to honor the robots.txt.  As someone who runs
his own mail server, that is certainly my experience.

So I am in favor of this feature.  I think it mirrors what many other
tools do in this space and having it as an option is valuable.

> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
> > index 7963a79ba98b..10653d8670a8 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -896,6 +896,18 @@ same as of the snippet above:
> >  It is an error to specify a ref that does not pass "git check-ref-form=
at"
> >  scrutiny. Duplicated values are filtered.
> > =20
> > +email_privacy::
> > +    Redact e-mail addresses from the generated HTML, etc. content.
> > +    This hides e-mail addresses found in the commit log from web crawl=
ers.
> > +    Enabled by default.
> > ++
> > +It is highly recommended to keep this feature enabled unless web crawl=
ers
> > +are hindered in some other way. You can disable this feature as shown =
below:
> > ++
> > +----------------------------------------------------------------------=
-----
> > +$feature{'email_privacy'}{'default'} =3D [0];
> > +----------------------------------------------------------------------=
-----
>=20
> I think there's plenty of gitweb users that are going to be relying on
> the current behavior, so doesn't it make more sense for this to be
> opt-in rather than opt-out?

I agree this make sense as an opt-in feature.  While many people will
want to enable it, users who are performing an upgrade won't necessarily
want the behavior to change right away.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--WZgUSzCUfrfbcvXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFahDQAKCRB8DEliiIei
gZ4IAP0XH/a44c+BhQNqitdUnHVMnlqIqm8lVOfgdZOL7u9ImgEAzKQBbeesHszd
FZ4sAMTkRAI+VmIIEQ8evgXphRd2UQA=
=8ZUo
-----END PGP SIGNATURE-----

--WZgUSzCUfrfbcvXF--
