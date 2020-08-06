Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C2C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ED3221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Be+vp2vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHFXwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:52:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41406 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgHFXwQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Aug 2020 19:52:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F99260129;
        Thu,  6 Aug 2020 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596757905;
        bh=oAGAdu7twnKm+97KePapykuWk17tforM7QoeGuK0CvI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Be+vp2vcWaAb1bYiBSnOFfNzeMdoz75hKnXeosVYGBBEPvDQOOFDS2kAwwRxRf3sz
         E4tK2hrIHV8v3zb8puL1GNfAlwf6xit/y1qM/jjz6Y69p7zAhdn8r8zgh2v4fxb/Ok
         1IoV1Gf61zGduxQJzkb+YRuUZjGIOY2PP2ba3cuMbi5QWp0Iixk3PBuseLK/WgHtEn
         79kbmQkkdDb6udcdYF9mxyN+NhiYWGnW1o4TzqKtRBYEnjNrt8+YeGasriUJPR4L8M
         jYSxmgD2oYiQolQl+WYAVrY6iW/uOwptA0HQaF1LQJTWU+RFQZS+i/PapoCm6AB1H6
         HHk6CgLe8jB+R8xVEi8KUewUJdC3GerfOBFEGpw2XvTiy+MtQ06wgcbv1KDMACApH7
         QOJ3Ky4r4ptpwJjR+jdVjiurP2xUpXSb0Xde+nL9y26BpgAF/B2zeLEMGuNXlMdLHO
         EVUM6iX9pm5i+Jh9r3GrhzEp7qbU5uxIn2/BKy78aTVmgRSmHv2
Date:   Thu, 6 Aug 2020 23:51:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kyohei Kadota <lufia@lufia.org>
Cc:     lufia via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
Message-ID: <20200806235139.GB8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyohei Kadota <lufia@lufia.org>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
 <20200806020407.GR6540@camp.crustytoothpaste.net>
 <CAFMepcn-yWtke7eE006a5RGO6uaScWb2xZe4H5M8X4F_T4Rhbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <CAFMepcn-yWtke7eE006a5RGO6uaScWb2xZe4H5M8X4F_T4Rhbw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 13:49:43, Kyohei Kadota wrote:
> I see. If I'd like to put those wrappers to the repository, is there
> the best place for them?

If you can stuff them in a shell function, then I'd just put those in a
file like t/test-lib-wrappers.sh and conditionally source them from
t/test-lib.sh.  Otherwise, I'd create a subdirectory of t and then add
that to the PATH if necessary.

If you're going to use it outside of the testsuite, then maybe
compat/scripts might be a good idea.

> In fact, Plan 9's ape/sh is pdksh, so it supports "command -v".
> However I think, like the above comment, it might be better to create
> the printf(1) wrapper.

Awesome.  I haven't used pdksh in a long time, but if it supports that,
all the better.  I'm surprised it doesn't have printf as a builtin, though.
--=20
brian m. carlson: Houston, Texas, US

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyyXiwAKCRB8DEliiIei
gQqAAP9xt0cAxXTUmOlCSLmAcAqd4CwsDxH5/Sg+yi8zzlGaSQEAwilgZ8uKiGbG
LtJ06s4v5918YhI6M1kRMs7k7zjIUAc=
=KUog
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
