Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F141C4332F
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 21:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiBTVYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 16:24:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbiBTVX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 16:23:59 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61137BFB
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 13:23:36 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 82AB35A0A6;
        Sun, 20 Feb 2022 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1645392215;
        bh=++OtTOJEAdGpiVb7UuRoUB8jKqr/f4ymKNIeWMhHWgQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vzKVPiviSUpCeFlWy/85Xh0XKLqpGsSBoxSddz2ehOTko/PXVPMUO8ieQwldpgW+U
         mmpjRXCvIMUQRkJXcM3ck99XFkCTkzifXDadmiPamUzNoiWJluK4zJiM5GMwHY6YlM
         QIUZYfuw+8nUTbR1tmxyvQEdrwTwYgZFIh44oMZtW1ALiaJ7YzDc9uNdBlR3ACrJLv
         LNaoLRCicQEXi78kw76A7Cx3ls0mtUbLPZ608h1uPmof68rHJdSil/fnV5Z3dUlyfg
         lU2dZuOBaenQP8xZcbCykaETM0hgbt80RYyegItVuWCL3mlx5G2lozOnK+xT9xDyOF
         aOs/0ULWOzccijmtD6ON7nTjK8KkGnZBQEB05nSEfGVs/UfteVJPDBVWNKYaF3cwQD
         M611a+yOzpN/JGJ5hijvGAyfJgZYR3hVrw0u9vCc6aeRxYqJWU9tfcHbK5cebv+XrD
         3ycbgbiS5WPKQCk/UfUB8LA8ks17tXXX47eA7KZQJWCufS48u2z
Date:   Sun, 20 Feb 2022 21:23:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Merlin (they / them) Patterson" <merlinpatt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>
Subject: Re: [PATCH] docs: update coding guidelines to be more inclusive
Message-ID: <YhKxVBReUMJUB0tw@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Merlin (they / them) Patterson" <merlinpatt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>
References: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
 <xmqq4k4ycvgb.fsf@gitster.g>
 <220217.86a6epiyii.gmgdl@evledraar.gmail.com>
 <xmqqfsog512t.fsf@gitster.g>
 <CAFZ26y3re+fJapXzLOpf73F-ECXhg2sCoBtm_=VUFy5nbN2UVQ@mail.gmail.com>
 <220219.8635kfhfoy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cd6RC5wjW+GD4Xmc"
Content-Disposition: inline
In-Reply-To: <220219.8635kfhfoy.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cd6RC5wjW+GD4Xmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-02-18 at 23:18:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I think this came about because of a previous discussion that you'll
> find in the list archive where some native speakers were maintaining
> that "they" in this context was widely accepted usage because it had
> made it into some style guides single-digit years ago.

Singular they has been in common use for centuries.  It became less
common for many years because prescriptivists proposed using "he" to
refer to people of all genders, which was in common use for a long time,
until it was widely criticized as being sexist (and also, at times,
sounding bizarre).  "He or she" was then used in formal writing, but
that was also criticized as not being inclusive as well as being wordy
and awkward.  During this entire time, singular they has remained in
common use in speech and informal writing and is widely recognized as
part of the English language.

It's true that it is only now becoming more acceptable in formal
writing, but it is well known and commonly used in English as a whole
and has been for a long time.

I will also freely admit that for people who have learned English as a
second language sometime in the past, this would probably not have been
covered in the textbook.  As I continue to use Spanish, I learn things
about the language and how it's used today that differ from what I
learned when I started learning it formally over two decades ago, and
that's okay. Language evolves and as speakers of a second or third
language, we'll have to evolve with it.

> I.e. this was a perhaps flawed attempt to say something like "this
> phrasing sounds weird, but it's actually correct".
>=20
> As someone who speaks at least 4 languages regularly with levels of
> proficiency ranging from native to something that sound as though I'm
> trying to butcher the language, I can assure you that advice like that
> *is* really useful to a non-native speaker.

I agree, this context would be helpful.  Maybe, if we retain this, we
can just explicitly say, "Even though some non-native speakers may find
the use of singular they unusual, it is in fact common in English and
preferred in our documentation."

> I.e. whatever you or anyone else thinks about this usage of "they" it
> *is* relatively obscure usage of English. I'd even bet that for some
> readers of this document it's the first time they've ever seen it.

It is simply not the case that this is obscure.  As I've said in the
past, singular they, in the sense of referring to a single person whose
gender is unknown or irrelevant, has been in use since the 14th century
and has been used by William Shakespeare, Lord Byron, and Jane Austen.
It is routinely used for this purpose by fluent non-native speakers as
well (I have noted colleagues doing this).

I will admit that using they as the pronoun for a person whose gender is
known and who has explicitly requested the use of this pronoun is much
more recent, which probably dates to the mid 20th century (albeit at a
much lower frequency than today), but this is not the context in which
we are using the pronoun in our documentation.

It may be that for some readers it is the first time they've seen it,
but it will be far from the last if they continue to read English.
Understanding the main idea of a technical document in one's specialized
field (e.g., the Git documentation) is part of the CEFR B2 level, and at
that point, I'd expect the reader to have read numerous news articles
and online documents where this usage is common or becoming so.

As to your suggestion to this effect, I should point out that I'm fine
with removing this text from the documentation, as you suggested,
provided we can stop having extended debates about it on the list.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--cd6RC5wjW+GD4Xmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYhKxUwAKCRB8DEliiIei
gXrYAQDb3RfEsmz9M/Cvzyqy2GJMGB9rFf957BTDI0J0kWh5EQEA8mBWYO2vwRud
ogTwF7bRngsLtxjAXr/k0RpGmh6Tzw0=
=Oasg
-----END PGP SIGNATURE-----

--cd6RC5wjW+GD4Xmc--
