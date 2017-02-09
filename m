Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127731FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 02:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdBICN3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 21:13:29 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38118 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751139AbdBICN1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2017 21:13:27 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C2B25280AD;
        Thu,  9 Feb 2017 02:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1486606333;
        bh=lHoa2tVgx0CvPAX2fRPU8pljj/Ilf+g5tqJaX8u5HnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ft1OkNAfCLE0FFVxKOhvXpjlSWzdelYeMR9tgiP6WKA5kcMcdHkAZSwWKf4b8dorY
         +/V0HZeFt2f27iDoA7N4qGqUTWhT8CYy4p9W2sFS4ktk6FUr0VvJqecEe0CCPxxQ/v
         A64qiMBOWztzLUfZ08XthUmgiqJlY4zvrSWXCSdzF5YQgcxSXGiIFLKMMghORg30Wb
         gLHIN1VZ+AqvH4OsztaM3Wkbft/ISOTTDqPQWyewLvnAT7+C1h0Rpf6Cl7+bUmglGs
         lAEHPt+7Jaz9wPFkHOT16ZVtxcpb1pOXrIWg8KbrLajPfpEpxwXxDJmN0ehCS+lSH/
         IvNbw0vPHi/yPgDY71LHrSQJh1BE12f1NFjdrNz14GYx6JhAJGESIOUXj2jOfQMvNN
         XLxrWHe+IF4SArAXg5Ro6Y0bhhLgLngoJ2371QndedQ+JXL814X2SROB7ikyBehy/D
         ZLEBVMUIkBspn556BuSrpX0BySIrZKwySnlSNaj+3KmJk5Zl8E0
Date:   Thu, 9 Feb 2017 02:12:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git-scm.com status report
Message-ID: <20170209021208.rvy7uww3qsktbf4a@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xbw3u7rvgjj75upi"
Content-Disposition: inline
In-Reply-To: <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xbw3u7rvgjj75upi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 07:27:54PM +0100, Jeff King wrote:
>   - It's mostly silly for this to be a Rails app at all. It's a static
>     site which occasionally sucks in and formats new content (like the
>     latest git version, new manpages, etc). The intent here was to make
>     something that would "just run" forever and pick up new versions
>     without human intervention. And that _does_ work, but it also makes
>     things more expensive and complicated than they need to be.
>=20
>     So a viable alternative is to use some kind of static site
>     generator and have someone (or something) responsible for pulling in
>     the new git versions occasionally.
>=20
>     A few people have expressed interesting this. There's some
>     preliminary work here:
>=20
>       https://github.com/git/git-scm.com/pull/941
>=20
>     and at least GitLab has expressed some interest. So I'll let people
>     coordinate in that PR or a new one what the result should look like.
>     Working patches trump discussion. :)
>=20
>     I have also talked with the GitHub Pages people, and they think
>     hosting it as a Jekyll page wouldn't be a big deal performance-wise
>     (with the caveat that we'd need to pre-render the asciidoctor bits
>     ourselves, as Jekyll doesn't do asciidoc). So that's a viable option
>     for hosting it for effectively free (though I think we _would_ still
>     want to put a CDN in front of it). But if somebody has an
>     alternative option, that's fine, too.

My only concern with using GitHub Pages is that I don't believe it
currently supports TLS on custom domains.  Since we currently have TLS
enabled, along with HTTP Strict Transport Security (as we should), such
a configuration literally wouldn't work[0].  I think it's important that
we continue to serve HTTPS only, anyway.

I agree that a static site is the way to go from a maintenance
perspective, though.  Jekyll does support Asciidoctor with a plugin,
just not on GitHub Pages, so it would theoretically be possible to build
the site as one big unit if we did it that way.  I've played around with
that plugin, so I'm happy to provide guidance if we want to do that.

[0] HSTS would prevent anyone who had visited the page from downgrading
to an insecure connection for the next year.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--xbw3u7rvgjj75upi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlibz/gACgkQv1NdgR9S
9otiqw/+POK8BwZTM6JsDOKXHkj6q3xjOr+vBAdZW9E3eoelAlLxAaApNKcxVgmx
jFMiwU+Q7I8a4nVfhh36G+vkR+T5nC0hWQ57C/QPnsHdSmMZblp/9k5fZbcrowvp
oK0mVCdD4NDYOcYyr6EpIoYjfOdv30bQycYH1t5QoqK/4Fsm5hpQXgfPIN8lWNbu
YD/Rx5/LIDGlC9otgc1S6J5Hv3La9xchkJFI5gh3fZQ9TRYYCXffWz8sJRdqfEk4
jiX11qdKku8zashBlh+fskSwx1eGWuVLK6IM+Lx/9nGqPcj+Pzz2Qsx8cvbpPfNC
Q/OTZJBI/nUsOmgNllTK2UxHlpqL8QoM52EfG8PsbUNVToEwAORovfuQ9S/wx/ZE
SFpGols7bkrGekOB8c+N3KZhLyGMHU0QYlCMX3f3MA/YkdNiVIGIfbhiT5OSetOO
OuIp84QRMkQvJYUkC5o4fVqQBaq+ytZUr/86rU7yaxT7OOS9Em1Su273h0JnUsIc
c29HdSWAvP2lkeMoZCgELtfnn6Fg1o/7EcJV/gS8QkV9xDv9vbkB7Mzf783RmzUK
vokeCGMZqpZ5JRzPUzLGTqnxlMBmw7RREOeWbVopLUU4Z+crZlvGQ8E3KhC/GrL9
tx9cssj+y/ESeVmE/dEDYnkHOAsPILQDD8lGrpFSFX9IY6gX9mM=
=mMa4
-----END PGP SIGNATURE-----

--xbw3u7rvgjj75upi--
