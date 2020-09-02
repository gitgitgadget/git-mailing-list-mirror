Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A292C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 01:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAB92071B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 01:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z5VJwjBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBBd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:33:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51816 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgIBBd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Sep 2020 21:33:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 192A560457;
        Wed,  2 Sep 2020 01:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599010436;
        bh=zP4W4eXN5h+C5IuiwhxuQi/FDTWCTbI1iQ11oRWuqu0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=z5VJwjBSPPHbjPObyCo5+6UCn7KhoD6H74qnjwep28i/7KnzZlWf63/mdYR5VyA56
         UTPchY2M8IoWDq2B457DtKJvQftAZIUsOqgiSVfths6GaJJLlBOnyTB9rzHGiKWnw8
         KnJqOO1eqnl10HZ3I1ebI+iHLq0L7EMjrGtW3JmEMqBw8uH1YiHGjkq8WBsNDRMeD5
         dc3/0u0hsX87XFI7nSXHacKDF4blXqFokpX/YW1CdVS7l3Tb8lkKeN358KpadMo40i
         p6UeD84yMXOpXUkkFEDtiiudD1A3LpjyqYUtpDkYrkJcXb8NYl47R+KajSVslhfH1w
         pkUQQ1lzqQQNK5Np2bLFcJu/Hu4eDsYig4sC+ECAreli0mWSniPayBhurrtJkonB2m
         yeheHXLp8LyZvj47sjaHOUmrUrH5i7nbdZO4psXKl7m6y2wD0wCFh0uBvOBSo68HlY
         RbfyG1wzHnFnfXz0ZVAuBPEaCLZtsr8TKo6CKIhZ37Zii2R/YW8
Date:   Wed, 2 Sep 2020 01:33:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation
 database
Message-ID: <20200902013351.GD241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
 <20200830221004.GB241078@camp.crustytoothpaste.net>
 <xmqqsgc3h28s.fsf@gitster.c.googlers.com>
 <20200901073827.GA3967005@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20200901073827.GA3967005@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-01 at 07:38:27, Jeff King wrote:
> Likewise. Looking at the output, I'm confused how it would help with
> things like searching and refactoring. It might be nice to spell it out
> for those of us exposed to it for the first time (I tried following the
> links but remained unenlightened).

Traditionally, editors had to learn about every language if they wanted
to add special functionality like refactoring (e.g., renaming "struct
foo" to "struct bar"), finding all the instances of a type, finding
where a type or function was declared, or similar IDE features.  When
Microsoft developed Visual Studio Code, they decided that they did not
want to implement this functionality for every language under the sun,
and instead developed the Language Server Protocol[0].

With LSP, each editor needs functionality to speak its portion (either
natively, as with VS Code, or with a plugin, such as Vim's ALE) and each
language implements a language server to implement its part of the
functionality.  The protocol is capability based, so implementations can
support those features which make sense for their editor or language and
omit those which don't.  This way, all editors can benefit and language
communities can implement one program to provide features, and the
problem becomes an O(M + N) problem instead of an O(M * N) problem.

In some languages, like Rust, it's pretty obvious how to compile your
project: you use cargo, the built-in build tool.  There is also a
standard layout to find and enumerate files within a project.  However,
C is not so standardized, so clangd, which is a clang-based C and C++
LSP implementation, needs help to find out which flags are needed to
compile, and therefore find the header files to make sense of parsing
the C code and implementing its side of the protocol.  That's what this
patch implements.

I use Vim and ALE extensively, and it pretty much just works for most
languages, including Go and Rust, once you install the LSP server.  Git
is one of the few projects I work on which is still C and therefore
needs help here.

Hopefully this is at least more enlightening about the functionality
that clangd provides, why it's interesting, how it works, and why it's
valuable.

> I'd also be curious to hear what advantages it gives to add a new
> Makefile knob rather than just letting interested parties add -MJ to
> their CFLAGS. Is it just a convenience to create the concatenated form?
> It seems weird that projects would need to do so themselves with sed
> hackery (i.e., I'd expect whatever consumes this json to be able to
> handle multiple files).

I believe clangd does need the concatenated form, and at least the ALE
plugin for Vim uses that specific file name to detect whether clangd
should be used.  The problem is that clangd doesn't know where your
source code is actually located and it's very expensive to traverse an
entire repository which might contain literally millions of files if
you're only really interested in a handful.

[0] https://microsoft.github.io/language-server-protocol/
--=20
brian m. carlson: Houston, Texas, US

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX072fwAKCRB8DEliiIei
gejbAQDNLkF3yv5l/mUdKEql88Chy8u+/3y/l3GfPQGHslbK6gEA7Gqquv4tTlhv
6lxfUh527celAbq5mHSijX/SfUoJYQU=
=1ccn
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
