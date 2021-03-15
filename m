Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF971C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B9764F01
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 20:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhCOUlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:41:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41136 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231688AbhCOUk6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 16:40:58 -0400
Received: from camp.crustytoothpaste.net (c-98-201-97-178.hsd1.tx.comcast.net [98.201.97.178])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 462C86048E;
        Mon, 15 Mar 2021 20:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615840827;
        bh=pwMLI8NN8G5JrNkHfq2p4DZL95+E8r8hpaU8KhvT8qA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oYHivwLX5mB3xzDmFKqvoncDIlYDgvNSDULGCA4uwP329tyo28nTkvYoJTgvVo/gs
         k5/WgKFOVNnnaDpHqqZlj+WpE/HVYeoBpF0wJlKhT0OnC6j2w0T4bV65n48jKCSZAW
         hUCIwAVE9KyQtATyB4s5z3gR0Yu1AkFuwZfXaGE2jpAKPDU+agShLBK99i3inXedZl
         xj66vxYaxkwwSYkev5IynU+EgT8DInhynVdbpVfIS0cQVAlUR4DgIzx5qD3xXG3Ltc
         0+batM8aG007OAXwzAIDTPw/cVy/5baJXWm5jwV93nkOSa6sm9m9Iw0RQgeVvttrzd
         BF/jFYegLQrXjzF/yCCbtA20pY7ci+AZBPP3EIsoPYbhEav38yLr4Dl+igkkUI/uoB
         hQHlzXFpGCZHlBUcnICr1gs1Pq6wtMS0Rn0tkCVyRxU1X4LvQrt1wH83DFsJLtMkSR
         j+bhdoLj6B1KOGIICslxvbiK2nhqfirxjdzRqZebvfojRo3pIWt
Date:   Mon, 15 Mar 2021 20:40:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] docs: add a question on syncing repositories to the
 FAQ
Message-ID: <YE/GNoqt1Ja2xZU3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-2-sandals@crustytoothpaste.net>
 <87eeh0l52n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uMrnCNBEo7Di2px1"
Content-Disposition: inline
In-Reply-To: <87eeh0l52n.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uMrnCNBEo7Di2px1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-28 at 13:01:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> make this more understandable by going to the heart of the matter, i.e.:
>=20
>  * We prefer push/pull/bundle to copy/replicate .git content
>=20
>  * Regardless, a .git directory can be copied across systems just fine
>    if you recursively guarantee snapshot integrity, e.g. it doesn't
>    depend on the endian-ness of the OS, or has anything like symlinks in
>    there made by git itself.

I'll revise to make this clearer.

>  * Anything which copies .git data on a concurrently updated repo can
>    lead to corruption, whether that's cp -R, rsync with any combination
>    of flags, some cloud syncing service that expects to present that
>    tree to two computers without guaranteeing POSIX fs semantics between
>    the two etc.
>=20
>  * A common pitfall with such copying of a .git directory is that file
>    deletions are also critical, e.g. rsync without --delete is almost
>    guaranteed to produce a corrupt .git if repeated enough times
>    (e.g. git might prefer stale loose refs over now-packed ones).

I'll include that as well.

>  * It's OK to copy .git between system that differ in their support of
>    symbolic links, but the work tree may be in an inconsistent state and
>    need some manner of "git reset" to repair it.

And this.

> And, not sure if this is correct:
>=20
>  * It may be OK to edit a .git directory on a non-POSIX conforming fs
>    (but perhaps validate the result with "git fsck"). But it's not OK to
>    have two writing git processes work on such a repository at the same
>    time. Keep in mind that certain operations and default settings (such
>    as background gc, see `gc.autoDetach` in linkgit:git-config[1]) might
>    result in two processes working on the directory even if you're
>    changing it only in one terminal window at a time.

I'll reflect the fact that only one process may modify the repository at
a time.

> I.e. to go a bit beyond the docs you have of basically saying "there be
> dragons in non-POSIX" and describe the particular scenarios where it can
> go wrong. Something like the above still leaves the door open to users
> using cloud syncing services, which they can then judge for themselves
> as being OK or not. I'm sure there's some that are far from POSIX
> compliance that are OK in practice if the above warnings are observed.

Unfortunately, it's a bit hard to make a concise entry that explains all
the different ways that using a non-POSIX compliant file system can
break things.  We've seen NFS where open(2) is broken, both with
permissions and O_EXCL; cloud syncing services that restore files that
have been deleted; DAV mounts that don't support the necessary
semantics; systems where O_APPEND doesn't have POSIX semantics; and a
whole host of other sadness.  I don't therefore think that we want to
tell people that we think that using a file system that doesn't support
POSIX semantics is okay, because in most cases, they are not.

Users frequently try to judge for themselves what works and then they
try one of the above things which clearly does not, so saying, "Try it
and see if it breaks," just tends to result in users complaining about
repository corruption later on.  I'm really tired of answering these
same questions again and again and telling users that their repositories
are hosed and that they've lost data, so I want to be definitive that we
don't recommend or support these various broken environments and that
users should not use them.  It may be in rare cases that users have
extensive knowledge about the behavior of their file systems and Git's
requirements and can make a sound judgment to use a non-POSIX file
system, but the people on the planet who can do that effectively are
almost all Git developers.  I will state that "File systems that don't
provide POSIX semantics, such as DAV mounts, shouldn't be used without
fully understanding the situation and requirements," which I think is
the most generous recommendation we can safely give.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uMrnCNBEo7Di2px1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYE/GNgAKCRB8DEliiIei
gbf9AP0fDdexRRPSd2kJANKwmB5wnZZC1UgfwEI6USOfyeDsbAEA2S7gZrr3RnEc
G4THuloCuiU8J6PBklpPO2gtlyNi/gc=
=62k7
-----END PGP SIGNATURE-----

--uMrnCNBEo7Di2px1--
