Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A502070F
	for <e@80x24.org>; Thu, 15 Sep 2016 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756944AbcIOXrj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 19:47:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:45952 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752117AbcIOXrh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Sep 2016 19:47:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EBE09280A6;
        Thu, 15 Sep 2016 23:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473983254;
        bh=pRoTZIjIZcszArH6AZ97tyxQRXNwVzZTd2dcQu1sTDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APcm84sk6I/Cvcd1jm9Vwj+7lHl42XsKlT/DJ2s8F7bMekm+Sbvx7WkSGMlxNQ8Lk
         Xf8MHc/cZmqyFe7FY3L+UKYTVlT5Z9LYFyk+AMost1iFg7wsoFaIBONrQ/27hx4O6H
         pOB2CgdKxc7EpNorjhFy3HyrCESrxVSOtrz+EiN5EJTD6OcNZeRouYCSHHPyM35cK7
         SxiWqGoWPnwG+DOIhkLzSt2QWmYcCUb58/VE87RnZvjWT3ZdWrHXoZ/lbyj9XKfPIW
         XVj2tAyJ3vS2OLI19HhL1k/4aQ3H2NRzoO1KSRDDKEPn6lhEBL9gZaYzs5fgvaHsY7
         0y462HhHip/MnjcZaAPUcT/JdRCU8vwtql0tNHwFZEFHFJ+y/RE/DKSv6Ed8PWc6lz
         tk6h3VPqfDChy776nw71kUjkCB6VzmZNimwR91i+2BeiFsOsBeGmFSgwa3wpsmFKY2
         Mu3iSS872WlNwvLJ7yn0bWZkjR9uul74HWJcNw8ty74JYwW7ANZ
Date:   Thu, 15 Sep 2016 23:47:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf, part 2
Message-ID: <20160915234731.3oqd6x7zxtcxuk3h@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prtrbuga2bw47tes"
Content-Disposition: inline
In-Reply-To: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20160910 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--prtrbuga2bw47tes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2016 at 08:31:00PM +0200, Ren=C3=A9 Scharfe wrote:
> Replace uses of strbuf_addf() for adding strings with more lightweight
> strbuf_addstr() calls.  This makes the intent clearer and avoids
> potential issues with printf format specifiers.
>=20
> 02962d36845b89145cd69f8bc65e015d78ae3434 already converted six cases,
> this patch covers eleven more.
>=20
> A semantic patch for Coccinelle is included for easier checking for
> new cases that might be introduced in the future.

I think all three of these patches look good.  I'm glad to see us
getting better use out of Coccinelle.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--prtrbuga2bw47tes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAABCgAGBQJX2zMSAAoJEL9TXYEfUvaLXnMQAItKICiSGibjLNw84Iyr10Ji
DzTn2S2+8nxe5d8q2D6moDaeQ3z0QH5RS0HfAQpLzAL0rYgF0xnzjyd8fRytlDj9
bg7wRaUGF5tLlC/aOnte2At3oSvbMkG3wgNWz5ZhLwqvimaHC02c1jq9e374kNb6
WavPlJuimZVfWb23kaiWPtblFf93DVFfxlj/9tzSUO5dEDJFwgDwa8d9ZF5FR/Pu
OTU0TDdbE6ExtnAlJLVPV2nQ0T32xmE9DjV5m9EqZ3yuBg/NgdqC1J1H1SC4fFkn
CvxIo5VrWSJnjRONvMxbVZ7dm3ePsBnQyAMmlYD9OXn4DpoNiSW4azw1thmkXojU
JxzzE0A2BSDvdvbvDRhiuh0/aLfGDYPERgE7V2oiemcYv7VHawZDGz6ULWkA6eaU
BVmQurYccgD/FsvyFjrD5PjWWY/KdEImJTlXACOK6bdmBVPHlcsvA/c4JV7niJNA
yadOsfoA0qCk2/oy645GegnAa8hyfTNBnIegnmX3NfQWbKrrflj38IQ48Ikxcend
8rioiz7GE2kBKlsSWHNSSvf5I8yPk218oC1oaW1MGAcCHAxGZ+y4kwuHaZoGFcrl
KiAq3RrI4oFmW6iRN4tV1a2YAw05EX6d81unnpgt+lLdES8Tz7enVevGy6iRR13b
VDvuhCsFzEyJK+1PbMDn
=KR/w
-----END PGP SIGNATURE-----

--prtrbuga2bw47tes--
