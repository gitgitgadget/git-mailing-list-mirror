Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A09C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BB720772
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tN0dna9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGCEzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:55:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40288 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgGCEzw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Jul 2020 00:55:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E12256048A;
        Fri,  3 Jul 2020 04:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1593752151;
        bh=jr5Tawtsd2D87px8097Pl5791hA9xZffVzAAHXbdxZo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tN0dna9qyRZxb7xnbJZLTg0haMu2DEBpdNiOaOsluJT3SePeREUp7YArs+hBbCJAe
         XEBnsdkBmu3O9KjfjSKsBCU1W0whDqqic4XiAxGb1SS52kqCnxM4D297umTMDadhwq
         EVoCqXbRgiAhBymJsW7oX5l6azI/Fwex+ATzJGGpji/3K7V4JT108TLin1o3u4zhXM
         HKC9XryQQs5RI/XzfJ0BpyWTv8al8Xv2sa+rprwEw2hKUxnA0nP0fit4GM7dtHxe7O
         9DWVfqIN8Yyt1vORcX2YvT+BsObndoKzRp04lWtIGpX5hpBPYQJ8tjIQNUqCQHCuQ7
         x1NsfAvvMcPwzxeKrIhVLG3aJYJlmYJDlmvPRZcrZdDB+jHyC+MMdnFWPxzTTwkNBM
         3D7ZMhRzwgQ1GifqqEQE473uE9cQMAXYee/mhnqPuX4cCjfqX8hpy/NPmZqgZ+s7pP
         CiJK2dXk5q8Na5sJivFkDif7jfbIPDhK46pyWUG70jxG1JVJeIv
Date:   Fri, 3 Jul 2020 04:55:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tomas <correo@tomaszubiri.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: commiting a change from command line with newlines.
Message-ID: <20200703045544.GD9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tomas <correo@tomaszubiri.com>, git <git@vger.kernel.org>
References: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-03 at 04:22:09, Tomas wrote:
> Hello,
>=20
> I'm trying to write stanzas in my commit message, and naturally the ASCII=
 newline character is the best tool for this, beautifully integrated throug=
hout my whole system, from my keyboard to my screen.
>=20
> My question is, how can I add a newline from the git command line without=
 opening an external program like vi, atom, notepad, word etc...
>=20
> Since I'm using a unix like system I even tried with pipes (and xargs, th=
e necessary evil) but with something like "printf "a\nb" | xargs git commit=
 -m" b gets interpreted as something else.
>=20
> Does anybody know of a way to adorn a commit message with newlines in a s=
ingle git commit command?

It's generally possible to do this with a multi-line string.  You can
write something like this:

$ git commit -m 'git: make boring change

Add this boring change so that people are put to sleep.  They will be
able to sleep well and therefore awake refreshed.
'

Your shell will usually indicate some sort of continuation prompt due to
the multi-line string, and you can simply close the single quote when
you're done.  This also works in shell scripts, and our testsuite uses
this syntax extensively.

If you need to insert a single quote, you can do this:

$ git commit -m 'git: make boring change

Add this boring change so that people are put to sleep.  They'\''ll be
able to sleep well and therefore awake refreshed.
'

Of course, the benefit to using an editor is that you can edit your
changes, so you may find that while this works, dealing with the
occasional typing mistake is inconvenient.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXv66UAAKCRB8DEliiIei
gSnnAQCGib17X4kbTzCUwX+eNjFxwZVA6AlrMJEjHsWlWIAQOwEAw3U/mfDyRrNc
ApjnLisyYnJLHoxhH3Vyo7DtDI9jdQw=
=A9LV
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
