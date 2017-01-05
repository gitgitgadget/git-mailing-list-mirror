Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD405205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 12:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031885AbdAEMZp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 07:25:45 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:44617 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031854AbdAEMZn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 07:25:43 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jan 2017 07:25:43 EST
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 05 Jan 2017 13:20:38 +0100
  id 00000000000000E7.00000000586E3A16.0000300F
Date:   Thu, 5 Jan 2017 13:20:37 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org
Subject: Re: [PATCH 2/4] t7610: make tests more independent and debuggable
Message-ID: <20170105122037.t4k7cby6klqb4lci@ruderich.org>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170104005042.51530-3-hansenr@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-12303-1483618838-0001-2"
Content-Disposition: inline
In-Reply-To: <20170104005042.51530-3-hansenr@google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-12303-1483618838-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 07:50:40PM -0500, Richard Hansen wrote:
> [snip]
> @@ -145,8 +148,13 @@ test_expect_success 'mergetool in subdir' '
>  '
>
>  test_expect_success 'mergetool on file in parent dir' '
> +	git reset --hard &&
> +	git checkout -b test$test_count branch1 &&
> +	git submodule update -N &&
>  	(
>  		cd subdir &&
> +		test_must_fail git merge master >/dev/null 2>&1 &&
> +		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&

This change seems unrelated to the changes mentioned in the
commit message. Was it intended?

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-12303-1483618838-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlhuOgYACgkQkv79t+RM
Mvm1og//Ykml/lsuwU9Wgtw8+Q2DJMFq9LWz+IV6wAX/9fR2iw3ty6g7H5Qdv87q
w9TL7xGbMI55sbWJ/HNOp22Il3thL4qK85e/q0/qp+AX1fTayLXtU6E1fIOWhwly
FmCgMa139m426IuwFBrWg54dfFjNNpBfYcieg7u5E8zUiOh0DTN9dzVzWIYMLdjG
DtjMLNkc5IH2oVjah0ZFHvNKKI4KbmwCLDt0tDAI4gyNS2kHsCT+HIsSGR5ve4eK
tLRjahZKKYlWJ1k4YLXnEIL/EYorKH0qy9pN28mcWPiNzrZJjW5cSgrfg3dlxfZS
z6hVh3jThyuhH1TTtEu3e8PQJTOq2YM2s6VfE8uugoTnKYNUA4ZEaC4e/2nz/f1v
+pGHYLDnJHmopSUvO7nnvk2RkNKPIz1tlU7mqsh4/3Y5gUIMPy6SY+7xqdGD3+tF
Cu5v7k/1cPgUhRpYH0ScYKBrwIzWRxzZJ3A8gnROpnweT7Go+VtwmYG5lg0qQsQo
NJIJJDrz2uj34G60dzBNUujyQsTNwN0EzKY8E/90MADwGN6e8e//ZmEuuQJWxSzq
NoFhKzoEdv49KDOr+fm+m15Y8AOpknV5PgJdH8X67LYeAJmcq+FHcibbxmx74EQp
HZNZoVUKtgaLScpFIMD/PD2gGJbaX9aArDQlKJScginJg4XroP0=
=WBse
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-12303-1483618838-0001-2--
