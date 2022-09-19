Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF3ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiISR1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISR0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:26:40 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9412AF3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:26:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A4B6E5A1DF;
        Mon, 19 Sep 2022 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663608380;
        bh=Jey3GHAcDTxNWo+oprBwTSKVPbS2VcuRbsqOSLR2BGg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h51V1kwv+l7mNXVoDzEGVXYiAKsMtr6EZv2AoKlStNi2BHlLTlJF4mYwOIsGayIw9
         hmxHO/CNTRm6Jvnre+UJd2pZUBq16NVKWTjS5Bcz5Hwvh0lNHTH0tiYbs0AzHRLnhH
         GtvTv6Oy613kh/v+Ct0dmjW70u0nF7kFJh69j99/oP2P6gsfmuancCdAFCW/QbcJKm
         fowynOaM8XMnJoljVRneAxv2nZiD3/x1GByPP4hxPyEBEnzbUkRsOlTLOUmCRwIiKP
         ABo/0vXxreuG1sQKp9qGxkSJf7uToCaCzfe3GOdNSEA6AuKZfv6LJiU9JifFSgRcOm
         vfDRBBgGpnmT0vBJ268LvuJdYeYKpREPTqTClzJ//zY25XQKlzUCtvHilhuuytEz+y
         fe2pXQoK9yf6tfGDEagN7QFkC7O+BTOLLtOsHA/4vRMGp8Y+W/OOYWKgCFJyUp9tfR
         o4Sbgn7DIYfY4qh9Nr/2p6D/RhHdRvvjivAGAvdvTt5Q+bBcunn
Date:   Mon, 19 Sep 2022 17:26:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Message-ID: <YyimO8Vp39DWgt75@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
 <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
 <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
 <xmqqfsgncoma.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ebvLpoFlhE0pbq31"
Content-Disposition: inline
In-Reply-To: <xmqqfsgncoma.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ebvLpoFlhE0pbq31
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-19 at 16:31:25, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Your statement that you intended to write exactly such a feature was the
> > main reason I dropped the SHA-256 hashed mailmap series.  I don't think
> > it's constructive to offer or propose to offer such a feature in Git if
> > we're trying to obscure people's names in the mailmap, ...
>=20
> Yes, I remember that exchange, and I find your position reasonable.
> Yes, we all know how to build such a feature.  Yes, we know a
> third-party implementation of such a feature may materialize.
>=20
> But we do not have to be the ones to encourage use of such a
> feature.

Sure.  The goal is to make the tool more friendly (at least to some
folks) to use.  Other people can worsen the experience; we don't have to
do that.

As I said, if we're willing to commit to not add such a decoding feature
to Git, I'm happy to resurrect my hashed mailmap approach with or
without changes and get it ready to merge.  It sounds like that might be
an approach we're comfortable with here.

> > I also have an alternate proposal which I pitched to some folks at Git
> > Merge and which I just finished writing up that basically moves personal
> > names and emails out of commits, replacing them with opaque identifiers,
>=20
> That part I can agree with.
>=20
> > and using a constantly squashed mailmap commit in a special ref to store
> > the mapping.
>=20
> This part only half (the "special ref" half, not "constatntly
> squashed" part, even though I know why it matters more to your
> goal).  My gut feeling is that auditing and merging will become
> nightmare.

Since it's not clear to me, you're saying you think a special ref is
fine, but having it be constantly squashed is not?

If so, I will say that my proposal in the other thread will let folks
keep a history if they want with a config option (although that means
you may need to rewrite history once in a while if someone changes their
name).  In my workflow and in the workflow of folks who primarily work
with forges, that isn't necessary, and the mailmap, if it's even
required, can be maintained independently or even automatically.  For
example, I could imagine GitHub writing my display name into the mailmap
file automatically when one of my pull requests is merged if I and the
repository owner have such an option configured.

However, in my proposed patch workflow, git am does the work for you by
updating the ref automatically, so all you need to do is literally apply
patches with mailmap headers and then push the ref once in a while.

I'm definitely open to discussing this approach more if we think it can
be formed into something viable.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ebvLpoFlhE0pbq31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyimOwAKCRB8DEliiIei
gfIyAQDGSeIFTP9k1xCziCk6OZE4d4n3ean8HZ0YncaV3BphUQD+K8ff6TB8QBEg
Dlp+qhUPDOeXf4zisXwZw/FNQ0xIAQY=
=es09
-----END PGP SIGNATURE-----

--ebvLpoFlhE0pbq31--
