Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E511F461
	for <e@80x24.org>; Thu, 27 Jun 2019 02:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfF0CDH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 22:03:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56254 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfF0CDG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jun 2019 22:03:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A69760428;
        Thu, 27 Jun 2019 02:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561600985;
        bh=7LAuMam+Yh0S4KGb2zZz9JQctFpxSFk7zV1P9FyK70c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IOgDvuQ/+pX0zFuNlGgSqtPTv2F8hM5q+zi5yMdyTuQOZ/KAP8fTvPCpzi6HRxbEQ
         G6p1Uuy4m6XMHE/Rca0BgPJ3mhZS/ZB82rB7d/SAMxrVYZ1dE7ha2H6tBjpJC6A007
         tyGG0E08nRth25TL5qUGHVimPiSCGFvInPE4ypqXTJCphXgdjxQ/a5XTbosW6d9rwA
         eBvisUC+wAC2x4DqWXfUYanSonY8U5/WlwuE19J0/5NDq1OYeF86iM8KyarrksQN9/
         6eyzYoo7/7HLAcjTuL7vtBuExqIH/OIRRZoXqIpFf9IlF/p9uz0w7pidTnRNp8CRwp
         oQcvzqrZAiCqO2Yw74qPF15TYcafk7hzv3CWWRozRJ79FvvXCK2/OYpShFIE2xhOA9
         lt8vmW+kKX9/KlxWWFGWR4bKEsn8/LdvvqRfei5bZhAUhQi8zLJHhqjDNsxD1V8Qa2
         CJqthvLtMD2sq6cumgz3mEovp+/R9dNoyvywcg4E6FDcG3lArep
Date:   Thu, 27 Jun 2019 02:03:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 4/7] grep: make the behavior for \0 in patterns sane
Message-ID: <20190627020259.GB9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com
References: <87r27u8pie.fsf@evledraar.gmail.com>
 <20190626000329.32475-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20190626000329.32475-5-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-26 at 00:03:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 2d27969057..c89fb569e3 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -271,6 +271,23 @@ providing this option will cause it to die.
> =20
>  -f <file>::
>  	Read patterns from <file>, one per line.
> ++
> +Passing the pattern via <file> allows for providing a search pattern
> +containing a \0.

In this case, I think it's easier if we write this as "NUL" or "NUL
byte", since I think you mean a literal byte with value 0 and not the
literal string "\0". I certainly find myself a bit confused, at least,
and I expect others will as well.

> diff --git a/grep.c b/grep.c
> index d3e6111c46..261bd3a342 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -368,18 +368,6 @@ static int is_fixed(const char *s, size_t len)
>  	return 1;
>  }
> =20
> -static int has_null(const char *s, size_t len)
> -{
> -	/*
> -	 * regcomp cannot accept patterns with NULs so when using it
> -	 * we consider any pattern containing a NUL fixed.
> -	 */
> -	if (memchr(s, 0, len))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  #ifdef USE_LIBPCRE1
>  static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_o=
pt *opt)
>  {
> @@ -668,9 +656,7 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
>  	 * simple string match using kws.  p->fixed tells us if we
>  	 * want to use kws.
>  	 */
> -	if (opt->fixed ||
> -	    has_null(p->pattern, p->patternlen) ||
> -	    is_fixed(p->pattern, p->patternlen))
> +	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>  		p->fixed =3D !p->ignore_case || !has_non_ascii(p->pattern);
> =20
>  	if (p->fixed) {
> @@ -678,7 +664,12 @@ static void compile_regexp(struct grep_pat *p, struc=
t grep_opt *opt)
>  		kwsincr(p->kws, p->pattern, p->patternlen);
>  		kwsprep(p->kws);
>  		return;
> -	} else if (opt->fixed) {
> +	}
> +
> +	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
> +		die(_("given pattern contains NULL byte (via -f <file>). This is only =
supported with -P under PCRE v2"));

We probably want to write this as "NUL" as well.

Otherwise, I'm okay with this change. I didn't expect Git to handle
literal NULs in patterns and I'm surprised that it ever worked.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0UI9MACgkQv1NdgR9S
9ouxmxAAhbcuVJFb2egBPnjgVJVnlnrJoUHpJ7XeutFWPm7b5ceb86BM5G16Xpqq
Af8OjaBNYNGjZhh98fJAKmrVN73m35E0JD/+SVJm941aXFG+6CcTsNe1/A+0HTm5
K9Y1cltsrlaIle0yucyhP4ptcJYU1b1pfysJaABTA9KFdLGXdFHbwg0ujiJqUhxF
2La6bXwRnM4NO1vjM96sUht1MKVHV+GBkBnzgMjWmmp3uMGrfVOSOR+i4SG3GaRR
0JQfIdNa0zGLFIythR3EAvsfhjBupUdCvQpYMWF8RSOELzCvwACoTOZ5k4OewQb/
MyW52zfc5GoU/vyLsv3VzzCxv8K04Jxu8/bjjOR6eKFevVY8bXBaEmhoP27Ptubk
/8N2ijQC+juUo/0MaAmGuVtYMKpZ9f5TqEFEO4pe87cW6irSfXKp2ziHOUrje7Zy
JNhEG+MSDvnJuqrrPQuOE94/nK/IK9S6kUufYmKNtgNSs7d+/g8COooyENdZ/B2o
l9xtM19yXBUb+iXUKZSK5oJ05AQWnPvmgtpSvGdzMbMcEuzHH7ehAfC0mWr4K5su
iEWtpcEcpO4XJ+0JzzgNphaxJl/B4lkmMVRM27zP5apeDxyUk1nzG6kl4/E5jJwu
o6IiCQmhRih6I618tIm9wIZd2/mAsxOVj6eEz45f1urBVF1LLBQ=
=cT0Q
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
