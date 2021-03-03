Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC47C433DB
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6319A64ED0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448788AbhCCGfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32892 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235450AbhCCAiI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 2 Mar 2021 19:38:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8125660DF4;
        Wed,  3 Mar 2021 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614731797;
        bh=w3TqbGsvkfAldD3l0mPIxZQ45UedHzA7U1JLQp2z7Cg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DKpIZA3703Jy5sW03ulmtMvVsoLcc9onpft7/CephQr+b5EnRWFdoz/a9N1DVCgQD
         w2Nf+KyF5EgyB7DjmsxkbNpNXdAUHJCYmgq+2EmpxFtEX+BTibd17bOmSWfWl9LAeU
         0ONGhPwwI9JtHVSpd1OOBdrpxfUZiM5mdEsB1jlCSErM4fGfLseAb9u6YxY4zXv6b6
         M04J9ILAseoNWIjPrBAcEryJkKVcq1+rqs6FRrBnw/Il1L6x4BBHgPY95Of+0cLvIc
         2z0JhKNiD+4Unbrt5dnre2fQzBI836AbfAFKNYaygr0/vqVN++5u1XlUKsT6k3U217
         FHGSto9LYI/JmCWWOWYcjxmtX+f/tXCR7ZWpJiwtdrkQHEQG52c1H0gs0WS/igrMNS
         iXazgYWJ+kMnB8lSP2bicHYF+8dpvfRG1JRRx8hm2XBMKAclpAwB7tdv9tIqcu7Nxh
         xNIfgd6uZ97mCl1j2qvJ5Hd7qR6TLr2s/W+glqS2C+RRMbkGF4A
Date:   Wed, 3 Mar 2021 00:36:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
Message-ID: <YD7aDwX/aiRN0GZs@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-5-sandals@crustytoothpaste.net>
 <87h7lwl5mv.fsf@evledraar.gmail.com>
 <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
 <xmqqpn0irb9a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FBWh4klG/WSAGE07"
Content-Disposition: inline
In-Reply-To: <xmqqpn0irb9a.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FBWh4klG/WSAGE07
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-01 at 18:15:29, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >   The output of 'git archive' is guaranteed to be the same across
> >   versions of git, but the archive itself is not guaranteed to be
> >   bit-for-bit identical.
>=20
> I do not quite get this; your original was clearer.  What does it
> mean to "be the same across versions of git but not identical" at
> the same time?  If output from Git version 1.0 and 2.0 are guranteed
> to be the same across versions, what more is there for the readers
> to worry about the format stability?
>=20
> Perhaps you meant
>=20
> 	... is guaranteed to be the same for any given version of
> 	Git across ports.
>=20
> or something?  It would allow kernel.org's use of "Konstantin tells
> kernel.org users to use Git version X to run 'git archive' and
> create detached signature on the output, and upload only the
> signature.  The site uses the same Git version X to run 'git
> archive' to create a tarball and the detached signature magically
> matches, as the output on two places are bit-for-bit identical".

I think what I had intended was that Git produces deterministic output,
but I don't actually think that's true across ports.  If someone uses a
different version of zlib on a different OS, the output may differ.

I'll rephrase to avoid giving a misleading impression.

> >   The output of 'git archive' has changed
> >   in the past, and most likely will in the future.
>=20
> That is correct as a statement of fact.  I feel that saying it is
> either redundant and insufficient at the same time.  If we want to
> tell them "do not depend on the output being bit-for-bit identical",
> we should say it more explicitly after this sentence, I would think.

I agree we should explicitly say that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--FBWh4klG/WSAGE07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYD7aDwAKCRB8DEliiIei
gYOXAP4r6fFGKa2DIvnqj6roXH5wcOAHg2x6qREZkIO57Opd0AEA93V1jkheU8yh
hpMdqM/rsrf0ZqC92yzkAtrdF1XwDwQ=
=SWSu
-----END PGP SIGNATURE-----

--FBWh4klG/WSAGE07--
