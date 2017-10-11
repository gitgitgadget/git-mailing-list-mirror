Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2071FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 17:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbdJKRt2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 13:49:28 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:43796 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdJKRt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 13:49:27 -0400
Received: by mail-qt0-f173.google.com with SMTP id a43so7702181qta.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWF3Gaf/U0yYL/KzHL9Sx6uEEqlQxYwa/bXd3O8Estk=;
        b=Fw/R3eclwvtRSohjtbDPtd0Ej0QTad6hitqgTTvWVYlRNhFuz79XByYThuSbWJf1Rg
         SswbjGgDfeljmKy6fv1ADMA1VyD9nJEMJ1H3t2p486mSMEKaQ1S2MCqaDxhJM9jBPvJd
         Cvc6bANK8GlQS0gCH0drLRQ9fL/C1ZezlDuluwKmo88X4IdqLE3ub4d263MeAbmrSDgs
         prYqR1h9Z+1/CoQ9CNp+bXyJSc/Krvdg9JfehPel7/+bbPMvoEHkBxfjAp6j1Q9G4WPZ
         biXeNKS3OMGamH5w+MVQWTQVkTwavCFJTgJnRgjeYYaCw328sWPaIYfJHMb3r6/JPfYy
         mmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWF3Gaf/U0yYL/KzHL9Sx6uEEqlQxYwa/bXd3O8Estk=;
        b=LqAWKnQpS8FAGytiRTkZUpGh5JzRuGoW1RMUAkELtcpNRSAAqrDYRTEqp0da9GnbWj
         9Xp6zG5UHxZVyuj6PR5I/KJb/elqlltq8sNc0EtGSxAfdc3zU1FrnRujA6Puj6+eJGxz
         +k0i+ixm+dGeh6kp3TlDaBmQQ8+CYb75B9X3nPj8IYNB08XgIaLyEWE1EsNl+raClEf/
         /9T7nGme97CEF39zIERBgBi1aJ9whk6rmP7IqARSo+w2eDH/0KzZGcO2DfDOKsvDAzFZ
         Z79rqfIgRbJhL0X9E6a+1dTGO/2a+YPoz4s2j4SlCkj0oVhCD5jwBrhBeT1mCHKn5oT3
         VeCw==
X-Gm-Message-State: AMCzsaWGnR5hq3nWuEHa0V8BtPD7RNfTg1IjEYgzooCGtidi1PN/x8RC
        GBaz1VvZh14zGh4VVAygtGEMWpw+
X-Google-Smtp-Source: AOwi7QCze06Xr5r86ajN826dmIjSebQ+cfOZG4z57gDzOuTLA154EwLSoJzTEPYSez8K6ap34uoNCA==
X-Received: by 10.200.42.118 with SMTP id l51mr743927qtl.37.1507744166976;
        Wed, 11 Oct 2017 10:49:26 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8209:6800:c238:96ff:fe6c:25f])
        by smtp.gmail.com with ESMTPSA id r6sm8417420qkh.22.2017.10.11.10.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 10:49:26 -0700 (PDT)
Date:   Wed, 11 Oct 2017 13:49:52 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Ayush Goel <ayushgoel111@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to use --patch with git add
Message-ID: <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aawnjxgg7xxdngmw"
Content-Disposition: inline
In-Reply-To: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aawnjxgg7xxdngmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It'd be helpful to know:

- What did you do?
- What did you expect to happen?
- What happened instead?

I suspect you are using --patch with a new file, so you probably need to fi=
rst
add it with -N or so. This is just a shot in the dark though...

Thanks,
-Santiago.

On Wed, Oct 11, 2017 at 11:16:39PM +0530, Ayush Goel wrote:
> $ git --version
> git version 2.14.2
>=20
> What more details can I provide to help debug this?
>=20
> --=20
> Regards,
> Ayush Goel

--aawnjxgg7xxdngmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlneWbsACgkQRo8SLOgW
IpXuLA/+J6+HJAwqKlOdKAbpHFhxlIuU0IFYnXU4ZARFrVApp2zZjahEWuDXfWYt
Wxvlc5zo3p00A2/QtnByJDV2aPuNyVSyDhMpFO1VN2Pl7hSWRZBupl1C/iwRflC2
U6HFDS9PRqs8ITfT5um334WG57ZkZYYgGih3+kGL+LwxT7slwVi9xRqzwBoJCjt5
uCXvnvE9vqaAmixsmvOzeVhKk/Ys9yw9DKVXNb8ARRQlX3411K9ceDDvZQrmWYCS
7P87RbKkGDS1C58AXPAYb56dmA5ykcHtwAlaHGODi4KjogHhACcgz/QGSJSvIgEs
9/P/Nt4grmpyqnB0241ZBdgCNABV2KCsZfZTe/4IaSboAy1dFPJ3exOvk9G8CHAC
QxIJME8IbRZcSpPSlxGM5FXK2/+VaX/D6788LK7dYBJwQRrQLQNLMa8IcRrIuJVF
KdWOXPPLako1GRcESY3Kn5zsy5gjVeMvaTkMk0UXZUUiMoX2wPKX7Fw8ZNrTY68O
oRgjtwpD9rKXpsk0Ne8kjLrtcB3No7qbm/TSAHhh7g7Yv9oX/wuaUrUDc+yfZ0/7
jLXNKgJsanr0j5cAACxWWDKDjmqbjYbsKDjxBmXjCaOSI7T/VsI/raHeyd2vIxUo
9UNslL5skBBYkxU+7Iy7sf7T3R1CmzTvPpi8x/AUkBwtMSI/aGE=
=cgRy
-----END PGP SIGNATURE-----

--aawnjxgg7xxdngmw--
