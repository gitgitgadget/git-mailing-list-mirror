Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CCBC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DF120787
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 23:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g+DUmK5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgDOXs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:48:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37200 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgDOXsx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 19:48:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A361E6052F;
        Wed, 15 Apr 2020 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586994532;
        bh=5NQOPSr1KzWCJHf761Px08z3TKrWUcxYqzqkLY7xA7U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=g+DUmK5YdYiB9RrfX2Yt1FTDQM1B7DV55pzM5qNAouKmdb8jxFdDENycZY5okybzL
         ghZV2G2NP1Bz8Ej2eVbPREF+rVsqMjAT9RnGZQwM5QmM0ew9xlVRTIAZDZQTXdM/9k
         bcvFQ1PfgKbtTZIQvyiTjXnkObKrv0wIC+iWPw3UE6ppJ85CrGjD69SjxABIjqKprK
         b5MNuKkUBfJ5fXKYuQP0HN9SdH8g+R7MnQPa6tWL8fSKzJm+EJlzDzzvOyvS93YnzT
         +KCFbY8eHhgFYn9VLQlX5devCejCZRAF1WHgOFfbSESO+gAegQoQZ2N/O9u1nh7GF/
         rFy9XFr/erkbiu6m52/1YnzhOU9thaI8vfbGsW68EIY9HDGv6nmORMIcFBSCN9Wkj3
         +QovW72RBVdhAuFx14mHsZzLfEAzy5jM5wIREHZ4VFWslRR+4JF1LmpUmvE2Ql/Iew
         k1M/ggZl/r2lTRPDPJFX8tTHmTwUD7BhKvXoJT40bm9Y1O0oXc7
Date:   Wed, 15 Apr 2020 23:48:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     luciano.rocha@booking.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/1] freshen_file(): use NULL `times' for implicit
 current-time
Message-ID: <20200415234847.GI2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, luciano.rocha@booking.com,
        git@vger.kernel.org, peff@peff.net
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
 <xmqq4ktk5t4h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <xmqq4ktk5t4h.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-15 at 21:36:14, Junio C Hamano wrote:
> luciano.rocha@booking.com writes:
>=20
> > Update freshen_file() to use a NULL `times', semantically equivalent to
> > the currently setup, with an explicit `actime' and `modtime' set to the
> > "current time", but with the advantage that it works with other files
> > not owned by the current user.
> >
> > Fixes an issue on shared repos with a split index, where eventually a
> > user's operation creates a shared index, and another user will later do
> > an operation that will try to update its freshness, but will instead
> > raise a warning:
> >   $ git status
> >   warning: could not freshen shared index '.git/sharedindex.bd736fa10e0=
519593fefdb2aec253534470865b2'
>=20
> A couple of questions:
>=20
>  - Does utime(fn, NULL) work for any non-owner user, or does the
>    user need to have write access to it?

The Linux man page says the following:

  Changing timestamps is permitted when: either the process has
  appropriate privileges, or the effective user ID equals the user ID of
  the file, or times is NULL and the process has write permission for
  the file.

So the answer is the user needs to have write access with utime(fn,
NULL), but the same EUID (or root) with a specific time.  I believe this
behavior is because it doesn't make sense to restrict the operation
which uses the current time since a user with write permissions could
just run open(2) and write(2) instead with the same effect, just less
efficiently.

(We've discussed this on the list before, but "appropriate privileges"
is POSIX-speak for "root access" or the equivalent in an alternate
system, such as capabilities.)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpedXwAKCRB8DEliiIei
gZ4hAP9t2+uPUNzjcDeTQm0DS9NuMbowQhRLmfwzHMA+INpL0wEAyzH/ZYVPpS1f
aSDLVoMGZkQTHeaEBwazMsWpLSINEwQ=
=andx
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
