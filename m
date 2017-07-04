Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A31202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdGDT6O (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 15:58:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53736 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbdGDT6N (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2017 15:58:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5EDAF280AD;
        Tue,  4 Jul 2017 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499198292;
        bh=Ur5jtZfP2u/mCEFY9Pny6kJBaJvuNLBuiXula9+LGXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jn0BSYUssbflYjLXejmqzTe3V62BYlL2OdVMGSMgxXzsEKG6qm5LrBMSC79wxyPLk
         RGrhdyvTDBIPmZuqfw29UMX8P23bsCz2NoieWFnipdHsEFeeEqG3jTKp8Nx5rMnqGj
         ETai96y8FqQ8lsRviIHQiAIt3yC/cUc5lf8ZEQDNKH+CNdUnT3WB6SS7oP8DLH1pyf
         t7AXMj0TcuSdXwoxWFuEGTKOOHB35jYshNHyC2OXr1UeP09PT1hbR/5zl6ui8+FSD9
         YAi254P3vLHt1ro18TY10ZHu2orE4wubQgKym9Q/DOxv/WerSiEJNfNyYRZp6B7C6o
         iZGh8utVQZbKnCuHTkwYdFEgYz7C9BPn/sQbWl9LKpt2CdE+kMjQjWKBis1B4YU+wc
         nJ+zmFTiKgl5o5E0F1qXCJKifnUV3ktwKyNpW9tkmP33HfAIitlewqLbuC9F1Cc/ia
         lWRyQPnccFugJ75SWb5DLeeWFq6E8mnSHXiQz3q5YToFq15Twcf
Date:   Tue, 4 Jul 2017 19:58:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
References: <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dl57uqa5kfxbrnlo"
Content-Disposition: inline
In-Reply-To: <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dl57uqa5kfxbrnlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:13:15PM -0400, Jeff King wrote:
> On Thu, Jun 22, 2017 at 06:25:46PM -0400, Jeff King wrote:
>=20
> > So here's a patch on top of what I posted before that pushes the reflog
> > check into the loop (it just decides whether to pull from the reflogs or
> > from the commit queue at the top of the loop).
> >=20
> > I was surprised to find, though, that simplify_commit() does not
> > actually do the pathspec limiting! It's done by
> > try_to_simplify_commit(), which is part of add_parents_to_list(). I
> > hacked around it in the later part of the loop by calling
> > try_to_simplify myself and checking the TREESAME flag. But I have a
> > feeling I'm missing something about how the traversal is supposed to
> > work.
> >=20
> > This does behave sensibly with "--no-merges" and "--merges", as well as
> > pathspec limiting.
>=20
> And here's one more patch on top of those that's necessary to get the
> tests to pass (I don't expect anybody to necessarily be applying this
> slow string of patches; it's just to show the direction I'm looking in).

I've looked at your original patch, which modified reflog-walk.c, and it
does fix the issue.  I'm happy to send in a patch with that and a test
(provided you're okay with me adding your sign-off), or if you wanted to
send in something a bit more complete, like the series of patches here,
that's fine, too.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--dl57uqa5kfxbrnlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllb804ACgkQv1NdgR9S
9otqYxAAyI8vfVOI7HKWJ+gZv9ZlufUK8vZARdJt0L0vEGlbJEh+GOyBT1Hc4bh2
v3YCs1/WEDjQJtS9Y/wDCj9vSaH4BubKcd/aKrx7BuYYcbj1YSMbA6lsXw1rC4mR
wuLphki990Sz3wdsuadVrwQ/RlGGT2Fju14Iwgry+CY3dG+McpcahBLhHM6WKfyG
nrcB9ylXwIy2ZdVAQzewG5ije2NFfRqz5pzThfLdz0n4xotcHrRo+KaVJun5N6ZP
9UzcVE2L3w+h/4L1lt5jM1kYGoYOvgRA0X5gIlVhmPLn4ZfHn6peC1KCCqCMPjeZ
N5beIiQpTbVp9FKeFj6NsTr3zY7nyYj3HkrodTxXjNoQB8p6Ueyc/JAw6XBeXhJG
KiYhhtgt4AEOrGveogrKylw4FNY3DFCb05Ymfdoza6mBJeYYQqH9NAzyGGC8dC6W
6EbrPzRimMmgZoW9UXMavPUnhygwrqhZIoU8Bgz1zGlo5xCBt1i5ygbTU3/sz6EV
xlR7wdNAj58B4yjEoNBSG4aUo5RpCEGF84e651/xDtFZs9lu4FSbI60CMXmLvld2
zc+mXg3D02h9eqHsjrxL63QufykBmM0AmjGKeLIGM00M0c74vgbgepBst78/FZWM
k1vzCbvg3EuqFMs5MRP8lJ+/Cun6FiWMoPZ0j5wxQJ/xESncIo0=
=cvaq
-----END PGP SIGNATURE-----

--dl57uqa5kfxbrnlo--
