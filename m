Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37622C33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADFD2085B
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IxkNJQOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAEQHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 11:07:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgAEQHD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Jan 2020 11:07:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC7F060426;
        Sun,  5 Jan 2020 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578240423;
        bh=95KZcikBpxoTYDynfa2UdCL8R4iOYOEzMmpyQKQqrHw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IxkNJQOSLrMSu8l1eo4C9yIFhq+w9b4wzesUtmuaaBtSZtvgldLIex9Fbzd37U5ry
         CpNEqmww64S8Zdfy/6dEU43lk9tzZ37g69BRWwPiOYNnYR+ggzyguYgL7PvlWtJnUq
         0EdaBpihWUhROjqLdvmZ/BhLnXyzGny9JAEVLvjLDtI6GI2oMTVkrm7DkTuCz6hksV
         CNTj7ESobqvVH1Zd7pt87ocbAqeoqnOr/t+iJiaC7Xgl62s9YLa04/9UdOrjvkMILy
         bPCExxTWC72z+ZvLKrS+cq42UduaH+Bkp+PRsh8NKHeBHSHf3dwMW9+I9l7BMXEAPd
         /hh6wJFf7FRd0AuBERUb5xjEaVoSt0vi+WHUTG6jSepBQd4UiZQ9jnyk20aZ96xrb1
         2DnTYArtaBC+FuC7m6ayOzKf1z1+vn76h01z2jglcJrYKXdbzjbWmlrdLq5bqmwDfF
         PUq/cG6fI0cuDJDWVC7OlSi22lVA7nqH0rkJVhYABdo9bl0msbH
Date:   Sun, 5 Jan 2020 16:06:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lukas Schubert <lukas.schubert@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: git repo on NTFS mount
Message-ID: <20200105160656.GG6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lukas Schubert <lukas.schubert@gmx.de>, git@vger.kernel.org
References: <op.0dv9xiwp1jamlk@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
In-Reply-To: <op.0dv9xiwp1jamlk@localhost>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-05 at 00:49:56, Lukas Schubert wrote:
> Hi there,
>=20
> for historical reasons, I keep the data that doesn't belong to any
> specific user on a harddisk that is formatted as NTFS. Some git
> repositories are there, too. Some time ago, I upgraded from Linux Mint 17
> to 19.2. That upgrade brought a change in data partition's mount options.
> Old:
> UUID=3D20D0WHATEVER	/mnt/DATA	ntfs	defaults,nls=3Dutf8,umask=3D000,uid=3D=
1000,windows_names
> New: UUID=3D20D0WHATEVER	/DATA		ntfs	defaults,umask=3D007,gid=3D46
>=20
> Now I want to initialize a new git repository
> user@xxxx:/DATA/Projects/LearnPython/wxGlade$ git init
> error: chmod on /DATA/Projects/LearnPython/wxGlade/.git/config.lock
> failed: Operation not permitted
> fatal: could not set 'core.filemode' to 'false'

The way Git writes a new config file is that it writes a file to the
side (as a lock file) and then renames it in place.  Because it works
this way, Git tries to call chmod(2) to set the permissions on that
file and when it fails, Git aborts.

You'll need to figure out how to make the chmod call not fail on that
file system, even if it does nothing.  Changing the mount operations
would be a good way to try fixing that.

> Since there already are repos on that drive, the initialization must have
> worked before. But in
> https://www.linuxquestions.org/questions/showthread.php?p=3D6074034#post6=
074034
> I've been told that using git in linux with repositories on NTFS is a
> recipe for disaster.
>=20
> Given I change the mount options to what worked before the update, can I
> escape certain doom if I stick to a certain subset of git commands? Or is
> the cathastrophe inevitalbe due to subtle errors that culminate but stay
> hidden until it's too late?

NTFS isn't guaranteed to be broken on Linux, but neither do we test it.
It will probably work if you can make it do standard POSIX things,
although it will of course be less capable than a typical Linux file
system.

Assuming that Linux doesn't lie about file system operations on NTFS,
then Git will either work, or it will fail loudly.  It won't silently
eat your data, and that's all we can really promise in this case.  I
certainly encourage you to try fixing things and let us know how and if
it does work, though.

As a side note, if you're looking for a file system that can be shared
between Linux, Windows, and macOS, you may want to look into UDF, which
is used for DVDs, but can also be used for hard drives.  It supports
POSIX permissions and is therefore more functional on a typical Unix
system.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4SCaAACgkQv1NdgR9S
9ote5A/6As3f92UT4LRwOK+IDr3ZdRZjOsz9Foy0TNv/hSq9dJoazbE/5PWjzwFv
u88RFJMaWaR8IuAcWkCf9o1mi2ZsJ11zOZrH6V01c6sxz3wEzy96AUrllE15olO9
KuSRAAfLgu6sKAl/mAQkoRWJKpe0J52NBOEglT+A/7C8bsViR/SAqZAbJ50XPtY2
+hD5oalU7dptXLeiAlV4/eKz72Ng+YlfJN3b603Ej6p4W+rOXZK6i2qMu0/cX/Xd
QUwWS+2nshrldzXA/2zLJ24CTOS2kJ1dQ6f2g8LIznbPYVB6zfwjeNjfehALHKQS
o1PozpnhKJoW2PyeJzALOxZZ7amt+l6scsv2dpXtFSwiFncPHEdW1RZ2a7Y+RvTL
WzYFfKSu3aRa6KbCLsZM+FPM4ThlTJHOyYi5ASzW9wONaUvoKHeV+kDwmyS1Ndm2
3w2kONCoXlRRnnOuq45BpG53UxWh59egce+CVX/oMPD5eHDt6m/JpRoQ9DIzsLxk
OON6lphEj2Xe6ko6F8smvYnv52a/On01j5ufIoqRVSiYH2MERKvBAWhHNQf3M1Gd
t9tbh6RvqnGC2OZvIE8hoXqyCIbZZbFsbQx7XwbguDoB+jKYyq/mgCRGUUXMQdYh
5Lh9NTVBsgvpu+6w4eo1XFPWsnQ6K8eIbVR3mYkiQ5BqgbhWTII=
=fzCp
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
