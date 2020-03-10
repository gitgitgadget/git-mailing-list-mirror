Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D508C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9FB2071B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tWKDqmVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgCJWXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:23:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51186 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgCJWXC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 18:23:02 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A732160732;
        Tue, 10 Mar 2020 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583878981;
        bh=DOcHU6jHRZ/KkwxRzhLa1fa3tbnB0dwQo+LlD1W4Rjk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tWKDqmVmD05+CBf7FEgbWclkprurpTDWpOt3rCtRMvN5ykqFfFwShi4+9qqgD3Lxk
         xg/Aft3tyKHUnK4sGk/QrD7DkKv7eZunZza219rS1i/OOwi3Sm/BHt+GOntuA69Bxs
         f8xSWxtDylP2AdYNIxq0jN7D0Q7LT4paAQvEjgI6UkfTAn3qN5RBOkutLgfJVYwKpi
         Gmb/AhxQJIZgMx8uTdGSjswwEsvhHuDtzRNKQ3h0CvQHxEf+il7V/XsSyvN7Axt53k
         V0////hIpNkOo35Tp6B85rYb5ImMq6gTQknjBlOOouMGKdLh/CcePYwjoA6Gptvlk7
         q1zKjDDmKieV0oxSpExpnELS6zNgM5i4JLXonRx1by81N+lziDkB4IPNAPvMYwCMyT
         YZF4vI6tuUfvA2RGN1s96odutQOuvr+ViqWYq/Tm6/3o9oq7n/z6qPfhEtakh9V27W
         +9KPe92ss88cKXj/UeRvBIHL14lIwed/eR7Qt+bwEriXdFxNwTH
Date:   Tue, 10 Mar 2020 22:22:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: new file mode 160000
Message-ID: <20200310222256.GA6198@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?SsO2cm4=?= Engel <joern@purestorage.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200310184111.GD1443@cork>
 <xmqqsgighu2p.fsf@gitster.c.googlers.com>
 <20200310195724.GE1443@cork>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20200310195724.GE1443@cork>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-10 at 19:57:24, J=C3=B6rn Engel wrote:
> That is indeed the content.  So no bug in git.  Thank you!
>=20
> Given that we don't want to use submodules for this particular
> project, can the git server be configured to refuse push requests that
> would introduce submodules?

I don't believe there's an option to do this, but it could be achieved
with a pre-receive hook.  That's the usual approach for denying pushes
containing unwanted data (submodules, large files, commits with
improperly formatted messages, etc.).

If your Git server doesn't let you install pre-receive hooks, you can do
this by adding a test to your CI system to reject objectionable pushes.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXmgTPwAKCRB8DEliiIei
gS/6AP9fppVhoXTwpfZTUqQl766YII5YkJTUpea1AY3ae2h1wwEA9XJeXqokZXcc
Q2Vn+9PFAcd23Djk/OamBQRUGFFGYAE=
=mkMa
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
