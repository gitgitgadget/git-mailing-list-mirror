Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA70F1F461
	for <e@80x24.org>; Tue, 14 May 2019 01:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfENB7i (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 21:59:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36504 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfENB7i (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 21:59:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6BF3360443;
        Tue, 14 May 2019 01:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557799175;
        bh=YkYq2DS+8Istyd40EvC1tOyZq76tERNWDCtikqFxsxg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ypz8ieuwMh56s8W/GfJ8qcGge2KNOccPQgKI4iv1PADqwMyV7G0OKH3bwQdHpkKDS
         eCuYNbBFMfwlcMT1e2BVIiyRJFf892gIInc/Eo0BBKnpV4FAyK0AfJF4gPKhb8sdit
         QqB11aj5ZXxOJl4X++9c2b4cO4KzZoR7h3022lNDjifqjN48h+ImamjftSCH9UWyKQ
         BdEhvaT9q/rPkKEnm8ioOwR5g9QMBjvvmKFmnKDdb6OfqwM3wJbbNUu9xl+DqPH/Ci
         ncK7ku12vh1YpuHrZoVp6HEkBvE+rbub5eADWHUcL9SQAP6GjqFkdBCb30FhCcF8ND
         8i7b0IkRr2Y+kXIEgxfJx6i63x3mtNNVR7CnDI5w9YTPDo68VgA//5vDbnkQPYXJfm
         jmjF44T4ofjKPeMQNzF8fl96bqrHjCywKnFAE3shncnqw3qcFJ8GsRBtKJ0gx69hPw
         wi2JKSmANfRJlZAUdBj9UvTlgQ4l1OL01f3k2/RI8ZB1hMpxEo8
Date:   Tue, 14 May 2019 01:59:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
Message-ID: <20190514015928.GG7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514004920.GB136746@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <20190514004920.GB136746@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 05:51:01PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
>=20
> > I've thought a lot about the discussion over whether this series should
> > use the configuration as the source for multiple hooks. Ultimately, I've
> > come to the decision that it's not a good idea. Even adopting the empty
> > entry as a reset marker, the fact that inheritance in the configuration
> > is in-order and can't be easily modified means that it's not likely to
> > be very useful, but it is likely to be quite surprising for the average
> > user.
>=20
> Can we discuss this some more?  What would it take to make it likely
> to be useful in your view?

There are two aspects here which I think are worth discussing. Let's
discuss the inheritance issue first.

Order with multiple hooks matters. The best hook as an example for this
is prepare-commit-msg. If I have a hook which I want to run on every
repository, such as a hook that inserts some sort of ID (bug tracker,
Gerrit, etc.), that hook, due to inheritance, *has* to be first, before
any other prepare-commit-msg hooks. If I want a hook that runs before
it, perhaps because a particular repository needs a different
configuration, I have to wipe the list and insert both hooks. I'm now
maintaining two separate locations for the command lines instead of just
inserting a symlink to the global hook and dropping a new hook before
it.

I don't think there's a good way to make it easier unless we radically
customize the way configuration is done. I don't doubt that there are a
small number of configurations where the inheritance behavior is fine=E2=80=
=94I
believe GitHub's backend is one of them=E2=80=94but overall I think it's ha=
rd to
reason about and customize.

The second issue here is that it's surprising. Users don't know how to
reset a configuration option because we don't have a consistent way to
do that. Users will not expect for there to be multiple ways to set
hooks. Users will also not expect that their hooks in their
configuration aren't run if there are hooks in .git/hooks. Tooling that
has so far used .git/hooks will compete with users' global configuration
options, which I guarantee you will be a surprise for users using older
versions of tools.

The new behavior, which puts everything in the same directory
(.git/hooks) is much easier to reason about. I think we're obligated to
consider the experience for the average end user, who may not be
intimately familiar with how Git works but still needs to use it to get
work done.

It also provides a convenient place for hooks to live, which a
config-based option doesn't. We'll need to invoke things using /bin/sh,
so will they all have to live in PATH? What about one-offs that don't
really belong in PATH?

> > I think a solution that sticks with the existing model and builds
> > off a design used by other systems people are familiar with, like cron
> > and run-parts, is going to be a better choice. Moreover, this is the
> > design that people have already built with outside tooling, which is a
> > further argument in favor of it.
>=20
> To be clear, the main advantage I see for config versus the .git/hooks
> model is that with the config model, a user doesn't have to search
> throughout the filesystem for .git/hooks directories to update when a
> hook is broken.

I agree this is an advantage if they don't hit the ordering issue. I
think a lot of the common use cases where this approach has benefits can
be handled well with core.hooksPath and hooks that can turn themselves
on or off depending on the repository config.

What might be an interesting approach that would address these concerns
is a core.globalHooks[0] option that points to a set (or sets,
depending) of multiple-hook directories. We then enumerate hooks in sort
order, considering both the global and the local directories as one
unit, perhaps with some way of disabling hooks. I'm not planning on
working on this myself, but I wouldn't be opposed to seeing someone else
work on it.

[0] Better name suggestions are, of course, welcome.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzaIQAACgkQv1NdgR9S
9otrLRAAxILe/C4UIakEhIAc03n6OWDk0K41BRX2yEQ3n67m1ht4q8lEE2Q1h3Zs
d8iITvCYDIrUDPqkjsly+9fJ6FwshLRM6Oq+8x/h8Fsrc6l0RTA4lCzztVmWhC8r
ZeVUvEfYHSm1N+jCN1WJNv3dZ3bPkcicGKxayuIFDkvkWQSyZYZRw7KrGzmgEClq
UTHTGFwxBEWNSBPvwKA17qT1iOGzkBcF03PzHi4+uitL86pfe101aw2sTq1Uo8wL
j0qZL8wKwit4wbUOMVZZ4QTvYWSBlU/22NTWC0bi+kfZlHNFmf1Mpnmer39s5BMT
toSxtUpWD+RTSzc2Fxlule7MJ4lh8/ci7Wg4oQu0javuVZQvJxfWUCXzLEH4MoKR
mwbJ7EhL6ETVKk2FBGTVATFGKvaygIVSlSk6XtZ15XidxnLgfQ44EafRAVE8ewEp
N49veOSTVqmXDIaKjeFY+p49Z6uUTvOOXkDaD3Yf585j7bVU+ti/z4kaQgwwYeYq
8qPK9en3Zu7nyXr0MTiMdSQ0dDaJB950gl+gS2XXH7W6igJg7OV0T5t6Sn0BgAVD
zSDgnPLNmQk0wO7xZ83Isj49rial8uZE3OOW/CW1C5F3ceEdHuUwUhByH0tWzXI3
FPCs8LOn/H0tHSy+4oYThyxY5OUd3upp+TLpCxy9ZBqXlokzmgs=
=KbNq
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
