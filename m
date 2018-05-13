Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0781F406
	for <e@80x24.org>; Sun, 13 May 2018 17:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeEMRqM (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 13:46:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751438AbeEMRqK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 May 2018 13:46:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B1F2860129;
        Sun, 13 May 2018 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526233568;
        bh=Y78HffLtCTHguSKsVrFafVBPpv8kShoWZwyNPulbC5U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ISEZHcSSMbomlsAf/Ec3PGcaICPV2UOlqtj/cg1czxs8SX5Cmd0XM/fkfyOBGI2ij
         LR6dCApFXBKbqfz4eYTn3GZNMNQIR5UkEcBL1ESPWlW1GU+MvmXUf2PJkQNwJWC6ia
         wGRfOCF/OsySbE8BxQlUiqW00UBeGjMeq3BMBziikJUXKoTk6Iofzgp4sUxoJZepvt
         graHpjXL01FZRvN0M/zj2UUybgCeaNYRcbu9QMX6xVNY4CvHrLUkk22DKwkN672XY5
         XuNYK/UFfRzBoRXueUBc4fccc9U7n+MkoZfOWMCzVPIyfAZhL1XM3Ar/8Z+traI8bs
         BQP8fCLqlA2O1RzvQXTfV5NDZf6l6ShFuAKKwPrXa3NIAt9FQLkG0J69qhsj2YTtrd
         9VXQI34Y1lsireBUdyf1CTm1ITkwbmSgBGC81ELQIVACOOCH4frAApjr54U8LzZFIL
         YKf9iU3u29Vv1NRLrbk4BoeHtr8fVvngNheeZ0TeAp2NxP+z57t
Date:   Sun, 13 May 2018 17:46:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 17/28] t4014: abstract away SHA-1-specific constants
Message-ID: <20180513174601.GC574870@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
 <20180513022438.60003-18-sandals@crustytoothpaste.net>
 <7485f683-e57e-acdd-4502-02c3f4f0b394@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <7485f683-e57e-acdd-4502-02c3f4f0b394@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 13, 2018 at 09:34:03AM +0200, Johannes Sixt wrote:
> Am 13.05.2018 um 04:24 schrieb brian m. carlson:
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index dac3f349a3..42b3e11207 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -578,7 +578,9 @@ test_expect_success 'excessive subject' '
> >   	rm -rf patches/ &&
> >   	git checkout side &&
> > +	before=3D$(git rev-parse --short $(git hash-object file)) &&
> >   	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file=
 &&
> > +	after=3D$(git rev-parse --short $(git hash-object file)) &&
>=20
> It would be better to avoid process expansion in command arguments, becau=
se
> the shell does not diagnose failures. This is preferable:
>=20
> 	before=3D$(git hash-object file) &&
> 	before=3D$(git rev-parse --short $before) &&

I considered that and assumed it would be all right because if git
hash-object failed, we wouldn't get anything on stdout.  However, I
agree that your approach is more robust, so I'll reroll with that
change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlr4edkACgkQv1NdgR9S
9oswJhAAww8bannifYCUjYHjWxGjKTmpBPN8Fh5o/e0ZT0Y2c9/uxYFvwFPsnIgo
q41/JX7I8fCilRMxvnUXpavIdRUs/ft36rQfil6vhiJ+FfU0iujWEQKEVoNHZ+Yu
qQizMXKf8r0bZJovNSeYelCA/HE028G0lC1/ycE6XIiQKXuEJt0h5Zrn3Zl1MfWx
3I9KDpyM0TZwyYZ0DVRkDoTL8h9DTFbdnzuIigdZZrsmsoVQoT6L7AAQe6bDG7+B
sqtTVKqYvcffwap7NyRIVN8MtHbQA0iOlujn5nVlVGc0JfTRkYEVA1J57aoJ/eCH
uBSxMrpfj0EG96v+VNWLrgcZdTBWO0+3ITu9EU1nRdd8sHzT3C2ui3EZaNbEZDEk
Olf9POLiKb9TGJAfLTpQQYao5oWVc3OT13s5PIqBNFzwOTV3msi5KoBlrt4ZR6Qn
cK3PSsIRJgLhutnBJ27m0cep9izwEWdx+5co+V7srpLAWD852qlud8uXzv77giEl
Pw7zLrcVZjPaK41OUHIfa/8GbxXPpJXqswDAdGck+ykam+U8r8S53Hmbic/xSxhv
UpfrY83jkrOewIGv4Elc+25o5xgbkIbopsoSgfhNc8yjt7W/zhLdocH22eXkVT9g
c8jAGnWHMqEqbDRCui/CakbAsaB6Cjpc72huy0pcQDWQVlaSIeA=
=bdm8
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
