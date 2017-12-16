Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F041F406
	for <e@80x24.org>; Sat, 16 Dec 2017 22:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756904AbdLPWBa (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 17:01:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56658 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756877AbdLPWB2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2017 17:01:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C915A6045C;
        Sat, 16 Dec 2017 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1513461687;
        bh=+s9vDxebyrveHcQ/D+R4Z1GpV1arBbAlVfpAq8N61xs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eNsl7xUQpHjVBoRrJVmnuNZK+hQEe+YomybDpGv3kY7i5BdmGJqAChHuneGSBEgSZ
         2wuc6q2Ylk/MszQkTdFxVuHUJBJJnjT+mvLpnfO0wgYIs4DMiN+4omD87ph1BnI269
         4ZqYX3AaSQITCIgiGfj91utTbdHBrdydnb09Sp5C/5RfBZjUtKgF2OziM3wRRj3oxr
         xBR0o9g1y6lNsrDkk7S1jSFTe4N8Uyzin7bNIhUkh8XZFVGWtcT+J58FPy3fsOFhIz
         YIGvI/s6YHQQEEPTGA4ZcI0JWlGw6qi+6AkgbpC6glAg3VtQh+R2hZP/kXqRomkgh8
         ONQ1+CMXVsi56AYvLxnPpqQ8vDb7eK+S3zK1g5jUC2pnJ6AHcBRIO85jPipQfidyWd
         1MF79vuskutzecvbvtIJzPfhne6Zd8Ps9GiPEDh/ePU9gxhN/nRUs7B2kv+T/fi7wa
         4oAVDiqU+j5sXY+HJacvFh/qmuKM7nbdCzSi1k2+WKHOBzbeQYh
Date:   Sat, 16 Dec 2017 22:01:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
Message-ID: <20171216220120.GB6217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com>
 <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-1-amd64)
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 05:05:01PM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > As for "git config --global", I think the best thing would be to split
> > it into two options: something like "git config --user" and "git
> > config --xdg-user".  That way, it is unambiguous which configuration
> > file the user intends to inspect or modify.  When a user calls "git
> > config --global" and both files exist, it could warn that the command
> > is ambiguous.
> >
> > Thoughts?
>=20
> I actually thought that the plan was "you either have this, or the
> other one, never both at the same time" (and I think those who
> pushed the XDG thing in to the system made us favor it over the
> traditional one).  So as long as --global updates the one that
> exists, and updates XDG one when both or neither do, I think we
> should be OK.  And from that viewpoint, we definitely do not want
> two kinds of --global to pretend as if we support use of both at the
> same time.

Sorry for coming late to the discussion, but I actually use both.

~/.gitconfig is checked into my Git repo for my home directory and
contains settings I preserve across all systems, and the XDG dir is not
checked in and contains per-system settings (currently just
commit.gpgsign).  On my main systems I have a key and sign commits; if
it's just some server I log into, I don't.

Now, I don't use git config to set options, so I'm happy as long as git
config can read both, which it does.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.3 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlo1l7AACgkQv1NdgR9S
9osTqw//QIVTXm1uqRelsp7p3/G/UGsis9Ws06OBqtuNEuQyRc1cC9LuFdpvP9Yi
6YM6nTuA239SufmrBqvZUH+yo7fIUkiU4KhtFomu2B1y06ZwSKxTXpxBd3XLXn65
SO8L59uNtHUO1NK8JLmC8NDTc/Zvtnu2RaucMbcUgvGCRfv8Cil/QNyNLp1aaLrI
CsEo8e+6ZWSkHk9oybi4CpZ6SnSA7S7guK+wb7nmFWd/qUGEowm3MF2cHLOXRCAd
CFCn92rJkFP2R3Blgz3mh7zJ8+8nnR/o3rmp03VRm9w8dWBPaCpzzq164bwFqt1m
ekpPizG02zMZOknbfs9pf0oD5BYUZRgBA1/O3BE3biQi1/nWn26RFZPEeCZcwuVR
gweebgnJsm0GrLF2XxjfKAj+tDg0NvA17CoTw92svH6R8bR2dZAnogbzLhRb0CmE
cWxyfK+UICNwGFi7JuD/CUeiV8LUOUBFaPp3deOqO3BjQJr6TjvJ9D4ZljtGiTFg
aoYhYYmB6piGIWgg7sIT7Nx2Ro5SK9VHKF9snR5hXMoER67pDQO6RZpvNadJicot
urgsqSLVLs2OSIJp6B+WTxR535HyjN8JQYLH8IRXPiW0I2rB/0mq3FosDXZdTORO
oiNXbQBYj40/RZpVc55lkMEXieb6kHdJ0qpqGIcy+f2NijBZnuc=
=PBxm
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
