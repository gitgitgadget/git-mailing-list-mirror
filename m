Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4432C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14B960231
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFJWef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:34:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47708 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhFJWee (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jun 2021 18:34:34 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB3E660400;
        Thu, 10 Jun 2021 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623364357;
        bh=IqdPr32eIQu7dgA58qxBpQ2cC4O4AkUOAod1MUNwXzc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Do/HHFoIPIoigf9Xbyzlu7fZ71h0n/m//5IsmH8+ArE1RILqlt1AVS7w7Cg1qzghU
         C84k23KuCT1HhDYj26igPfL47t6hOsaYO2awLsEvgMdd4ituFIdUH4AAWoXChWuvXu
         Oq60BNav6Jt0u2iLXIQvPo7RTDQFG98vqkLLHSMchgejx7PNwQxNkmL9qD/M06jkQw
         FDHbu5ksw1ACaUUDpTVHBFvnwHlRmf2o0hihnPc/gQpENxw2GF7Fnt9pzLCPb0bB02
         61R/to82wjvAjBoKBjw7b/FSKJdRVSwrsh2exwk4SfVO1dUhQ6CxVsn8Q6yGodhcBV
         Kkef00Y/aLgeqpnmilJWgpdVO0LQQu7Voq+EA9evYlGDm75G3XwqZJU+6IPpgLlsG0
         ik22GQGq/S8paAN88QCVkgQDPbUo4mW5mChXIeui3hChQ/+P+/pBzkfKrhMFzVdph0
         OpQXh/Y1Q1Zu7eqCxxpDwYqEfmuxxtlp47tmYNfSt0EsKfNYuBg
Date:   Thu, 10 Jun 2021 22:32:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Message-ID: <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>, Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s55KZqGV89kIJkIa"
Content-Disposition: inline
In-Reply-To: <87a6nz2fda.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s55KZqGV89kIJkIa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 at 15:44:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Jun 09 2021, Derrick Stolee via GitGitGadget wrote:
>=20
> > Updates in v2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  * Some edits were removed because they were in contrib/ or
> >    Documentation/howto/ and these are now listed as exclusions in the
> >    message of Patch 4.
>=20
> Thanks.
>=20
> >  * Several recommendations to improve the edits in the documentation and
> >    code comments were incorporated. Those who recommended these edits a=
re
> >    credited with "Helped-by" tags.
>=20
> I think a v2 is a bit premature with all the active discussion on the v1
> thread, a lot of which isn't addressed by the v2 or this CL, e.g. many
> point I[1] and others raised.
>=20
> My main objection of extending this to commit messages and thus making
> e.g. non-native speakers be on their toes when contributing to the
> project is gone, so that's good.
>=20
> I'm still not in favor of this change because I think an active
> recommendation like "Refer to an anonymous user in a gender neutral way"
> probably isn't needed if we simply document that our preferred prose is
> to avoid the issue entirely, which is the case in most of our
> documentation.

I agree that in many cases in technical writing that the passive voice
(or another technique) may be preferable.  For example, this selection
about O_TRUNC from open(2):

  If  the  file already exists and is a regular file and the access mode
  allows writing (i.e., is O_RDWR or O_WRONLY) it will be truncated to
  length 0.  If the file is a FIFO or terminal device file, the O_TRUNC
  flag is ignored.  Otherwise, the effect of O_TRUNC is unspecified.

Who is truncating it?  Who is ignoring it?  Who is not specifying it?
In all three cases, the specific actor is unimportant or irrelevant, and
we're better off using the passive voice here than trying to enumerate
the actor.

> The below for-show patch[2] shows an alternate approach that I think is
> a better direction than this series.
>=20
> It shows how some of the s/he|she/they/g search-replacements you did
> could IMO be better if we simply reduced the amount of prose, e.g. in
> strbuf.h changing:
>=20
>     passes a context pointer, which can be used by the programmer of the
>     callback as she sees fit.
>=20
> To:
>=20
>     passes a `void *context` to the callback `fn`

In many cases, saying less is better, I agree.  If we don't need to
refer to a human being, then we don't need to consider any pronouns for
that human being.  If we communicate things more simply with fewer
words, then that's clearly better overall for everyone involved.
Nobody's reading documentation for pleasure, after all.

I do think that the recommendation that we refer to an anonymous user in
a gender-neutral way still stands, though.  Sometimes we will need to
refer to the user or another human actor and that will be the most
natural way to express the idea, so we should use gender-neutral
language to do so.

So roughly here, I'm in favor of both approaches.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--s55KZqGV89kIJkIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMKTAAAKCRB8DEliiIei
gSvBAQCBEwF9LASFq2kyQjh/7G5KOgMaauHKOuIl45DF6MpsKwD/SsWFi4hK0nU7
643SyTQ9Cx4wSKoivCdErMeKknr3qAk=
=ln/8
-----END PGP SIGNATURE-----

--s55KZqGV89kIJkIa--
