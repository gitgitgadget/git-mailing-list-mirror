Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AF4C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 04:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIZEVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIZEVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 00:21:51 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214381DA7B
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 21:21:49 -0700 (PDT)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 42E1834110F
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 04:21:47 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        by grubbs.orbis-terrarum.net (Postfix) with ESMTP id A70922601C7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 04:21:46 +0000 (UTC)
Received: (qmail 28485 invoked by uid 10000); 26 Sep 2022 04:21:46 -0000
Date:   Mon, 26 Sep 2022 04:21:46 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git daemon inetd mode: need traffic statistics
Message-ID: <robbat2-20220926T041714-401286569Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kO+JdfMhc0QNb6f"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3kO+JdfMhc0QNb6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Has anybody got patchsets that let git-daemon send traffic data (to
syslog) at the end of each request, about the peer, and how many bytes
in each direction?

Hoping somebody has something useful to share that isn't coming up in my
research.

Gentoo's seeing a big uptick in usage on the anonymous git daemons via
xinetd (we do offer HTTP/HTTPS as well, but the growth is in http).

I know it's via the git/9418 protocol because the HTTP traffic is
well-metered and hasn't grown, and the overall traffic to the hosts also
grew. This is confirmed by using Netflow data, which tells me it's the
Git port, and some of the IPs, but doesn't let me get which repo
directly (And processing the netflow data is also painful).

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--3kO+JdfMhc0QNb6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmMxKNhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsT81Q//aJGiNEmWeKVRlQVi0xkzfcbOuHecDxdL0zW/NFwC02Lna1aNXwsDcCvL
TQ+sJP2TbY568c0c1tujUsAQYhmq6edGaaMiOqdmoJRnETMEG2rHw+QBdR7lZ8ZS
4sBzqbCWp5WFTdN3vU/ZKdtNFZ5Hlr9Xx83z7Ia+btM3Fk+n6ZVRIcc1eUqfvCbh
c6U69DbrgAwO2REo3weoEd8Kq55xpvtTrKvZCuHw6GcvdfAWOn8RUTpr1rjk/QBZ
8nkbX8LH0Yq2Z/ywkaga44K4dRj+Ak45jO1sOIdSUXP7pvvCVlCXb1T6do+Ro1eM
a9lNjCyj8IJOsxY0YSYxzZR6aWo/HEGx1I9rQC4mWtIMRXGF5vnUTMhhoewlU3AE
YoVarnsRrGVY5dgHJpRJ0bBbvdtxRbTyYdxwrqvejJkaBHoznLYow+u0eQ7Gjx3N
rT2BUjSvp27xTZ/daf4Je9uSw4Z2xRwqdXWkQpT7tPCh1NUeobuW2fnnKJ2Q93rG
3g4eLsw/MPiN2ShrPbn2UOt8X5yajUEwmi8SRXT3ZtahvCplzAQz5XWXWK5a0wLu
gWluE1MsIWP4QYglpacZ3vxJpnLpy/fDgJCu7JcimV8HKehqpAn3anEvyf9l6b0V
RdRhMYbj2G8FtTPDvyUYplkbKMc6KXHAjeOSFqYUmRgvHY1+fvU=
=H9cB
-----END PGP SIGNATURE-----

--3kO+JdfMhc0QNb6f--
