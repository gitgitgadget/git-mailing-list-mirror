Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66909207F8
	for <e@80x24.org>; Wed,  3 May 2017 23:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbdECXgp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 19:36:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36846 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751692AbdECXgR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 19:36:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DB52E280AD;
        Wed,  3 May 2017 23:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493854576;
        bh=IZTDzkx6GgtCURVcLz/35/MpFJVZfS6VeGLXs+pbJZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJ/bTGr8uZ5Hp8lzv0Y/Gu07I0BUjyetzZIwrbX11dJ/vZjWMcFCUij/pRxKli7La
         Pda27vrlOdpdSUDtV586N6y9gatz2BsMsc4KXoPWf3gyAUM8O2/jbacpOSTbhRt/YJ
         IxIYBEXzQDKuEIFJyGEH7n1HL2JwMUmQDCxeHJD+2i/+zz4zJMkH7+Yj8vya9Poyh0
         psrDYyOnRGyzregTE6dk6JW3mw2SIvnc9rH299u7cz/roKJW8LF4mHaDv+7wmOwgHI
         AL8fi/GsQArqTGlsKKN3j02c/hUhdLzpzmsqiato/O/pvnfTC2RDajTToD2Tnr+Lpy
         UKqqmOHeyUaLPUIFJEdv/AJmC8csPBaPHboIMk3SOzGjrO8Xse8m5RIwDvtjrRhnsD
         uvMie7E8W/w0qoQaqd9vgoHpVVVvStem6JuUn42NeJYgFiHxNxETirgGGDnDYCoYbv
         iB15I4px10Jt2gY7HmL7H6n5N9uQFyey62To+ajfKwKg7006AHL
Date:   Wed, 3 May 2017 23:36:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/53] Convert struct cache_tree to use struct
 object_id
Message-ID: <20170503233612.h7762lndq64iobvt@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-4-sandals@crustytoothpaste.net>
 <20170502181308.GD181268@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rneqcjpbcdmapeya"
Content-Disposition: inline
In-Reply-To: <20170502181308.GD181268@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rneqcjpbcdmapeya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 11:13:08AM -0700, Brandon Williams wrote:
> Should this 20 be converted to GIT_{SHA1,MAX}_RAWSZ?  I know this is a
> generated patch so maybe this is addressed, or will be addressed later?

Since this is a purely mechanical patch, I plan on addressing it later.
I'll probably do a search for 20s and 40s in the codebase as a future
series I work on.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rneqcjpbcdmapeya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkKaWwACgkQv1NdgR9S
9osAZBAAq/UQZKIR+TniCrTm5Q68ds5LbirRXUH1SvHHEjqcJ7ext1YgrFZaZo5q
sLXKYPYHN7dQIffrfS1BqeUXjuPhlh8M5LpoAKB5QfwRiYVDnTKm/Oxa6Lt+uMcW
thPn3CoVc5Qt9hzanjvYm8Dd8gJonCN7SyWpjG2VhIMThk0PhrZVMJYQMI5bnigZ
e7JEilb78purI7Y00aV8U60Uwih4mqS6lDNAEKM/87d/qlmNQCL9VOtkT3Bhd8gb
BkLXV8IuTIjjl7PbeJibjdgM+3g/eePaIxpDlnzQBbxwRsxwqai/X1vFTUchejP0
dNU6VutWN1tc2OXceELdTM6nWO+ykQ++2i4zL4Jl+9W1C1EcoGxlrO0mZKQ4eotz
2FLGIjRFHxCUelt3gWBhazkzrtAPUFJ8+OSJ9Mjp3/BtgixgZ4IiisCn0dNwkssQ
Qi1xFlYF96bCGlpy7KY/ZP1jiuaLOrNNAkwvZosp11v9drY5PmYwl1zhlEcLu7Ox
BJEEr6gdAhGV0wL9BdMgex3wd2x8SCfRGQrCmjEmNzA/URMHlrFpWmY5uamdlEum
IRClaHkiebQRUs76vdqJU9ZRAByz/cDWRAEiVmgZFRAFXqVn3ceKICCo7vuZA390
gKM7TmtKCGX7Nd0knra7xO7Hble2xqZae1su93Fw2dBeN04lvoU=
=vQZJ
-----END PGP SIGNATURE-----

--rneqcjpbcdmapeya--
