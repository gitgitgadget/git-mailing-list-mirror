Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A5D2035A
	for <e@80x24.org>; Wed, 12 Jul 2017 01:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756024AbdGLB0k (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 21:26:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58350 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755938AbdGLB0j (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jul 2017 21:26:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0B120280AD;
        Wed, 12 Jul 2017 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499822798;
        bh=pcfkN5uzp9s3YD+JstmILPqmzLhzTga25JaS1k5eXK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVzqp1DJrE4azFmFRhbcEKzMMpGEVNISIX2w6G+ZR4rzbexmuBDI5al+dbH59KnPK
         76cX8mhPt4iIV+AThHib59fKZmjmgNCgMHkqe4IOZr5gAGCNm6hLr+jKpChD9sYAR+
         tqubFW92CmBBvHwO/SkmLaLOuFmqqKLNoYQf/ArrBqySie1eQ9/FOd0ReQ3HN0dAf2
         OL225yuFFWaO/4Wbc6W+Bbk2ud1r+yOpsERk9eOFO84qdQKpr2/y/gCfdr5q7NFmk1
         MQDA102eW/nHVtjXmis7rewCzLwFti0IvoUxTieg7M1SdUM5bd4mMpufDzaR1WmrR4
         U3PT38eaE2mA8P3We63/DmQ8Ova6f/JM+hrivWQjgcAr23cCGZ4A1QK2An84XWsSQg
         FwdAhMi0K3VU42nX7v2vkEcWrjS3i682x8mfmwlSgKHTUnqc7dfM0JFiBUv7Au8/Li
         oFoH47jefCz4Jk5Fx5bVR/VypSP9q7Rhj1t42puR0xeJrCBIu7F
Date:   Wed, 12 Jul 2017 01:26:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170712012631.o7jdced5hqkqzug2@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
 <577e31a0-ecb2-d0a0-b259-b65b31116be8@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76lidjkfk63lbn3p"
Content-Disposition: inline
In-Reply-To: <577e31a0-ecb2-d0a0-b259-b65b31116be8@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--76lidjkfk63lbn3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 07:24:07AM +0200, Johannes Sixt wrote:
> Am 11.07.2017 um 02:05 schrieb brian m. carlson:
> > I have tried compiling Git with a C++ compiler, so that I could test
> > whether that was a viable alternative for MSVC in case its C++ mode
> > supported features its C mode did not.  Let's just say that the
> > compilation aborted very quickly and I gave up after a few minutes.
>=20
> It's 3 cleanup patches and one hacky patch with this size:
>=20
>  80 files changed, 899 insertions(+), 807 deletions(-)
>=20
> to compile with C++. It passed the test suite last time I tried. Getting =
rid
> of the remaining 1000+ -fpermissive warnings is a different matter, thoug=
h.

Yeah, that's the size I was thinking.  My goal was "easily achievable in
half an hour," which it didn't seem like at the time.

> I can revive the patches if there is interest.

I'd be interested in at least a pointer to them if you have one.  I
think it might allow us to take advantage of desirable features that are
in the intersection of C99 and C++.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--76lidjkfk63lbn3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlllescACgkQv1NdgR9S
9otadRAArHgYzmjP/KhMNCr5i9dMk0jBcde/oQmhiu22OSCj2xmL+3TAlI+BJYpw
SFQByvsvfnc/KWul5wgX6lXk4yGKqsDryP3xYfVIimuMPpQsnllz5x/lOMXOg/kP
anERMG4oMeS1LQc/uage5RqOIv2seg9X4RlyknZ5hlBYncTXUUdJArDroegKmSAR
05qs6qHsbdzrBk4SGwS1i4T9rx/hwP+MXu2/2u52JFtvWQ3O1YwOm7cFaZi3/0yO
c1WzAuMgOCIX2W3YRqFjE26I68M269EK47P4eBZyf6wTCr3P7NyTeFwOpVNZnIzn
xrVm34CeF3HKJFkVemYNgnMz5SDSN7XBYF2BoA2utxqOjJkacfaSB3g3rIqpBmHD
/VHbLVCtX60M1Clh6I4oEtTmF5eO1NnbilHoNDUGf0jqCbOwZCWdUkS78cMZO6sD
I1vJW832df/PhN2UV7UEg5nSaZL21y1A4AtqhIR+MHwRiPqljFcj38eywdmiH7UW
g5iaZSJSEGnbuVJlIVBnsBn/jmSfH5CwAXwby467Ky2L0EDiP4YQ94SkJQBk1eMK
c5+it442K8R3tP7F950WPVvit0Yi7UqFQQYUtK1sCfgmZi/D0v5UHKLS8Ts0mpi9
q7/mLvoM8IuI2+mEbmfV9w5gV8zb8ZPIssFD9d58v9WHZuKRzMs=
=TXtS
-----END PGP SIGNATURE-----

--76lidjkfk63lbn3p--
