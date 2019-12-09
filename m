Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBAC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 02:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582A206F4
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 02:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xdgE6ngL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLICGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 21:06:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfLICGa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Dec 2019 21:06:30 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE86F60428;
        Mon,  9 Dec 2019 02:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1575857188;
        bh=LV4s3a1oigEpd8HFhDXmo+ND/BwZl9MqGe/w8pnJPUY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xdgE6ngLjpG5q9VhCbqnGjsz5om/FJ2BqFfWdS6OZ35IMYlI1ta+fmFdZtkEvFER5
         z10IsY8uLT//8PMl8geSPh6WOOBLym9TCkwAx4Z1Ap6g5palfseCFjSSgesxUzDW0L
         YgI8nLiroe3Onq+JLKp83i6f6ATNz89TKSI0gA8CqhpA2ktUdPnJ+EHF1Hw+UfASbv
         UBcDTbC3yzyQTfrO8so2vInBg5NjjLNfRO0K1iGRZJvk9zGyBC6ADdZTFXJcho+8NE
         dKO68wrwzA7h838iy4S3xaULRVnjUi4yJJ99WHRbPCd1I9Zs07BKl8FaLrxJSoX3C6
         ahTKSlhGjqRUmUcxTGlCFTg75mCAS6iC0MMBDnhgQV5FrqHmPgLlL6/tM92aI70iiy
         TiJH1NTcHrWWDpfnZhthbot03ycwp8ZGhJafMu4o2vn1yJIPt8LUBMGcuWADMLy9b3
         3UbUps1P+NhbbUjZSMhuGbHtt/WG62i1YEb48DK4pGhoDq9TbOx
Date:   Mon, 9 Dec 2019 02:06:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-id: use oid_to_hex() to print multiple object IDs
Message-ID: <20191209020617.GB1334263@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <bebcac17-f560-bb73-9aee-72f944df7d95@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <bebcac17-f560-bb73-9aee-72f944df7d95@web.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-07 at 19:16:51, Ren=C3=A9 Scharfe wrote:
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 3059e525b8..822ffff51f 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -5,13 +5,8 @@
>=20
>  static void flush_current_id(int patchlen, struct object_id *id, struct =
object_id *result)
>  {
> -	char name[GIT_MAX_HEXSZ + 1];
> -
> -	if (!patchlen)
> -		return;
> -
> -	memcpy(name, oid_to_hex(id), the_hash_algo->hexsz + 1);
> -	printf("%s %s\n", oid_to_hex(result), name);
> +	if (patchlen)
> +		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
>  }
>=20
>  static int remove_space(char *line)

This seems like a nice cleanup to me.  Thanks for sending the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3trBkACgkQv1NdgR9S
9ouu/xAAlZX2k0T2ShbTlmlH3Iy1eGp7R+pzNcl0wyVV4Iih3rvTof0CM+k/A/xW
R6RMRqceToIhApXz1ERhvkUWuqu8KelJzAbUbH6XSW8htJJfWUXdMrGG8t7gJP+h
I7fZ2aYndyBemjLbqpQN2O1g6OeRdhK4BOhjAOduOrU4epuiex3aTGlTfPpFg0E8
KOwe8hBzW27q0mJakC2ovwc2tK1CYBGxKxM+DUgl2aYtEwKLi1S46UDhnt7BXmS7
GMgna18d6ZCbkvdL1nkKfh1aNqon0PGL8E7tPky+iR7nP+Ksn63S1hIQqZ7BA81v
24DT46gTH+pQyUt/rbod9Oh44ZtlWoDtQdgmXm3x7GRVph4oeImuiRcgxcLyB7OV
YiAsoa2fK8H2Iup2gxhvZby2hjJpkKht6orr1dzifD7qeEWgmnx4hg9XCGJg3dzu
aYSD6J/Gs2bhqbCYJ1XUv2UTtsdND35ZnZKi1RJ81NkKyASTbiEP7pEFrLEdHeJz
Uh1zWLAbByYhrtHqLtZ7n8Pt4Vw2UZS1wTxSuVTW84ys6beHMtJZqrxhPI7CUIvd
rFYOLdt1gAIxl+vksCgq41WrwsfBK/Sl8C/32WVdcpdSxTS88Zjzngr9ElWRF8Je
my0GFqNHo/eAGMYsPpyBCyt75I3usGjK9Xv+J64At7gKHpqko94=
=cau0
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
