Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0057D1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeA1UQ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:16:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752437AbeA1UQz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 15:16:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B6B660431;
        Sun, 28 Jan 2018 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517170614;
        bh=NskvI+eGieUmIdHH5Lxy/emg6Pu+qMUh3H5qfEhD7Kg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x3keN2O0NAuHaQU+Iv9SIcVFxzmZT2STPPVNhAEVSQdfQiRzQMaNwXyj4rwu2FOQ8
         jo2NLYzNFPQwyKV9W2YqXwKOlELbZsz2QejFFLbYALgCq45pxCbBbTjObr/g5pAOU6
         4wKk+oveOw+cCUbsa00/NUrlIxM6STGcgo+qhZ4vByti+qx7DotS8wZiYu9eKCyWhT
         YXuS1QqTLjsuD85UEZrKTXKvcEhx7q9H0dqdnzT3smv+qTUbxAv+tzI5nDAxBtrtX+
         MRxhUgdFPnJ0ln5lbITRnlAqACpL0B8ypafQ/3nVPRoeYanDPA5aLogoBZpjLlZVQG
         uKy8xQggSPn1/YNAqqqvjXb0qTnRb9p9KSKpL4OjEPvplHPJ+t1HkEjzwIY3ae+4u2
         g70p3d0NBiYnqCvtFgTs9VXUDSUBSWJtjJ3t6AqP7COGqKfYl7kqd66zlo1XwYtppr
         qVQXGuQVdRK9fLeqpwh6JAIPiQTpPRGRtBOyBV/HI9Q4iZrGixb
Date:   Sun, 28 Jan 2018 20:16:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/12] hash: create union for hash context allocation
Message-ID: <20180128201648.GK431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-3-sandals@crustytoothpaste.net>
 <54b29396-d994-7afd-9c18-83fca8e4ad6f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
In-Reply-To: <54b29396-d994-7afd-9c18-83fca8e4ad6f@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 08:57:21PM +0100, Patryk Obara wrote:
> On 28/01/2018 16:57, brian m. carlson wrote:
> > In various parts of our code, we want to allocate a structure
> > representing the internal state of a hash algorithm.  The original
> > implementation of the hash algorithm abstraction assumed we would do
> > that using heap allocations, and added a context size element to struct
> > git_hash_algo.  However, most of the existing code uses stack
> > allocations and conversion would needlessly complicate various parts of
> > the code.  Add a union for the purpose of allocating hash contexts on
> > the stack and a typedef for ease of use.  Remove the ctxsz element for
> > struct git_hash_algo, which is no longer very useful.
>=20
> Overall, I am OK with this approach (it's straightforward change and
> cleanest way to replace direct calls to git_SHA1_* functions), but just to
> play devil's advocate: OpenSSL decided to sway users into heap allocated
> contexts, citing binary compatibility issues if they change the size of
> context structure. [1]
>=20
> I think we might need to revisit this design decision in future - perhaps=
 as
> soon as we'll transition away from calling git_SHA1_* functions directly.

The approach I took was to keep the code as similar as possible to
what's there already.  If our hash implementation wants to use pointers,
it's okay for it to define git_SHA1_CTX to a pointer type, and
everything should still work.  We treat the type as fully opaque anyway
(outside of the actual hash implementation).

> > +/* A suitably aligned type for stack allocations of hash contexts. */
> > +union git_hash_ctx {
> > +	git_SHA_CTX sha1;
> > +};
> > +typedef union git_hash_ctx git_hash_ctx;
> > +
> >   typedef void (*git_hash_init_fn)(void *ctx);
> >   typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t =
len);
> >   typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
>=20
> I think it would be appropriate to replace "void *ctx" with "git_hash_ctx
> *ctx". This way we can avoid unnecessary casting in git_hash_sha1_*
> functions.

Yeah, that does make more sense.  I'll make that change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpuL7AACgkQv1NdgR9S
9ov5/g//eAfn8JFurvIi1ns/iFb4VmzpyOOQ8zfY0AUoaSCZFq2kSUa6796gY/4A
mcfHnitHmspvgpajLx+ESNKX79JjdDAmMG/jU2C1J/Pw1KaqHyLYe4qDICGjDQIn
W4KoNkGu4Ds1JdVCx7KRFSUZV/50qMeYM6T79gNYnC3xqNueSYq/TDcAMWnJgkIK
S+6aRUMXAKyqulFZCIcPBBqJ6Ymn4wVmVO+dUASBBjIBn+ezJHDwcs1Uzj8OMFtI
gtw8faVup74MRz/Y6XFp3RRkYY2ANngHh4Pkkvvj3eh0yfIKBML6+b2hbMvq6YmD
3wOlaUDlU75k4ayqvuVB8slwQszIF0D+cdScUd/AdnlIawiXK2TBlwc9br3yOdmg
fUGGdgtAiem8DFX2EfR2S1tJmilbXq9tcLipqGaAUyAQ5gKIiV/fpUGsmfaHhZy3
2k2lwZo0l5oXZ1k80AFjKcAEKIFGU3WXm/X59NTAfFnX7SCRqcAn8t4k45Dp9XY+
xK1Sf75l9DX8iQvHUQyLHq/0c0YtqOqs7EV8V81Rybh5sli1eFaHr37y7Y75b0zu
C05htLrFZrEnVg7mBdElr2N5cP0QXIxOH/g4MdMOxBgUNbbXaBcwYva17CbAz/4G
+slWt63FCn5W0P4kyQ7dgNbhY0nPQWZ2NSIHuOzXjdPX3yCsR60=
=jrPa
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
