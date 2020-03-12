Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56FC0044D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2CF20753
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 00:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iSGBmYfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgCLAjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:39:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387488AbgCLAjS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 20:39:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD0FB60478;
        Thu, 12 Mar 2020 00:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583973557;
        bh=RjK44o52ZEFAfdtlQz1R3LVsadWZsYCkK1rCsyN0jYI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iSGBmYfUGxtosnrLV7FdZMj6Q1jw/OF7Lr40CGDtLea817OiaqPsBLGgvFfPyitV2
         ppu0XMabOWe2l+keRHKZX3Mgg2DuZyjhn6+eaxUUE2ln5Of19PGA3XypQD4oVHUS6I
         d6iisntQnJp0/hXP1DIfP5jU2iJTBPPy+xNbLeCsaVh2CtY4LFopDR1qvp4YdIYKwL
         gQSpOfT5RlPXdTzwxdOTqGfV0Jay5raxxHOJ5VLsAgankTlIgnKKkgL0fapW0hE1Sv
         51c3m5p3H5FOji4cpJtkgvZDaLAhFjbDdp82Qg/B+pQISkteq33gRYREZjXVL5WE6L
         +PjBCFXITmdK0zXkmdVjNNyTWez6q9x8RD9yDbhCY4/yun85KpmkvL7ua3IaZ7+1Qj
         9qiBpa87XTmZBW/NH5uxgzDAHONBHXkvpdKyAbye+9s8rVkCxoOYNurJ/2Tj6r4ncc
         yHvl0Yxft18Vi00ETuJavBg/9IcDRI+AiGzD348OiGpf6/D7ebp
Date:   Thu, 12 Mar 2020 00:39:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/8] convert: permit passing additional metadata to
 filter processes
Message-ID: <20200312003906.GC6198@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
 <20200310182046.748959-3-sandals@crustytoothpaste.net>
 <xmqq1rpyhbjd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <xmqq1rpyhbjd.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-11 at 20:38:46, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > From: "brian m. carlson" <bk2204@github.com>
>=20
> Do you want this name/address associated to your contributions?  I
> am asking because to me you have always been "that toothpaste guy" ;-)

Yes, this is something I wrote as part of my job.  I mostly work on
non-Git things there, but occasionally I do some Git work, and I attach
a work email to commits I do at work and a personal email to things I do
outside of work.  This is so for licensing reasons: I have the ability
to grant libgit2 or other folks permission to use stuff I wrote on
personal time, but I would need to ask first for things written on
GitHub's time, and I am really terrible at remembering why I wrote what
code.

There's already a .mailmap entry that maps everything to the same person.

You should continue to see most of my contributions come from my
personal address, since most of what I contribute to Git is just for
fun.

> The "filter" you talk about is the clean/smudge kind of thing that
> works on individual blobs, and the series is about giving a bit more
> information than the raw contents to be filtered.  I am assuming
> that I got at least that part correctly.

You have indeed.

> Now, a few questions.
>=20
> Is "refname" "refs/heads/branch? when I run "git checkout branch" or
> "git checkout branch -- Makefile"?  Is "treeish" the same as the
> output from "rev-parse branch^{commit}" in such a case?

Yes, we'll get something like the following:

  command=3Dsmudge
  ref=3Drefs/heads/master
  treeish=3D16f09066000e3328fb2d5c54beb55fc25c1af15c
  blob=3Dc8e324426dccfcfebad5c33c8ffb97d5a2b54a67
  can-delay=3D1
  pathname=3Dtest99.bin

The treeish is, in this case, git rev-parse refs/heads/master^{commit}.
It will always be the commit unless we have no commit, in which case it
will be the tree.

> Assuming they are, what refname and treeish does my filter see, when
> the user did these things?
>=20
>     git checkout origin/master
>     git checkout v1.2.3
>     git checkout v1.2.3~4

We get no ref for these, because HEAD doesn't (well, won't) point to
anything other than a branch, and a treeish pointing to a commit, plus a
blob and a pathname for each individual blob.

I tried to emulate the "read HEAD" behavior as much as possible for
refnames, but if people would like a ref in these cases, I can do that.

> As a writer of a filter, do I get different clues when I am munging
> Documentation/Makefile and t/Makefile, when the user does
>=20
>     git checkout master -- Makefile Documentation/Makefile
>=20
> i.e. grab these two files out of the tree of the commit at the tip
> of the master branch?
>=20
> Or do I just learn what the "refname" (presumably "refs/heads/master"?)
> and treeish (presumably "rev-parse master^{commit}") and I cannot
> tell where in that tree hierarchy the contents come from?

We already pass the pathname when processing a file; this is guaranteed.

I clearly need to update the commit message to explain this better for
future readers, since you should not have to ask questions about what
output the series provides, so I'll do that when I reroll.  I'll see if
anyone else has any feedback, and then do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXmmEqgAKCRB8DEliiIei
gVu7APsGCk4DvWyFBkL8qdngQg45NbxC329Y/MC6OtZPhwPICQD/a/SqeVahQvnI
svXVnAdpqCzPXIJGWKhSaWNRG26A1AM=
=OUP0
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
