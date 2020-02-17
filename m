Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA77C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D91420658
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hiUmKiCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgBQRaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:30:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34968 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729727AbgBQRaA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Feb 2020 12:30:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 99EC860478;
        Mon, 17 Feb 2020 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581960598;
        bh=izOhKljjYlVcx0v8S4rD4smffV22Ig7/Jez/jhkQUok=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hiUmKiCj4YJVmveLQ0XJKD5a+XYvzZ8m1EJvZJvBTH9/GwRY4yw+K3ptK2YR8rN/X
         D5vY/qgEM/xWw92fiPveFzQypR7AZhpxFevbUkS5TWY6nfbwZcuqLMB4lxaor5SCEx
         uoldxB9B5agJv2CrM3Cp04YKzyNONQijai+apJci/HdE7ysE9pq7w6z6fS9iYziDOv
         r4lPKAqljwgNKDNclj3ezbtnGL4iemJ7PmpGfet04n8y6NdjwFFMK4mdvBnMtSB2LK
         AP/Bt2bftUrkIFq6CPfbslO/jcqnxmYXkXMjEMQzoC5yuJrazfsPaKPmNFQeSP9JB4
         wwz87Urs8/hnpyIZplaUs2cExPcL45GANHGaLIewHcHZig0bnexbM0inixUSEFnoWG
         Tgx2h+xl4u8BuYBH/YzOuU+4ES0z3X6ljd006u0GeFhQinW+M092anPTeBUWZm1IiU
         AWT8ehZ5XMXqI2bi86ZIY9AvbpkA/4AaO9AU+Y/3wf8ZpzR8Joy
Date:   Mon, 17 Feb 2020 17:29:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Manish Devgan <manish.nsit8@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
Message-ID: <20200217172954.GH6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Manish Devgan <manish.nsit8@gmail.com>, git@vger.kernel.org
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline
In-Reply-To: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-17 at 08:02:44, Manish Devgan wrote:
> Hello,
>=20
> I am a university student from India and I was trying to clone the
> xfwm4 git repository from the git-url :
> https://git.xfce.org/xfce/xfwm4
> I was trying to clone this repository over my university network and
> it didn't work. I worked my way around by using my mobile
> wireless-hotspot for the same and was able to do it just fine.
> The next day I tried doing the exact same thing since I couldn't get
> an answer from our university if any such firewall was blocking me
> from cloning it. But this time instead of failing to reach the url the
> command ran with the following output:
>=20
> gabru-md@bhaalu:~/Desktop$ git clone https://git.xfce.org/xfce/xfwm4
> Cloning into 'xfwm4'...
>=20
> after waiting for a few minutes the command didn't fail but it didn't
> show any output/stats like it does when I try to clone a repository
> from Github which is definitely not blocked on the university network.
> for eg.

So it looks like git.xfce.org is using the old dumb HTTP protocol, which
basically serves static content.  Git has to look up the references,
attempt to download each object or pack, and then determine which ones
have the objects it needs.  The server provides no assistance in that
regard.

> gabru-md@bhaalu:~/Desktop$ git clone https://github.com/gabru-md/stl-cpp
> Cloning into 'stl-cpp'...
> remote: Enumerating objects: 186, done.
> remote: Counting objects: 100% (186/186), done.
> remote: Compressing objects: 100% (128/128), done.
> remote: Total 186 (delta 92), reused 146 (delta 56), pack-reused 0
> Receiving objects: 100% (186/186), 105.58 KiB | 256.00 KiB/s, done.
> Resolving deltas: 100% (92/92), done.

Here, GitHub uses the smart HTTP protocol.  The client fetches the
references and then reports what data it has.  The server actively
computes the differences and sends a single pack containing only the
required objects.  In addition, newer versions of the smart HTTP
protocol contain a sideband where the server can report status, like the
"remote:" message you see above.  The status messages on the client side
come from unpacking and indexing the single pack received.

So this is working by design, although it's confusing for users.  The
dumb HTTP protocol doesn't know how much stuff it needs to fetch=E2=80=94it
could be a single object or pack, or it could be tens of thousands of
items=E2=80=94so it's hard to provide any progress report on the client sid=
e.
Additionally, because the server isn't actively producing a pack and is
just serving static files, there's no way for it to provide status
output at all.

Hopefully this answers your question, although I agree the answer is a
little unsatisfying.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5KzZEACgkQv1NdgR9S
9ostJA//YY+50xics6STroXKHSpeUkyA8bmucpGOIO/DZ9WsaA1ruHZRXg3TNrC+
p1W7lQEKpPhfx/TMRCMscSAWebGuQRQ2YC4kGi1KQiqHHlM1LqY/9FOChkodl6h7
BjVUI9OXnwI02FcSCw2QiEr/U4zA/N2uEG/WwLx5Ogm+aBMVa/V8Zfs3yj3OEgHc
XXGEovF0r2hR3ZIwy+MKC/qSQNlC5cJqA+4cYxihIaJgaG/vgd9LiWZjpKRaDzMD
eg0+pqAA+0pSnc3kUp38rNNmyALfhbwdAZPw0daEe/54JOOFMhWtjAJ25LUWby5G
IcoND+yWtGvkSH/+TWjoOt9ostQG1Uf1d11h5p4ekl6jpsrHG1ANoZws86kM1Ahz
u6ivMtKr4F8+R+i78uVnp2c/p917dKa2yhPMIQrM6zqEdvBisvWBidA+EF4RoN52
YAfD2zzBEJ0THFEPYMkcHBkD/mV/7Ap/HH2nmDgjJRUTAlbzf4rKgAibLyZHjgPE
BgiOgMOBW/jRKB16zZB2IBPTCbvnGy0R/Z1NU2a2unQrbsgG1c9bhmZML0i5LnAC
hpQV/pjlXs1TJ+VHsNREypOKV04L5lxP8ubdTTKFFBk7Acygdd9HSNMv7oqcQiLp
gl8i3C1cEIXxOTmRnZx324Pv7OlihXDkubGYFVKdydbkxusdNfw=
=tOG3
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
