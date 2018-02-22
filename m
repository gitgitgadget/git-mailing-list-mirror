Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707331F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeBVAYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:24:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33664 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbeBVAYR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 19:24:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 93F536042F;
        Thu, 22 Feb 2018 00:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519259055;
        bh=qXDxdKOSl3oPdDnZnwSLfLDNm1B6qlXgkzFs8lh1CSU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=slDu02Lr/GStjFPIZDADBISaZGwTr+1paI9E1SwPwXvNEtYinwWJof4DiqU8WtP6K
         YP32PM4s5XmdcNp90tO7FaG0XU52p8KW+vL6pVRSZWWrQk42loEBjAnNwjyxk+Zms1
         z8/ZURiwsp6K2H7famWb9sKZq9q4ytiJznnqZ7909SC9QR9XRXs/GJHD/4FqCzXLgl
         7Ucht1NrTwlVS/ad6AD/GFPuBro5vWW+mUlwe2zFVEA0cZWDzUGKQtZB2+M59Lwhkk
         YBagfuTnm08cP+ybwly1cV5hGr5v3MgbEcQznr3ZvJTd57r6AsoAyYXeecKMVUtxyO
         MHrJ7aO8ZdeQfrIwMRhkseh+hxttHXluXeEKNsekYY9jnE91LNYZD72Y3s2urayiBM
         yRK+7yhor0A3x3mxKkFBDNS4MOPamWpuq94L6WF81RvtYXPr94FlKW/r6cpt+gAznb
         Lx5gGan6+huQ+D2L4pmj0BnbyfpEHo07ck4ODOBtUQDIKqOwyzd
Date:   Thu, 22 Feb 2018 00:24:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/36] object_id part 12
Message-ID: <20180222002408.GH6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
 <xmqqh8qayybs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <xmqqh8qayybs.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:47:19AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This is the twelfth in a series of patches to convert from unsigned char
> > [20] to struct object_id.  This series is based on next.
> >
> > Included in this series are conversions for find_unique_abbrev and
> > lookup_replace_object, as well as parts of the sha1_file code.
> >
> > Conflicts with pu are average in number but minor, mostly because of the
> > type_name conversion.  None of them are tricky, except that the
> > introduction of get_tree_entry_if_blob requires a conversion of that
> > function.
>=20
> And the reason why this is based on 'next' is...?  Which topic(s) do
> we have to wait for until we can queue this series, in other words?
>=20
> Thanks for working on this, though.

It was waiting on the hash_algo changes I had submitted, and I don't
believe they'd made it into master.  When they have, I'll rebase and
send a v2.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqODagACgkQv1NdgR9S
9oubrA//Q5ImqUzEngiG6WhR4DTGcxNVbuGWCBExcJn4xd72izYtyraJNcIJ/T4u
NIIM/1fkxqBd2iWzCWPSPTvtwtXsJwh6StCXe0PRFiBgfhp2LuYVLw7mLe50DquX
mlVuCk/d/QWtLnSr8pgr9xdQmSleL93ZSJwX1i/ttkzs31+3qZnC972RdCSNikh/
NkV9zHI8bJXjzz7lATSldoOQOy8vEcoDwu1fzW43sFLDHpJMnYDAyq7NXQzfUySl
MqKhmAc7cinhre81sFWC/x7Xw0f2W6HCsEwq95J/bKMAWDT/iqNh8DdXpvb8Dtp8
7OiNxQsiKbpUQxnOWL+SOqu5gFHs+ex8eYuIEszKEKfYplaCvkgrSEDM/1lVjfKC
JhjRsZt54uEUxyDvovwhiUZk+QbW3nc1oL/vfmiD0W2pFxaxpFUv1I0/kwRWRZAq
6Fvn1JjHy9uemREur/5H1Lno6Ss1dHgk7VRG83jPzLmv6cUyU45P9UTcKcsG15Q2
o0Gr0bw18BkWZcIhGzJ9N3thXNCuAA6CL/OkMNU6jmP3otU+Fc7IGuuR/dn3XRej
NQe6CWUmY1dgL7CTQl1EkD75NlN6AwI5KBxZKkn9GxDkmqQu1WraRVJoYOqh55fy
GunULCH817eqSbKx82bcELTUhM7vDLojxj/sNjxUEK+ARIq7oms=
=C4Hz
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
