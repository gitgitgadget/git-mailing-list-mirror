Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A88EC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1021D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIIWXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:23:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56600 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgIIWXl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Sep 2020 18:23:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A39A060489;
        Wed,  9 Sep 2020 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599690219;
        bh=O5zxS76ZvnkWEiPwsMswOLWqFMTFH8jxFhm/nF/Impg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VfJZo/WOAdzEOG/c+dQbwHbdFF7R7FjAiWBfLYyLkVxoZNrSU/2M3jcOOEMk7jDZN
         JJ1AnKwp6eq7/of5jAymswypIMD0DUqAziaoh3XJr5LVmR/uau8mMbBEDvT5oLZqMb
         KvA9ZKnY9pqzF2FgTC9d8wthzU/hB9MPbN0gcZZh3txoAs63cgifjfPE2IOgTcdoyx
         0jWzCCQJkgUFYCGREPNBHGgOnBmBriHWT3ZyijZbdg9NlqyjT5D39tWTr7/o4DTsJf
         z2I9H2T3QcaUZ5+yA8UGZ++5vze/FHj2INxfAOZbrElIQ9DD0mizz4M9vzYKRxlEhh
         z4RwPp9B5+KVYL3aGzljYdzH1VwRlrUKGXmKxXhQGiouCH42e1Aq5JI1zMR1hpPHaQ
         aEVAqJR9BsdaSQ0+PmV975gsgIkN6x9B9tU6e2WgnnoVRAVv3RH7girpCPydbValSI
         KESQQR8HxxiLGgrIvEyTh3qr3JY3zqYdZl9Ie7i/7VJlQ0XaIh8
Date:   Wed, 9 Sep 2020 22:23:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20200909222333.GH241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20200909145114.GE6209@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <20200909145114.GE6209@szeder.dev>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-09 at 14:51:14, SZEDER G=C3=A1bor wrote:
> On Tue, Sep 08, 2020 at 06:50:17PM +0000, brian m. carlson wrote:
> > diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
> > index 19b12b6d43..6b95292559 100644
> > --- a/Documentation/git-rev-parse.txt
> > +++ b/Documentation/git-rev-parse.txt
> > @@ -208,6 +208,15 @@ Options for Files
> >  	Only the names of the variables are listed, not their value,
> >  	even if they are set.
> > =20
> > +--path-format=3D(absolute|relative)::
> > +	Controls the behavior of certain other options following it on the co=
mmand
> > +	line.
>=20
> Does it affect only one subsequent such option on the command line, or
> all such options?  IOW, while standing in the top directory of the
> worktree, would the following command
>=20
>   git rev-parse --path-format=3Dabsolute --git-dir --git-path foo --show-=
toplevel
>=20
> print three absolute paths, or one absolute paths and two relative
> paths?
>=20
> The wording here is not clear on this, the commit message doesn't
> mention it, and the tests added in this patch only check one such
> option, but looking at the code and doing some testing of my own I
> found that it affects all subsequent such options.

It affects all subsequent options.  Moreover, I believe it's possible to
switch in the middle of the command line if you want some things
relative and some absolute.  That seemed to be both the easiest solution
and the most flexible, so I went with it.  I'll add more tests for this
case and improve the commit message.

> > diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> > index 408b97d5af..6f3811d189 100755
> > --- a/t/t1500-rev-parse.sh
> > +++ b/t/t1500-rev-parse.sh
> > @@ -3,6 +3,16 @@
> >  test_description=3D'test git rev-parse'
> >  . ./test-lib.sh
> > =20
> > +test_one () {
> > +	dir=3D"$1" &&
> > +	expect=3D"$2" &&
> > +	shift &&
> > +	shift &&
> > +	echo "$expect" >expect &&
> > +	git -C "$dir" rev-parse "$@" >actual
>=20
> Broken && chain.

Thanks, will fix.

> > +	test_cmp expect actual
> > +}
> > +
> >  # usage: [options] label is-bare is-inside-git is-inside-work prefix g=
it-dir absolute-git-dir
> >  test_rev_parse () {
> >  	d=3D
> > @@ -60,7 +70,13 @@ ROOT=3D$(pwd)
> > =20
> >  test_expect_success 'setup' '
> >  	mkdir -p sub/dir work &&
> > -	cp -R .git repo.git
> > +	cp -R .git repo.git &&
> > +	git checkout -b main &&
> > +	test_commit abc &&
> > +	git checkout -b side &&
> > +	test_commit def &&
> > +	git checkout main &&
> > +	git worktree add worktree side
> >  '
> > =20
> >  test_rev_parse toplevel false false true '' .git "$ROOT/.git"
> > @@ -88,6 +104,24 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=
=3D../repo.git, core.bare =3D tru
> > =20
> >  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=3D../repo.git, cor=
e.bare undefined' false false true ''
> > =20
> > +test_expect_success 'rev-parse --path-format=3Dabsolute' '
> > +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-dir &&
> > +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-common-dir &&
> > +	test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=3Da=
bsolute --git-dir &&
> > +	test_one "worktree" "$ROOT/.git" --path-format=3Dabsolute --git-commo=
n-dir &&
> > +	test_one "." "$ROOT" --path-format=3Dabsolute --show-toplevel &&
> > +	test_one "." "$ROOT/.git/objects" --path-format=3Dabsolute --git-path=
 objects
> > +'
> > +
> > +test_expect_success 'rev-parse --path-format=3Drelative' '
> > +	test_one "." ".git" --path-format=3Drelative --git-dir &&
> > +	test_one "." ".git" --path-format=3Drelative --git-common-dir &&
> > +	test_one "worktree" "../.git/worktrees/worktree" --path-format=3Drela=
tive --git-dir &&
> > +	test_one "worktree" "../.git" --path-format=3Drelative --git-common-d=
ir &&
> > +	test_one "." "./" --path-format=3Drelative --show-toplevel &&
> > +	test_one "." ".git/objects" --path-format=3Drelative --git-path objec=
ts
> > +'
>=20
> I would like to see a test that demonstrates that '--absolute-git-dir'
> is unaffected by '--path-format=3Drelative', just to be sure.
>=20
> There are some cases where this new option doesn't do what I would
> expect:
>=20
>   $ ./git -C Documentation/ rev-parse --git-dir --show-toplevel
>   /home/szeder/src/git/.git
>   /home/szeder/src/git
>   $ ./git -C Documentation/ rev-parse --path-format=3Dabsolute --git-dir =
--show-toplevel
>   /home/szeder/src/git/.git
>   /home/szeder/src/git
>   # So far so good, but:
>   $ ./git -C Documentation/ rev-parse --path-format=3Drelative --git-dir =
--show-toplevel
>   /home/szeder/src/git/.git
>   /home/szeder/src/git
>=20
>=20
>   $ ls -l .git/foo
>   ls: cannot access '.git/foo': No such file or directory
>   $ ./git rev-parse --git-path foo
>   .git/foo
>   $ ./git rev-parse --path-format=3Drelative --git-path foo
>   .git/foo
>   $ ./git rev-parse --path-format=3Dabsolute --git-path foo
>   /home/szeder/src/git/.git/foo
>   $ ./git rev-parse --git-path foo/bar
>   .git/foo/bar
>   $ ./git rev-parse --path-format=3Drelative --git-path foo/bar
>   .git/foo/bar
>   # So far so good, but:
>   $ ./git rev-parse --path-format=3Dabsolute --git-path foo/bar
>   fatal: Invalid path '/home/szeder/src/git/.git/foo': No such file or di=
rectory

That's going to be a little tricky to fix, but I'll look into it.
--=20
brian m. carlson: Houston, Texas, US

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1lV5QAKCRB8DEliiIei
gYoRAQCsh4MLfMDUo6UoqALjOIGhEGJAc8V1x2EmSrz8a4CYxQEAt2b4vKcI9N2c
zi0AWNiIzGIqA0/gt1oE8l1S97V57QY=
=SIB3
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
