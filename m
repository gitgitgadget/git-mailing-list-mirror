Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659D71F45F
	for <e@80x24.org>; Thu,  9 May 2019 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEIXvU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 19:51:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbfEIXvU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 May 2019 19:51:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:414a:17e4:5dbd:d3cf])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E92F960736;
        Thu,  9 May 2019 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557445878;
        bh=wlR7o9T5gXfVe4RIayaASVwhGcBkT9em0g3FX/njPCE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xLxrLRBGCaRta6c9eBA6UCwofNukxEXztvy33CQmnbjYYox1yXbNDYr+J8MPcqwCR
         0bnK4zII3Y9vapfqq4roSyn9wtzxP6JzYcAihvy/vm6a86OVTvniM8a9SERLCH2p7I
         e+Mn+7BKJEDaOSksjILrLl4cv/LdAWZxwKMvGd0rwMI91+4A9lMjaIwqRgQn3053I9
         MqX+L56xdrRuSkMDG0PYdjjRJTzZ2nGru0gcoB/kBKUqGxdxf//o9R5AcM1dysMIGN
         1KaGD6swaNike98/nV+pHSb0YaWs3C+u4K21wyV72tz86T6tVcaAh8Er5NPyi3ABFn
         3txoTz44yqnaZ8/dD1DLogPVRfDeJS6chG2PQaN0LVTEUa5r1Ghu4fqWThXboxoMK8
         x7UGfdpnVJtCCxmeHiS0GfuTyaxWt5jFtVhAd5rVJZVuPx+Ym+A/kceGzIcpA2nfvg
         1shZhK7YQ0QK3T8D3oodeMVPV9a11NIhHmz3MWI1C6uX2TtKqx3
Date:   Thu, 9 May 2019 23:51:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in
 that order
Message-ID: <20190509235112.GD7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190508105607.178244-1-gitster@pobox.com>
 <20190509114830.29647-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20190509114830.29647-4-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:48:30PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> @@ -363,6 +371,11 @@ sub read_config {
>  	}
>  }
> =20
> +$identity =3D Git::config(@repo, "sendemail.identity");
> +read_config("sendemail.$identity") if defined $identity;
> +read_config("sendemail");
> +read_config("sendemail");

Did we really want to call this function twice with the same argument?
If so, perhaps a comment is appropriate explaining why.

In general, I'm not opposed to this approach, either. It does make it
easier to handle parsing in general. However, having said that, I'm fine
with either your series or Junio's.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzUvPAACgkQv1NdgR9S
9otXMw/+IhW8vtMO5MlMqeMjD9E0/hB6EesfhrQqdxYgr1/wNtHoVGZhBv0gb+6V
zvXEF/ff7/BPeu1SYSbBeSq/IUQXIT7csYUpWdHZUKtQQ1r3QKm1uUBXcJJlYLt1
lIS4WdgskUL3IPT96UpCJBJRliI4vskLfQSEzs0VsAcOlh6Ok62/uAh64SYDYbqq
kN+4JGN+/ITRCJYANZ2mKZeHrgcx6ZP1G8+zT4y06jtzytiBR3SuGdwxVIndOZxl
94N30WT5FZNkTtrPh2ypPexh4wz4NnCargsdNG8sZyVCzOF6f7Adu3cxkFGWnZxo
RHIWKo8z9rYtkYBB5VRFTOtYxt0EaMsGPR0c0ORu5hS2zVPMb7M7N2BOqcGB00a6
bWDt3hEF+ZOSVla9gPWDIo0krwKGZHTRcSpPdzMVug/aJT26NGhHu3J8FF5T0h4W
lJndU9TbcZPEz37qu1/Y3jxxANE/9WM4mhQhOJ+zIVzEZstkOh/AsyW7gwdp8wsN
INwD2q6tfPdo+rnvo9iYEDO4Jub/nNk/aZY8T+TMlpoqnk0Waa73b40lsGz4eW5w
t/DygX9R+scJgvKSgwY+AGt16jllPLuV2viIMHzYKKoG8VjJMxh1dtwkbsRYAPMB
z5kFHBKG5F/PLgknjETBJNrDVq9MDF8xQWprLenru19SU+ho1Sw=
=fdKm
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
