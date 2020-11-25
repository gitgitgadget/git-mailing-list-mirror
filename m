Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FCDC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D22A206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgKYWsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:48:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47886 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbgKYWsN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 17:48:13 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7F3A60427;
        Wed, 25 Nov 2020 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606344462;
        bh=Aze5MlwPLLEFqcnJXGOrqhwE0sbl+hKeiaLZVAV+6rY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n83bj8LYCt0MDAjKL2gkYtTUTFqYnkJ/8YfczhCV89cxKfByVtGfhW0yhPpbxE07D
         l+PA9mQSkUiyTpvhzoy+QUXHte2HCdSnsNswtyjDLRnx94SIpYexUmZQT6P5F/UGNj
         CKiDY1/m14x5O0JUeJlXTxcFgAIMtpw4WYZPjKzZtsPCIJSxN8Ts9ua7CRa6Mi8cJR
         VPw8GsBClAhLhgB1CllybHHSAdZaS8gIv27ZOd3CxFG54lHDcdh704p3CGosTSmFSJ
         +qjWvt3S7kMqz9O5R29uxRUb/AbzdahXMxY8KtmaRKIt/yGnRNgNIJmr/sgdWBZs2h
         8pzQWsDVG83ui7e8qm0FwQhcOpUvvfJ3M6XD6feuOEMHPyYpXLjGMROnVdXJTwW0mr
         gjb5apR/cbjh34nF1aKelu2typJWaeorYymJnqMaT3IETwp/XVa/kzwuPdLQX33y09
         AqKm2i/NU2rwihH9nd13q8Q/of1vrCtjHm3IiU605Yf8ZdlZb+c
Date:   Wed, 25 Nov 2020 22:47:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <20201125224737.GK389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline
In-Reply-To: <X740yqoYIhrqsNRE@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-25 at 10:41:14, Jeff King wrote:
> On Tue, Nov 24, 2020 at 11:50:46AM +0100, Patrick Steinhardt wrote:
>=20
> >     - I've changed priorities. The envvars are treated as command-level
> >       and as such override all values configured in files. But any
> >       explicit `git -c key=3Dvalue` will now override these envvars.
>=20
> That ordering makes sense. Those get passed through the environment,
> too, but at some point there is a process where your new ones are in the
> environment and the "-c" ones are on the command-line.

Yeah, I agree this would be the right way to go.

> I do still think that a "--config-env" option solves your problem in a
> much simpler way (especially in terms of interface we expose to users
> that we'll be locked into forever). I sketched out the solution below if
> it's of interest (and I'd be happy to polish it up, or hand it off to
> you if so). But if you're unconvinced, I'll stop mentioning it.

I do rather prefer this approach over the multiple key-value pairs.  I
think the use case of scripts could probably be easily solved with an
additional environment variable like so:

  args=3D"--config-env abc.def=3DGHI --config-env jkl.mno=3DPQR"

This isn't necessarily super elegant, but I like it more than needing
to handle many key-value pairs.

But while I do have a moderately strong preference, I'm not going to
argue for blocking the series if you still want to go this way.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX77fCAAKCRB8DEliiIei
gbacAQDp/BqdNqBGsY6wHmT2p0hUwpzpICUelZBr5Vem7zONVwEA6SVRXA3d88VM
mQgcWWNBbz/BROTz2ynvscqQCoTNygg=
=SJ3a
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
