Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B113C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D8F60EE9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhHKBfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 21:35:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41090 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhHKBfG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Aug 2021 21:35:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0C5356042E;
        Wed, 11 Aug 2021 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628645653;
        bh=fSjnESvRXzL0iWhkgSTOxFqX/0au1mjPQ2OqiWhcGGw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=knsILF3PTclns08wP01F9L9NoERTxX7QtCl0Wsy5SQA0ojvDUqkBqPjKEcJtnTmtX
         chvsb8DISgGqAH0TVHxrnroogk8AUVoqOaBRbh//Qiw5qwrUI/4vz8wlzJxbZsjMHo
         1YgrCmdXDs4iMVID46rFBL5UfP7LRXK3FhHGtNfw7Ph9Njxw3z25zbwYK9/mgoqd1y
         Tww/ynBFfEebj+1jDC1vsukzCW0lv8204gGqmX5/WoVW0hdbIJ+xuqpptMr2/vEgJz
         SGi4i3M3oHiinG3V2llJ7Q32l5yZL7ytXPcFGQAkiyeJ33WElSrOeiXIugQUMx1wOF
         0erLN9x2qkGfDKftj08GB+4hJovGrr2ozUMu/9/BbxqDYb8gkZXAEbBomWHZvj52Og
         /wzbVkj1L1bTnPlonC0XTxRMo/ENfIvkBygI3ugmQEutps4fLB9PN03cfe3/BI1EpL
         I6SL13DdNnTe0KPqvnvcz8Sa3z0Nsf8Rhcxv7Ewouc0v2iRHUKK
Date:   Wed, 11 Aug 2021 01:34:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
Message-ID: <YRMpEV/uuHrxcOug@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7fwbx86.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3yDeoI/PFLVeDoy"
Content-Disposition: inline
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u3yDeoI/PFLVeDoy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-11 at 01:12:41, Junio C Hamano wrote:
> * bc/inactive-submodules (2021-07-02) 1 commit
>  - submodule: mark submodules with update=3Dnone as inactive
>=20
>  Usability update for inactive submodules.
>=20
>  Comments?
>  cf. <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com>
>  cf. <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>

I haven't had time to look at this recently, so I'd suggest dropping it
for now, and hopefully I'll get back to it in the future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--u3yDeoI/PFLVeDoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRMpEAAKCRB8DEliiIei
gQxjAQDwwdpCw9bb9hyn/8AcJvNR/kROyjQZEDJky6zA1OeOqgEAvaU7EWWOyLdh
Q8pML2JWAJnd19yp7XvmD4qCmaxHTwE=
=cNLS
-----END PGP SIGNATURE-----

--u3yDeoI/PFLVeDoy--
