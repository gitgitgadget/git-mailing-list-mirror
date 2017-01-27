Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA201F70F
	for <e@80x24.org>; Fri, 27 Jan 2017 00:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbdA0AlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 19:41:14 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40368 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752247AbdA0AlM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Jan 2017 19:41:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DDECC280AD;
        Fri, 27 Jan 2017 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485477656;
        bh=ygB4c7+WDtUzvx40H+Vhmpcutizhd1Z5pPThxSs4n7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u00lFN7jzps0n4gDG6AtljQall5HRIgkhh693YjyBjp5fOKmY6LsFQ+pNk/FZidbr
         TMdBpDjGL6ZhuuifKqFdVZ5KshJPFDVh0B4LqfTCoijhcKx/xz2O7AVM2FVZmgZmvQ
         leRVklnztyHOly6RvQ8abVLmiXkyuLHaYGv87/2E/GikQKoQ1ymcQ306SperC3hsQi
         NgXpxmHhDJwV4DHumGAjZVmE+hsDQto6lhA9aEtWxoT+ENnBBBT0rm57iAujy/pnwV
         gI75YDXFrz58ZhlMATjwNbSKBU15l7eZFeBd4U5/zh1dzOXaE2/nDYbhDjD+WYnTP9
         sYqB+TXlTL3Yh95ETHgFyd3S5jnuBAeEqihMnblhtREY9m/b3WHYIbnNJTSnfZ25Xe
         1jxywr+vjMjXyKv8I2XRdFLYgn/HZ6tz2BJnGJWds3UL5GlHACWYVYIxOfd+Q3ql3Y
         pJe/ekP912l6NTHcbqn95lkDdmatQVDiuqKUdtUP6dL4SrvuJPG
Date:   Fri, 27 Jan 2017 00:40:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
Message-ID: <20170127004050.23jrq5iqwfxcwmik@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
 <20170126001344.445534-1-sandals@crustytoothpaste.net>
 <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
 <20170126074304.GA26530@starla>
 <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
 <20170126191841.GA6060@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbwbayi5l5n4p2lu"
Content-Disposition: inline
In-Reply-To: <20170126191841.GA6060@dcvr.yhbt.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zbwbayi5l5n4p2lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 07:18:41PM +0000, Eric Wong wrote:
> > Eric Wong <e@80x24.org> writes:
> Junio C Hamano <gitster@pobox.com> wrote:
> > +          "<citerefentry>\n"
> > +            "<refentrytitle>#{target}</refentrytitle>"
> > +            "<manvolnum>#{attrs[1]}</manvolnum>\n"
> > +          "</citerefentry>\n"
> >          end
>=20
> You need the '\' at the end of those strings, it's not like C
> since Ruby doesn't require semi-colons to terminate lines.
> In other words, that should be:
>=20
>           "<citerefentry>\n" \
>             "<refentrytitle>#{target}</refentrytitle>" \
>             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
>           "</citerefentry>\n"
>=20

This change is fine with me.

For the record, I don't have a strong opinion one way or the other.
Since this code is related to Asciidoctor and Git has no existing Ruby
style standards, I picked the Asciidoctor house style, which uses
multi-line %().  We could pick [0] as an option, or just argue it out
when someone cares, like here.

[0] https://github.com/bbatsov/ruby-style-guide
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zbwbayi5l5n4p2lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliKlxIACgkQv1NdgR9S
9os7uQ/7BtJnqmnOtuRbVpYdWCxdMskCH/YPN+5IGhEIe9A9Vmi0vH991kYJ4cWQ
52XOc7lmqm4BJ0o0Sxt/OOgeq+UFa18v6vGin0xhoIulm4cdEIHM30f7MGbP7iWI
UZGFCStYv80fBVfqCCHz1MyN/SOAhgMzPPQOWKUxz7MQ6JQmRyKfgMnCaBPYinE8
XCTWxi9uRRig40bldF7VKEKxxmiB7E4g1vaOhWRAAO7CSkJFh82AjEeQtnZ3smnJ
35G+1mx2bmkLuobjFFeojdggVWQE988aBO4LNbdKNMH6oOXm+An9YdLpwuVAOD+8
SjsYrK3SxaTAzUw3FCA+D/E7TeNr9jEyDBJQ1JawpIpoLiuADCiGb2ZessTf+Y2Q
2SAKUsVV3IH2GV8FTSAdBLW38INbTXujDPTCzhsuwzRQHVsneNLu9kUZZCFkyC0+
ejEUcTw8KTQvhKSbSf16JiO35A3y9k8eWty9gjFrqZbBZOwIW87EkI7DlO622gTX
ZjOnqXHc8X0HkbuJlIsrulEOQDAhAIYvQ7eoenLnSUaDKiNQoBWoZqutXoKOHjfx
6AfkmQ/cSeRcQA75TKsybMz14ukaPAuk9JlniwgTgrJ5S66GNyLe81nzdnlCOWM0
Pkzvk47fkRhWD6s+6MGw1PSVTtga8Db+XbgjTUuoC7GCgJexskI=
=BuIj
-----END PGP SIGNATURE-----

--zbwbayi5l5n4p2lu--
