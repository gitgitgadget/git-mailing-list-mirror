Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637DC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D22206EB
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uNOV7OER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbgFXBbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:31:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40168 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388347AbgFXBbI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jun 2020 21:31:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8267860459;
        Wed, 24 Jun 2020 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592962266;
        bh=XIzPqAyzrqEz7LnUaXKhMJXg8Oc6jSRxdq2VneG4G+0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uNOV7OEREdr37NUsnLjBNce/QZS+sBrnUrtXkiq9E23uabglgz+HPfDesMLWA2glz
         FT9OtT7A1jutpGRoSdMVcW0wa9ehgXjXPIbx8Az2ty7cnfBZd6DO+WCekRym8FtMYU
         wDsOC7wLJgKw5fRLTwFZJ15v8MW4tSjx9LHCQsbMK1BjAXWScmix4QfoK2zEBI4FD6
         1MAtgHEjtGDKXOYxePAzb29F7/SQ/MlfuC2zreDWbrvJeSeLtiq4p9w5bAY2q/VH5/
         aHhPIX2S6zzxlaapR1o2rofRePYM/8SjDLro5QY3Ej4GjAyDvq4XiZoG+IWSwxjhp+
         +tmdN9xxlrGVUeGrXQXkNvRAmjDr7m0OH6zEUQC1soWUx7tv6kZOVxiEDutMziowlG
         x3VUJb5gXe3qiVHpA2nqzb2VTRi3aBJewynkvU3EUpRjiUSwc5D7EiF2TmW5x7PpCr
         8H6NxxjCthaCYN23sMNjGeB0yQ1wa3GBaMMUBly8X/Nc7m5giLj
Date:   Wed, 24 Jun 2020 01:31:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     shejan shuza <shejan0@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: your mail
Message-ID: <20200624013101.GA6451@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        shejan shuza <shejan0@gmail.com>, git@vger.kernel.org
References: <CABO4vy0WTYbeAiyWf7hE_4QurwH_c1wJUdU=A4FSC0uSxiEO7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <CABO4vy0WTYbeAiyWf7hE_4QurwH_c1wJUdU=A4FSC0uSxiEO7g@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-24 at 00:38:39, shejan shuza wrote:
> Hi, I have a repository with about 55GB of contents, with binary files
> that are less than 100MB each (so no LFS mode) from a project which
> has almost filled up an entire hard drive. I am trying to add all of
> the contents to a git repo and push it to GitHub but every time I do
>=20
> git add .
>=20
> in the folder with my contents after initializing and setting my
> remote, git starts caching all the files to .git/objects, making the
> .git folder grow in size rapidly. All the files are binaries, so git
> cannot stage changes between versions anyway, so there is no reason to
> cache versions.

What you're experiencing is normal; storing files in the .git directory
is how Git keeps track of them.  It can't rely on the copies in your
working tree because you can modify those files at any time, and if you
did so, relying on them would corrupt the repository.

Also, note that Git can and does deltify changes between revisions once
the data is packed, regardless of whether the file is binary, but how
well it does so depends on your data.  For example, if it's compressed,
it likely doesn't deltify very well, so storing things like compressed
images or zip files using deflate is generally going to result in a
bloated repository.

However, if you don't need versioning for these files, then you don't
need a Git repository.  Git is a tool for versioning files, not a
general storage mechanism.  You may find a cloud storage bucket or some
other artifact storage service may meet your needs better.

I will also tell you from a practical point of view that almost nobody
(including you) will want to host a 55 GB repository filled with binary
blobs.  Usually repacking these repositories is very expensive,
requiring extensive CPU and memory usage for a prolonged time for little
useful benefit.

> Is there any way, such as editing the git attributes or changing
> something about how files are staged in the git repository, to only
> just add indexes or references to files in the repository rather than
> cache them into the .git folder, while also being able to push all the
> data to GitHub?

This is how Git LFS and similar tools, like git-annex, work.  Git LFS
will create copies of the objects in your .git directory though, at
least until they're pushed to the server, at which point they can be
pruned.  Git LFS has the same limitation as Git here.  I'm less familiar
with git-annex, but it is also a popular choice.

However, as mentioned, it sounds like you don't need versioning at all,
so unless you do, Git with Git LFS will be no more suitable for this
than plain Git.  If that's the case, I encourage you to explore
alternate solutions.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvKs1QAKCRB8DEliiIei
gbdwAP90zUbX2/iMiaOAKsqhdBZ4DzuYETSMaAgXOpMIYS9gAQD+P4Bi4YECJqtz
qLEw+NFLqNxDC/+Jf7DWkQdkAmDv2gM=
=IalQ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
