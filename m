Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9982D211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeL0QoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:44:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728083AbeL0QoD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 11:44:03 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFD796042C;
        Thu, 27 Dec 2018 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545929040;
        bh=zfwykLZtFYVAzZt0yDo5kCJEMNFNewRnTIpY2/WJBs0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u0SFJ75rPgQB5oPLinVDDmE7w5cipDElZ6tnOljZaawc1AOsJUNKlBvuntj9BppNv
         nIMG/ixEALOPgjFi4lRgxTTwMKeCR8XaT4BGqND9ncoPv/63We/XjstmO0hoiL7WfB
         u9krYqwIE4RJ0IjPxHLOct4YW417aPZ7rouIXQjVWdE0dQfp7wey7gwSdCLMpzf9PR
         AHV5MhPQRygCwhOVlSCpnqadobtmwt2YNUoJFLbskfDgS8VMOxpcYQZ3qVJq09zOpb
         FC7VJhEFeel10huHYebii0Kpaavk+ZlAqFU5x0d/TVbj88ba4m+j/uejjVavwBHQub
         X58eTRO76uQHcvOi01jEYoPK+c3+++el1R8Ai/BVbQ6hdjq+b0J+YLsnK3CJGp03s2
         6YpMxq52wWqXOWS9sWwuqJ7R2rs6OT3VxMs4FPtSLC1EOoHXmMjO8FDokXBZtk6yyZ
         FKIQNlTB6CHeZqCQI+OkfqEIoptlSjaJ90nYrarM3C8ZOMHsyjX
Date:   Thu, 27 Dec 2018 16:43:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
Message-ID: <20181227164353.GC423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 11:06:17AM +0100, Johannes Sixt wrote:
> It worries me that theoretical correctness is regarded higher than existi=
ng
> practice. I do not care a lot what some RFC tells what programs should do=
 if
> the majority of the software does something different and that behavior h=
as
> been proven useful in practice.

The majority of OSes produce the behavior I document here, and they are
the majority of systems on the Internet. Windows is the outlier here,
although a significant one. It is a common user of UTF-16 and its
variants, but so are Java and JavaScript, and they're present on a lot
of devices. Swallowing the U+FEFF would break compatibility with those
systems.

The issue that Windows users are seeing is that libiconv always produces
big-endian data for UTF-16, and they always want little-endian. glibc
produces native-endian data, which is what Windows users want. Git for
Windows could patch libiconv to do that (and that is the simple,
five-minute solution to this problem), but we'd still want to warn
people that they're relying on unspecified behavior, hence this series.

I would even be willing to patch Git for Windows's libiconv if somebody
could point me to the repo (although I obviously cannot test it, not
being a Windows user). I feel strongly, though, that fixing this is
outside of the scope of Git proper, and it's not a thing we should be
handling here.

> My understanding is that there is no such thing as a "byte order marker".=
 It
> just so happens that when the first character in some UTF-16 text file
> begins with a ZWNBSP, then it is possible to derive the endianness of the
> file automatically. Other then that, that very first code point U+FEFF *is
> part of the data* and must not be removed when the data is reencoded. If =
Git
> does something different, it is bogus, IMO.

You've got part of this. For UTF-16LE and UTF-16BE, a U+FEFF is part of
the text, as would a second one be if we had two at the beginning of a
UTF-16 or UTF-8 sequence. If someone produces UTF-16LE and places a
U+FEFF at the beginning of it, when we encode to UTF-8, we emit only one
U+FEFF, which has the wrong semantics.

To be correct here and accept a U+FEFF, we'd need to check for a U+FEFF
at the beginning of a UTF-16LE or UTF-16BE sequence and ensure we encode
an extra U+FEFF at the beginning of the UTF-8 data (one for BOM and one
for the text) and then strip it off when we decode. That's kind of ugly,
and since iconv doesn't do that itself, we'd have to.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwlAUkACgkQv1NdgR9S
9otM0Q/+NmWnDeUipl0RWD6Tgq5JG0F4WE7kLAQypsHB2H5/pw+cjl9gqFdwDJEa
rLnVCpFWfKjOQZYqtBKQ0m4r9QAJAbPRMm+nLDuRPLZj9XRxLkRmzE/K2Uy3H2oq
z0//pk4dVkCXNh6IKvdzRdY5z9y5Jjy1zu6E394OBWK0aGjwtkd3yH2ufxmR3RX+
SA7pfz7+nCfAdJhJ4a5Ekmp/TM3Se628PIV8mr7Yfn5u8CKRJ5o9AG0qN5n+V05V
xHtUO2bSih09hguAkkORbnY4RrmtdQLg/HrRxoY/mFaQpAkN6J82D/Sg+H0zbTuf
rfSwYd09dqhHW0EPkfrGOrsntqZdIwba9JJsEkRVKrluGCbLGvl7gwvtDGBcMa4e
zQMSi2XySDd+75X9O06W9JORE2DmoNNsTZV/G0whu+lWEQGnERrJfjtLRlWbkHfD
MsG6oL2xFF9SX4dJqELdWfkiozG0fbOjvtnb989j3lIlI9Fdm2VqPQpgxOqhDQ0i
aqKwrovWHmge647k+Owdob0vDlrQWU6DafwsXttMrJcqvWy8Rb/qth5s197lgT4i
nE7Lszq/df8+9UfEFU0Arai2Rpsmr0DM5DH2jTGxYHSR6QPBylnb3VXj0RbWCyeS
OxghtI0pGXes+lBdh7Y+fJEseltkGPKzljXPKvYbRCu5pqChJtU=
=NUax
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
