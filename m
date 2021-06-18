Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA3C2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F5E6120A
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFRA4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:56:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51100 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhFRA4L (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Jun 2021 20:56:11 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2EB0660749;
        Fri, 18 Jun 2021 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623977642;
        bh=d+VjCH9ajI0s5+ImjoGcREtKxia75+qlvizDIcwyalc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nWy1E0zG1tTMjPyzlF+a9DDqLP8LYnLxKqh6clU43Aj8SRjhoVgMhJnfYCjH84ngb
         OEehh5Mz+SQnbPxhRSIZVFnc2Y0VjoVqufYbeSpT+rjHQQEvvZHAVY6wtkuiEUOXk8
         ZC2G6N/G+VR0NrHYXBAyynvyo5YNjjV6gVk/3U/ZlHaZNb6h9hVPx5ItWs+sym1kgs
         osN11YFSoqxY88UgpOS3Y+i19LBLv4IXQ4JyI508WEzByy1jHDfjOXmxua3P1BYUfC
         IBKDM2i67LKRx6RAENgCtr72d9KtZmreOvSxczMl1wm9kQ+pd59TS+V8UlVyv6n4kj
         yym0llm0wDjkD/2sj+k5JQOmW/akAb3pA9+lFDmgKMmzL/3wsWk/tTEaYWCaek0CsU
         AABQ4+PZ6wyIqBCXiK4eM+b7Eg6Lbhda0B7bZaA2N3IkmkwatHA+xhLt1mC1Q6JUGn
         5Em1Zs+j0bn6XFlkSXqoAY/Mmr3AX8ISaUpH5v3acBT2PEx1/Iu
Date:   Fri, 18 Jun 2021 00:53:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
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
Message-ID: <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z5EoyfMke1KM738J"
Content-Disposition: inline
In-Reply-To: <87bl85y15s.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z5EoyfMke1KM738J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-16 at 19:54:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> The references to "gendered prounouns" etc. are gone, perhaps there's a
> good reason to re-include them, but the point of "isn't that issue
> solved by recommending an orthagonal approach?" is one of the many
> things Stolee hasn't been addressing in the threads related to this
> series.

I think I've addressed this.  Sometimes you can avoid referring to
people and therefore avoiding pronouns, and sometimes the prose reads
better if you talk about the user or actor.  Also, sometimes you need to
discuss a matter at length and using variety in your language is
desirable, so you may want to, for example, avoid continually using the
passive voice to discuss the topic.

I don't think it's fair to just say "don't refer to the user or other
humans if you'd need to use third-person pronouns" because I don't think
that's applicable in all cases.  I, for one, don't intend to write my
commit messages in that way because I think it will make them
substantially worse.  For example, I often discuss the behavior or
expectations of users when writing FAQ entries or other documentation
and sometimes we'll need to use pronouns.

I agree that in many cases we can effectively rephrase to avoid needing
to do this, but if we acknowledge that sometimes we will need to write
using third-person personal pronouns in some cases, it's worth
documenting what those should be.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--z5EoyfMke1KM738J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMvupQAKCRB8DEliiIei
gWjwAP4i5UBs7KvkuR/TbcrtKnnoIsUUxAA2hlFkOa1kd1mwQgEA8zeVD//Y7/I4
cLDeeSY0bdgtxyDoh8WyyM0cXZXJDAs=
=M7r7
-----END PGP SIGNATURE-----

--z5EoyfMke1KM738J--
