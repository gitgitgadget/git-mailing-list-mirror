Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D5C2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E893A610EA
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhFRA3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:29:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51072 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhFRA3M (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Jun 2021 20:29:12 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D09C860443;
        Fri, 18 Jun 2021 00:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623975993;
        bh=ifJ8vNncIjijsCF2VDBNHbPMBnQD9c6+sS21n2w01uc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cnTmvFwpwUr49ZxT9dEEJyc3Imq4UOZd1YPMjAXYbn9tFBqAMKVK569om0lFt0gcM
         +QOU55Bp4a3xfUVdjJV3NqwpFBFAA3pAOk6Tila2ZhtQhoLf3cjl0OQBHeVImOGHq8
         dT+NjByb07ATP/I5FEIWxfye7w7Gf4X3rpFrfg9a2nvYFoWHeZUGdKXDzk9pBGHu5h
         Qns5gYMpwNwq7B/RRsPkUu9DbeUrzl5bnI1XPc/EAWXZfci5gI3GDZbgrhKdUCStdW
         XvI+ui1q0jbgk61SJuWRCKmkMvCRci8tp4uWX2kWbJlSjgb4h3gaBk0gX9Em/EBGoI
         lwCQRSm5SbVXT6yxWf/pV76q0a8rMF3CPAHoMeCOR9uhAzcT5qVfoqZ0gzYxk34Jfm
         FD2FNFhMykRXmSYpb8l8Ws0TuMbvmYMAFWKBA2PBW17/OpDGgj8PENnEc/keMFwj9a
         VwApxMZjfuT88cc+LPOEdSPVMHO+UOIxTJwV6R4kt/n7aVnxFt/
Date:   Fri, 18 Jun 2021 00:26:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Message-ID: <YMvoNcFXnHo0KXH3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>, Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
 <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wI1cKH6P49jeRAwi"
Content-Disposition: inline
In-Reply-To: <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wI1cKH6P49jeRAwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-17 at 13:22:21, Derrick Stolee wrote:
> On 6/16/2021 8:09 PM, Junio C Hamano wrote:
> I disagree that removing gendered pronouns and updating the
> guidelines are orthogonal. At minimum, we shouldn't have
> guidelines that we do not follow, especially when they are
> small in number and we can fix them in a few patches.
>=20
> The entire point of this series was to reach a decision about
> gendered pronouns so we can stop having arguments about them
> when they come up. We should just be able to point to "here is
> the decision we made" and it's not enough to say "If you go
> look at the mailing list archive you can see that we removed
> all gendered pronouns so you shouldn't add them again."

I agree.  Part of the complaint in the previous thread was that we were
overly debating people's commit messages, which can be demoralizing to
contributors, especially new ones.  It's much better to decide on an
approach, document it, and then, if there's an issue, we can just point
people to the documentation.

And, judging by the amount of discussion around this topic, it would be
helpful to avoid rehashing the same discussion again and again.  I
certainly would prefer to not have this discussion multiple times.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wI1cKH6P49jeRAwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMvoNAAKCRB8DEliiIei
geTjAQC19BD5/9Bojfq1DCBSpGxxqFkh0XDgqIArZ85SEqj4GAEAiu5ihdQcwfUa
AkSXQguICiMQ+dwRSPcGSChgclHjSAo=
=OT7w
-----END PGP SIGNATURE-----

--wI1cKH6P49jeRAwi--
