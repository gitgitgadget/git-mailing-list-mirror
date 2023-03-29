Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64477C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC2WOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2WOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:14:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB34ED4
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:14:35 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4EF795A210;
        Wed, 29 Mar 2023 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1680128074;
        bh=QTRAf04IBI1ldOcluSDx3VQ7VFnmnvLCsc0AN1H8Clo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BSHDOZBPmUCUFlH+t06rXIW2c3JF6tdgp4WyvqatzWiamp5NK6gXarrvvToPa1Drq
         LP+3MUcxrwEhh82Y1IwEU2b1yCFQSG0Pif41XkTlOJgkP+QdWsLf0jfeQAUjZ+nVlO
         bGzjPrXB1dGzBW1KTBW7gRPMNQSGqPfrA9cojiDpnk/mdEIp4U9M6lEIZ/6AgIrxaJ
         nU74q0TIRgIZuo9hAUyhahejBe5Zm8l82SW0sU6PLjSeeYqffIe6D+gM8sSy3okYSD
         zg4Su+f1jrPpuYrx5olyZ54A4w0n7POPuALA7Jrznz1JDd4fPOLM9YiEVD+w+92smI
         95vES6jQlMUeIUTgQhvjoE6xygj8XeWEqy+aENJ4MH+eONxqum+Vlpm+3oTW9iXMmt
         IkAPhkfpUN3hr/KUlriU9wwVZUf88BPnyIiVgc1JMbGL9GsUTmNf7RBieCRpn+wQg6
         RsU5TilbFb3hlii+iQtkeSxttVbdo6/8SfWKCBb7cjlzjkEur6a
Date:   Wed, 29 Mar 2023 22:14:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
Message-ID: <ZCS4SXlkqnvjxidA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
 <xmqqh6u3d119.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReSleSxKyUprK6Hu"
Content-Disposition: inline
In-Reply-To: <xmqqh6u3d119.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ReSleSxKyUprK6Hu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-29 at 15:34:26, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I don't care a lot of other folks want to make zsh run the
> > testsuite in zsh mode, but I'd think that using sh mode would be
> > simpler and less likely to break in general, and would avoid us
> > needing to carry a lot of patches to work around various variables
> > that are special in zsh mode.  It would also be easier to
> > potentially test in the testsuite as well.
>=20
> While these patches may make it "work" with zsh in its native mode,
> because zsh that is running in its native mode is sufficiently
> distant from the more POSIXy portable variants of Bourne shells like
> dash and bash, I find it hard to justify the cost of maintaining the
> resulting codebase to "work" that way.

I think that's a fine position to take.  We have found some fun bugs in
our testsuite via zsh's sh mode, and zsh (in sh mode) is a valid shell
according to Debian's /bin/sh rules, so I think it's fair to address
shell fixes for it in sh mode where we can, even though it sounds like
we'd prefer to skip the zsh mode.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ReSleSxKyUprK6Hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZCS4SAAKCRB8DEliiIei
gaIBAQCkOsO7d32OTIJwKl8+gyAAVcOgmiLuaChI5iCogsgKTgD/VgPq+fP13D07
fA35dFhx+gu0uGIuAxfOT8X4wTbhFwM=
=dBGz
-----END PGP SIGNATURE-----

--ReSleSxKyUprK6Hu--
