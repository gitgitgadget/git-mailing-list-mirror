Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFFAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DB46127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhHXVtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:49:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhHXVtU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 17:49:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C49E96044D;
        Tue, 24 Aug 2021 21:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629841715;
        bh=OaIe2GDLg2w7+5uD0t6HssEmRJPr2t6DveewhaVzYbE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zyUP2hWMj4G87LDdvi4yw/sQRUZtdf3ghpdeb+B2hl91xV9hjfByezFRk8YEhXhPU
         FXyC4Y2lCWY5/B3DmDVNPyAbQH4BRuML9ojTlGphhYibRBDZSmZl+dqugdW3oLAOct
         MmXgGJ2VdfeGpAFIGqztyfSQnDMmLwgtxhUmbrt6mq3EochKi6lvNRSUPnJVA0wCvG
         FYfEYu+1IhhRN779yXycMTH2C0zRMPxLM603GuN3GGSJpBCq968fCKYtVbb3APaVjx
         TOj+tVUu1K7J3b3c8CI06HuA8Yjgc9tEOUimx5wQT7iEdHKXUac79+19SFiBGC3GQR
         kEP4Z6Ne22SRUlLy2s/+GHQDMLgRceeZqL8ikGlXv7i6z9kaUcVu8U7TzFj/pCB/j+
         GrJG0rkjcdNirc+4rnEfm1at2Ic8D7kPkBkHDGwl5YuHzjc5ujiQfghltlVg6Klfcz
         6BqtsVE5f8abQOcxWjQB7BXbKk3dR0FF9AaFIpyA1S2+FtMcg+6
Date:   Tue, 24 Aug 2021 21:48:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 13/13] bundle-uri docs: add design notes
Message-ID: <YSVpLjAhhS8v2dR7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <RFC-patch-13.13-1e657ed27a-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rO/GQidGZfXCVLp0"
Content-Disposition: inline
In-Reply-To: <RFC-patch-13.13-1e657ed27a-20210805T150534Z-avarab@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rO/GQidGZfXCVLp0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-05 at 15:07:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Add a design doc for the bundle-uri protocol extension to go along
> with the packfile-uri extension added in cd8402e0fd8 (Documentation:
> add Packfile URIs design doc, 2020-06-10).
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/technical/bundle-uri.txt  | 119 ++++++++++++++++++++++++
>  Documentation/technical/protocol-v2.txt |   5 +
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/technical/bundle-uri.txt
>=20
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/techn=
ical/bundle-uri.txt
> new file mode 100644
> index 0000000000..5ae9a15eaf
> --- /dev/null
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -0,0 +1,119 @@
> +Bundle URI Design Notes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Protocol
> +--------
> +
> +See `bundle-uri` in the link:protocol-v2.html[protocol-v2]
> +documentation for a discussion of the bundle-uri command, and the
> +expectations of clients and servers.
> +
> +This document is a a more general discussion of how the `bundle-uri`
> +command fits in with the rest of the git ecosystem, its design goals
> +and non-goals, comparison to alternatives etc.
> +
> +Comparison with Packfile URIs
> +-----------------------------
> +
> +There is a similar "Packfile URIs" facility, see the
> +link:packfile-uri.html[packfile-uri] documentation for details.
> +
> +The Packfile URIs facility requires a much closer cooperation between
> +CDN and server than the bundle URI facility.
> +
> +I.e. the server MUST know what objects exist in the packfile URI it's
> +pointing to, as well as its pack checksum. Failure to do so will not
> +only result in a client error (the packfile hash won't match), but
> +even if it got past that would likely result in a corrupt repository
> +with tips pointing to unreachable objects.
> +
> +By comparison the bundle URIs are meant to be a "dumb" solution
> +friendly to e.g. having a weekly cronjob take a snapshot of a git
> +repository, that snapshot being uploaded to a network of FTP mirrors
> +(which may be inconsistent or out of date).
> +
> +The server does not need to know what state the side-channel download
> +is at, because the client will first validate it, and then optionally
> +negotiate with the server using what it discovers there.
> +
> +Using the local `transfer.injectBundleURI` configuration variable (see
> +linkgit:git-config[1]) the `bundle-uri` mechanism doesn't even need
> +the server to support it.

One thing I'm not seeing with this doc that I brought up during the
packfile URI discussion is that HTTPS is broken for a decent number of
Git users, and for them SSH is the only viable option.  This is true for
users of certain antivirus programs on Windows, as well as people who
have certain corporate proxies in their workplace.  For those people, as
soon as the server offers a bundle URI, their connection will stop
working.

I know that you're probably thinking, "Gee, how often does that happen?"
but judging by the number of people on StackOverflow, this is actually
very common.  The antivirus programs that break Git are actually not
uncommon and they are widely deployed on corporate machines, plus the
fact that lots of companies sell TLS intercepting proxies, which are
almost always broken in this way.  Many of these users don't even know
what's going on, so they simply lack the knowledge to take any action or
ask their network administrator for a fix.  For them, HTTPS just doesn't
work with Git, while it does for a web browser.

So we will probably want to make this behavior opt-in with a config
option for SSH, or just not available for SSH at all, so that we don't
magically break users on upgrade who are relying on the SSH protocol not
using HTTPS under the hood[0], especially the users who won't even know
what's wrong.

[0] I can't tell you how many times users have complained about the Git
LFS SSH protocol also using HTTPS implicitly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rO/GQidGZfXCVLp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYSVpLgAKCRB8DEliiIei
gVilAPwLGDjCDAHyt9oZckhh4C6ilmE5Xq3HCLm/5iKKT55I/gEAgQ0BLiIEL7iJ
O3AOIqULFagX72M8bGZLJjhSIN1Qxg8=
=jXrf
-----END PGP SIGNATURE-----

--rO/GQidGZfXCVLp0--
