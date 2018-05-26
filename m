Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D26A1F42D
	for <e@80x24.org>; Sat, 26 May 2018 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032376AbeEZUar (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 16:30:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54810 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032365AbeEZUaq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 May 2018 16:30:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:9077:77aa:9ef6:1abb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 236DF60129;
        Sat, 26 May 2018 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527366643;
        bh=KsxMg6T5a+m9SqHw0iucVfCq6h5q0RKT+vSX29ZFTPY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Rj7aBPnF91BjBxbHPL3VmDa+DBJwNRQzRHOFJOEnM9137ww5imk6k0AUGU+hMw6dS
         pP1JJQi7bvGdfg7wpO6q2FzPEHhevOdxpPASmKy9IAfjz5iXUciRY7i8O0KBziuUFL
         x6jOs6Xv3bjf0sIQvhxAiptAj8DpHA8UwtuSphVEpE8DJWxwIPetTssgdRlSPSf6oE
         8Pu3DlO09fM7epEXlb86xLJdhDARoOUo4gb9IYLk3wPsOB3IcD/cMgeGQcvKMWe7mA
         xLO+s3O/ndvBhZ1TRrgYDJmvecErzfwBPX94vrt0oDE7FcZBHDnjt0BwtLIQO9pR8i
         hM0qmqV3zgNuW4io6YJ4NmJW+AErOq1HCApWh00bz9NINUOV1ehwv6bFMy/U+5QR1z
         OBALKRhT/WX0WALk4xt2XBmiska4U78/9K6SyYrEVBjkSgUTnwbVtKm+90l3u/Kari
         7irmzcP2zKE/nOlMbfzK7mV2ob42UxC+2ft4SPuALQpydlcXJ4j
Date:   Sat, 26 May 2018 20:30:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 02/20] commit-graph: fix GRAPH_MIN_SIZE
Message-ID: <20180526203036.GL652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-3-dstolee@microsoft.com>
 <868t861ci6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <868t861ci6.fsf@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2018 at 08:46:09PM +0200, Jakub Narebski wrote:
> One issue: in the future when Git moves to NewHash, it could encounter
> then both commit-graph files using SHA-1 and using NewHash.  What about
> GRPH_OID_LEN then: for one of those it would be incorrect.  Unless it is
> about minimal length of checksum, that is we assume that NewHash would
> be longer than SHA-1, but ten why name it GRAPH_OID_LEN?

My proposal is that whatever we're using in the .git directory is
consistent.  If we're using SHA-1 for objects, then everything is SHA-1.
If we're using NewHash for objects, then all data is stored in NewHash
(except translation tables and such).  Any conversions between SHA-1 and
NewHash require a lookup through the standard techniques.

I agree that here it would be more helpful if it were a reference to
the_hash_algo, and I've applied a patch to my object-id-part14 series to
make that conversion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsJw+wACgkQv1NdgR9S
9ovw4RAAokzDRbIBQaXLRrBzWUBMTUcKXvg8dZwUSrbjl5dsa0in8Z3iaQA/BFh8
PlR7NDlzTQrvvinHxGPQo+TiTUrgF0To0QvarzGvPgMGmX+aCdML0nnMr5PVrFvX
/zHqeJtk7DTIX8lPQckxqng/phPYk3tWOit3UtcAzCQuQuNPnd2ExPKB5aL1+lV/
dXSSMQypWLuwICchYDJ0u4STlJzhXZuviiPV3+XigKybREbqFBE930wWgeqC2z/L
6NRvyYeKiy2eDeUOE28ahk118HpHBLw0JbaftGG+KBbrxQ+VWeD6KeXPrTWFse8t
lT2CUc1C5VMo5GTYXnvc1K/xGQwwynQw77ruGrfiDaK8YYPAsFmJud9d59TGjWyO
oQq7PpX6MwLH6qDvXEK/928esWFfbAcpH/dwnxgCBKapPGFUeJYvo4mHWPStGrSy
g72leqAYzfGwf8m0oNkiUNmNUW0yPnhGUwChBq3SMzEeTdLkWFTrlYQQIsKnluVP
qI6htF3TxDYYhC7jEmtMlWsOB4Am9Nz5/8TXWBdStB8J4CWJ8vYAOLRNVYIJ/qv3
htr9iPzKpG4ayNl/eDz9jVo5/oDdZRl5zhqTSiLJfAUc8XWLLWWAE7tSYopfP0cM
9f6JVmytrVq20Ro7qiMPDeib5FDlT1/suWCUvKLt+AXq+jFT9Zc=
=x2Wy
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
