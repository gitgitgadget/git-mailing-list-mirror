Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B4C433E6
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB8F64F38
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhCRQe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:34:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43770 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhCRQe1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Mar 2021 12:34:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C2D760457;
        Thu, 18 Mar 2021 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616085236;
        bh=OQn+Devq5gOxW690nQ6hLZXU6X37lwAPikpy8qGV3Bc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IqEeb/qSVIpAm8j8L4o7ahGpqAAFgWxj/pl1I6mcm5QlIPazykH6xHoueaFek9xWY
         K+yy1R0uw6ne3TYAm+Alq87folv0XiU8upGfKgT35JO/XU65DG4UtLdl8DeOO2xPhS
         GCr0Ud4TLQTb4OfDK14KOjblhwkZqX98Lt+gX/8uODLM+1yFFr+bvXaz2s7AFtHKqp
         g86WheEHMsYduMlXv72Skv8iTAMJWNldnA+Mcg9gBpxrVZAOF+hsItsbpWrUNQLxR2
         0g/ZaosteGK13F0DlnB+hwG1RrqcUAOqoCuYPA1G5RPE/IntAYBYUaG8STA2XFkEw+
         L/380PXwKMhfUNfK240kjlPWL4beQuER3O9eFaT7NIrGnOnKXAqQSGzhwWNePIA177
         DsjM4k38dREVmBQp8j/DnoLZYvmOR1oGoOWXdzZtxos4lbR9nSQIuZ1pBkNdNT/NqO
         lhHu2i/Ii/ocygvng3PXnqWjQq/hP7PBz6t0k/q6Lvv1cblywe5
Date:   Thu, 18 Mar 2021 16:33:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian Strasser <christian@avr-fun.de>
Cc:     git@vger.kernel.org
Subject: Re: Git install crashed nearly whole System
Message-ID: <YFOA8ARUwa34tiTl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Strasser <christian@avr-fun.de>, git@vger.kernel.org
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
 <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
 <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwmvrpRb719fb6Mk"
Content-Disposition: inline
In-Reply-To: <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fwmvrpRb719fb6Mk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-18 at 10:37:04, Christian Strasser wrote:
> Hello Brian,
>=20
> First, I want to thank you for your detailed information.=20
>=20
> I'm a little confused. Is the instruction on "
> https://git-scm.com/book/en/v2/Getting-Started-Installing-Git" not the
> official one? As you can see there, the first part is how to install
> git with your package manager (git-all).

That is probably out of date, and I'd suggest reporting it to the
appropriate spot, which is _probably_ https://github.com/git/git-scm.com
(although it might be a separate repo).  The git-all package has had
this problem for some time now, so I wouldn't recommend it as the
default option.

> Should I remove everything form "git-all" and reinstall everything
> according to your advise? It seems no git daemon is working right now
> (systemctl | grep git).

If everything's working for you, there's no need to change it.  It's
_possible_ to install git-all and not have this problem, but because of
the way modern versions of Debian and the packages in question are
configured it ends up tending to have this problem by default.

In this case, it may be that git-daemon is installed but not configured
to start, or it may have been removed when you reinstalled GNOME since
it's not a hard dependency.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--fwmvrpRb719fb6Mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFOA7gAKCRB8DEliiIei
gWWkAQCnAWf/09HwI31/ht2jtfNmqH8KCA2oMjGFSabHGPoxfgD9HuDYaZ6UGYml
QhY5h1ZL3p2BiXogGGTE7ymkQaPsVgg=
=APDY
-----END PGP SIGNATURE-----

--fwmvrpRb719fb6Mk--
