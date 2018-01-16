Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B0E1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 03:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeAPDBB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 22:01:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58054 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbeAPDA7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 22:00:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 599786052F;
        Tue, 16 Jan 2018 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516071657;
        bh=MebRLYmZjtQNEu+RgyBIiadvpOh6AfEXk/gRyGbFEl4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hURhh+SmlrNpLB10bTpOImY0CxMb3WB078P4vYYp6XKLAxn9SOhwcis6t6RpfjPFP
         yR9z17Z++dRWE0lPIP1J7eZXm5EGYYib+7gM4zmryu4GcnH7BXfWP9JEYK+zXhXABn
         mWkhVsWUnNoyZ4VHxxdqEBM+HYiSCqvRO83zJwYhQcoTKczZwe5LG2vgzeU92bFewL
         jySlk3tQzWMj3u1ArUrZEg41qokB34U5mU86bgG+NMT4qkOH1wA1uAJK/1FKgow9pl
         Ven5cVufwyTFF9gD0WUTQ+XMGqhf3iQgmHKPfqdxqKoN2RmK0dlp1H9wDsMMpStxxX
         ygqcPr8+bblwGofG279dgw5xbguuq6k1ie0kq7ZtHhK/AiqqfOiM6LkQUkB/n6MNyB
         kXJ+F6hASaMsa2BOvfDgl72guaKek1S8VcQhYXIE0JRIwDbnfnfb1x46FRgNQVPW5+
         xRXaqNHtMSs+c/KWdUMy0e9/AkbrBTO3ehXc9FaZ7yOZqte4zI1
Date:   Tue, 16 Jan 2018 03:00:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Johannes Sixt' <j6t@kdbg.org>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>
Subject: Re: [BUG] test_must_fail: does not correctly detect failures - Was
 Git 2.16.0-rc2 Test Summary on NonStop
Message-ID: <20180116030051.GA244260@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Johannes Sixt' <j6t@kdbg.org>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>
References: <004a01d38cab$705262a0$50f727e0$@nexbridge.com>
 <001a01d38d57$d36c7d10$7a457730$@nexbridge.com>
 <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org>
 <004a01d38d7f$3306e810$9914b830$@nexbridge.com>
 <007901d38da9$d517e9e0$7f47bda0$@nexbridge.com>
 <499fb29f-ca34-8d28-256d-896107c29a3e@kdbg.org>
 <001b01d38e0c$ba16e250$2e44a6f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <001b01d38e0c$ba16e250$2e44a6f0$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-5-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 09:25:37AM -0500, Randall S. Becker wrote:
> On January 15, 2018 2:06 AM, Johannes Sixt wrote:
> > I take "die exits with non-zero" as a piece of information for the
> > *users* so that they can write "if perl foo.pl; then something; fi" in =
shell
> > scripts. I do *not* interpret it as leeway for implementers of perl to =
choose
> > any random value as exit code. Choosing 162 just to be funky would be
> > short-sighted. [I'm saying all this without knowing how perl specifies =
'die'
> > beyond the paragraph you cited. Perhaps there's more about 'die' that
> > justifies exit code 162.] I'd say that the perl port is broken.
>=20
> I agree that 162 is wrong. Its interpretation is 128+signal, which
> clearly does not happen in this case. On the platform, if the perl
> script is via stdin, 162 or 169 are returned. If via file (perl
> file.pl), 255 comes back. The port has issues. I have an opened a bug
> report with the platform developers. Usual non-Open Source timeframes
> to fix apply. =E2=98=B9

I believe the standard behavior for Perl with die is the following:

exit $! if $!;
exit $? >> 8 if $? >> 8;
exit 255; # otherwise

Is there an errno value on your port that matches 162?  Maybe EBADF?

On Linux, I get the following:

genre ok % printf die | perl -; echo $?
Died at - line 1.
9
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpdauMACgkQv1NdgR9S
9ovP7hAAtB8dh50VcyijKr4YJ9zokvu8sZX/H1yRTQc2xT2z6KS/NrvBucpCFqEH
7Wvd+n2UAXx7RTSus0tRitYgs2zaOLStXO8eyYQYxPc2spjoxw27739s909xuTVa
X2f7TFlf161UR0EJUFqHh8UGJ5I2r+DokjqDz6lQeo27qzVYM+/QfRAeQwfgkTYU
8tjJQF7ApfQ/wTNTgP/xI6rdKo9k7wEl5rNSox4Ts6b7j56prWE4cNgkX5vLNHl+
nqrwNdlwb2EdSZ7Rc3rha25Pu12k+zrD2xx6NOOmfGoq3l8QvxiEDN7VmopAoTWp
/bl1r5YfimAgW5xYFvVHZRw3nqJOSO5QexrfUZUTTBqD4xqnmahcdUVqo3M3KPyQ
QWDfQw1urvz370JKYL87zlx2xeYw1XrIbBsxIGG8nTyFZNLnwRzVpOIFcj/19qEj
vBdnwBBbo9xu87fZ9bIPIXntz3fmOVi+tr7wTKy0UdMCeVy3X36iz97TibKZ1Z/7
icDWbHS0J+0kg/TeKwUiCjzcU5nHGRO2EIhRTvqrNuCkNwch4auW9Gi+hD+Bddse
wXsV+cVW4lkvIOQLsAVhXCuwXy3xqrs20F8hWkVRw4VXfp54mC3QrI9DjcoT5sC0
oG0pnbh5OpFmgFSaiJPKJq5aLL7T+V3BHlOBSpSysoKzE6RDmQY=
=zWGp
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
