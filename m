Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4181B1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbdKMRLa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:11:30 -0500
Received: from kitenet.net ([66.228.36.95]:59350 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbdKMRL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:11:29 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1510593079; bh=hU6cxE9g9zs07uIwngr8moIuIosiEwci/d4UTNg6//g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApCM7rCX6xYdhpM+YpT/CNA2qNcMHyzl21JOIj9WFSG7+g1+Fg8LeMpNKU6p1dge4
         IC6tuvYX5yV3/zSKog2y6nB7Ke8vYdZjwYIQQvmibXGzHLbiGC6RJ1AjYLcM+Qn3kD
         6/iLT3gDrABawUoreeMm5XFz+QIqCiYro9xgGUj0=
Date:   Mon, 13 Nov 2017 13:11:19 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] link_alt_odb_entries: make empty input a noop
Message-ID: <20171113171119.fjhufmbbuidr35ud@kitenet.net>
References: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
 <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net>
 <xmqqd14pef5q.fsf@gitster.mtv.corp.google.com>
 <20171112102739.6xtnnsmtabhnhrm5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhns27aii4lrebpp"
Content-Disposition: inline
In-Reply-To: <20171112102739.6xtnnsmtabhnhrm5@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qhns27aii4lrebpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> This should make Joey's immediate pain go away, though only by papering
> it over. I tend to agree that we shouldn't be looking at $PWD at all
> here.

I've confirmed that Jeff's patch fixes the case I was having trouble with.

--=20
see shy jo

--qhns27aii4lrebpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAloJ0jcACgkQ2xLbD/Bf
jzie9xAAufbI9QW17+zscUCK5fS7PLvnXLh11T1yorNGBpr70pRLAJBwULJYUSSL
oo8nhijxXZKf0j21AA9qMJlewzEOT478Ipnxu5Rz83Lr0uKIZudXBSP1Z6546gDY
JjaMJIs/soxL9r4xEQ+tkUYnJjLAmkequDWG+x3qkiPefg2MOYlyXmta2sPGkIVE
WAFb+yMEyaye+vs+KBDBxDJnbQqrNyM/tts5JwM2qYos5C4Q4/IWI5VkQEgsHSOo
xD3yFM4fzEMKVeoHUTWi4sxRqG1ENQXx8Qvuz8WdkmyffN0+i4ZHzUv46sSHexmc
Es/ggLpIK8SF4YQG/t+m77PBHwZ2i5O8q4VKTFb9Jo/kR8VkHEwZZFgtLL+m6Eou
YiEiIUxQjlIyghsQBTqHcxpIFWzNT6ao1qyjNmaWQOSaocPQ6iom4fbtwJCqeShF
ma6Xxzee7aK72gfAqocgHcTiOJ4+VKMy+vCVhyix/WveuvjIJvvNxbRXfFFAeLqG
TeELIF11+xFuGkwiAFe4/2lkdm6cflFNkE+7D2E0sihhyT1QoDYiZKOMpueY/Wok
03fi+70w0wsXGfihOwru5s62ugGWh/2uicpJd55TVajlAd0nxIlm3V6zdH2GzfZQ
3MRDbpZupg+uHexrY+/QteFf7WV104JzIYca+hF8uKp4JjB2nvY=
=J7hx
-----END PGP SIGNATURE-----

--qhns27aii4lrebpp--
