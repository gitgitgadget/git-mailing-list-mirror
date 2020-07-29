Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A31C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A0320809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TTi5VMZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2Wbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:31:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgG2Wbw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 18:31:52 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B61B46077C;
        Wed, 29 Jul 2020 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596061881;
        bh=2N0IGCXXK8kFLKGvAxlGE7D3wO6KtIPQtiIVuUNmKb4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TTi5VMZM/fkD6NG37H8mEmEfIWyYV5dof2zdBpVJIbvCNOs/8u8S+Dof6/+84M4LU
         bmzIuvzqkh95mgHF4wwNkFqGm2CEJ+IqEn5PPCeNJQfje1XO9XZXDAa4N0uue4a3N/
         WUc2+xOuPT/w45oY+C4QPtjhG/iKA9JlG5vVfa1vZl91eHd50td9to9lr1wacQ/81N
         AK4DHkcTVIJpfvWzhyTr7FkZ76GXtbKlcOJIvkMjsKvTJOQuS0Vy8cAhJyrgYWjMA+
         I2PzhmCzwcvO0cS0nOa1/iC4KIDj+Cne7fbDSOFZRob6Ne+KD9A8GjNMGwdsOtzNUK
         TUcJ5dzPTk0gfWktf8fGlLpYq9Ae/P5GhKvJ8K49S1vXKfpS59vIBtyFUXW0yRQSXv
         BFliqZYbPdFu1b1quqr9KriwAmM6d+IKeku+/cwQ+ewndhnOAAxQjZK683TK0z4Oav
         XW4OBh9KcskKzqxQl14yihN4GgGMNjLsJ4a+26UuPjI4S7bYTLA
Date:   Wed, 29 Jul 2020 22:31:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5 18/39] t8002: make hash size independent
Message-ID: <20200729223116.GG6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200728233446.3066485-19-sandals@crustytoothpaste.net>
 <CAPig+cTw0XXNcKp5vVLhPtV5jH9d9gwfuYGuLqpSXsGmpn_fqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <CAPig+cTw0XXNcKp5vVLhPtV5jH9d9gwfuYGuLqpSXsGmpn_fqw@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-29 at 02:24:42, Eric Sunshine wrote:
> In the previous version of this series, the "setup" test  invoked
> test_oid_init() as its very first step. This version doesn't. As a
> reviewer, I was caught off-guard by this unexpected and unexplained
> difference between versions. The script works fine without
> test_oid_init() anyhow since test-lib.sh invokes test_oid_init(), so
> the test_oid_init() call introduced here by the previous version was
> redundant.
>=20
> Some of the patches in this series add test_oid_init() calls to their
> "setup" tests, while others don't, which makes for a somewhat
> confusing impression as one reads the series. In general, it would be
> nice for the patches to paint a consistent picture (i.e either
> uniformly employ test_oid_init() or don't), however, I would not want
> to see a re-roll just for that. Also, since the final patch of the
> series ends up removing all those test_oid_init() calls anyhow, it's
> all straightened out in the end.

Good point.  I'll try to remove them from the existing tests which add
them in the rest of the series.
--=20
brian m. carlson: Houston, Texas, US

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyH4tAAKCRB8DEliiIei
gRvVAP0dxRp177k2ME9IurKIxEiktYMhw1f1vCnT9K/oG9huZAD/chqvseFMpn+y
en3e1h/jHpK34s8kw7UmmOu+zjrxZQo=
=sbo6
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
