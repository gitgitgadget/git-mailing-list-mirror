Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C49ECAAD1
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 00:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiH1AjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 20:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiH1AjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 20:39:04 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4073C16A
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 17:39:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AB0DF5A26C
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661647142;
        bh=6RUua6yAXFRtjijYe3wSnsMVqKMVQ10tfGPcFuyBNFI=;
        h=Date:From:Cc:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kLrDZ+GfGSn6717AvTCuH5+AMFrT8gNE87flnsS+NkkZyAyIG5WwuY0lngmh12EKV
         x7/kx4H7PbZC909LOCsXsZsQubPcIlolVM+lF380CxDbnhEyuON6lYASUvusP3oZ24
         H7Y+eXjtmF1G70yDouvYgAii5f7baO7KrxBA1nX8j0bEzsRHVsef8T4DbkCec9BKMJ
         nf+rhjz/Rp2wT3aSpcNcpzawDQ4u+DxvcQ4eE+9AhqXQUdaF5b7AhGK0D2atw/wH5f
         YC0h+42praqtDv+BAl5tvb4iFfvbzO/jZ5n8zXsikPEbD53kAhUo07ukZ4mBxGOuoH
         7Tu7YD9vTArr9FMK6HaFcGrh3AFWLOhnfwBNMx9nIJeC9mWkzi2Jey/rw4UqU2enxB
         H6ESiQxl0j1mqas32IfN6Sqm2TqdsnboG2zvxRM6ZyZRrdFuQiBce+XQKsa9m+nlm6
         s2guYHCfMqWJmYNJN9m3VXbiJtr+LK5Mozmkc8XX5aVAoqJNUz8
Date:   Sun, 28 Aug 2022 00:39:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Proposal] Pass additional metadata to sendemail-validate hook
 from git send-emailg
Message-ID: <Ywq5J2q9PwBrXnrm@tapette.crustytoothpaste.net>
References: <87czcm7maf.fsf@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tEq59MVacIwtNPJM"
Content-Disposition: inline
In-Reply-To: <87czcm7maf.fsf@amd.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tEq59MVacIwtNPJM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-26 at 21:00:25, Strawbridge, Michael wrote:
> Hi,

Hey,

> I was hoping to put a feature proposal forward for git send-email.
>=20
> For git send-email there is a git hook, sendemail-validate which
> gets the body of the email that will be sent but is missing some
> of the metadata that git send-email has access to.  I propose that
> we also pass the extra metadata that gets presented to the user
> later on via stdout such as: From, To, Cc, Subject, Date,
> Message-Id, X-Mailer, MIME-Version, Content-Transfer-Encoding to
> the git hook.
>=20
> I'm willing to work on the patch but want to make sure the idea
> would be accepted first.

I think the idea is interesting and would be willing to see a patch come
to the list.

However, having said that, we typically evaluate patches, not proposals,
so to see if it's actually accepted, you'd have to actually send a
patch.  We may find that while the idea is interesting, it turns out to
be infeasible, or, for whatever reason, the patch is unsuitable.

I know that this is different from how other projects typically work,
where you typically pitch an idea first and then implement, but it's
what we do here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--tEq59MVacIwtNPJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYwq5JwAKCRB8DEliiIei
gRKzAQDXgrI7s7n9PMd21Iwk1m3M81n5dOG5ZDkDzyvxbGHnMQD5AXX95HbxZzDN
44C8LS8DJ/m9ogin44Avopc5WbgUrgE=
=CmnP
-----END PGP SIGNATURE-----

--tEq59MVacIwtNPJM--
