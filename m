Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A9C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 00:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGKA6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 20:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKA6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 20:58:34 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56812B3
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 17:58:32 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DD5E95A1AB;
        Mon, 11 Jul 2022 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657501111;
        bh=vkWsRe7XJ1ToMa/EAHuRIw3of6GgiCDJjUHwjZkwb9w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sm4BoCDxDpKXbJfnfVUsumeyUWdh84liyhClE98iPBDueatPkGl4ch3Tna+mlAPUj
         ID44NVbbrrEcvPor20U1iocZAehugP0bX79CCGNicoE+v3O6oDLMlz4sbqQoR6UQwq
         TIykzfU1H2AEGI+2Grp7NlcsYb5QnI/xZmE1GLPL6M+wVCtdNRf1os4AFA6NWeRKdx
         dUiQYSviz37KLaAXY3mQt/VKJPIkLRJ6HdoVhRQMO3Cn5Sc2p4joNkiUZfiaaxFTEm
         VY8MFsP2FORxI1Av3dq6ZxfHV3mSmnargVPdhtjgkBzpggg5S5fKSn9J+Oq8IziUPy
         +1QjU3KZf9JgSe7clYUTin+WImpHEUjWh+GH+zi6Hxv4IvTrB4UNqwD9MXhxOMBcsH
         LcDmc15Alc3H7JH1FqzWtxSnnHMeWdb6tLLtuYsWZY5sZNKfvV6373u6KU2x0wcuUO
         TVVrYByfWKiFnJyCuLGASea0kC0/mbLic6mvSM4VI0HHEtmGsXq
Date:   Mon, 11 Jul 2022 00:58:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: Automatic code formatting
Message-ID: <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, git@vger.kernel.org
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4gil+7+Oc2BTlgu"
Content-Disposition: inline
In-Reply-To: <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w4gil+7+Oc2BTlgu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-10 at 22:13:01, rsbecker@nexbridge.com wrote:
>=20
> Being one of the platforms that will be specifically excluded from
> this proposal, I would like to offer an alternative. Before that,
> please remember that not everything is Linux. My suggestion is to
> create infrastructure to automatically format on add/commit. This
> could be pluggable relatively simply with clean filter that is
> language specific - perhaps with a helper option that installs the
> formatter easily (because clean filters are notoriously painful to
> install for newbies from my observations). It would be nice to have
> something in perl that is more portable and pervasive than clang -
> although perl could launch clang where available. I think having
> infrastructure for code formatting that is built into git is actually
> highly desirable - assuming that it is not unduly difficult to install
> those. It would extend beyond git contributions, but the contributors
> could be told (Contributor's Guide) that then need to follow standard
> X, which may very well be clang format. There are java formatters, php
> and perl formatters, even COBOL and TAL formatters. My position is
> that having a standard way to plug these in is a more general plan
> that would reach a larger community. Git contributions could then just
> leverage standard git functionality.

I am willing to acknowledge the fact that not everybody has clang on their
preferred platform.  However, I assume you do have a laptop or desktop
with which you access your platform (since I believe it's a server
platform) and that you can install software there, or that you have the
ability to run some sort of virtualization framework on some system.

I am in general not very willing to say that we can't use or have useful
developer tools because of uncommon platforms.  Linux, Windows, macOS,
and (I believe) FreeBSD, NetBSD, and OpenBSD all support clang and
related tools, and I don't think it's unreasonable for us to expect that
someone can have access to such a system as part of development, even if
that's in a VM.  Those six operating systems plus Chrome OS constitute
the overwhelming majority of desktop and laptop systems, and there are
several options which are free (both as in speech and beer).

Moreover, clang and LLVM are extremely portable[0].  As a practical
matter, any platform wanting to support software written in Rust (a
popular and growing language) will likely need LLVM, and there is also a
lot of software in C and C++ that only supports GCC-compatible
compilers.  I do feel that providing support for modern toolchains is an
important part of providing a viable OS port, and that we should be able
to rely on porters for that OS to do that work.  I realize that LLVM is
not yet ported to your system, but I believe it's going to functionally
need to happen sooner or later.  When it does, you'll be able to send
patches directly without needing to copy to another OS to format the
code.

I should point out that I'm very willing to accept less common platforms
or architectures as build targets provided they can support the 2008
version of POSIX (which was released 14 years ago) reasonably well.  I
feel strongly that we should continue to support such systems for the
indefinite future to the best of our abilities.

[0] LLVM supports targeting 18 Debian architectures under Linux, Haiku,
VXWorks, Fuchsia, UEFI, WebAssembly, NVidia CUDA, the Nintendo 3DS, and
more.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--w4gil+7+Oc2BTlgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYst1tgAKCRB8DEliiIei
gdBpAP0ZKnc5e5eWt6mjYhYeZHJtCkqKZJqUHlGcYPQf+Uv+MQD+IpJiwvXE1t7h
jVwLafmgyPV7dZEgnpkDFcfo/tfzOgY=
=pr+f
-----END PGP SIGNATURE-----

--w4gil+7+Oc2BTlgu--
