Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DDF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBFBpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 20:45:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752126AbeBFBpD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 20:45:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 418836042C;
        Tue,  6 Feb 2018 01:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517881502;
        bh=otxffA2QSn2npenjsa8/61tovdLLGFEw/XLe6ALjVsU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uL7dRGs0F8dFddc+frPcEUxXx1T3at1sYXw5g4PGD6yX84UoSRxizv5pzfvpptr2A
         GjX1m6F4fdBn8VO8wYSYm2Hpx8CqdhIMkcdQIGkbNwEOaFksRzk3+Kt974qA1XIEEq
         xNXbvKSG1yydTga/IjwIUweVZbxf8BV70IBZdKO7WX5iI0NIyoG69pj8uo3Rxwe4Jj
         uKpveyRPOtKsXYPnXtYm1kcFjt4ayZXIPtvuV2c368zHI5jAnZHhuDM22iqIV0xFKj
         DqO4zPxWx9bb5JsP102TSwiVI1y+FR9yMNX4Lv4cZHJIBVfNIlnqtJUBtAKPJxkLHd
         5T7VX8Un/Eg+oPa9qGwgMQkaIq1j/ylwKjcN1CmyJhPkiePi60lP/RDp21uz7jrONH
         TnxxfFTEAhKlDfPKDG3XFHVxswKsaj9fu/cTNq+uKW59TsgG3/UL1Yl50/hSEBpZWZ
         KMNUIR0CJIraSvd7CTUao5hJfKMTRE5C7ylJYwlKescOVT5N+7T
Date:   Tue, 6 Feb 2018 01:44:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 042/194] object-store: move alternates API to new
 alternates.h
Message-ID: <20180206014457.GE7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-22-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <20180205235735.216710-22-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:55:03PM -0800, Stefan Beller wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
>=20
> This should make these functions easier to find and object-store.h
> less overwhelming to read.
>=20
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  alternates.h                | 68 +++++++++++++++++++++++++++++++++++++++=
++++++
>  builtin/clone.c             |  1 +
>  builtin/count-objects.c     |  1 +
>  builtin/fsck.c              |  3 +-
>  builtin/grep.c              |  1 +
>  builtin/submodule--helper.c |  1 +
>  cache.h                     | 52 ----------------------------------
>  object-store.h              | 16 +++++------
>  packfile.c                  |  3 +-
>  sha1_file.c                 | 23 +++++++--------
>  sha1_name.c                 |  3 +-
>  submodule.c                 |  1 +
>  t/helper/test-ref-store.c   |  1 +
>  tmp-objdir.c                |  1 +
>  transport.c                 |  1 +
>  15 files changed, 102 insertions(+), 74 deletions(-)
>  create mode 100644 alternates.h
>=20
> diff --git a/alternates.h b/alternates.h
> new file mode 100644
> index 0000000000..df5dc67e2e
> --- /dev/null
> +++ b/alternates.h
> @@ -0,0 +1,68 @@
> +#ifndef ALTERNATES_H
> +#define ALTERNATES_H
> +
> +#include "strbuf.h"
> +#include "sha1-array.h"
> +
> +struct alternates {
> +	struct alternate_object_database *list;
> +	struct alternate_object_database **tail;
> +};
> +#define ALTERNATES_INIT { NULL, NULL }

I was surprised to find that this patch not only moves the alternates
API to a new location, but introduces this struct.  I certainly think
the struct is a good idea, but it should probably go in a separate
patch, or at least get a mention in the commit message.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp5CJgACgkQv1NdgR9S
9ouZmA/+LydD6VwFu/hfMRoBNs85K80tXboND/aXhKWpEDPSpNDyl1BY6BWstGzV
f1gadcmRZZj+NEY6qglVwCcRmyfYzrNE/dhTWQlgPBxJj1VGBYnshxZZh/tJMNCO
9vYhd3+RZH9BvX8jNaqKydokHKsALkysxunG7FZ7GHUEkr9CiC9x85CxgHGU89Fe
siqqVrC+jQW6mftyXmVx4QWam/ogRnHTFnfaEBW0h0Qc7G/M5GBs6yL+J7B6crY7
Qgjvb/cHbUIIlcLM4TDk3VOWHI6U8fk4GhUl+jU3gPav+sK7YV1tZmWEJTzvg1GE
T1eqS7taBIpOtFMSTJFKKcKH45dBFWcC/BA05qhv0SUo1dlNjxcHOohlyCnZelBE
qpPF6+0K+baXYarG/u2/5SZ6gnO5//jLrWYpxEr1JRLzk8+bcgRv/77+0x2qgrUv
OyG7N2k8pm9inV1WzdjzCzGmMCeCFo8eU8MfwYSs0T6Wx0A+R+M/qo04a/ELH/w0
E3ua2gJQSuCIyZPjCI+az7hP9sqBqgIwUY+c3AHXgZN4R7Her3RZGiNlEDUjzPId
RdnZEwusfs62NgfOIC1CJ3ilbHImKe+ExLmTM0rx2tY4I4HRsIdDxPGJwtFmfVCM
efH2B2ae3pNa+1Hgmpqg+ujpfguBztj4zDqVe1feKBxBwv1M+Q4=
=PzqO
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
