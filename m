Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD4F1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 23:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfIKXTf (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 19:19:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58644 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfIKXTf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Sep 2019 19:19:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:9d62:8fc3:cc7d:8629])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06DA76074C;
        Wed, 11 Sep 2019 23:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568243973;
        bh=898dR1Z8rZjmb8zpNfr5Ri80AU4z/OUphIVE2oXmsA8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nuw8VaozvkqPlCw+ucMSI+ixE0EdvQxBU7NXmyh2oqqNRB0/W/T7iK7wJ9yCx+wDC
         vSU296eTIT1OJFBkbUi+Je9iz89kD+LPoMppPFORn7KlR5FpQ0r/UY20ctp+se1OFD
         /NGLokkip4/X/p7IUJVXnyJv25v7BYQRwyo0Cmwr7azJs4Zt9hKhhnLjexeWAfOhFy
         OCVk1LCFkdmo7zBKk8IUov0ihaWwZN2s1XfDLSp7ZNwUXnOMligZM5a5HlvePayUk4
         EeY+BmETeIPM9eJw2W6m20DhPkuegj+9UetYy8JiPhoLm8Yx/YGLdS1cDrIaSmx0mv
         g3OeGkfEQtC/fqO/POrHPrJU2+18kmqT8HGEdCQK+g1crgaWau3h6wpYLsVoRZAciR
         w/V7dV+VujPtxJCWejltzaD9hJbCO6Cl1N3J34b6yKjvJm+oEzSth/QBjg4NUu5DWp
         1IfnIHXOTUze2SnyIOKEO0UXSjAjeehCS54/hQ/OOg3zOA1h9CA
Date:   Wed, 11 Sep 2019 23:19:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190911231928.GQ11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908104833.GE15641@sigill.intra.peff.net>
 <20190908171807.GL11334@genre.crustytoothpaste.net>
 <20190908212122.GA8514@sigill.intra.peff.net>
 <20190908222423.GN11334@genre.crustytoothpaste.net>
 <20190910184422.GA17446@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubuMVesmirrCclZT"
Content-Disposition: inline
In-Reply-To: <20190910184422.GA17446@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ubuMVesmirrCclZT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-10 at 18:44:22, Jeff King wrote:
> First off, thank you again for your explanations. I dread digging into
> how anything related to docbook or xml works, so having you serve it up
> on a silver platter is a delight. :)

I'm happy to do it.  I was an English major in college and virtually
every assignment I wrote in DocBook, so I'm far more familiar with it
than I'm sure most people ever want to be.

> Isn't this already the case just with the docbook DTDs? I.e., if you
> don't have a catalog entry, it is up to the tool (xmlto in this case) to
> either fail or try to fetch it. That seems like the best we can do. And
> as you note, this typically just works out of the box on modern
> installs. Of course people may want to build on non-modern ones, but
> IMHO we should probably be more aggressive about dropping legacy support
> in the documentation and pointing people to the pre-formatted pages.

Yeah, that's a good point.  Since we know that most people will have
catalogs working (since usually fetching the DTD repeatedly over the
network gets you rate-limited resulting in a failure), I think it's fair
for us to do this.  And anyway, DocBook 5 isn't exactly new: it's been
around since 2009, IIRC, so distros will have it.

I know Homebrew doesn't have this problem, since they fetch the prebuilt
docs, even for HEAD (master) builds.

I'll try to get the patch written up and sent out today or tomorrow.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ubuMVesmirrCclZT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl15gQAACgkQv1NdgR9S
9otlFA/9Ffruw+ypJ3SbEzVa68gAtjW38zHK0vy31qYRBSNK6Z2PvHXlL0Wvm89f
4zJxotCQiGk0QXOytP1sKrwyeOxZklupobqjDUFTXL8de7ZRi36LR3ZPMrCx7Gym
sbOc0cRQ61wHibYTMyxMTFbP1kAoOTzEeKyb69hQlFH7Mmwwe+tzW7lGS41LDvaI
RhHwRm8GtwXost+EkofNiUy6sWfVW4FhX7ePi9VU3uOesDPF/UFFoQaT0xiJxuRT
AINqURTgILHjnXSdv1lhuwnTsDVdx4rlspQs0L2hBuhWHvgHnS3ZiZULf35VGC3H
A3s7AUz7bmeJmr647WmDWWcIc19a87eAz+ohKIU+Bqstg8jPJQ4EEWxFSHZ/5dHp
EceA5xnZ4UcS0S1bae7jfFCwSUnGMQwrV5PrOq79gUXOpOlCx+q5zp2JiZusQd+s
WuOLlpPAb68UPbEOBVGN1309LxkTCX+XaTTet51kSAXIcDQKKhu70T9nCx/g5ljd
S8Mg2F5/IWEtB35GDZX7iXAHdi3NQP+yn1oevk5+D+gpsOl/sbMQUf1gLGuzMmdj
2BUo16zv4aG6HonjhbLMNMCkbzPTlTjptXKVzvFAAtNSSLhz7V3/hc3kB0asv189
cGz0Iv9Xgrs5v6MIEOyXRO0RxunCIYGEjwl72ka2S0SsldH6X9k=
=ByQb
-----END PGP SIGNATURE-----

--ubuMVesmirrCclZT--
