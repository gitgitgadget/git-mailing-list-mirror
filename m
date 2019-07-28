Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F147A1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 21:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfG1Vgn (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 17:36:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57182 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbfG1Vgm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jul 2019 17:36:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2120:88a3:41cd:c920])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 43E946047B;
        Sun, 28 Jul 2019 21:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564349799;
        bh=vNyQGlSSHQH7xDPt6PeGtgRNT9IKf34R3whObNqT9vo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=grakCkX8Bkp1GmzykVwv1gZ/MARR/vg8V7w60xlOk6m0Gf05wxC3U8A6SkVKoFq+G
         tRfi0ouoesJxRovK1sJGL9Jcql0azEiXoKsxoM3JZhN9IHoTI/mCcO+NZHaFbsg6T4
         wtjFORf3Kysj2vdEPwR1YyVbhKTpaVN9p9szy/ScSVfJOo6bt4gnRMnP+OVZfE6BDj
         C1Vrk6zn/nzFhCh5Xb8g8BFv2ZouxCUdrGZJDO+Pr16Mhtc/kgsw2dSM4Rmo2h12WM
         gAJ/HShz7SH891FxCZZdZjHWow84FIYesKlOWEpu5gR1RzQJ+6UPDoDX1vemyhFxGI
         +hoKhTzgKowixf43RqJO78SUMkVjYTh6WYcacyAnv5Xc0KQaFOpXzaHR/JDpgTzp87
         3W2v9qQjjX+cwEpTx+YSLsWPYxiBdhZ0eGYpwV0K8peBFsD6uisKcBFrjZYZXWgsdF
         NcoAvogCwpPHEEmtx0IR9pQaR42OuemlD/sXXnRVvsjAEKKSg6G
Date:   Sun, 28 Jul 2019 21:36:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
Message-ID: <20190728213634.GB162590@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pratyush Yadav <me@yadavpratyush.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20190728151726.9188-1-me@yadavpratyush.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.0.0-trunk-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-28 at 15:17:26, Pratyush Yadav wrote:
> If any changes are made to the tree while git-gui is open, the user has
> to manually rescan to see those changes in the gui. With this change, a
> rescan will be performed whenever the window comes in focus, removing
> the need for manual rescans in most cases. A manual rescan will still be
> needed when something makes changes to the tree while git-gui is still
> in focus.

I don't use git-gui, so I have no opinion on this change either way, but
I do have some questions.

What exactly is involved in a rescan? Is it potentially expensive? If
so, it might be better to leave it explicit, since people can
accidentally give focus to the wrong window (bad click, focus follows
mouse, etc.).

Is there ever a situation in which someone might want to see the old
state? For example, would a rescan change the active commit shown?
Someone might be looking at a particular commit message or object ID for
the current commit; would this interfere with that?

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 6de74ce639..8ca2033dc8 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3849,6 +3849,7 @@ if {[is_enabled transport]} {
>  }
> =20
>  bind .   <Key-F5>     ui_do_rescan
> +bind .   <FocusIn>    do_rescan

What's the difference between these two? Why are we using do_rescan
instead of ui_do_rescan?

>  bind .   <$M1B-Key-r> ui_do_rescan
>  bind .   <$M1B-Key-R> ui_do_rescan
>  bind .   <$M1B-Key-s> do_signoff

The answers to a lot of these questions can go in your commit message to
help reviewers and future readers understand your change better.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0+FWIACgkQv1NdgR9S
9ov05hAAvFiHtDixRTbvJN+3KO04PZJKjyfzOVF4UmrGR9nLt6M1Kihlbftnz8E1
kwno0duZ5grvf51RKJKXh0A6NvImC67aLWEdjK3kbaVSojEi0Xh60nv6KlmwlA4U
dr97CqerSbnxGnWGGkydWaddu9SaXjRbVgFAaIs0oylTM/omgvz3UzPM5YjxDXR+
ZqcQqqxCvPkniEiJdNtftEMo696TxWWrkA3TRgiOh+Id5VrqxLCzmvN9IHzgQ+mc
nKkKC4B3OPW7Vvqehksh8RrEznRchOqS6nwCTdTZ/dvrqMlJ56FU+PipvDOnUDqo
qGvoKjnUhygMq99rR5cILXy21vKGjZWNSLVKK5g4tcuwSA6MMb6d6hlaNbW5Vk9w
w8ewXu5oIDGX5NYuPodfqBcYEbgrmz+2ckIItKA8ap4OrdLpCTsqWpnklOIdIbyl
qucdLbNBDHT8MzQW1gbBykWpv1z7ekTog2vCgNRNcesVHXWZmy8tGhHagQUeqPTf
Qk5b12cVF5KalS4m86G28PZVfHDYW1eJRlI67m0GFG2sBFVpSUtE1Lv3LlWXY6Nn
wFBLZDocIVpNUV1a0MqwpTPo4iAu8d2d4AgLci05VPCPHOfmjAUx2l0WRJ0oj52R
v/blzeDXr78sCJ+Nbjhnaw8Zu44ak4I5GNzvdRHmnRCWg2XHooE=
=Qtjo
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
