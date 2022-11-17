Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F2C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 01:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiKQBYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQBYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 20:24:53 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B02C67B
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:24:51 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 532FA5A1FB;
        Thu, 17 Nov 2022 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668648290;
        bh=xddphfK9JAGhn26im2HfKBMbt9l09H5bAH5uQ0kDTEI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lTkSDcHdG95p7Ps6AlnZUupRTaLq2fy/Obg8bPpAg9isaEr1IdsRicPcxTeENoaN4
         8EXA1+mn10RwVRrPYiMSYUqtDNe13hwiYA7/+bfBtpmSK3lRU9wN3XHJ6AAQBSz+er
         KrjVf9pJubBh6d602APu5R/iZAAm33C6bqeaWepwhNVpArYzjSGTYJEJJU2loO7pAc
         FyMzj2si5ZJMjYG/01GaANHJ+LckoiRi3oXyR0P5uC8kOGpbE7oOapgERT3d3EB1an
         tsd6quDe285A41eD2OthYevNGA1mk8v92fGgiURhzr1ABaj9ILf8z8pjb5h8UJzj5J
         3q8dQZeo8PUNPYuqEnRQ2lD+/m/bMiG59jfIujd9r3oXjT9qMVs/3J8yxjYgPOn/7h
         bWZQGJLY1Hi4X0B3s+lPW/+HS2SBrH/DKNAn/TLwlPYYhr/RPORcDgVFSdOqqRgF0I
         qWb4H4b/qfsjmveTC5juWXMCww8WcjFZUF0hzdJvuwoU94w9oGT
Date:   Thu, 17 Nov 2022 01:24:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Hary <davidhary@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Issue: Git for Windows: : Incorrect registry entries for the Git
 Bash and Git Gui
Message-ID: <Y3WNYNjos+2996jb@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Hary <davidhary@gmail.com>, git@vger.kernel.org
References: <CANNdkQZByT6dAiAJ=yrQshBi9suDUV2Xum2TtAGyJDKxb3f5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MuH++N55C0WAkEgZ"
Content-Disposition: inline
In-Reply-To: <CANNdkQZByT6dAiAJ=yrQshBi9suDUV2Xum2TtAGyJDKxb3f5QQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MuH++N55C0WAkEgZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2022-11-16 at 18:36:27, David Hary wrote:
> :Observation: Incorrect registry entries for the Git Bash and Git Gui
>=20
> Likely Cause: the registry entries do not update when updating Git
>=20
> How to reproduce:
> 1. install git as a personal level user; git goes to c:\apps
> 2. Change user level to admin;
> 3. Update git; git files move to c:\program files;
> 4. Try git bash or git gui from the File Explorer context menu; both fail.
>=20
> How was this discovered:
> Having had some issues with android emulation for visual studio, I
> changed my user account from personal to admin.  When updating, Git
> got installed under =E2=80=98c:\Program Files=E2=80=98 instead of c:\apps=
=2E Yet, the
> command lines for Git Bash and Git Gui as recorded in the registry
> were still pointing to the c:\apps folder causing the explorer context
> menu shortcut to fail.
>=20
> Workaround: edit the register changing =E2=80=98c:\apps=E2=80=99 to =E2=
=80=98c:\program files=E2=80=99

This list mostly discusses the portable upstream version of Git that
works across systems.  Any sort of custom Windows patches or Windows
integration, such as interaction with the registry, should be reported
to the Git for Windows project on their issue tracker:

https://github.com/git-for-windows/git

You might search first to see if someone has already reported this.  In
any event, as the folks providing this integration, they'd be the ones
best suited to fix it.

Hope this helps.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MuH++N55C0WAkEgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY3WNYAAKCRB8DEliiIei
gb1wAP9IiTzFNAsRjaeLAnvhJu3BOKDXmq8V/gmN4Jfb6xWU3AD9EF5w6ESlkj7d
VdomeXIXZJMEgYj5E94Iue1/i3+cfQI=
=af3Q
-----END PGP SIGNATURE-----

--MuH++N55C0WAkEgZ--
