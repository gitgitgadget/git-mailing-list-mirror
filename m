Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2872013C
	for <e@80x24.org>; Wed, 15 Feb 2017 02:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdBOCI4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 21:08:56 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53348 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750791AbdBOCIz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Feb 2017 21:08:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A2C38280AD;
        Wed, 15 Feb 2017 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487124534;
        bh=vd7tcBodISVgTdv/4pACAmKw4g/qaval2ZY7tguLWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyU/592NZP/0+POFsMMTBvLqdX2DSwvxfes3JrOkDjAjOOZCd8i2oGGA66wKgDUio
         PqROygZjf0KDW9Hc1vjhVWuICgkuaD6B2yaVG2Xp+MGI0o8OD/73Ocy5DzkUDDQUMi
         LF6V/RqU8W51vjGaQlEg5/bPgVcpoijuNCZfAbYykBsHxfB6tGHXzmk2WsAPr0YNZ1
         fZOYH5KrvISH+55Av8p3oaJ2TbbqLxT3B+eBd5rAcF4wbj2NUMBi0DjDfYYb0M/Voe
         V1m8mXBvp6VSE763jG/cCwFCfyJPY8MFoW9aUe5493TraDo0q5oDOZUMCvoXUuQFf3
         N7oc1i/hVj/2IZMlOHZabL03tc83GBiNln6LWiiPmFiB8/PDnh0chahD6pEuRvHFNz
         SwB0QU2UpIyfPU6bef8j1zxMQkpN3KPzFQyxDfB/dV9/soluHcgggYV+qh1PRfGOtu
         CibXtV8BPboeqB0bZO7cRSZm3SgOovGbZ5Ud17yq/pCHWx1lObQ
Date:   Wed, 15 Feb 2017 02:08:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH 14/14] builtin/checkout: add --recurse-submodules switch
Message-ID: <20170215020851.awwddgprd7nsdbuv@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, gitster@pobox.com
References: <20170215003423.20245-1-sbeller@google.com>
 <20170215003423.20245-15-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e4l6gfacau2cta2i"
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-15-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e4l6gfacau2cta2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 04:34:23PM -0800, Stefan Beller wrote:
> +--[no-]recurse-submodules::
> +	Using --recurse-submodules will update the content of all initialized
> +	submodules according to the commit recorded in the superproject. If
> +	local modifications in a submodule would be overwritten the checkout
> +	will fail until `-f` is used. If nothing (or --no-recurse-submodules)

I would say "unless" instead of "until".  "Until" implies an ongoing
or repetitive action being interrupted, which isn't the case here.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--e4l6gfacau2cta2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlijuDMACgkQv1NdgR9S
9ouxMg//Vy2PGTiEdcyBPfNM0jR/oWO9w6EJ38kd6uG8k/jPVNrpfAcxwijHpL5g
oZfom4Og7mrzzwsc+uLAoEhoxzpgORYKIkctK6D5WxYolJNHWg4ebziZ0A3VRFvq
WRaRK1Qf5v2zrotrzw349UmVvK0VFd7iXzFfC2/mWkZzk940nd9kIeoxBuVVTNxt
qMFnB65sCvcfV/DbuCVlUKHl5t8Ky5aeAhYfhI79VoNllRXmQO3K0m48Nbdq4y+s
vckfkIEEv0WxEygJz/EP/YlUXzT9zwm4H9wVHWRB5q7Pi0cDylQqB3UVqQ3nBJzC
JOiGM3e4y9NfFoSBMkBd+XbOhrvN+09HOFICjRn43whk9XnQqA2YXtrhVwcglaXt
avEtoe7GiwGAJ7qboB0MpQbvM+g2FQR2LWfG7yuh2S4MK3RbkdqOVqV8a3EEQSRi
VZaFtQJJ1EY7GN+3NrRIuLw9jjjJ1dVLVmTlK/OdvenAheQstGvSsx88beTBD7rb
XcpyGfieGX5z4b/UZC+IZ5KgSfyRSbmQTxoY97VVj4rzyw6VICro+OHKYbAaSLZw
f8uldwHfwWEZ/TLpjDm5MK3ahEjxPyERBvTuBbHerV+JcK2H4nCk2acV6DNCC2D5
w+Aanl+EroQfI7dl/F3ZGm5C+LXTfjLgqxxDsnAZciASz06luwY=
=pTi9
-----END PGP SIGNATURE-----

--e4l6gfacau2cta2i--
