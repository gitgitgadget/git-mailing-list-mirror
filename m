Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED6C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174FE64F6A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBBXZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 18:25:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38124 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233010AbhBBXZB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 2 Feb 2021 18:25:01 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 27C276079B;
        Tue,  2 Feb 2021 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1612308229;
        bh=4qfatCppc/7Pz7qtLditS53rhexzmgjEfmlBvTCFqGg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ybdUx9vAGCjOLNWZZHR+3hO7yO6uwI0vv0ERREGmqh+0rFJ9rvTc0hUDPBDhAPNKl
         wPbc89VcrnKsOKkPX7OZDAc8l8N3lI3KyM+EuH5eau1kiMRpKi/gZI7xmEtf8DY5PW
         5HpqnVsBdUWCwlPVHS4DsjbjjpnGrktnLju7DWOt8XkhYcwnXYlmm7Ff7QBuLVr8TW
         XEZh2mNq3R1PkTaMMfPGmudeoTHDWbdJiocFeDC4QR3Ixn1zLjrPxWc0OZODx64TX9
         LsYWBfcm/OK0k3xWiOcT0tiEVXV8+/Otc5Ki1g3qA5Z/uQFeZr6MdV85nEqxoK5QNf
         0PExLwwI2GgxOBcxTe8Jfi2SFrEMOKOTfzbihOZhqt9I4fVkuMGux+o1xMM4OBpeD8
         H2EddXGLXInYa2TSkB5sxO0pv8x+cCsxtG11V2pKxkqBXOiLQY67FpRI4dNEqJw4My
         aCMJwpWVxrfaY0IS+vY7tQJJm7WiP+pAGOI21Ql7FxzLJK0gTND
Date:   Tue, 2 Feb 2021 23:23:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2 5/6] doc hash-function-transition: move rationale
 upwards
Message-ID: <YBnfAAcuTV89l0mM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
 <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
 <711a37969b6f51922c12555534d9c4634cde6021.1612282749.git.gitgitgadget@gmail.com>
 <xmqqbld2gs9f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UdNdnQPPBgcV69um"
Content-Disposition: inline
In-Reply-To: <xmqqbld2gs9f.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UdNdnQPPBgcV69um
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-02 at 19:54:20, Junio C Hamano wrote:
> "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > -Over time some flaws in SHA-1 have been discovered by security
> > -researchers. On 23 February 2017 the SHAttered attack
> > -(https://shattered.io) demonstrated a practical SHA-1 hash collision.
> > +Over time some flaws in SHA-1 have been discovered by security researc=
hers.
> >=20
> >  Git v2.13.0 and later subsequently moved to a hardened SHA-1
> > -implementation by default, which isn't vulnerable to the SHAttered
> > -attack.
> > +implementation by default, but SHA-1 is still believed to be weak.
>=20
> Even if we've hardended against one particular form of attack, we
> still have incentive to switch away from SHA-1.  It is unclear why
> we just do not add ", but ..." to the original and instead remove
> the half-sentence about sha1dc.

I think we should keep the original statement about the attack since
it's relevant to why we want to change.  I also think we should say,
"but SHA-1 is still weak".  Saying "is still believed to be" implies
doubt or uncertainty, and the fact that multiple collisions have been
performed and can be trivially verified should remove any doubt.

Even if SHA-1 were still perfectly secure (which it is not), it can only
by design provide an 80-bit security level, which is inadequate by
today's standards.

> > @@ -57,6 +47,19 @@ SHA-1 still possesses the other properties such as f=
ast object lookup
> >  and safe error checking, but other hash functions are equally suitable
> >  that are believed to be cryptographically secure.
> >=20
> > +Choice of Hash
> > +--------------
> > +There were several contenders for a successor hash to SHA-1, including
> > +SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
> > +
> > +In late 2018 the project picked SHA-256 as its successor hash.
> > +
> > +See 0ed8d8da374 (doc hash-function-transition: pick SHA-256 as
> > +NewHash, 2018-08-04) and numerous mailing list threads at the time,
> > +particularly the one starting at
> > +https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpa=
ste.net/
> > +for more information.
>=20
> I personally think this is referring too much to external document
> for typical readers, and lost too much relative to the original.  I
> do not mind losing the history of how we reached the conclusion that
> SHA-1 is no longer viable at all, but I am not sure if we want to
> lose the list of criteria we used when choosing (i.e. stronger than
> SHA-1, 256-bit, quality implementations, etc.) from this section.

I don't have a problem including this and in fact I think it might be
valuable, but I think we should keep the below data as well.

> > -The hash to replace this hardened SHA-1 should be stronger than SHA-1
> > -was: we would like it to be trustworthy and useful in practice for at
> > -least 10 years.
> > -
> > -Some other relevant properties:
> > -
> > -1. A 256-bit hash (long enough to match common security practice; not
> > -   excessively long to hurt performance and disk usage).
> > -
> > -2. High quality implementations should be widely available (e.g., in
> > -   OpenSSL and Apple CommonCrypto).
> > -
> > -3. The hash function's properties should match Git's needs (e.g. Git
> > -   requires collision and 2nd preimage resistance and does not require
> > -   length extension resistance).
> > -
> > -4. As a tiebreaker, the hash should be fast to compute (fortunately
> > -   many contenders are faster than SHA-1).

I'd prefer to keep the original criteria here, because I think it's
useful to document what they were for why we'd want to change.  For
example, we occasionally get random users asking why we didn't pick a
hash with length extension resistance or why we didn't pick SHA-3.

The fact that we don't need length extension attack resistance and that
most non-Linux crypto libraries provide an extremely limited set of
crypto primitives are essential to our decision.  I think if SHA-3-256
had been more widely available, it would have been the winning candidate.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--UdNdnQPPBgcV69um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYBne/wAKCRB8DEliiIei
gaMKAP4u52wtuucT3eKGKzxIXTOe/HahOtc2O7von40WULErqwD8DglRiGYPkBq8
ZFf1Z+rRTTMHoptIR6RTro+YEWuLXA4=
=+vVA
-----END PGP SIGNATURE-----

--UdNdnQPPBgcV69um--
