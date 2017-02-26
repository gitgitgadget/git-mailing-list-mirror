Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89C92022D
	for <e@80x24.org>; Sun, 26 Feb 2017 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBZSa4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:30:56 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41190 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbdBZSay (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Feb 2017 13:30:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f8da:200e:3546:3090])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BEB06280AD;
        Sun, 26 Feb 2017 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488133851;
        bh=RHsyfHQTgM/91LhKocbK43cBrt2XwenQm+KtkhhM9fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5ZG5vs9W4IYS2DggNJocCfFVTIJG1MBb5AdtSHZCeiKxq9SS1ur76vy0FtBtd8ci
         LUEGtJiFUmTmOOmYMJiuRleT5j/fZXcbV4Kw4a8ZD9qwpX+oTbYC6oHnPJU6AQksjz
         ZOtVHFOL2zlAKQuStd2Xevg6MWACLQyTjehDIFymogfhMJCKeE8JDYho0mGCB0Q35X
         TIb0C7vsDFevrhFKCVFsFoTBNaMkAkt1gpOHHlblXaXYd4Mw1L0CukV2StFDrP5kZ3
         dvpUwZrPhcV+PNrJJokrDRnWn3z0s539Z5AgbBC/XR6m9DGzSpov3HZixpiuhr4XDM
         G2lUgpR2KmLzHBv14ijii5jcU+G4yZes0HKBr3uFyk4IUFw9R8fpTZ6mrX5Vw/qC7B
         YMgDlPZanKW7GCrkccfL1V/4lGFx660YS54xtBTpTHR8jXacoqlX0Ivw8xiwPCCV95
         es+kjgw4KHWbTmweiJvBE/aUp9GOsoD+Q0+3mdameIFpPMbdfOa
Date:   Sun, 26 Feb 2017 18:30:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170226183046.tbpodi5zt4kvrbpg@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
 <20170226011359.GI11350@io.lakedaemon.net>
 <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ogvrnrsahrrlmuai"
Content-Disposition: inline
In-Reply-To: <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ogvrnrsahrrlmuai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 12:18:34AM -0500, Jeff King wrote:
> On Sun, Feb 26, 2017 at 01:13:59AM +0000, Jason Cooper wrote:
>=20
> > On Fri, Feb 24, 2017 at 10:10:01PM -0800, Junio C Hamano wrote:
> > > I was thinking we would need mixed mode support for smoother
> > > transition, but it now seems to me that the approach to stratify the
> > > history into old and new is workable.
> >=20
> > As someone looking to deploy (and having previously deployed) git in
> > unconventional roles, I'd like to add one caveat.  The flag day in the
> > history is great, but I'd like to be able to confirm the integrity of
> > the old history.
> >=20
> > "Counter-hashing" the blobs is easy enough, but the trees, commits and
> > tags would need to have, iiuc, some sort of cross-reference.  As in my
> > previous example, "git tag -v v3.16" also checks the counter hash to
> > further verify the integrity of the history (yes, it *really* needs to
> > check all of the old hashes, but I'd like to make sure I can do step one
> > first).
> >=20
> > Would there be opposition to counter-hashing the old commits at the flag
> > day?
>=20
> I don't think a counter-hash needs to be embedded into the git objects
> themselves. If the "modern" repo format stores everything primarily as
> sha-256, say, it will probably need to maintain a (local) mapping table
> of sha1/sha256 equivalence. That table can be generated at any time from
> the object data (though I suspect we'll keep it up to date as objects
> enter the repository).

I really like this look-aside approach.  I think it makes it really easy
to just rewrite the history internally, but still be able to verify
signed commits and signed tags.  We could even synthesize the blobs and
trees from the new hash versions if we didn't want to store them.

This essentially avoids the need for handling competing hashes in the
same object (and controversy about multihash or other storage
facilities); just specify the new hash in the objects, and look up the
old one in the database if necessary.

This also will be the easiest approach to implement, IMHO.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ogvrnrsahrrlmuai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlizHtYACgkQv1NdgR9S
9ovKWw//XknTeGntFzosCvkDDRbgqY+K+5Fm5XDEFhtmqMS5sFHWNcAfH1h4Y9Lt
Sfu01+FVYlcG0o18TYf5R+kDLQ1b/RWP+PSer8EUJB+6/bp1LENK5kRLI8sUiRVt
mi2Yiy90mM6RXclyNOnwJd4PTkEPUcxi/cLWuJ7CEGExQzQsg+DX8bzkuhe4AzxU
OW+O5R1hxoXLfqTGjTLhCWx69FCZmnPONuWIe5o93sOIj/U8nC7cga2h5OgWevN4
G2vH7kFkyL2YTLbDbQNj5Cl3eNHcIbbPu2/7JoGY/ImDL4CMm+kOLkbaum7W2t5L
BRCvqMJHeGc98SqIVx+zCKhMhLePllYlbkjJQOUEtbqFE5M29n/i3GK92bFc8eyM
5muW60R0TAlRCSsju43+LqEO+8sEqIhIPJaC6Ii06oFdiJisgczD6c34NjBZnYqQ
nxydlB4q4ktRlwzGbY9vzCXMVHW+W1tmQgz1BrnZgFXDpAIJ2QOVHeYiC4V3Vbwz
ol4tttB6/TNdbaj+E+Qx9xIuYJkueK5uyX7xJvjHBSoJizAd1gg4JUTpOeqkO//E
TZqPM4Z5wTcudH5+THUXMNEDx+wAg4N1xvkZVKFCqebtlEh2vHWTFapVJBWv6Is/
fo9/AUx7Ife7NDTmrt9BSSlAlWq48XSRYbK3c7Bd1fG3yUs6yFc=
=6D/S
-----END PGP SIGNATURE-----

--ogvrnrsahrrlmuai--
