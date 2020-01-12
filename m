Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95AC33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA962053B
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fOa23r7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbgALT4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:56:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37048 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgALT4x (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jan 2020 14:56:53 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF55260787;
        Sun, 12 Jan 2020 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578859013;
        bh=S8CyrHyXdypJJM4/tGZK0kPK7kQIHYML52iTeJQ6VBE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fOa23r7phiyPNHVFTrIdXdXtBvDtQuIySbtWWHx3jgRGwqkzBdkrZdIXyzBNfnyyS
         Fp2mVBfCEKu9zjWbgkmDA3L8iCTiZjJSRSX3OgfEKJphbehoOkND5KgXSb/HfQdVLc
         b29ajIs1hKY/66Ks0mssGBmQ8dMziaUdXbnRkx1vTlpIMPxmV6L5g1UclSoNMVGaDl
         7nDS9t9S3w328Z7wIto6w4WtdL3FhYRy4+2KgkiTySf2ql9kN1TiKgRf2Watp9VkOz
         oPU5HENqcyV88tj8i2QsceMeRu5I6ddhZaAhfYsOz1uLV76xRtCjQbWwqOW6Br+29a
         nXi+o4Eg0LtVfzbf++5SYjRYXXVVWhjHPMmgYirbta5QeSQ4hsKK58b6KNZxxgqFBD
         Ow3LlDAd+wgZWrBL4me+Vpg032u0L/tO1ljiWSqx+1KDSGNK49xBdLPuG7tX3JLQf4
         Yyx6lBtHYcJ2vO/NS7t9O8YGd9iDMOgPepXVsd4on757V+LPa/q
Date:   Sun, 12 Jan 2020 19:56:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     1234dev <1234dev@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] An easier way of rebasing if you just want to
 "force send" a file back to a previous commit
Message-ID: <20200112195646.GQ6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        1234dev <1234dev@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ep5m4srWGXPl6O+g"
Content-Disposition: inline
In-Reply-To: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ep5m4srWGXPl6O+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-12 at 19:42:46, 1234dev wrote:
> Hello!
>=20
> I'm pretty new to all of this, but I was wondering. Is there an easier wa=
y of rebasing if you just want to force send a file back to a previous comm=
it? Rebasing can get quite tiresome in the long run. It's like 7 steps, and=
 that's without the merge conflicts someone with my luck is guaranteed to r=
un into.
>=20
> For instance, say I've made changes to a file. Those changes are too tiny=
 and insignificant to make a new commit out of - they actually ought to be =
part of a commit I made last night.
>=20
> If there just was a way to cheat :) I'm aware it would rewrite my entire =
history but that's okay, I haven't shared my repo with anybody yet. Maybe s=
omething along the lines of "git rebase --off-she-goes <file> <hash>"?
>=20
> As opposed to "git stash && git rebase --interactive '<hash>^' && <change=
 pick =3D> edit> && <apply changes manually> && git add <file> && git commi=
t --amend && git rebase --continue && git stash pop && <merge conflict that=
 requires manual intervention> && git rebase --continue && git stash pop &&=
 <still a conflict> && rm <file> && git checkout <file> && <repeat the whol=
e process> && <still a conflict> && <go to IRC and ask for help>

The way I usually handle this is something like the following, although
I have some helper aliases that wrap this:

  git add <file>
  git commit --fixup <hash>
  git stash # if necessary
  GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash

That does use the interactive machinery to apply the fixup commit, but
it also avoids prompting you to edit the interactive TODO list.  It
doesn't avoid the merge conflicts which can occur, but it is (IMO) the
easiest way to go about it.

If I'd like to edit the message, I use "git commit --squash" to add the
comments I'd like to add and I'm only prompted to squash together those
messages.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ep5m4srWGXPl6O+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4bef0ACgkQv1NdgR9S
9ouWOw//cazfzuNEFxIOY4Pzx0F1Ndx7r4R/+U5dgdUrmvARXdw1DBgucQHRFACg
fGZ2ZG3KZ+B/gQamf4exat/HaXDbmBFgNCn+4XLJ4VYFmTASNfpaXnH/O2r7T/tx
BgZG8kziHgmVPRWwGu4KTJzYnrdDeqrR/ZqxdyW+xG83332wDBRbrn3DNL/PN9vF
Ku4kjdUS9Re2szFOd3LGOAKPPQu0MNXx7yE3geggU0S6WE+1Xua8UozJ08qnyIdn
wq7nX4D+mFdKkXGyJYOurzqY5CDesOaM68/LhCZk4oUlHqJKvtEXT7ejCBNKIBF6
v/U8mMZBJgk8X8VmFhGmFRokl2smwlXhpixUG6/AamtUcTByTwvxnpsXEnDyCITr
nvLT16d/0LTbq/OA+E+UPNol8gUFOCIJ91rnIzWoR9lwJqkRNTRPnzUt4u0As9Bm
eYB8NKlHerMh3/uSbYin7xGulo447MFPO9s2C5bRlu2uO3HmUE1Y58GUpc0AMkYT
LtoYzczhuWMwYzstIQLc3H9hLacDMMXMtDHJyPPWYL9mk3lY5a3tLGqQKJtf43jC
yAuGz0bB65xpmYAsx4canVLHgE03EjvvANmx4uxmWXNVXvxfTLPPN4FI93Xyp0y+
Tk2dIbrWjtPHZFISMWS2cEbxz9U8hDgQ2u8GuBsccDScAQuoMYw=
=5o1W
-----END PGP SIGNATURE-----

--Ep5m4srWGXPl6O+g--
