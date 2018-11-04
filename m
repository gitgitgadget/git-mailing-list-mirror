Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CECF1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeKEAZh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:25:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53164 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730148AbeKEAZh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Nov 2018 19:25:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5930:2634:17a1:2ef9])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 988726077B;
        Sun,  4 Nov 2018 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541344218;
        bh=aABt/nbEuDuVonREoZ7Z89p/m051whdw8JsfPMTRdC4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ll67xSIMHuBfNAie94cebOujrmnQMAzSCQvL+RWAO8BgAjMSB+LGhBed6xNLa7WyC
         bK1fDQSMmGYAY2sdGbLE/vd8bS0DsorQJxt2+afCkjohxV4VwwMmt58aw/USls2PI9
         HGyXb+a4n+Xbt8Gy/A1M18e/j5V16eD9cMSHD6NFpaE5q6HkGEOkBKOtFDlUblSebc
         jpi6NOfnM3GFRSl4QrMBsUYwJ4bwROW36PlHHFbyDFMzSHJRV53pLyA/dAemPiC+rP
         sDkjZ/RFPIZluRBr2EdqG4fJpsxf9CRJ+Vs7Wx4TMy0y6NsdAXDAyp7D1GGLryu4Zi
         AnC07u7ec2ZfUM9H/PBMOsUVna5s7gTi/doJcpgBW30NjacKy3YWYTb92xc+wb3AFi
         JGdwsBVY4p6aAJNrmc39ISeaLelTKa5bgOBajFEPP6QqE9gyg317Uzw6j4KTTEgkGM
         nALiZ4sU1A2Z7nF1QjiE0kH2twVkyxYXCfeiO0j0olWnn4uUHJ5
Date:   Sun, 4 Nov 2018 15:10:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] t/t7510-signed-commit.sh: add signing subkey to Eris
 Discordia key
Message-ID: <20181104151013.GH731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20181104094710.27859-1-mgorny@gentoo.org>
 <20181104094710.27859-2-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20181104094710.27859-2-mgorny@gentoo.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 10:47:10AM +0100, Micha=C5=82 G=C3=B3rny wrote:
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index e8377286d..86d3f93fa 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -197,9 +197,9 @@ test_expect_success GPG 'show bad signature with cust=
om format' '
>  test_expect_success GPG 'show untrusted signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	U
> -	61092E85B7227189
> +	65A0EEA02E30CAD7
>  	Eris Discordia <discord@example.net>
> -	D4BE22311AD3131E5EDA29A461092E85B7227189
> +	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
>  	D4BE22311AD3131E5EDA29A461092E85B7227189
>  	EOF
>  	git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actu=
al &&
> @@ -209,7 +209,7 @@ test_expect_success GPG 'show untrusted signature wit=
h custom format' '
>  test_expect_success GPG 'show unknown signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	E
> -	61092E85B7227189
> +	65A0EEA02E30CAD7

It's my understanding that GnuPG will use the most recent subkey
suitable for a particular purpose, and I think the test relies on that
behavior.  However, I'm not sure that's documented.  Do we want to rely
on that behavior or be more explicit?  (This is a question, not an
opinion.)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfC9UACgkQv1NdgR9S
9ovumg/9EFFayqtT6wzkMF8M47WOmuDX8nWZVIRVLPGxAtqhKl17jNokbnOE9cc1
UwPbqymOGp8Y+El2THiS4Mf4ryJSvEvjlJzxiba9wxhSwW+o/qgHeud01kG/Pmnt
T36tPTO0TjNBT4FBGfYewcfbsRUG5E5iToqKhO3ygC0xptOHrpQfcJEjKmOTHN74
wtKjEXdeIFewboPc+iIM5rRzDA1RqviVh4hRjcvPqn7wYhT4uUEEjZ8gtd9S7V+F
OYL/8gSep73mzL4s7iV/MnL5SmlYlthmSjAf1vSLuLLO7CiRBKU4lbjMG02kwexW
FCKwtI8c8g2gHLyszzU0M8n867Z8AwB7qHtiPzFgklO2u+wWw/gTZd50uL3NVFwd
VstBvN+OKrXBWnuB3OGubNg7L3ZWpQBhwfoUSLoZ10JJfni1AAPD71P6npH0TZI5
bAABrBSdv34Efl26kF6fNkMWO1TNb/u3tD3k/qbQjWZyC59ZmV34dcclk2sVfT7F
jDLnpGD3kzmRNjvkEhmra2FL0EIUeGNBYzZUotR9/Z8kn6fsL9fCNj6W9tXZK+tJ
qKxMXJcggnD7BMqB2xnf5/M04Yj8dWkVLU5NOITdWsbE/HIqgWAOeXnViYQkHGg7
bBTXPlOm7CxFyybLUQ2U7OscHfeorxLgu2z2vdB1wbHSYsOoALQ=
=oanx
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
