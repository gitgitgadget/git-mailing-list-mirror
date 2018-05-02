Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8B021847
	for <e@80x24.org>; Wed,  2 May 2018 00:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeEBAQO (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:16:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbeEBAQN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:16:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78DAB60129;
        Wed,  2 May 2018 00:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220171;
        bh=Hkbj2lrEiVeuR9BEA/tez35zrfmnsRDtvh49zw/7RqE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=evVSBgOLubQD+KSiC39hBkvxEEj8WnmFAa0FHMp3kE2gJIJ1hOpEorA4czXRus0jw
         XKXnjCz3jylS5tf+4KmKEkwhSZbwwVacXf2dJhi1WPsYGdNFAvlLNsF+gkT96G86s+
         cYKVsh9sHkoN3Jz5jfU4aFDsI3mxBUf1JANld9IyhZx/JCp5e6v3yxgmbryj/2VwPi
         KvoearLOc4I/KxvMgnXjtdYeekk0xJL01WDGOjfw5J4kb9uiydWCLcZJUjDgYNx8pX
         fe/KFcJ3Osk+PGxHxUfrwDjgFb30rTKQzrqXbV1YwocEFcmzHKatnrcV1eyWBSgKpY
         SOCV260bcWrIVtH0LuGZA1gGf2X4juVHLhy09RUzg7y4egAn5jbJwxJqyFE1N4RcPG
         c12ppK0Q6IOB9BVoHytP1nV3psTHYtWhM0sYbQufZJlI0fWKP2lR3n4fSfhHxnKg/s
         V+p7cCYVgx0ZOKR/A5IhF+CP83tKEy5mwAAEydxosu5hz1y/IjN
Date:   Wed, 2 May 2018 00:16:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
Subject: Re: [PATCH] format-patch: make cover letters always text/plain
Message-ID: <20180502001606.GI13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
References: <20180430020930.GA13217@genre.crustytoothpaste.net>
 <20180501000214.833766-1-sandals@crustytoothpaste.net>
 <CAPig+cRucJfzm8Z0XhPa0CMw+LiBdY_b5=bMz0LkezJxvC9qJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <CAPig+cRucJfzm8Z0XhPa0CMw+LiBdY_b5=bMz0LkezJxvC9qJA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 09:53:33PM -0400, Eric Sunshine wrote:
> On Mon, Apr 30, 2018 at 8:02 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > When formatting a series of patches using --attach and --cover-letter,
> > the cover letter lacks the closing MIME boundary, violating RFC 2046.
> > Certain clients, such as Thunderbird, discard the message body in such a
> > case.
> >
> > Since the cover letter is just one part and sending it as
> > multipart/mixed is not very useful, always emit it as text/plain,
> > avoiding the boundary problem altogether.
> >
> > Reported-by: Patrick Hemmer <git@stormcloud9.net>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > @@ -1661,6 +1661,15 @@ test_expect_success 'format-patch --base with --=
attach' '
> > +test_expect_success 'format-patch --attach cover-letter only is non-mu=
ltipart' '
> > +       test_when_finished "rm -r patches" &&
> > +       git format-patch -o patches --cover-letter --attach=3Dmimemime =
--base=3DHEAD~ -1 &&
>=20
> Nit: "rm -rf" would be a bit more robust against git-format-patch
> somehow crashing before creating the "patches" directory.

Sure, I can reroll with that change.  I had considered doing that, but
decided against it.  I hadn't thought of resilience against a failed git
format-patch, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrpA0YACgkQv1NdgR9S
9ovW2xAAp9YquVovb4otKh9t55YpibhHcv8edq8Q+7p5ezON/yiv8gfZbnHImyoE
hhf9OwGMbwrwNo6sKLoac0skbSUobhp/M4Z0PSisO8zAOH0hUa70KW+c085/CSek
7Bi4A5exFizIf/HBzXJnTcG/oUG3hfyJJ6HulS+CNeqjd5NuPtOi0pgO0RSoxbAe
u4Lbb+SsTY/ONRTtSfhmxxYyzVBbrrT+Evr5lnRbEx9oK7B+CmRGeLZj7Xi7KoHh
g2B7b0chSef2bZyGC7D7L57mYqf1i1Drywq05cV0fEqfylC8sQGf47N+Tt/n9R8a
21s1oi8msqnSAqaRiLMoQ5ptGESOKYLE57Axenp06s/PLxAfWLIk6/K0HM6dgg1D
BDfVg285M0NpUdIHuDDImYjpnFhlvANbP9c8EKfHDM41VMtT6XOCHCLftIOniHM5
hLWe9nK5XeRZcY+XKyWyaCEGvl7AczN5z640E3+xFeuAliLkvgmsgblQsoT6j7Vp
fNc6WdCQuWDQBOtWAOgWdxohT4mI+3sDd9bT0bngMVgXR+gFFo2l9yyF+PuRrFEM
8f/VPVGmb0GiuFjmqdDacte8AfD6mg3JZu+fjxyGpl0aO6BODuuys1ad+Iz7XeuR
mQniM7SxToo3vh0kQUI/QTk5Q3JGUiCB5143MX+k+Trm7dqKniE=
=sf9P
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
