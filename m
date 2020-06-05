Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C31C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C64207D5
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g3ZMWn5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEXYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:24:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728316AbgFEXYU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 19:24:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DD9F360756;
        Fri,  5 Jun 2020 23:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591399459;
        bh=iT6c21usHevvd6Fhqvet1ad854l/3/vsLDJtUzXGoxg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=g3ZMWn5EsC+AcYxVhTBZJY5L7diKd/0SXWyaEhvsw30JHmbUTSkNXMtUD9tbBB4qK
         0tZCaUXVPAK5ovYqMBZJfGPmUvSQOAv1S1mqNKGLtmUDcNtxJkYAMTco1bF9rD/Yw8
         Cea0zu9r6nu1Tj4ivanTgxJh/G+6/8VzFxHLLup+9gGeCNSatIR7G3w9E0Ulevhvf1
         z87T///7Ig88pNAkeXUe0ESs/FL39KgVKEHUu0WkjI15Xj3ADjZxtsGGIIV/ltnqKx
         USguIGej/iCbKMLwcuoUQmFEY9QnehMmQ86pvWxKv9zGBEKlci7h5UoR2P/IzU3MrN
         r6o0YLzNk3OiFLiZUdRLEP/9XmUNxK6Rda+SgcaXCQ0yzKN/SRbR4H7RGFMHsFxhJn
         M+Fuj2wuYG+NYzdiUnsVQS9OS2wt7Sp3iO6EpSgVKN/oaZW/y07NoCgEUuNrxuUEN4
         ieGmPuCsFoJV4O+izmnNqDh9Gk5gV4H93u7JMwx0X/MQhdKlzwr
Date:   Fri, 5 Jun 2020 23:24:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Standardizing on Oxford English
Message-ID: <20200605232413.GG6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
References: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-05 at 05:34:21, Varun Varada wrote:
> Hello,
>=20
> I noticed the Documentation/SubmittingPatches file reads:
>=20
> > We prefer to gradually reconcile the inconsistencies in favor of US Eng=
lish
>=20
> May I ask why? US English is highly idiosyncratic, illogical, and used
> by a minority of the English-speaking population of the world (see
> https://en.wikipedia.org/wiki/American_and_British_English_spelling_diffe=
rences).
> Since British English has its own idiosyncrasies, why not use Oxford
> English, the most international English that is used by millions of
> the world? It is used by practically every international organization
> (such as the UN, ISO, IEC, BIPM, NATO, etc.), taught in practically
> every school in non-native-English-speaking countries (and even
> native-English-speaking ones), and used by myriad publications (e.g.,
> Nature) and people around the world. Given the inherently
> international nature of the Git project, it makes complete sense to
> follow suit.

I should point out that many of your arguments about U.S. English are
true of English in general.  As a native U.S. English speaker who also
knows Spanish and French, I can confidently say that even French, which
many find difficult, has a mostly regular correspondence between letters
and sounds, and, overall, a reasonably consistent set of rules for verb
conjugations, albeit with many irregular verbs.  English, in any form,
has none of that.  It is, as languages go, highly irregular.

I didn't write the text in question, but I suspect the reason is
practicality: most open source projects use U.S. English, and most
contributors to Git are able to write the U.S. variety.  It's hard for
me personally to write Oxford English because I have never written or
spoken it, and when I need to consult a reference, the one I have is
=66rom the University of Chicago, not Oxford.  I suspect many Canadians
and second-language speakers from at least parts of the Americas are
more likely to be familiar with the U.S. variety than Oxford or British
English, although I don't know for certain.

This isn't a defense of U.S. English (after all, I wrote the first
paragraph), but just an acknowledgement of the way things are.  This
project is all about practicality rather than purity; to quote from
CodingGuidelines:

   Again, we live in the real world, and it is sometimes a
   judgement call, the decision based more on real world
   constraints people face than what the paper standard says.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtrUHQAKCRB8DEliiIei
gfEbAQDL4h9vT6kZ84cNJ4bIRja4+sqEqi7SSTQJn6/m6M2ZngEAhgXmK199R5rJ
B1ziAbyg1dJl3DGUjTwZL5nNlxRkOAQ=
=C1EG
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
