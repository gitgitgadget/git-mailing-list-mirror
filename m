Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0AAC433E0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 01:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219C52076A
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 01:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LpldOO3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGKBGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:06:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgGKBGV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jul 2020 21:06:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8673960424;
        Sat, 11 Jul 2020 01:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594429579;
        bh=sCgQ6HZXW+b49JMvt4JDlaZJe/c6eZiHwwJorjkzSLo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LpldOO3s3u88ogb/nGwftwhb8xafnG9CY8cSJUxQSe9lW41uPQwybCmNy9ILqRvC2
         eKgyz3eflbm5afG5wQda143nD+N7DtD1clv7NEt/ypMUAwQsbyyaCPsCK/wToNWAxd
         N4gJsTIeCky9FpXIu21BS5fLol8+NSPvrjXP0AdBnPgI3X2MW+HuRjxJBNKvnVTU97
         WKyAnvu2H/UiKRthn00u5VHrpzvDm0iYA8OHtDkvsF1sTucid5AcdUuQO8IOpGOSpe
         rgFFkNj8+Fshda82/0svWI9E35P9Eo2unNvQ+lgQCyLIgnWSv+YIDMvQunmiUMq+Ss
         8/dumvTWZJKaCCkJZ34ELpMc+r/mb7zlrujqZoT3yaPfRAJJr+JUSEwwY0Ep3d3SB8
         XQpf5EteeSJLVnT9Ul2WkNd6v7N19AfT7e/JXR2U1O2IRm+v8Q8w0G1/nfPRu5QNfP
         3Ng2FfEUdCz/7YiqmoBGTPzDfuB5QCiYFyzciSUjsgWwqGZ06dp
Date:   Sat, 11 Jul 2020 01:06:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 00/38] SHA-256, part 3/3
Message-ID: <20200711010611.GM9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
 <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
 <20200710195507.GK9782@camp.crustytoothpaste.net>
 <xmqqr1tirio5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <xmqqr1tirio5.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-11 at 00:37:14, Junio C Hamano wrote:
> I do not think it was an explicit objective for Denton's series to
> catch the use of test_might_fail with test_cmp specifically, but I
> offhand do not think of a good use case for saying "expect and
> actual may sometimes be the same, but they may be different", so in
> that sense, it contributed to find a nonsensical code.  I haven't
> read thru all the 38 patches of this series, so there may be an
> obvious reason why we may want to have such a thing expressed that I
> am missing, though...

As mentioned upthread, my patch is definitely not correct.  I've
squashed in a fix to remove the test_might_fail and will send out a
reroll later this weekend.  I want to wait a little bit in case anyone
has immediate comments on things so as not to send out patches too
frequently.

If the breakage is bothersome for you, please feel free to just remove
those test_might_fail entries in the meantime, and the series should
function correctly.
--=20
brian m. carlson: Houston, Texas, US

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwkQggAKCRB8DEliiIei
gc+8AQCXBn6BhZWXOn5zZw31jEqgBn9idJ8ihDwjg3v3tLOYcAEA4slgSywb3K3P
rVgsFqXjmBXglNdtaN9KjVGCRHVBjAA=
=r4lp
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
