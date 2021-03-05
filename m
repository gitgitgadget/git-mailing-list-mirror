Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D73C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89EA650A9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhCEVyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:54:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhCEVxv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Mar 2021 16:53:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2CAA60DF4;
        Fri,  5 Mar 2021 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614981231;
        bh=2oIMiAOAb931fakm4mvinuG8T3Axs0PA9S1s0PEIrNQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y77qr/L/sPV4LrEoj56D/tFUef7NWSbkA8T+UrwKdugcne+1xx8G3iVuLUWyLhzW4
         iTYWiORGnQuUSqS154F2OGXap/XsPcJugOhiN5GO+QHC8/Z9gJA2KFMBRf0Xqplo8p
         FUUaGcMZda2AUYMw7dWuAvYGt7Il74+MbTMBf4JEYY2uEAXRBm18v/nRRW+kUoYFIj
         oMFLfSI1MuyXMqbAn89Cde/dtldqOxu4GTn2R4r5COj+TpIXTlUd6dvrUgqnD/Vz87
         caUgrrtE86ZoOEruWifiNp//AgFw3kI213EOcIh5K+VTj+I/Ae7IeMj+oPNEPOfi/G
         +k//pY+FKoEUL+lQ1iXgfCkXWEZ0vv4gIwlqvvUsXcVlqt0J1cw4eKY0hLPWXd9Sr+
         qXP97r4PjsgwiIWgBoz1PW103jA/JDdwOIuIX7LOs8mz2a2hkUh+s0c7b4xpuwjZXV
         IL5My9XqBst0ZGvyrBiFNmAjTZCymRr4UWp36g0iKzOGs+B5F0y
Date:   Fri, 5 Mar 2021 21:53:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Possible to use git over custom ssh libraries?
Message-ID: <YEKoav/IOp4Mpe4H@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stef Bon <stefbon@gmail.com>, Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
References: <CANXojczh98ax2KwsaJg4CkusgrUWvhH0yG-u6oSW9nwwMLz_iA@mail.gmail.com>
 <CAGyf7-HuBHC64rL-NBRS_HDD3dbyedV-LKOeP+=k2ZVxpDOLbA@mail.gmail.com>
 <CANXojcymWsK4g7s5rx0_OPu_XSf4ZiKUbYgQ-h38cvF5WYQs=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vNMb9GStO6UCQWh"
Content-Disposition: inline
In-Reply-To: <CANXojcymWsK4g7s5rx0_OPu_XSf4ZiKUbYgQ-h38cvF5WYQs=g@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4vNMb9GStO6UCQWh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-05 at 14:22:42, Stef Bon wrote:
> Hi Bryan,
>=20
> thanks for your reaction. Git itself can thus deal with a different
> ssh implementation, only I cannot use that for
> my fuse fs. I need I library which "talks" git.
>=20
> What is libgit2 in this context? Is it a library which uses the git
> internals, or is git self written in libgit2?
> And can I use that to use custom ssh libraries and build a fuse fs with i=
t?

libgit2 is an independent implementation of Git as a library.  Git and
libgit2 generally don't share code, although some code has been copied
=66rom one to the other.  It supports SSH using libssh2, although you
could probably patch it to use a different library.

That's the only general purpose C-compatible implementation of Git as a
library that I'm aware of.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4vNMb9GStO6UCQWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEKoagAKCRB8DEliiIei
gUqWAP4/J+b793IgcrT/lINRlwRniB5pSczdksLgzj6BEL8U7wD/bb8Q9DzebXDA
5Rtu4lPy4CWJfLDhHPCx6fjjIExKew8=
=FCd1
-----END PGP SIGNATURE-----

--4vNMb9GStO6UCQWh--
