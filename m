Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDFC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E43D206D5
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wvRGPnhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgFGVEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 17:04:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbgFGVEV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Jun 2020 17:04:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3632060436;
        Sun,  7 Jun 2020 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591563830;
        bh=6kieWAVRYzrAmHlSNhSfG3eoH0QYo2NquK6/fwbM6Lc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wvRGPnhQuyHcPfAp1+oxLm8ACelRLLYZlFpguDmKeYdeVOIOmsCgJFKwXObh0Qd2V
         RbK94Qv0ckr1ao9lPqqAZUkIbFo15iAF5wPNehWzCgcA5XeEdl02f0dgiCzd2gwq98
         IOYSwdxGXiy3BSpbHzWFlFXqjFJ0BSJlmjrc2k5r/3pUak6xlkvnTB9haj5IvjcEYF
         Ye2LtUJBX8se1q+NtWZCDX5YUJiFN4+EK6xB028wM/Rtx+9qXqJLl9gp3cAM+79jdc
         BkkpYzhl754v9um5X9bpO0tfmAE7LuTGZbp6XtnBX7devktclBZDJUW6hTNVjotiFh
         fb5BRMHZPkZu2xwk5YfJgjz0MDoQFx+aVdAXOIz0MhJT2yseEdfLZPDN01Q6fY1Nci
         4k2zWmheGFkjJLKNWRn02lX5EFIShlva/Atpifsifq9YLBAtxQlZNmMyRbjuFo26oc
         JTdbE/H2pDXqcgxdpjVNPO3HhJiXDCREUn8RJAuPFZa16iZqifV
Date:   Sun, 7 Jun 2020 21:03:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Soni \"They/Them\" L." <fakedme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fetching a lot of repos
Message-ID: <20200607210344.GK6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Soni \"They/Them\" L." <fakedme@gmail.com>, git@vger.kernel.org
References: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
Content-Disposition: inline
In-Reply-To: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-07 at 20:04:03, Soni "They/Them" L. wrote:
> -----
>=20
> [soniex2@soniex-pc multigit]$ git fetch
> https://soniex2.autistic.space/git-repos/ganarchy.git +HEAD:repo_a & git
> fetch https://github.com/ganarchy/GAnarchy +HEAD:repo_b & git fetch
> https://cybre.tech/SoniEx2/ganarchy +HEAD:repo_c & git fetch
> https://soniex2.autistic.space/git-repos/abdl.git +HEAD:repo_d & git fetch
> https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin +HEAD:repo_e
> [1] 2236
> [2] 2237
> [3] 2238
> [4] 2239
> remote: Enumerating objects: 87, done.
> remote: Total 87 (delta 0), reused 0 (delta 0), pack-reused 87
> Unpacking objects: 100% (87/87), 36.06 KiB | 225.00 KiB/s, done.
> From https://github.com/ganarchy/GAnarchy
> =C2=A0* [new ref]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> repo_b
> From https://cybre.tech/SoniEx2/ganarchy
> =C2=A0* [new ref]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> repo_c
> warning: no common commits
> remote: Counting objects: 113, done.
> remote: Compressing objects: 100% (74/74), done.
> remote: Total 113 (delta 48), reused 88 (delta 38)
> Receiving objects: 100% (113/113), 30.07 KiB | 138.00 KiB/s, done.
> Resolving deltas: 100% (48/48), done.
> From https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin
> =C2=A0* [new ref]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> repo_e
> [2]=C2=A0=C2=A0 Done=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch h=
ttps://github.com/ganarchy/GAnarchy
> +HEAD:repo_b
> [3]-=C2=A0 Done=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch https:/=
/cybre.tech/SoniEx2/ganarchy
> +HEAD:repo_c
> [soniex2@soniex-pc multigit]$ error: unable to write file
> .git/objects/d2/5baa9c0a78b0007a34a569b774d983b905f0b5: No such file or
> directory
> error: unable to write file
> .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66: No such file or
> directory
> error: unable to write sha1 filename
> .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66
> error: Unable to find baf9414a35a2f48ed1b22644fd4522272fb4bc66 under
> https://soniex2.autistic.space/git-repos/abdl.git
> Fetching objects: 12, done.
> Cannot obtain needed blob baf9414a35a2f48ed1b22644fd4522272fb4bc66
> while processing commit 3f9f66712aaa071bd3bb32c46e1e4dc1fed13378.
> error: fetch failed.
> Fetching objects: 78, done.
> From https://soniex2.autistic.space/git-repos/ganarchy
> =C2=A0* [new ref]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> repo_a
>=20
> -----

So when Git needs to write a loose object, it will create the sharded
directory if it doesn't exist.  If it removes all of the objects in that
directory, it will remove the directory, which is likely what you're
seeing here.

In general, I wouldn't recommend fetching in parallel, but if you want
to do it anyway, I'd suggest setting `receive.unpackLimit` to 1.  That
will result in you keeping the packs you've fetched instead of exploding
them into loose objects, which will help this case.  It may not help
enough to solve the problem, though.

> So I figured, "okay this is a git gc issue", and started over (rm -rf .gi=
t,
> git init) and turned off the GC (git config --local gc.auto 0, and that l=
ong
> command to run 5 git fetch at the same time). At first, it seemed to work
> fine, but then...
>=20
> -----
>=20
> $ git gc --aggressive
> Enumerating objects: 365, done.
> error: object file .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66=
 is
> empty
> Counting objects: 100% (365/365), done.
> Delta compression using up to 4 threads
> Compressing objects: 100% (357/357), done.
> error: object file .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66=
 is
> empty
> fatal: loose object baf9414a35a2f48ed1b22644fd4522272fb4bc66 (stored in
> .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66) is corrupt
> fatal: failed to run repack
>=20
> -----

It looks like this particular object is corrupt.  If you fetch with
packs this should go away, but you'll need to find which repo it's from,
clone it (without receive.packLimit set), and replace it.  Then run git
fsck to see if you have any more objects that are a problem.  Anything
that says "dangling" can be ignored, but other issues can be a problem.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXt1WMAAKCRB8DEliiIei
gZFuAQDkQ3/caTYAt0m+yPVtB0AyMdYlX2MrJjGyrJbA2TMZ+QEA7FkzsZe/rn7n
McYiConzSBQ6CpCHWpm+5BkKBVzatQU=
=tdZB
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--
