Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFECC4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CCA61285
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFGA6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:58:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhFGA6t (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Jun 2021 20:58:49 -0400
Received: from camp.crustytoothpaste.net (unknown [50.203.243.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D826060424;
        Mon,  7 Jun 2021 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623027389;
        bh=drSnYkvfUay50f8+lju0owgv0+O1UkU+Te6w3+KfYL4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nd1hGwpepkARqel1fz5BVIWHNZhnj0od9viahkFSRbCDIFRN5+X0b1JmWeNO1L+RA
         K4n6NYSGGTRRC0UR9POykm5fUXcp1Yy/pjBsDtY3Yw9hmSSx9YuyS5LQeEMlA4Jrcc
         1lY0GxWsuWiWgCyckeH4Kie/mZjXMRE5c94Pv9q1MfDANuoMR49v5xkT527y0M8IaU
         vKydDPJTp74oU0EIPjtEJALDVUdefU0si/l4IEYp6H0gZzeYukxVcmi9cBf7OkchJK
         hCnD9Gkxk5siesAPZR5viaOczhVwZvYVVVHAPVbftRYNhQL2zjRKtaxLomVC1s3zZK
         lSjzpxNO/DGaKh19UoJzMpjDdQ9Vrr69MDFYGAfRgThaV5A3dFFQ1EtKhv5nKWCnJg
         X94ldO/OQX7APeXMUY074hXoq41UyDd+nHHHJU6OpHcMYJGPgHqe7DtxxxhQPuwSeL
         BdnnrKfXqk/ONj9L+Dk7GvV71CTuibeuqvwxIU9/nlCQ/3DJjpd
Date:   Mon, 7 Jun 2021 00:56:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere: enable by default
Message-ID: <YL1uudVxwcDUg2+T@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfsxvxjj2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+kLKyamSsV4sItb"
Content-Disposition: inline
In-Reply-To: <xmqqfsxvxjj2.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R+kLKyamSsV4sItb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-06 at 12:30:25, Junio C Hamano wrote:
> By default, the rerere machinery has been disabled since a bug in
> the machinery could screw up the end user's data at the most
> stressful time during the end user's workday (i.e. during conflict
> resolution).
>=20
> It however has been in wide use without causing much trouble (other
> than, obviously, replaying a broken conflict resolution that was
> recorded earlier when the user made a mismerge), and it is about
> time to enable it by default.

Yes, I think this makes sense.  I've been using it for quite a while
without problems and I'm usually quite good at breaking things, and if
we can make the user experience better, which I think rerere does,
that's definitely a good thing.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--R+kLKyamSsV4sItb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYL1uuQAKCRB8DEliiIei
gR7YAP9JO+w46VUaujlU8jU34Pa6KYU+bSeYVbBKT1aCQxLy+QD+Ij16yGgBdr9L
HKgPe8SfIAZcUmICl3cALnQYzT/l6gA=
=t1hI
-----END PGP SIGNATURE-----

--R+kLKyamSsV4sItb--
