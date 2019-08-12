Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C8A1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 01:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfHLBLD (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 21:11:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57480 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfHLBLD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Aug 2019 21:11:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e9dc:6bd6:18c8:c98f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 634F2603C6;
        Mon, 12 Aug 2019 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565572259;
        bh=l+bfi4b6PCu5obfv0qKfYYBT7G4ExDEyADpCYff54Uc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y8OpH8poIf6q/qTppUcDAroQVBnQZGXzDyaTukZQT0+19JF/Z9NOR6wk6cOj/jz5c
         jL2QC98lPS2JbZU6e+OIVWDD56AT/fGq8P9VXcLbB/AGshKGA+r7rcl1gceFMdoEBL
         sA+z+EuLl8rQv/0oO8BJcIXJMcoQtMqiudu1sWrv7rkvSdYKSlHIBCgq8llEP+5VsA
         YlnCMCaUs9R+g6e5nsubSZVx61W5uscxZmb0JiWBxjPAmS1mPm0dgflQbrrxqLFek+
         hdRMv89DFLU9kxl0QNv9AfMwGAVuS78IOw6nT7PsKy1nppTtCW7uZHy3d47pdVPkVK
         vEkE3FDHZ3XftYPuhrkak/PowE2zaoG9xU7OA9bB/AOiGOhnUMPjaES/L6T4WqXzVx
         ycx1TQ2rlkIufo4c69jWejPL4XAezkyvYF92v1v4KKAuPmATRUPGPP8zWUICUD6mfD
         3MtCrKboq+GyCZqq6m96RakraDGo+bkl92vzG6LHnKZPc6cCxY6
Date:   Mon, 12 Aug 2019 01:10:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
Message-ID: <20190812011054.GA9180@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-2-sandals@crustytoothpaste.net>
 <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-12 at 00:32:26, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > +static ssize_t stripped_path_suffix_offset(const char *path, const cha=
r *suffix)
>=20
> Perhaps
>=20
>     static ssize_t last_path_component_offset(const char *path, const cha=
r *name)
>=20
> I am tempted to also call the second parameter to this function
> "basename", as we know from the proposed log message that you wish
> "basename" were usable for this purpose, but basename itself has
> another confusing factor (i.e. "are we stripping ".exe" extension?",
> to which the answer is no in the context of these functions).
>=20
> If we agree with the "last path component" phrasing, has_path_suffix()
> would become something like:
>=20
>     int last_path_component_equals(const char *path, const char *name);

Except this is not necessarily the last path component. It could match
one or more path components with the way the function is written. If you
want to ignore that and name the function accordingly, I won't object,
but we could theoretically handle a name like "foo/.gitattributes" as
well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1QvJ4ACgkQv1NdgR9S
9os8DhAA0IRu/zRi+0V3aU0sHtJvfsEO3WX36zjoiwpNgOlNCBPv/5VTG9mCQtLN
1j4oMIX3u41g4SHfg6Phi2FasTwgab6/aEauP0xeS+lFq591CRRRmQkqryotoMK0
ToxZw6wWkW847z3QEKBdpxif2kVyFlwp597fFbQGY6RZWbHNrZGT2WtmeBnqgZMZ
iKWjzNy7NJeehclpwZndDse1JbYXm+sWvLrLXtlA9qWvnUxsNL4rJmRWhnqoLuPC
Gd77d7qJIaUkHnRpKHe35COs62FRqS7apmGK0ccCZeHUkGOIHVoZkiOdPjeBKgj9
iFPwmK0HTBpgugIdGjuOjutFJNbUpxM+dtxVNlfRMvS8S82rbFjE1DcVZOm2gQHQ
Tvg+Yl9EFFb7dclEANr174cEh1u/nSuypXbQ2EKi8PEvOofZIkDxar6YqT/s1RDy
ExtCB0sUUIxSxr96EWrD8GgEGTLR3dtekJ1QYCAMCAFpezDhh3jVgteLYqyd4c2o
drL9iQD7pkQjokNjQ1w9+XpNWjNz5jzO+C59LpuxEL/Prj6upske1L2h0N27oidL
staQ3h76VN57f5zANjPhQ07RYC1fzHggMg3Asegikl2QuU8ImCoGKZ+xtWUPYgm6
LaEokvux/LG5IVTBeA0PchUzTjjXnHwTHNLciKwDA3Sjnet59RQ=
=KuYH
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
