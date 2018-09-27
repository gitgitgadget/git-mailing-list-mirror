Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5853E1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeI1Eyf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:54:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725728AbeI1Eye (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Sep 2018 00:54:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:596e:6738:f59:e0e0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 746B361B73;
        Thu, 27 Sep 2018 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1538087638;
        bh=AeeTgBWrhGsNXsCtwJmf3pesTrI3hCb8gqJE3FAzafI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N4PZ2F8ag3Xji5B4tNcxBORfQ8Z8KR+FuGHpN1jFKnaJsBdgLAjCUFViLP95L++3w
         sF//Qe5b3ZbR2GaI2QLJEoZGcmKM/fwNH1D6K9CqcFpruNQiLpBlhpsIJWOs/F6aqn
         kuO8I3Y7y0nuJu1Syfgl1agZu7K9gq/ORuHs+piLww43kNpGW9igCDZ31rwyd+jGdJ
         +YyFzvUwDuiZsNE53QVMObDqY8uoHb+XGIjJTTiOQIcTv7iLJhkAJewrpxh7gumzNU
         wDS4UUhgn/9cyD0YwmTavB5Y30f7kYoRL4MzBQEWGLi3M9ixG3Gy7vSgwxdte0Dte1
         qurA6cNEmy2TsBJJRxXAFh+8WRH7sIhFygcdJ1wkSZwLitGV1PyJRpKtl+bWNiD//i
         VLpaJL6wmLHotZ4kqv4c4y3aKXpZUtkYqkJZNkhF4DcRbGNef6bwfBvLR6aqv5Le0K
         cjF2wQiJWhKhc3bM77O7LnBifyGEspre0Ga9LEC9YoWaGuNbdC5
Date:   Thu, 27 Sep 2018 22:33:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180927223353.GH432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
 <20180920000013.GZ432229@genre.crustytoothpaste.net>
 <xmqqk1ng2rdo.fsf@gitster-ct.c.googlers.com>
 <20180921225039.GC432229@genre.crustytoothpaste.net>
 <xmqqefdislto.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlXFiQcSFG/a+HqU"
Content-Disposition: inline
In-Reply-To: <xmqqefdislto.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HlXFiQcSFG/a+HqU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 01:05:23PM -0700, Junio C Hamano wrote:
> > Would it be helpful if I sent a script that ran during CI to ensure they
> > stayed in sync for the couple places where they overlap?  I'm happy to
> > do so if you think it would be useful.
>=20
> It may even be an overkill.
>=20
> A comment addressed to those who edit one file to look at the other
> file on both files would be sufficient, I suspect.

Sure.  Let me reroll with that change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HlXFiQcSFG/a+HqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlutWtEACgkQv1NdgR9S
9otVow//e7glc0PFmyTWoirTuBZkMCF3Dp8iJpKXc9N/IoLmKZxWXegCUdqdfKf8
E5m2flJ/Y3mSM3UNrbiisq0iOWk69BSmM7uWxxaCODCWbF8+fTB5ls1yxO8XO1eW
LYiIqeeajDrbSKb6x3MW/7+NsmNDVHNVQ8XuNPwke9uhNXnat0K2G1gGrPS2qeOZ
Z5KiUHQxX+RKj4PeFMZAqugUACvk3bGI52SuC+Xk9S5ZWcr9UmnaVw6xEBIw1P3T
eHOJXeaorfPbI21ieQ7yd+8U6M5jpesaQKkH9UYV9SQ4qW35u09FpgSf1KtXfY0b
5GTPolachRF3CXEb9owwsTlsZKeP+CgtCZa1RhgveU/xW6W4p/fmJEzHwlvzzRDD
hqDjq3vfIo5HZsF58PqAOe7Lc8WObAqig5xR9clmGT17AQj4KkBTXo4gtTPiCuyw
bU2sNWP1dieblnUSs6nm73Fm0+w328+AXrGPQ3/JKpEdtPet5xjmZto7Ru32y0vs
cciboFKLxKxieQUnzOLdTZLoz86V8OjPJT6f7rT+ImrYO24JlsWEWPjaMc+uICnt
OhX0gBBqQ/cPRDf0UXEdw/JfTmBSI6yiMg2l8LeRoJI6RSsByJ6BcgdUB8lvuSQz
CYeyqiX8kmiumrZo2tXqnI7No5yBMPDH2OfLELISQCLnP/Ho+oA=
=StXh
-----END PGP SIGNATURE-----

--HlXFiQcSFG/a+HqU--
