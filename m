Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290A31F461
	for <e@80x24.org>; Thu, 16 May 2019 01:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfEPBqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfEPAmm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 20:42:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 12D7760443;
        Thu, 16 May 2019 00:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557967358;
        bh=Crd3b4nuUryLkxPjP++AJ4TP7u5bJJFs5qgOWlaSeY0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UyQv5/+0ZKpYUaZjfvvNSTFrXQRWW2tStgz8dIW2c3Exs19NT/TZYNUaHx65gHcsC
         zHPNk9XrwWqb/wSn/x+XQF1HaFezdxaycyO12AAvgs2364eliPglKljk7tjEzxRCnc
         cE1hFxayek6jvkhXxoQzSfuHy7UucnvLAmf+VBVz1yKnr1XwZwakUJsARjNOa8tGSR
         CdHmSGa4hbBoCuidDvz6ZCqSPmsOPuQEWGEcZLGdyuZoC77omKDtQDMdaYAys4rXz+
         0ueNG/GoE3iL/vPSyUChgSMNcn+cmyZboTeDCPi+zkoisDqL83qyeydq0TTkrI7ZNQ
         vzsa6dpS5yuYe0JnkAXEXmssCy62L+VXh65ymhLtj13NhmzaIodHuPlGSgInlfxCKE
         lQQbnz9M1PXFV4N7+QnLfqkA5pk0RwnNffdnB/kG5/hs6GQzhMtSqYonvNtGu3Yns8
         HH4vsj+aFeQERjZo+lpZ/8WMllBBThitSBi1paw2OtQGSRuRcBL
Date:   Thu, 16 May 2019 00:42:33 +0000
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
Message-ID: <20190516004233.GO7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514004920.GB136746@google.com>
 <20190514015928.GG7458@genre.crustytoothpaste.net>
 <20190514022653.GA34155@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Content-Disposition: inline
In-Reply-To: <20190514022653.GA34155@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 07:26:53PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
> In other words, use the standard config convention for the set of
> hooks, and treat the order in which they are invoked as a separate
> question.  You could even use the hooks.d style alphabetical order
> convention.

If we're going to have named items in PATH, we do not want to have those
items numbered.

> [...]
> > The second issue here is that it's surprising. Users don't know how to
> > reset a configuration option because we don't have a consistent way to
> > do that.
>=20
> I agree that it's underdocumented and underimplemented.  But I'm not
> aware of any other method that Git provides to reset a configuration
> item.  What is it inconsistent with?

Some options support it, and some don't.

> >           Users will not expect for there to be multiple ways to set
> > hooks. Users will also not expect that their hooks in their
> > configuration aren't run if there are hooks in .git/hooks. Tooling that
> > has so far used .git/hooks will compete with users' global configuration
> > options, which I guarantee you will be a surprise for users using older
> > versions of tools.
>=20
> Indeed, in the long term I think we should remove the .git/hooks/
> mechanism entirely.

See, I don't. I like the current mechanism and don't want to get rid of
it.

> In the shorter term, I think the kind of inconsistency you're referring
> to applies to hooks.d as well.

I think it's a lot easier to reason about adding a directory to the
existing mechanism than adopting a dramatically new one. Users can
easily understand that if there's a file, that the directory is ignored.

Also, this is the way that most other programs on Unix do this behavior,
and I think that is a compelling argument for this design in and of
itself. I think Unix has generally made the best decisions in operating
system design, and I aim to emulate it as much as possible.

> > It also provides a convenient place for hooks to live, which a
> > config-based option doesn't. We'll need to invoke things using /bin/sh,
> > so will they all have to live in PATH? What about one-offs that don't
> > really belong in PATH?
>=20
> This hasn't been a problem for remote helpers, merge drivers, etc in
> the past.  Why are hooks different?

Because they're often customized or installed via the repository itself.
Some projects provide pre-commit hooks to run tests or such in a
repository-specific way. Some people have one-off scripts that are
appropriate for a repo but they don't want in tab-completion. Also, they
may wrap a system command with helpful information, but that doesn't
belong in PATH.

Git LFS, for example, installs hooks that warn the user if the command
isn't installed, since it's a common misconfiguration and not pushing
the LFS objects (via the pre-push hook) along with the Git objects is a
common source of data loss. Uninstalling the tool (or not installing it
if it's a shared repository) doesn't mean the hook still shouldn't be
run.

> > What might be an interesting approach that would address these concerns
> > is a core.globalHooks[0] option that points to a set (or sets,
> > depending) of multiple-hook directories. We then enumerate hooks in sort
> > order, considering both the global and the local directories as one
> > unit, perhaps with some way of disabling hooks. I'm not planning on
> > working on this myself, but I wouldn't be opposed to seeing someone else
> > work on it.
>=20
> This sounds overflexible to me.  Because of that, I don't think it
> would end up as a default, so we wouldn't have a path to improving our
> security stature.
>=20
> If I implement a config based multiple hooks feature with name based
> ordering, would that be useful to you?

One of my primary motivations for writing this series is because it's a
requested feature in conjunction with Git LFS. We often get requests for
features that are properly directed to Git itself, but because the issue
comes up in conjunction with the use of Git LFS, folks report the issues
to us. (Also, people don't like reporting issues to mailing lists.) I
think it's a useful feature for others, though, judging by the multiple
times it's come up.

I see the series that I'm proposing as easy to implement and work with
using the existing tools and with other tools that use the existing
hooks. It's a simple change of path. I anticipate there being more work
to implement a config-based multiple hooks solution in various tools,
and I expect it will be less intuitive and less discoverable. I can't
provide definitive evidence for this, but my experience answering a lot
of user questions on a daily basis leads me to believe that it's not the
right way forward.

I'm not opposed to extending the config system to implement multiple
hooks directories or add support for inheriting hooks, because that's a
common thing that people want. I just don't think our config system is
the right tool for specifying what commands to run, for the reasons I've
specified.

I can't prevent you from writing a series that implements a config-based
option, and if it's the solution the list wants, I'll go along with it,
but it's not the solution I want to see personally or as a tooling
implementer.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzcsfkACgkQv1NdgR9S
9ovUixAAjeTOo+KeDuFSaJ9b0g5BT/MSTYK+YsOV61bcTqm4Il6B2rRPBew9dYLV
AXXjYOiM3SJmMN0JdR6eHhJsHmy58mc65j2I9H7j2j7Og+srPxYtyg59fp7S/+ox
va4oNy4bsCDMBaib3dDBO0LMGJaCD9IloSbYDFu2DEejtahNpbbcnSYJ5ZDp3KBv
zVj7mrTUMLk8yBNfwCeZMjYDwD+m1WQvPPXkctlH3mQVQCm+H6+YolgPHa40IPYw
FFwTkY/aWakup8QomesxWWg/7X7f/JQpE5oJBCO9B3bj+RZH6QbqAc/l75YFvqmX
SEgfVc44msfTpl4VJsre+WL8ofR8ITljxzYLnRn/f/hL19jivN8yaoz3rp7mw/fS
UY3PRjPB957KxUrGs9j8/YH7+dFavnGbDUgNoAj4H/5qKE4QjNHwl9KjyzyF5duA
ifFm4B/VPxr16koRjjxi+59BPC+TF4aFk+F65QraHZ3xjO0wo13lK7yu7Eea1kBc
P1B62Fi2k66yOOf+bVM9rCinhUUKtcCAiIDd2oIMgEUHusG2Q3jpuZ5uaRH5SrFp
r91Q4z51Qd9+J/k8Y6W7i//5cJl4qvOTn19f0hD02WZYnawjIflbVSdVzfkJgAur
ANqVBKlqkcSy3StwJJ+1NqjmwidMTuvHLt/fmbIiSvbh+x7viSI=
=EMr4
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--
