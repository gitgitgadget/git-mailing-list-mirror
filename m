Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1323A1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 22:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeCDWjd (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 17:39:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932118AbeCDWjc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Mar 2018 17:39:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 014DB6072F;
        Sun,  4 Mar 2018 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520203171;
        bh=rIKxLr/H75K7eOYUWXV6eK/8rADsrLMYy7sGAqOgM9w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GuaRWaQvCED3ES4EI9KXFOqunT87f7JGhM5dbZfRY78pVkeJeHqnU19YoJXd3Clg2
         yCyOCgQt7LgcHaXhGAztsfE4VtiF9W1k0VvbCTXhkjlNe8rmkFJPve0CuOpdkZ1CyY
         mqtPYCmvH2twqc04YCGMuBUiEAw5Le/2Sojm6G/xoPNO+yACskhoOzKk8GLi68tc9j
         LCm+Mg1cGxgA5IOf4591gtKz1l2quVeRQzW5GTMOTbJCkDgLQkDG7AoKg9qc/OEx7f
         aCHESow2PW0XaFxQJIiDCTj1c4/T0ZKeVDB0znFRJFQuawAHrxVgGxj2LnSZcMdcaB
         51Pcts2O9V8VZxeeOSWUNajv58NQ/qnev2dB8nPztj2yJ8hMM+2JGoqlF6BEni9kt4
         +PC+8aKcMgY+gR78YHSV2XFn/0BhsK4eHAtBVlMba7MtVNo9Zydhc5/cWouExsa/N9
         ESYphd4VLZIi2x3McGpcI+HZV0sD0gpjmm6hsCsH/KbD0wGDjE4
Date:   Sun, 4 Mar 2018 22:39:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Leah Neukirchen <leah@vuxu.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH] color: respect the $NO_COLOR convention
Message-ID: <20180304223925.GA808005@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Leah Neukirchen <leah@vuxu.org>,
        git@vger.kernel.org
References: <87zi3reoez.fsf@gmail.com>
 <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com>
 <87efl3emlm.fsf@vuxu.org>
 <xmqq8tbbhayi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <xmqq8tbbhayi.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 11:06:45AM -0800, Junio C Hamano wrote:
> Leah Neukirchen <leah@vuxu.org> writes:
>=20
> > You are right in calling this out an emerging new thing, but the
> > second list of that page proves that it will be useful to settle on a
> > common configuration, and my hope is by getting a few popular projects
> > on board, others will soon follow.  It certainly is easy to implement,
> > and rather unintrusive.  Users which don't know about this feature are
> > completely unaffected.
>=20
> There certainly is chicken-and-egg problem there.  Even though I
> personally prefer not to see overuse of colors, I am not sure if
> we the Git community as a whole would want to be involved until it
> gets mainstream.

As a note, turning off color can improve accessibility for some people.
I have a co-worker who has deuteranomaly and virtually all colored text
at the terminal poses readability problems.  It would be beneficial if
he could just set NO_COLOR=3D1 in his environment and have everything just
work.

For this reason, I'm in favor of taking this patch, assuming it comes
with tests.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqcdZwACgkQv1NdgR9S
9ossgQ/9HtA15yama9ss/aWLihLuJboMKugqiVnwlzI446VLd6Mn5+9U6XTsbWj1
oK2bhrGkG3njMIab1SwaW/8a74zBHlO1Gz7fDqtI2RCfEL35wfKEm7WiG0lAuN6C
kAq34RWfGNPWASbAuFY8Z8JBsIHlCnKJBvuBfdmMjsLncU8eeE+0Z9JWkqR2GLNT
yGxLoxMeCBT14EnrmIMA+JOgzdWaHHFCyiznDn4zsDogT1jhabEu+k5H9HHJl49K
S0+0Bl2upnVSPLOPK7jpedDnmf9wW5ybb3DubKoOmxXxhe8bcacb6eaIt+4Ea2fR
hmJwXXZYwlNdYPqdb7BBetqlDfijYGi+Qo3Q5mZFtPS7Cz2aSSN+/KgVEFJlO8CZ
4Pq6dM7j6SG8lZeGf2E3NgCt71++TLJGGqo4E1M/WrHnQEZ0fg0e2RAf0PgSkugh
pNMjdmJjIZJ6YsfFiP2ykHDjLez/3JWtbrm/W8fPj19s2Rce2BqtbiDiNbxMAkqs
UQ0G1VGeGehjDm2bvRl6psImTzQxebPHZIeDU2zKqsVPwWt1NEnYmBEjbnf2NI+B
vpX11nlyTvbF2atQpVHWYQLuCxJPJjNtjI+yuhXEZS3p2hJ26J0qP0qLddFacpGH
NqKyvfL0CXaPnQYdOfzShkm/7VRiyebWLpKsT59A9pplVqwJ7TU=
=7ZxK
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
