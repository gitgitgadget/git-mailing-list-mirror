Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A1D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 01:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeGFBPA (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 21:15:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52354 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753439AbeGFBO5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 21:14:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 09E6660102;
        Fri,  6 Jul 2018 01:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530839692;
        bh=EydAnixDKvkkLKua7wboNo+FyZMaUhMWQfNQfROHxyY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QzKuFSwwMYP1a4dv4zIr4YTnlCRGHhAqW0hn/RSde+riDL87h9DDglNF1y3Os1Hz2
         hwqi+j5tf6/Q80t/yKqVYBz7BUIYCi8n4nnVeYxikhefKS9nt3UOutF8NULm7P79QC
         Wue1EEWWgzaCO06HMehN1Iw1ujWBlCYC35pI6YfMLIMnnSleKX4MASumBw6N+iBQJp
         EJcKXUScHVhKocnuFCzzVf+9Z7huRd14UAuK5595xs0tV2tTDKath9Cz1II2OeiHpn
         tETzM3B4x8LwiYpsl2y7WOECMXwezolCmy+XBSDHGhNVPEXAlkjEINRvMBCNiUNONm
         /7jD3SauQuQzP98AG2+DBhNIZ/zm2Dfh0nfN7NeEW1Tnj1OndcN74Q5TvVDjKPnSJl
         Pf/23BRyCyy9MnaQa3uaS/h9dvoxxGdlj4gaF8S1HT+bdugJiF7gBX1Fhcwmhn3Cu9
         GB7RllqGt6/oy0ZPyvjJ1pOzMN4E6YGnuPmTzUd1verhQtBRrzQ
Date:   Fri, 6 Jul 2018 01:14:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 8/8] gpg-interface t: extend the existing GPG tests with
 GPGSM
Message-ID: <20180706011447.GC7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <9ad3e4b6adb38440d5766e34e3a41b7f64281dca.1530616446.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <9ad3e4b6adb38440d5766e34e3a41b7f64281dca.1530616446.git.henning.schild@siemens.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:38:20PM +0200, Henning Schild wrote:
> Add test cases to cover the new X509/gpgsm support. Most of them
> resemble existing ones. They just switch the format to X509 and set the
> signingkey when creating signatures. Validation of signatures does not
> need any configuration of git, it does need gpgsm to be configured to
> trust the key(-chain).
> We generate a self-signed key for committer@example.com and configure
> gpgsm to trust it.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/lib-gpg.sh               |  9 ++++++-
>  t/lib-gpg/gpgsm-gen-key.in |  6 +++++
>  t/t4202-log.sh             | 66 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  t/t5534-push-signed.sh     | 52 ++++++++++++++++++++++++++++++++++++
>  t/t7003-filter-branch.sh   | 15 +++++++++++
>  t/t7030-verify-tag.sh      | 47 +++++++++++++++++++++++++++++++--
>  t/t7600-merge.sh           | 31 ++++++++++++++++++++++
>  7 files changed, 223 insertions(+), 3 deletions(-)
>  create mode 100644 t/lib-gpg/gpgsm-gen-key.in
>=20
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index a5d3b2cba..9dcb4e990 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -38,7 +38,14 @@ then
>  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
>  		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
>  			--sign -u committer@example.com &&
> -		test_set_prereq GPG
> +		test_set_prereq GPG &&
> +		echo | gpgsm --homedir "${GNUPGHOME}" -o "$TEST_DIRECTORY"/lib-gpg/gpg=
sm.crt.user --passphrase-fd 0 --pinentry-mode loopback --generate-key --bat=
ch "$TEST_DIRECTORY"/lib-gpg/gpgsm-gen-key.in &&
> +		gpgsm --homedir "${GNUPGHOME}" --import "$TEST_DIRECTORY"/lib-gpg/gpgs=
m.crt.user &&
> +		gpgsm --homedir "${GNUPGHOME}" -K | grep fingerprint: | cut -d" " -f4 =
| tr -d '\n' > ${GNUPGHOME}/trustlist.txt &&
> +		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
> +		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> +		echo hello | gpgsm --homedir "${GNUPGHOME}" -u committer@example.com -=
o /dev/null --sign - 2>&1 &&
> +		test_set_prereq GPGSM

It looks like the GPGSM prerequisite will only be set if the GPG
prerequisite is set as well.  Do we want to consider the case when the
user might have gpgsm but not gpg?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls+wocACgkQv1NdgR9S
9oszyw/+KdP3d8KHVVmDisEt0bREam1HWigclQkT/GAXfdTWNlZWGCoy6cAKtPjw
WYptyQe3vbeSchNvwdqq0X1NhDdZiEGtuRh3jH+8fDtnTwoUVBuDYN0DzlJfrdkE
Ls45g+gGcjOn1eR1Q0NZl1+qvJM6PWFB2dOwedcGr+imgC1yfUUMuNvwNslXRbPY
kqvHO9UISqmy30OOMbmxxlwvMGql87fZfmKeiRyCXCBEyCoznHQkt/nMtrIB52Dd
mlK5zb7axHVRImGVlzTjM1trF3JU3d7ufFsHjf64Au2rPPEr8L4XoNmbhjggvHVr
pZRvEwJ1ZV/bplSDvBIL0pxtGsMzfs1isvpwlztFBbmn2IMh44wJzXvnBlvmttpi
L2HOUDVBxNEhDH51x8Sdw7gQCIsqwDHPEyjHc5ExK+ogjYXzhPqX4veLfb9icldJ
aJ1zQEt6e7MAc5h2sj4FZOBRftnvMUycJN7KaJXgGYzuAGl43h3jglnYRYzOzwCy
JylGh/te33Nln6FDx5t+D/CbVOBmJAFZbecpl1+HR7GYKqgYr/mikZiUizFJY+rR
FxGAim5PdCu9Yp9pB0lWiGefIRW6YxcGiAFKbRy2F0XTjxMKB1b6UoezS9ZDiLoX
6eync6jGLox2Z5YAzJTzDZppjNfyRalzUx+dht3eHKuJodmqr54=
=QnHP
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
