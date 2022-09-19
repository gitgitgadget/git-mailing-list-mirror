Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67635C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiISPVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiISPUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:20:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630AD11445
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:19:46 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 57FB55A26C;
        Mon, 19 Sep 2022 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663600785;
        bh=WZ53dnzDHcgU5R0HVuMgSlFznZnmxcXYalXQFn2JsbY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LTJwvEVvvC+kZTQ29XXwJM+blbXiCMxKkT92CbX2Kc9Hjah860HmHHJd/t5kmkQvT
         gUA4KxGoEICzIH5979Q9SXust4Y1yMF/fQ4DVQNov+RuA2PVYLlf6YrpJVwgg4E03u
         CvhLtwgyXEu1B3IkYK5u0iU3unxVxN+eD83qIIkdd1LmAdUkZp0QivyeOpR7EZ64C5
         ijBhphikpgz/iIkDiGVbcrAtq25GCvkOvNMK/wRANBY/wM6Q0oT/pKy7HguNt023hK
         fY+zQZydjYRaBBeY04A9jytYz4S5uIPWta2LXUCIsniG5XxQZemuD/KowUfWhGwnm2
         D4IYCvnt1eigtXV6nnMuh2G/rtF8BRfjvbrxhonFe8jYNyRuSJmA8kKnU6NBWmapa9
         q4uQi6wbdq1ew8ngdL9sPwy9K2jLuA6GL36RzpiQKc8H7BcV7K1hNzTkugNBvoiDGO
         e7zYP5KErRBfARDysTIjCV5ZRvIeeDuOMZJzxfIHM3R0ZwnC99r
Date:   Mon, 19 Sep 2022 15:19:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Message-ID: <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
 <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8FPugIMmKRPsgyU"
Content-Disposition: inline
In-Reply-To: <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n8FPugIMmKRPsgyU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-19 at 11:20:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I.e. I think a "deadname" use-case of this would probably:
>=20
> * Have some comment at the top of .mailmap about why some values are
>   over-encoded (or perhaps it would be obvious to everyone working on
>   that repo why someone was encoding the "plain ASCII" A-Za-z0-9 space).

I don't think we need to do this.  First of all, it makes people curious
and nosy, and it draws attention to the situation when in many cases,
other contributors might not even notice as they're updating the
mailmap.  Adding lots of attention is going to add the potential for
harassment.

> But should not:
>=20
> * Assume that other tools such as "fsck", "check-mailmap" or even "log"
>   won't have future features that make de-obscuring these values easier,
>   or something that's part of a normal workflow.

Your statement that you intended to write exactly such a feature was the
main reason I dropped the SHA-256 hashed mailmap series.  I don't think
it's constructive to offer or propose to offer such a feature in Git if
we're trying to obscure people's names in the mailmap, and as such I
would want to see a guarantee that we wouldn't implement or accept such
a feature.  I don't see the point of obscuring names in the mailmap if
we're just going to print them next to each other in the future, and I
don't think it's moving us towards a solution to suggest that we might
do that in the future.

I'm happy to resurrect my SHA-256 hashed mailmap series if we're
all willing to agree to not implement trivial decoding features.

I also have an alternate proposal which I pitched to some folks at Git
Merge and which I just finished writing up that basically moves personal
names and emails out of commits, replacing them with opaque identifiers,
and using a constantly squashed mailmap commit in a special ref to store
the mapping.  This doesn't address changing identities in existing
commits, which as we've seen are nearly impossible to fix, but it does
address new ones.  I've sent it out at
https://lore.kernel.org/git/20220919145231.48245-1-sandals@crustytoothpaste=
=2Enet/.

We may in fact want to do both of these things (hashed or encoded
mailmap and opaque identifiers with squashed mailmap) at once.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--n8FPugIMmKRPsgyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyiIjwAKCRB8DEliiIei
gcsHAP9OpPpr+Eg8qfiSY+4NMQQ0gnvjG7ebdpnkRk31+24e1wD/SDjBc7atxPYs
t93gf9WyjqaWuvt1U2Udq/c2Sw61Ng0=
=kdNs
-----END PGP SIGNATURE-----

--n8FPugIMmKRPsgyU--
