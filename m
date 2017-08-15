Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9B920899
	for <e@80x24.org>; Tue, 15 Aug 2017 00:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdHOAks (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 20:40:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53028 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbdHOAkq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Aug 2017 20:40:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 945BC280AD;
        Tue, 15 Aug 2017 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1502757645;
        bh=5Pk4C/7FK2HB5BPktIRwcwRGjBgcKt4e8LNvS+0uGA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bsz31GDskKok2lrwI6GiulLyMf7mgdMqRIAiICPSBZ2T6MFKFCaWxaSXQswCw6YMi
         sZuljcov2kbdL0s5eYM4IQHHZztHOJb/bpSyiOZbNpm/jEfZvB2rO/yJwk9fxQ1goI
         /wfVvcUxh49L0seNGY0sxPWUX7enNiEl15ifx1Ag01eBxJiLil89QzUS1l8joQpQNJ
         fXZsL1l8+Pcgz/DtLUV+hZaxW894JFcciJD9YgdLMXaU4zdJn0V5kWjXqXmWU4GTts
         g0CjuI6Eo8saBiWyKpYQqIpKnEzRzLH47eOAnYgpxNcOHOSFbLfiAi8g0xhZ3qR8NI
         QOsQuzEUkXt2vvmta1HqYkovH+ib53ciBlZoC5m49oZU4EbdIioSdGz2ttP3WTs9zd
         ZMo8/0QPAs+gTJZNdv27qgo9lq35jLMhnw1983gVGSUrO7yCPhrj6u8YYnEFGxoh76
         Uft49Q8Jtplfd9f6R2ZxWnVNPgTClvbbC8K1DFHevbri28gmkGA
Date:   Tue, 15 Aug 2017 00:40:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170815004036.m5ejio6gdyvu6e6a@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <20170809231900.3535ja3zqdvyerv4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiblgfrahprlt2uy"
Content-Disposition: inline
In-Reply-To: <20170809231900.3535ja3zqdvyerv4@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hiblgfrahprlt2uy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 07:19:00PM -0400, Jeff King wrote:
> On Wed, Aug 09, 2017 at 03:53:17PM -0700, Stefan Beller wrote:
>=20
> > >> Right, the reason I stopped pursuing it was that I couldn't find a w=
ay
> > >> to have it make suggestions for new code without nagging about exist=
ing
> > >> code. If we were to aggressively reformat to match the tool for exis=
ting
> > >> code, that would help. But I'm a bit worried that there would always=
 be
> > >> suggestions from the tool that we don't agree with (i.e., where the
> > >> guiding principle is "do what is readable").
> >=20
> > We may have different opinions on what is readable/beautiful code.
> > If we were to follow a mutual agreed style that is produced by a tool,
> > we could use clean/smudge filters with different settings each.
>=20
> I'm less worried about a difference of opinion between humans. My
> concern is that there are cases that the tool's formatting makes _worse_
> than what any human would write. And either we accept ugly code because
> the tool sucks, or we spend a bunch of time fighting with the tool to
> try to make its output look good.

This has been my issue with clang-format in the past.  I have an SHA-256
implementation with an array of 64 32-bit hex integers.  These fit six
to a line, but for neatness and consistency reasons, I'd like them four
to a line (4 divides 64, but 6 does not).  Last I checked, clang-format
didn't allow me that option: it reordered them because it could fit six
on a line.  This is not the only issue I discovered, just the most
memorable.

Other tools, such as perltidy, have traditionally honored existing line
breaks better (although not perfectly), which lets humans optimize for
readability.

Of course, clang-format could have dramatically improved since I last
looked (which was around clang 3.4 or 3.6, I think).

Overall, I do like the idea of using tidy tools, because it does reduce
quibbling over style quite a bit.  I just like the tools to be more
responsive to the whitespace they're given on input.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hiblgfrahprlt2uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.22 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmSQwQACgkQv1NdgR9S
9oseaRAAk2rwyfadzaMurgAEqK/gUICiL/UA31c8ELzhoBScqfHmh06CfGfDlPhI
CNPcXoCXdJnYcLhwvKhzAKGjM458qpZq1WDEJW3C5w/qA2em+wrbgLZwF5TcLyAI
eM8iG5UCY9l4cvYn5IyGeVIDOwqxPJHfiE2fW5jisZWtNGz/GBJU0RhXZDZizu2i
kdrPoGDn5XAmnVtCD4GhCQmLoCV+0oTgP4NHxPCV1IpIR/WfDpSoZBRxj3RqzavL
heig5SwoRgh2gp1NQKX50PRkN7mBrY/c5gcdL2aRamaScJMXBqMLmQ1/kn5ChlE8
Dgd7BnhaZMYGNgYys8hksmdjx3RtC9IC7q6pk9woWQgzbgKDI1pZV8wY4mGXL7RL
Lq0tPmtfN6yQVvqIqmA69Lzq36+AbG9AKh4XmFTLRT1OzC7kpB8WKZpcgE8e+BJ8
Q+LGfa4U9fwE9fxUwHaowPaunr+ZAaCdeuZxbWaLm7UeULorjIB7J9tB5azokw6x
QokqYnSaB9tvjF7+F6xSWHcdTVWIvm7fNlPy7uBRYviVz6JxPZTfvm+FVr9qd/Od
Xx74YV5EHjwHyXkEkux7zIGSHxCvrVd2pb8iZUSU0ZJPU4SRuPjXlBQff94HvR/B
0d1AdmFTxzrMOYKCwqtUjZ8BXka2NWu9s5U47ssK1dN1pFy/4Yc=
=twBD
-----END PGP SIGNATURE-----

--hiblgfrahprlt2uy--
