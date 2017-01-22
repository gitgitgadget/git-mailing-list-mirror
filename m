Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027E41F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 01:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdAVB1O (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 20:27:14 -0500
Received: from sunbase.org ([178.79.142.16]:40650 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdAVB1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 20:27:14 -0500
X-Greylist: delayed 1404 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Jan 2017 20:27:14 EST
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1cV6w4-0002Ub-Ec; Sun, 22 Jan 2017 01:27:12 +0000
Date:   Sun, 22 Jan 2017 02:27:12 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170122012711.yy6dnjz3vrr7wert@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmbkyyiii65ka5or"
Content-Disposition: inline
In-Reply-To: <20170121200804.19009-2-t.gummerer@gmail.com>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170113-14-7f1397 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cmbkyyiii65ka5or
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-01-21 20:08:02, Thomas Gummerer wrote:
> Don't mention git reset --hard in the documentation for git stash save.
> It's an implementation detail that doesn't matter to the end user and
> thus shouldn't be exposed to them.
> [...]
> +	Save your local modifications to a new 'stash', and revert the
> +	the changes in the working tree to match the index.

The patch contains a duplicated "the".

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 42073b1c-e041-11e6-bae1-db5caa6d21d3 |-------------+

--cmbkyyiii65ka5or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliECm8ACgkQ+wy+6JSlBuXrBwCghaK6vdhc+idf+2u455Tt/94c
BX4AnArI0ZVZzZZk2oDqFgVT/VFduovI
=rVXH
-----END PGP SIGNATURE-----

--cmbkyyiii65ka5or--
