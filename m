Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688DF211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 23:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfAYX6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 18:58:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfAYX6W (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Jan 2019 18:58:22 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84B256072F;
        Fri, 25 Jan 2019 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548460700;
        bh=nbzUEf2re4DjIVID5kdj9YMnCpAACPxTeKfe27Ai8pc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XhzYU2toW45PuJREz/pYlaVpz4IMi4XeoACW0hKC2kw+5ZQuyJzylHDspwTC566Le
         ssGkp7nr4iSZxxsGIIYDnMcs+aPy+C8mhzjP5raq2wMC7Wqt3qeM78qZzZcD9tNs9v
         JY4KR+OmD1KWXpujQkJUbrYGy3NYUefpBpoGLdn55PFm5RWxAl6JpJNdLdi9tkWXtf
         XNgUKFoYJ/SqK9uHMxo/huyNC7VlCNL1tyB0t4GIH3jVWh1uJzoAgyjcTFtwCeiZfT
         j3oqGszkxb/IJ3nKDL+QPB98cVO6Lk3wXUUr8x0i4B+9SNlalNEwdFZZVEdBLbRouE
         ygfwBwz1BYi6VUPRro0/0pn621M43gw1xQRDvSSziBwBpSiGGsWidSkCCUd+hMJ/M/
         0f1eki7RYmPNXO/3NRQsM/SP1JBEDY9kihYVVPdA8B98ua1z/bSE8prxg1jpHg5Scz
         cmS15055+I8dZ7EL2PN0ZtZgrGO0z736k8QjXRdQ+U7V1VPADaU
Date:   Fri, 25 Jan 2019 23:58:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arti Zirk <arti.zirk@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org, peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        wil@nohakostudios.net
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
Message-ID: <20190125235811.GW423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arti Zirk <arti.zirk@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, wil@nohakostudios.net
References: <20190124161331.25945-1-arti.zirk@gmail.com>
 <20190125020451.GU423984@genre.crustytoothpaste.net>
 <xmqqva2cg61l.fsf@gitster-ct.c.googlers.com>
 <5bc3256d49834c96db2a51c12190f2cb7cf7ac42.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JVVqWhpkAs5raV7A"
Content-Disposition: inline
In-Reply-To: <5bc3256d49834c96db2a51c12190f2cb7cf7ac42.camel@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JVVqWhpkAs5raV7A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 05:22:45PM +0200, Arti Zirk wrote:
> This is the built in http server that Python comes with (like Ruby
> users have builtin webrick server). While it is possible to install
> something else, I don't think many casual git-instaweb users would do
> it.=20
>=20
> I haven't looked in depth into it but I'm pretty sure that by simply
> changing the imports I could make this code also work in python2.
>=20
> Upstream python2 support ends in ~11 months and would Red Hat/CentOS 7
> users using new git releases really care about "git instaweb -d python"
> not working on installations without Python 3?

I'm sensitive to the fact that upstream is dropping support for Python
2, and I have no objections to limiting this to Python 3. However,
whether we like it or not, Red Hat/CentOS 7 is going to be around for
four years after that.

> In the end I would like to keep the name just "python" to signal that
> it only needs standard Python installation and nothing else.

Could you update the documentation to put "Python 3" in parentheses or
otherwise make it clear in the documentation? My goal is to avoid
confusing users who are on systems that still have Python 2.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JVVqWhpkAs5raV7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxLopMACgkQv1NdgR9S
9os+lBAAr4XPN2K2OoQHvG7B6hI4bqDGlBNFnlEkvFnhTU8PNL5TDGWVxHX58Sus
r5nZqQmHs/LfDzEST+HIergmbMwkaFKAq7kyHhdk759i7yKMzOP4u9pfgIe1yzVJ
lQPOa28GdkcyB8pB8nogM7MrLrws3JUMGxwt+cyBxdWY3pG4iGzgtwlr2kr5/P10
S2xYfdGM9Mm6SQbGmgYK9ALgaANQQnOGrDussQ6rVarYbml1XOgYj0pooJy3dZ1O
eyHJF/qwAaE1jfYRH7ED5y7tH1xneDVo8D6bsSZLt7N03Fscl/J27Q+X7ARPDWHT
ZzBsv6t0JuDsNGmLkPQMTsWvYN8yx08vdMP3sXIt3lHLjuVkciaDbzfODfMuD6Tz
qt29VOOYKC/1MehMrHEjtiGPLsAxWItWiAntlfs1TnAXrPkP8xewSgXjOhkPfi0+
EXsS0ZWWtAVHQT7uJkvXkTxVLGB6b9V4phF18qmEJAcnuMWRJ96VIytZSNNaYglc
XhFoXpLH8L/ItaGc+cNxZ4Pw1IyLfX+AaKP0CeBvysURRvJ51urKlvVyzHMaRG5I
TMCt5ODoPN11sMgMjKG0T9qCBhvduWzVnYrUY59EyOU51+hSyrljHwcotTsBblIl
kgbPzyAgH7qVRVE8uoBTqGlVJn/p8YuCr6tQ7hD2jKcSRUFM7LU=
=JEyO
-----END PGP SIGNATURE-----

--JVVqWhpkAs5raV7A--
