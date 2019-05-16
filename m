Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DC61F461
	for <e@80x24.org>; Thu, 16 May 2019 17:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEPRUC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 13:20:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36616 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726807AbfEPRUC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 May 2019 13:20:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AFA7760737;
        Thu, 16 May 2019 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558027198;
        bh=yV5EAbk3T9E4nAj93DVLxs/9TokoqA9qLQOsuICOpD8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QAkuQuZNB76Mt9IsXJI3Xe3PSBvfhOMVCwuxXLrol5IKvGN3fNQqvMIpsH1Vrh5xN
         ythQgt1BOL6tmogF+CnUjoCrShm5swE0izanmK4LwipiVnNOAWVCJ0K4jRWuF0Y4Uo
         XuIB1/+8THP7YeEimhFWNzaWsoiR1q+Im8/5nAqR3VuglOE7lbqODYSugnxGen9kur
         T1VqTsf6ZUyEuJh/JtbUo8E+MdRHYiXAIz8fZoA878ivCCyj7A1ODdeuFCf7y5moeO
         YP0/fzGGhWjMadCvtAoov+gH578JXxmjm2BfFncF15JeFWDQj6MXI7vshwTgfDXWIA
         GZ72k/PQdF9RJlWXSzITechUVjKMhBHndaodG8/WS0QT8BWb3xCuMLbtDZLIovK22D
         uDWjUwIyirdJitq4jIFZ3iME7yjf7WTAfXqI8CUoNZ9TUqH6oX99s7SXwHvqPJpU6+
         TFMwPnJZTvAZLGo3jtRdxJLHQjM1BQAow3aiZ85fsxueTV082ZU
Date:   Thu, 16 May 2019 17:19:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook
 error behavior
Message-ID: <20190516171953.GA265608@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-8-sandals@crustytoothpaste.net>
 <20190516050200.GB7241@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190516050200.GB7241@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-16 at 05:02:00, Jeff King wrote:
> > +static int git_default_hook_config(const char *key, const char *value)
> > +{
> > +	const char *hook;
> > +	size_t key_len;
> > +	uintptr_t behavior;
> > +
> > +	key +=3D strlen("hook.");
> > +	if (strip_suffix(key, ".errorbehavior", &key_len)) {
>=20
> There's an undocumented assumption that the caller has confirmed that
> the key starts with "hook." here. Can we be a little more defensive and
> do:
>=20
>   if (skip_prefix(key, "hook.", &key))
> 	return 0;

Yeah, the caller checks that, but I think being a little more defensive
is fine.

> here (we could even drop the check in git_default_config).
>=20
> Or we could use parse_key(), which is designed for this:
>=20
>   if (parse_key(key, "hook", &subsection, &subsection_len, &key) < 0 ||
>       !subsection)
> 	return 0;

Oh, good, I didn't know we had that. That's exactly what I want.

>   if (!strcmp(key, "errorbehavior"))
> 	...
>=20
> > +	/* Use -2 as sentinel because failure to exec is -1. */
> > +	int ret =3D -2;
>=20
> Maybe this would be simpler to follow by using an enum for the handler
> return value?

We can't make this variable an enum because we'd have to define 256
entries (well, we can, but it would be a hassle), but I can create an
enum and assign it to the int variable, sure.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzdm7gACgkQv1NdgR9S
9osurQ//WdP2TRdDsLHTAaR4iKwizUSwjlm3t2i4Zti7VI8tG0d4ylApApQcqtnQ
DK//zNOgk8oFTMEycYkGQcVLD7GV3xGhnk9s1i+yu+rWAeud8eu9NpXiGv/TAe5v
8u3qMt+/Y50Pkz6lmTv83c/AD5/CTvzBtRW0UBQK92vSkAObKfHga5nf5hbOmRlu
N87s7qIkNNKtDuAUp7q0zFz5u+NIvyEDGGQUT27FnNtEco8J1Ssbk8AlHU7zWUdY
5WpTO4W1ulQdYw+zHaHZoPbpX6OCR1MpS+ZFjErgBwpGIqKzpaRcRkoU7ToLiN++
G7dX19NUrOvauoNxXnhhKxqI43ieuDgRZKcGUjk/SLpwryAtqzs8QwbMFuTxCiBO
04jcrlzekqqm6J95mJJrNUfE6J5ENr5leE25yllRD6JKXTKTrf3ILu70oN9bOJAX
pc6wG4pz5SVfTTBtw5iNqYW5CsWe2CaW23giYdWdFnYHBbsrvjZYTIjpvIR6JPpj
rB8dVf0oYP4Zjxustf7rAWVsZ+whhRraS5/+G2xTmJWPtA1NCQmGBin+5y0abvmv
AUS03NFYdz6NdVkVxO2mNsTRT2CjQ5P4JEdK59jrNvtd+K0DpUrSch8Gz+EUnU1r
5vvEB8zhqPVWmQUU0f7jBjo3xmSmv05Bteiouf+mGnjIFNIb64s=
=x5lS
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
