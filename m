Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400F6202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdJ3CyO (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:54:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbdJ3CyN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 22:54:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C71676046C;
        Mon, 30 Oct 2017 02:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509332052;
        bh=+2P14KE5ma85KN/6V6tjQ/ZCMnsIhQz8sAZIZVzYpmA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lYAUr0eFndommHuHPN1uI1RFqGR5I5VnYSp9dWJvnjvqFAfzc9sh0OCSdJcLGMIcQ
         kHwP8tixjuhJBvzS/WRz/f9GAhwwCN9Z0hhH073Rb0ZWCnP3bb6PEQejrmdnXBHBsN
         ptCU5N0UCOIK+mSROUk+DAGEY2jfG0rVOikurWmV4Zuk/GGUp2ualGFqSrYYmQT75K
         1Is+AxxKkqqlXM79d97olMeUIMOrtdxwxHAOcfzN2GxsjQeC5mr4vX5YMdYfS+GUuQ
         RNV9hC4lzr+oCNaZDdrWX537j1tbIryar8S/3ppMzIgZh0Fsjq59vOOfl0U38y77a0
         cTWmojogsucBrrbn7FcQ5Qrgbshasj9HAUKbnC7/IP8Yn9jWfMbBC2bXqBsiAy0mh5
         aScIP84DSBrw3kSIyOAsxj/VMiocfWs0ynL+o6FGn8/v5IpXCTvid2xj2cJS386rc9
         hTN75gzGgFEUwUTj0+lWPVqoySHRefKHjOpso4+/g+OKS0q4Qqd
Date:   Mon, 30 Oct 2017 02:54:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
Message-ID: <20171030025405.53f4sqxlc53vqake@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-4-sandals@crustytoothpaste.net>
 <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
 <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
 <CAPig+cRtexDJYMCUR1rGZjJOBRuDbhxP==US2VdNPhSWzeL6LA@mail.gmail.com>
 <20171029193327.uqkj6w3ypfwqwm7b@genre.crustytoothpaste.net>
 <xmqq7evd8jsa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zl75iqybkgxzyfrl"
Content-Disposition: inline
In-Reply-To: <xmqq7evd8jsa.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zl75iqybkgxzyfrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 11:13:41AM +0900, Junio C Hamano wrote:
> Is the plan to allow running with multiple hash algorithms in
> parallel?  I thought what we want to see in the future codebase was
> to have the default hash algorithm used for everything except for a
> select few codepaths, and assumed that the way we achieve it is to
>=20
>  - allow very low level helper functions (e.g. read_sha1_file(),
>    write_sha1_file_prepare(), etc.) to take a pointer to the hash
>    algorithm structure;
>=20
>  - have higher level helper functions to call these low level
>    helpers with a fixed singleton instance of hash algorithm
>    structure that represents that default one (SHA2-something?); and
>=20
>  - a few selected codepaths (e.g. index-pack that reads SHA-1 stream
>    and converts it into NewHash pack/index while building the object
>    name mapping) use an additional singleton instance of hash
>    algorithm structure that represents the SHA-1 hash, and the way
>    they use it is *NOT* by replacing "the current" one with SHA-1,
>    but by explicitly passing the instance to the low level helpers
>    as parameter.

This is consistent with my understanding as well.

> So, "current" does indeed sound quite wrong, as it makes it sound as
> if you can swap it anytime and ask "which one is in effect now?".
> If we do not want to call the default instance "SHA-2" because we
> want to prepare for migrating again by not having the name of a
> concrete hash algorithm sprinkled in the codebase all over like we
> currently do, why not call the instance "the_hash_algo"?

My original plan was to handle different algorithms in different
submodules, but I think with the current transition plan, that becomes
unnecessary, since we're going to paper over any differences that might
show up.  the_hash_algo should be fine, and it's consistent with
the_repository and the_index as well.

Thanks for a sensible suggestion.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zl75iqybkgxzyfrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln2lE0ACgkQv1NdgR9S
9osZPw/+MufECkIcg0zZw5bUmmlc6i0o65gOUPEoAjBUifRqiXPMOrv/qqukdxIF
jM5bQMeEIxU+HPhzj8KBkJCo7kiOBXDGzbwkvxc9SIAh4h9Z9rasC3wSdxmmqDS4
q+5IMFe2RooRAED0pG+GNY1AHkMwgc4/wOKrQ4FUdyxZlK8HYDrpCNVpurr8Wg86
wjMMnOyVExlw0e/q0U9ObgYk6pI1BD91vBKhTbJNpqn0E6/ed3Z1qxClLAqvQbdk
dD4nqLJCJDLYkkyYluLVTl6nGcIEVauvvkH4vKaepSmGBzzaFZkqIJQX/KbNQJli
mSNssZr/GcpBsGbai6+REjotMeaYQHo1UFwhh9gD4Or7wC71+Sqjk97xSHPOg2M1
M5mSOEkEI9FE6W7vU3fjZpWN8WhybzPA1eoR39N6yPF+9DF54ykgTSkAP1WQ4L9o
AchgnShrwslR0blZCaUeh/2u1OvelS8l7ucrVaWlpUHqsLt+1oBhMZ/CmHaPJ9sI
hHT25FqpaO0VS0vq5t830rGtHnw0cjIKdMqGGjbroOUuEY7ZDShgEbh0YeeJ7j2s
tW9yy2FIdObuZOZl8VkjZRKeA/oIlEZTmcVMCyeGd1XfGBFQ4gjyLz6X0V9BvuaE
Q51UwGzMA7LQZ06PYAcbTzwF5ecWAwoQDfKMETntmH0wRuML4uU=
=5+WU
-----END PGP SIGNATURE-----

--zl75iqybkgxzyfrl--
