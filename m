Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09C120966
	for <e@80x24.org>; Sun,  9 Apr 2017 10:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbdDIKAT (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 06:00:19 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:53089 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdDIKAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 06:00:17 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Apr 2017 06:00:17 EDT
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sun, 09 Apr 2017 11:55:13 +0200
  id 0000000000000069.0000000058EA0501.000071F5
Date:   Sun, 9 Apr 2017 11:55:11 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] push: document & test --force-with-lease with multiple
 remotes
Message-ID: <20170409095511.d7wewvggvirnhsbr@ruderich.org>
References: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
 <20170408114100.13743-1-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-29173-1491731713-0001-2"
Content-Disposition: inline
In-Reply-To: <20170408114100.13743-1-avarab@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-29173-1491731713-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I like the documentation update and test.

On Sat, Apr 08, 2017 at 11:41:00AM +0000, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> [snip]
>
> ++
> +Now when the background process runs `git fetch origin` the references
> +on `origin-push` won't be updated, and thus commands like:
> ++
> +	git push --force-with-lease origin

I think this should be origin-push.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-29173-1491731713-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAljqBPgACgkQkv79t+RM
MvljVg/+PtidRMJP6e0Q3DAQBQk4KkU6KoLDztr9I++jcMLk9eGxLjJnZ9OvN60I
ZgP4iFsh7eullLeFSaStnqtOWxGUcHgKHnQcLiUV8EWq/hyM2rXL2h367H81b/ei
DTqLCacggKnZWWzUOksEWaV2GtBQS+9QWSwiyOJK4C9OvuAIuoup6ymSVAUjk7L6
JyEu9poiTBFZe0MGnYXgKdOJVxVlLtYdbENPuA9eXsRIcQTeG5YN6QmnVw7mmeSz
hRuWhAK+kKNvJ2UcgaYDiVHelQWB/qlUBq17m9ydy2DcbXGH3IFClyOBL1qOc7s0
/4Qf5nV02yhdX+bgg6S3hfRoT6vDJy54mCb6qP2zmgzemD6VD771/DhmAbfQVpUf
npmk5g4Y5TuMDVhZ7KZ6/l9IGjZxOp+l93f/y1MKCzCUiTEI/NCU4a8ZbLgQGRmD
HvVyksY8ux3rksNh0SHxQcDNRqXaQT5gRmP62ueKz0/oLfNqPROAKTBMQyoQS6QF
Xt+4WCBB+oxOu/IvQYiWjPXufQ4Ev2Grj52umWgeOVXyNpplNImGRrnYgm0E0pgP
Y8DG89C+nWwTNEZwtxqv/8G47KsJrBLyLpZnTz1OInmIug8vm7JoC+LZ/wIYDxeH
Hc2IwokxsWCCtu8jyMLhHIJgYjBItJMGuha9BZ42XQ907/wXql0=
=o7cX
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-29173-1491731713-0001-2--
