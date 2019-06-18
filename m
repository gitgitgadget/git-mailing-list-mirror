Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267BE1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFRXDn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:03:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730377AbfFRXDm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Jun 2019 19:03:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:8174:fea0:25b6:f16a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C56860427;
        Tue, 18 Jun 2019 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560899021;
        bh=bcr55k3rjFJup2Jg/JprGG+uq84pI7aMbS7UdcuhCTc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yO7GjaUrs6PDh3M9bnyAZ5Fh2ZsSy5w00K/zHgyy8fXlHSldzb6phNSY8gUTzc2XF
         +lDS3I84yMnDnFwgdPOWIeC2u6taelrWg94g4lODQKJ1WhHoLeu4Y87oesjYsSyzaq
         yjEK/al8NRYxuamcXNrvjrDzP1QyuLIjHyKixWlTWgbmzlhigC0xiN7I8NoJ7kxG7u
         vJMNsaJi2GhP41LP/9u/3vx9jJ3NHS6c/xMrkUFDixBvhRBafexLpXQlGZHTnrRiCU
         hZQKizJEUcuJQR/gIYrCxeorTjd/2VhtuNLPMlrW7HNnaJgRRgwc/JmngWDWrGIK5R
         QwPuU9hwnlJeM2F3GJdWUKBpYAXJfJsfHtJ/ivy4G/bHFCAyifL7mSp/XkWhmF/LRA
         6yz/X/nLWL/yP/dOl5e2qftok6Hgm4dSDNMBAL7LP0C4QixMSrxmEh5/vX4ngCiHBV
         dCH00AtJ7kSVCpJVqDS5AvDSvKE5zjpCtzWOCp47lrX4hg9CFnS
Date:   Tue, 18 Jun 2019 23:03:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
Message-ID: <20190618230334.GC8877@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
 <20190616185330.549436-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
 <20190618012943.GB8877@genre.crustytoothpaste.net>
 <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-18 at 06:14:03, Johannes Sixt wrote:
> Am 18.06.19 um 03:29 schrieb brian m. carlson:
> > On 2019-06-17 at 19:05:03, Johannes Schindelin wrote:
> > I'm fine making that change. The original design was because we had
> > other code that used that technique and I didn't see an obviously better
> > solution. Now you've provided one and a good justification.
>=20
> Regardless of how it is implemented, I have another gripe with this
> helper: the way it must be used requires a process: $(test_out_to_path $f=
oo)
>=20
> And looking through this patch series, I see a gazillion of *new*
> process substitutions $(test_something...) and $(basename $whatever).
> Can't we do something about it?

A command substitution need not invoke another process. In fact, all of
the test_oid calls operate only within the shell. The test_oid_cache and
test_oid_init calls require spawning only expr, and they are typically
limited to one or two per test.

Within reason, I'm happy to try to make things easier for Windows folks
if I can, but it's still the case that process creation is more
expensive on Windows and shell scripting is designed around process
creation. My hope is that Microsoft's work on WSL will help them improve
their Win32 process creation time so it's faster and this becomes less
of an issue.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0JbcYACgkQv1NdgR9S
9osDMA/8Dma6Q6WXZHPPjzmokdJfU8DXqh1641voAtMVbVEgPqJ3kTMUw9+mXWYc
XFEn5lILWxJn9T5n1HfAAvxYHVz2v8NVPZHFCgnMUegoZuAH7Z1vkR2Yre/wDFfp
d90QkrAoXVuX4gcZ3UCoplYGaHXNrM135mDk4A7DaDaStkmKyQVHZG1jbVyscvNi
t2A9L6flIHQdpt/l4/9weqFJp73OLz4Kf0mW+ro3THdLAFEE87gyrhjJqNqQNzDe
7ewTIecwt2HXA9Nhc/JoZeagjgjCjFCtRl/DPkLs4ymYTdh8yDv0AJd188a/cXl6
IB9JgusUATcf/RaWAvCV/O0B4DgnM1Ji2jHt2yZhENPx3CUYLp9xIGLWC6IsmBBu
Vcxfg8YEz/FFekgopb+9Kypq7RKfsyA4AXEGQFEqVh3hF52Hh/wdEIEa77b1ZYRG
wnhVCekpQpVuOtvl8CW7nEeeYMNVRFWZ5HFZbHoQ2NH2pGCKQV8tmmL7JNEuJdwX
hhckM/losDar4R2Rw5FkF2d2KbNsQ03tV+iuLOayJXwmt8fsq9bhFz87eh/eEuiJ
rDlEuEU09y8tP3DjZX3UFck3+KppMD2Rpww5c7y34cM5yz98iYLjEfbwlIONQR8W
9YV9pAxeISxLD/NmO9F0JKA87W57b0UUATFKHiWo4v8P4u0NlTo=
=o0PE
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
