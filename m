Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9942D211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 01:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLDByy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 20:54:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56926 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbeLDByx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Dec 2018 20:54:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c029:e61c:1a0c:a1e6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0E39460100;
        Tue,  4 Dec 2018 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1543888491;
        bh=gvhERbEHHbm40lmJoWwz34AUK7ghCUjdS5nskh7xq4U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AC8HYi3B5BMpczSKT+oEmQylC5Njd1chODnrRV3DfrnlhCj7hULwP53v5eb1fufzr
         vukaSfIm9nznlw0LgUYnwQaqmIYZo3XXXc/O2gdafspwoCymoHii3RUNHU335zDZx5
         BGYRC1V3qpoJmxPGbqk8aSpLm6ob6j43fb+TfMsV2LW+smz0Xg/gsJvMeF80rkIStB
         xC1e7jYrXytdIGGCcA3uEr5QQkVuLDyW109HmHfoLpoo4iF5JUgk2O7logIxghA19J
         STsds9o1e0lwMbu7faRgXsmpaAl0mm5eyIIQ2vA9kuNAdGXi9DlrNj4NRnm9r2cbd9
         5slBPRJKht7Nnv/7F84qQTNOf8IszKhEmz8xaItRG009D4U+KK7PdZCyRy3QtBCubW
         W8O2/SNCR1x7mFjl/B5lnu3JAASfvz+cOeu9MbR/jNPtSYjGv3E3zo5fsrPH2IT6HM
         eAf1OIW61ITkGhfyRZHHvmzH34JyGe+bv7xBUjThIp92N0Nez2y
Date:   Tue, 4 Dec 2018 01:54:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
Message-ID: <20181204015446.GX890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1543879256.git.jonathantanmy@google.com>
 <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s8wpp40TDz0KNMmP"
Content-Disposition: inline
In-Reply-To: <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s8wpp40TDz0KNMmP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 03:37:35PM -0800, Jonathan Tan wrote:
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/packfile-uri.txt | 83 ++++++++++++++++++++++++
>  Documentation/technical/protocol-v2.txt  |  6 +-
>  2 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/technical/packfile-uri.txt
>=20
> diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/tec=
hnical/packfile-uri.txt
> new file mode 100644
> index 0000000000..6535801486
> --- /dev/null
> +++ b/Documentation/technical/packfile-uri.txt
> @@ -0,0 +1,83 @@
> +Packfile URIs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This feature allows servers to serve part of their packfile response as =
URIs.
> +This allows server designs that improve scalability in bandwidth and CPU=
 usage
> +(for example, by serving some data through a CDN), and (in the future) p=
rovides
> +some measure of resumability to clients.
> +
> +This feature is available only in protocol version 2.
> +
> +Protocol
> +--------
> +
> +The server advertises `packfile-uris`.
> +
> +If the client replies with the following arguments:
> +
> + * packfile-uris
> + * thin-pack
> + * ofs-delta
> +
> +when the server sends the packfile, it MAY send a `packfile-uris` section
> +directly before the `packfile` section (right after `wanted-refs` if it =
is
> +sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation=
 of
> +this section.
> +
> +Clients then should understand that the returned packfile could be incom=
plete,
> +and that it needs to download all the given URIs before the fetch or clo=
ne is
> +complete. Each URI should point to a Git packfile (which may be a thin p=
ack and
> +which may contain offset deltas).


Some thoughts here:

First, I'd like to see a section (and a bit in the implementation)
requiring HTTPS if the original protocol is secure (SSH or HTTPS).
Allowing the server to downgrade to HTTP, even by accident, would be a
security problem.

Second, this feature likely should be opt-in for SSH. One issue I've
seen repeatedly is that people don't want to use HTTPS to fetch things
when they're using SSH for Git. Many people in corporate environments
have proxies that break HTTP for non-browser use cases[0], and using SSH
is the only way that they can make a functional Git connection.

Third, I think the server needs to be required to both support Range
headers and never change the content of a URI, so that we can have
resumable clone implicit in this design. There are some places in the
world where connections are poor and fetching even the initial packfile
at once might be a problem. (I've seen such questions on Stack
Overflow, for example.)

Having said that, I think overall this is a good idea and I'm glad to
see a proposal for it.

[0] For example, a naughty-word filter may corrupt or block certain byte
sequences that occur incidentally in the pack stream.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--s8wpp40TDz0KNMmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwF3mYACgkQv1NdgR9S
9ov1kw/+NcqTGACKrB3lrLXBuZjX9P9wQaZZKG/0lpbteSjCj+GAi4ULZPSv6SpL
AKE6T6kB9KD8Kqi3L37G10CoOrrJ2wD0w2I3U7fu4bAp49iGPsiedKtR3xEFtVDX
cskW6fGWIJ8D8OAZr4yYmOGHQUr27B8TtQgC7/NuD01GZt2WHWMJFl3TkZj91uCI
3Ozxtx/8E9Xju4m8fnXY5XHb04fmhMDx6ku5nZqFn084gqJ3+TPgZfl2XPKkq11c
syKWU1St+81UbhsafdsszFOi4lGNJEy7Y+YkMCc2MJfuU6HfNp/oSMVtXRw2zgaA
AxEToYFWHqws26DFGGlfy9lcpHYESQBoeDTSqZXLhDyV1Rn7wfcqVCok7dGRJuPB
zVzL3B7zGropExSka390Pw2NqmkG5roam2IyyM4kbA2Qv46bFK0glIa5d98XXQ/y
ExUP5ZgITp248muc9r7SqINIZfKk4mSh/5WWJhuULISpiWlmx3kRnAgHt691OZkd
yW5LFs8nXfoKkybl+aXYunNuYQBoC+Dzf2rzBPBhuRC67iZ7ll8PdinqrVMg90nU
tlEps887RSRAjp0g1/mugTvzfsR7Po20ke+BuNEmbRbJ6+2BPGf3iSyLP+CSwlMv
jIqpxNbgmS2zKByLnLNt2QpBn7X/UZvgTZq07sQCJpA6nIq7Gf4=
=NolY
-----END PGP SIGNATURE-----

--s8wpp40TDz0KNMmP--
