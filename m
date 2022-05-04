Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F9FC433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiEDV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiEDV7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 17:59:52 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DD4C7A1
        for <git@vger.kernel.org>; Wed,  4 May 2022 14:56:15 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1B7B35A0E9;
        Wed,  4 May 2022 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651701375;
        bh=/Pad/YGYRGAn6emh34IxqQMonFTEi9+ELS5vSYzCtaQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dnEGWznV8kQCHVIOETfww0q5/Q6oelouI5+t9cqinHAqnldv2WWYOToep2pD5tJ//
         4+JsURC4tnccYxNIRXlGDL/Z9mvgd9ZVmMY3VlM+To5hjmUyapRDaetyzrsk0LGD5N
         +I2E/3ihA1Q1aCdbwG8RPycwHFU7rHzlM0y6KfRQq2kx2M2mLHN8pV6Ab2wvyhygVc
         ixm5isZDUl/2mkCcEzGY1W9vu/V1BEvP0aFoD+3z2cPNxBRK667ktiyKTmMQ/dfvat
         6sTxl9Ghh8/I1MvI1sLdfuU1JE1l1Vd7FMFxXa5jhqg4EMFCn6VEKtSd97spi98DrC
         s/Y8gWINQViIeA0cvIL6hBFyNC1pK4bPbBPqffs4ub7GMoRxDKfYqPdspb/XpdYNro
         X49svmo5xIFm8Byl1W0lQLq0uD/u3YJX3rsWgkdj62DAdvD2k9k8gAFfHOmBvoKtVt
         UAH+tjnqcdrJpWFPaJaROxBB5zA/c7Sh+47SM0RVcbjaOG0/L0w
Date:   Wed, 4 May 2022 21:56:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
Message-ID: <YnL2d4Vr9Vr7W4Hj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilqnvacd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gzy+E9zNEs2Gs3Ey"
Content-Disposition: inline
In-Reply-To: <xmqqilqnvacd.fsf@gitster.g>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Gzy+E9zNEs2Gs3Ey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-02 at 22:27:46, Junio C Hamano wrote:
> * bc/stash-export (2022-04-08) 4 commits
>  - builtin/stash: provide a way to import stashes from a ref
>  - builtin/stash: provide a way to export stashes to a ref
>  - builtin/stash: factor out revision parsing into a function
>  - object-name: make get_oid quietly return an error
>=20
>  A mechanism to export and import stash entries to and from a normal
>  commit to transfer it across repositories has been introduced.
>=20
>  Will merge to 'next'?
>  source: <20220407215352.3491567-1-sandals@crustytoothpaste.net>

I think =C3=86var had some requests for a v5, so I'll try to get to one
relatively soon.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Gzy+E9zNEs2Gs3Ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYnL2dQAKCRB8DEliiIei
geveAPoDVHxr0LRR5gznUpeiuqlyiTLPr6BzZB1kxQ3aQJHbHgD+PV+kM4wgEvsz
qfT95C57BDeCSJ5yYc9HqTwwRn1Gmw0=
=5uae
-----END PGP SIGNATURE-----

--Gzy+E9zNEs2Gs3Ey--
