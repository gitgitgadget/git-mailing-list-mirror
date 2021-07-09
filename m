Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD34EC07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D91161445
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGIAvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 20:51:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38668 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229843AbhGIAvU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Jul 2021 20:51:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 55DE66042E;
        Fri,  9 Jul 2021 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625791687;
        bh=ByPQIO8uNwB1S+ywDfDYOUgO9V1ntfzrlAqNh5Isj+U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Zo5+szRbAYilGLWE1/MQCYLb4WekE3HlK/G+mMwNEd+FAWJzUyZXK1ayEkUIpAtpK
         /afnM1YpQK0+6EjzB480KOMuNWKej/Tf1QKS2NhpluGrSWW81sSnXDsKoCJKlq3gRV
         MemSGKdKkRVSeAqoICWQ0PkT2PNpmw9FLIDyG/7ZThYWsuIjeLKsGo7ADXeEkIMIiV
         mLaH2XwpY/rq82EcE+X52ksb0iLleDQdVJjPUYFNJzJRCrmCJYO1y3saQlLhHpbAGo
         /wveBEKI3tXEHhXUFFF7hJAaRBK3i1PTOd9IXTovCSscdZY8E1ULL1s20KiFJGAhfr
         UV3x5waduK6ZTGcneRAGZuAg5klnjs9LwDnUtP0UqRq85hDLdn9g3Vj9IcFb7qnvLS
         jRwvaFFDlOHYDb3aNI7mbHcy9vzzdMnLca4q/YqY7TQuf+btqBGNwMBsQttDxkJNFM
         dSSfpOoPSpX7+Kw0mxTaYDrKisuQgFUnq+NjNf3W/zEucjbSwWx
Date:   Fri, 9 Jul 2021 00:48:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #02; Thu, 8)
Message-ID: <YOecw2k5x1qc/GJk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8s2ga19f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fm8Iz8CkjnWKOqtD"
Content-Disposition: inline
In-Reply-To: <xmqq8s2ga19f.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Fm8Iz8CkjnWKOqtD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-08 at 22:28:44, Junio C Hamano wrote:
> * bc/rev-list-without-commit-line (2021-07-06) 1 commit
>  - rev-list: add option for --pretty without header
>=20
>  "git rev-list" learns to omit the "commit <object-name>" header
>  lines from the output with the `--no-commit-header` option.
>=20
>  Will merge to 'next'.

I haven't seen a review for this, so it might be better to hold off
until it gets one.  The two people I CC'd happen to be off this week, so
it may be next week before they get to respond.

Of course, if you've taken a look and think it's fine, I am happy to
trust your judgement.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Fm8Iz8CkjnWKOqtD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOecwgAKCRB8DEliiIei
gWa1AQDgL8PHoJRnWsU582jsRtfv1gPMEkgrMdutP31+8XvT9AD/USpnIZf78b+d
jYxIVH9cNThZtbpigxDnLNViSD1PTws=
=2ce7
-----END PGP SIGNATURE-----

--Fm8Iz8CkjnWKOqtD--
