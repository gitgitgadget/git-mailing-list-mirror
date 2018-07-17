Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CF71F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeGQAdD (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:33:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59678 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729615AbeGQAdD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Jul 2018 20:33:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 990876047B;
        Tue, 17 Jul 2018 00:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531785796;
        bh=6PwgYnQNjK8SQPNugOu3peIAKO1S00oPucQuA2Yy4HM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oTmLBbWPdWr+fFRlvADgo8Fd3PfDtlS4IkTNxWGJb8hxV4HTcNOOD46/DAJDg7wYo
         Gh9yWv+FTD2+nWGSAxORvD+uWXh7Jh9MvxInFQAdx60huZTQnzsXJdxLSb/9NT1c/Y
         MnSjAfq+HzDdyN0iiuKxfknC3oUcXZgtKI896ed5S/6zolCzsfJfrCoqUejXAfcVps
         UkrwGEPRsKq7u7i531AX+1Q2ObK4FDfATn8IvK1Cno2jJa0gWImqZnGwd/uyw6jNUp
         wLgEzeaEej6ISXD45l7JTr01ojr30NKmjumBGCgXEP6GibKLsq0Zd9QFouBKARtOAf
         oToxP14Nk4pLKPFH6RSD9xZ8980mS21hTHNGoLn/sQ4ngVA74suWEQxSopKfqEG638
         H8ZnWT2XtGa3tHUHfGNqnrspvTJMmB1IvYETeR+qbFOgBSUQbU1PKM0lX9rJ1PEPfw
         /52anB1x8jx0qe1cV2IBjjcrmhxH8OZHVvNLc6/V9QqXqzWIkfn
Date:   Tue, 17 Jul 2018 00:03:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/7] gpg-interface: add new config to select how to
 sign a commit
Message-ID: <20180717000310.GA980821@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 10:41:23AM +0200, Henning Schild wrote:
> Add "gpg.format" where the user can specify which type of signature to
> use for commits. At the moment only "openpgp" is supported and the value =
is
> not even used. This commit prepares for a new types of signatures.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  Documentation/config.txt | 4 ++++
>  gpg-interface.c          | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828..ac373e3f4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1828,6 +1828,10 @@ gpg.program::
>  	signed, and the program is expected to send the result to its
>  	standard output.
> =20
> +gpg.format::
> +	Specifies which key format to use when signing with `--gpg-sign`.
> +	Default is "openpgp", that is also the only supported value.

I think, as discussed in the other thread, perhaps a different prefix
for these options is in order if we'd like to plan for the future.
Maybe this could be "signature.format", "sign.format", "signing.format",
or "signingtool.format" (I tend to prefer the former, but not too
strongly).

I anticipate that some projects will prefer other formats, and it makes
it easier if we don't have to maintain two sets of legacy names.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltNMj4ACgkQv1NdgR9S
9ov1vxAAnQ5D/uO5NOELdK1ZJxGc49sJqOo7GlLRUHMQuvUxCuJNegK0/vo//PVv
jv2ynHA3apABkv+Au8gitB1fxcXoP8KJznga91yK2thMEUZiTYVTwinWlIu2o6eE
DKVua+i2wKli17HfBDvtlkJa+Oq4dKzjfdApiljtT/+qCYsBRqj8JScWO0P/93nP
3ds1tqvzPcOUEmU1HxYW21TClbVfDY+yOj4Wu1EhiKBb3zyasaNyxm65yYjxeRP8
l5JniEhEbJ2ztzbx+O7CI2LBJa56uUCA71I3Y9nYyevfoY62xyvOgcPxeTdMfu/q
gGA7cSVtuC5IoAzDt0tDOiVk+gzHsGHO6YrUFbegujLPIhFMkB2F50hIyN9zK4Pv
ziKDQbOqoSgn6IJHvX2M8sa1rCT09djPPFhtG5PUqVRDdnSL+jij4tmC3cU6xzO2
R4c3Zt3Lc87n7Xqtdq3AoexuY9tNV/UH/XTJYs5fVDIKUGuNeGQ0erKCX6LlkfgL
f7GTAPGUKcOfXiR9VKpZ029HvMbILq5sH6KmSF06kkq8h67YJcNUuV7jsnEsRHwf
EqXUxZCPVhB4Ryg/fDWoFauefBzET6mW3xO0fDtutFdzgsUZRVt7BKteSt9qUd91
Q0gePMkHcMXnVI9yZw/Huq6AReJtbwUzBRg9/+tSTDq7RhktKAk=
=XVDG
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
