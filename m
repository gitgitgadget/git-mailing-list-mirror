Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E286FC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjELUwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjELUwU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:52:20 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29855FD7
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:52:17 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 099A05A1A8;
        Fri, 12 May 2023 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1683924737;
        bh=FA/4r3+eDSD0iVqGlz0FpEM68euaIZnRt3DHGIzV/xc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pL51fWOe7ZgYt4VaCWASGD8TujbEgMSxhDWbr2WrAWBX9VXrZUCQwqCWJQHuygGbD
         +AWsjqwWTJAGYHP6UGiEiItlorW42S2+B6PP7vXR6rAecel1lWCp6ayLBTjXvix7FP
         dkJQ2dHyAhG1KslQgj8hkV+N4k67auYgq1X+U83ePBJmYyB81JXw5xm+UgVuuwWNAp
         siVlFRgraTiKSNmj2sRlt30nRwB/OBqzUyxy9AIzi8lAAWl+17DfJz9dGygYHz4HOc
         stDVz4/YP7hGshNVLORi9tL9pWhWfRwX5a3d3PSZb2ftSxWba/4PvUysqV/W8u1r/Z
         U8dqB7DwyUq06vePvBmbmqrYkK/b74ilXTobiMWWeL0jQQTrNYGycFNrBfAFJSUDCX
         9SLYDlwxR1ZYNlLpWGQcUdJ7LJl5iCUUub6U2rtXaxAqHC9gekII1vttUoQmdLtYyt
         dlJ53XeFABpCo50oMXG24QpRS03Xkc+5tw2cKREky/W3RQsIQCE
Date:   Fri, 12 May 2023 20:52:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #04; Thu, 11)
Message-ID: <ZF6m/ooy0OwsB3ku@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo7mqs7rp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q8vZWAqsLlRR7Jtz"
Content-Disposition: inline
In-Reply-To: <xmqqo7mqs7rp.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q8vZWAqsLlRR7Jtz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-12 at 00:39:06, Junio C Hamano wrote:
> * bc/clone-empty-repo-via-protocol-v0 (2023-05-01) 1 commit
>  - upload-pack: advertise capabilities when cloning empty repos
>=20
>  Expecting a minor and hopefully final update.
>  cf. <20230501224038.GA1174291@coredump.intra.peff.net>
>  source: <20230501170018.1410567-2-sandals@crustytoothpaste.net>

I'll try to get a v3 out early next week.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--q8vZWAqsLlRR7Jtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZF6m/gAKCRB8DEliiIei
gZJ0AQD3Vdz7H9xOuG2d/c67zjTPkC2J87m6M8EDn9Sh5JGv8QEA+UduKCwTo265
cES6QDsWeeCcFCs6vE3gPYzZy2XGkQQ=
=tV3r
-----END PGP SIGNATURE-----

--q8vZWAqsLlRR7Jtz--
