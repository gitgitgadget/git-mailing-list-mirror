Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29E41F461
	for <e@80x24.org>; Wed, 10 Jul 2019 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGJXjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 19:39:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56548 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbfGJXjo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jul 2019 19:39:44 -0400
Received: from genre.crustytoothpaste.net (rrcs-50-84-77-156.sw.biz.rr.com [50.84.77.156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7A9C8605AA;
        Wed, 10 Jul 2019 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562801982;
        bh=wEQwwmFo8wK/fVzzFh+OEaFAxX1WLWG6i2azjxcsn7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=V9zMOisQTECzdmpJHSTIDG3gPwGI6TDDYLN4Akx3oBCePLGR5J4Mp5z/V6TzgYXGM
         Fmz6lEn1ARB2vVg5Mk67wOgHHqgCedcpQGKNrA2Uu6COKbLD1qO3HyBzcxZ33Wf7eW
         BeHwQd35iFfnJHhATtV+QtVuvcusK6OpzPzc2CQz4h+vudXfUBuot3utmsN6XY1wrG
         l7q05xZqjR7zCij8F+2pkg8vIhrkjyNHQFJWxFgdyLcuZmgGe0m4pIneWEfJc0Tvca
         duzzl4jDOOA2aKIorT4VSrVjtMzxNulknOpINzKlPfuZobIvsn3sEYh/DJOdOtm6Sm
         CzmqFalxsJMgT86QYVgTqhrkNnQWYo+XPg4gwBfP9jGJaqMgTrF2gxdcqLS1vbW7fB
         D8+qXvzDA14KN3fylQgCkecFQMXVinMsXlYrSq4y71yCOsWs1qTh4cms4um64DoOdr
         5lKDef1CFzExK/sDkx8UCbjPaAjcnXTRmrEcwPPwHZ3rZa3EIoz
Date:   Wed, 10 Jul 2019 23:39:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mark Florian <mflorian@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
Message-ID: <20190710233937.GG9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-10 at 05:06:08, Mark Florian wrote:
> Hello!
>=20
> I learned today that `@` is a shortcut for `HEAD`. From `git help reivisi=
ons`:
>=20
>     @ alone is a shortcut for HEAD.
>=20
> However, when I tried to use it in a command I frequently use, I got an e=
rror:
>=20
>     $ git push -u origin @
>     fatal: invalid refspec '@'
>=20
> I'm running git version 2.22.0 on Linux.
>=20
> Is this a bug, or have I misunderstood how this is supposed to work?

This is a bug. If the destination side of a refspec is omitted, and the
source side resolves to a ref starting with "refs/heads/" or
"refs/tags/" (which I expect it does here), then that ref is used as the
destination.

I submitted a patch at [0], but it was decided not to pick it up. If
Junio and the list decide that it's wanted, I'm happy to resend or
revise and resend.

[0] https://public-inbox.org/git/20180729192803.1047050-1-sandals@crustytoo=
thpaste.net/
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0mdzkACgkQv1NdgR9S
9os7BRAAgprkyfaHXiNOFu3f0hHeBBhXxJwU4goZmfoF6XXOyAu8mX2NHmIb2ja8
t8jkLnX8mj6CwLrNPTZobUb16tzYDbyhUp7CmVClsjPD8SPtAU5T0csvEkFC2jlt
R1SOQQZB0J6/m3aYZGsYAlekXaU//+RbwdKfJv5ZzqgN7Yju+SHI8rLxmadjxbYl
z7nU8cEnlcm46PqegFphhjiDzp9NZy5l80zNXl1tuv5qMntrUGWGUzRhf/WC5Y8q
YkPIqYCKnTmz3etatKFTVNsHmxZRpmAXl2uG02nuBYH+lVEnN//Mv14nW//JlfFq
rtdhBkun3Z/nHQPt2rbt/szHOca+M0/oF/m8OMsy0q+2xupVpmIQbg+7TxMeUdEI
2/Zt63ELI2gM/YFlJj2Au/Zy0V8ijQWhwtmi6vHVc5Z03qg+Qo8I7dE+yQpZIry6
tJ7sz+tqd55xWScGn77DNKjXsQK3rHuuT3YxqT24iwTdws9EoijxRNPgBK/3sl69
+bXe1Dnr+hxyLxEjObc+sZTxlurIqt6jd+5AmtlvQNtCc0DAh15VRnStmVyF/Fyc
0j75nTGhPEzk7+/boiVhQPDZJhRTkRv+fcMX+VzAK4sWwtopRngnKueQPywH3kXd
5LaGaFGaOPUQiEfGENnN/6RjihSF3DNARRuqg81u45N77BmisSg=
=obXU
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
