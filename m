Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0125BC433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C455620734
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0Sn8p/Fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbgFRRwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:52:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39380 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgFRRwj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 13:52:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5AE06048A;
        Thu, 18 Jun 2020 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592502757;
        bh=Z57+OtNRT7Yr5FPiL/uaskFvlqduAcEUuvClZxjLAU4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0Sn8p/FlSBHEid9z8v9272BXyD6NlrzcZ3CvDh8vX7XMn0sTnLxZKRbphYryKtAiT
         /Zv7o6gbrtROtJpFSvQNcugNN7QOH2RI9uCTuNv/HfAmdZuzFGb26URGcRGtYZVnLn
         8Fv4WewxSM0W8QOU3MOOequeOQgka6ODFHZu624/Y9Wr2kg0CZLCuDhKi9UZ77OMfy
         0w0G3liHNLU254n7tEwIVRZRqGP/3jlTvHzxpVMmeCSPQHcDGjRTwXs5U//iAYHsZ+
         AiIxCb3w7GwTpX7sHtkBaJvRVvIFzopFX/uJnMppb+SOvf+H2tsVqaO7S78YmE2s77
         MlNs/ob829fWM0rz3SuWCVgQoXWkY2OjVr1YnQJxR4Gt5Zt1vj6DNV3I3s8BEgzkPg
         gy3O7pLT7nNjAw6B/LJaHbHpw+b3e6Ak8QUQzBPCE9iPJtNDy4TfDUbg/l88X8SphB
         sptSwTvtV/7/9iO8luHTLUUD9uxN2MQmLVej1K9W6HPyhbMcgZH
Date:   Thu, 18 Jun 2020 17:52:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     sopq0asmppc9@online.de
Cc:     git@vger.kernel.org
Subject: Re: Git commands throw error
Message-ID: <20200618175232.GI6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        sopq0asmppc9@online.de, git@vger.kernel.org
References: <01af01d6452d$1a91b590$4fb520b0$@online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
In-Reply-To: <01af01d6452d$1a91b590$4fb520b0$@online.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-18 at 04:58:27, sopq0asmppc9@online.de wrote:
> Hi!
>=20
> I recently upgraded my GIT installation to git version 2.27.0.windows.1

You're probably going to have a better time here reporting this to the
Git for Windows folks at https://github.com/git-for-windows/git.

> I have all my repositories on a NAS and now I get errors with all command=
s, e.g.
> git status ->  fatal: failed to stat '=E2=80=99: Function not implemented
> git pull ->  fatal: failed to stat '=E2=80=99: Function not implemented
>=20
> Setting fscache to false (globally or locally) does not help. Please fix =
it quickly =F0=9F=98=89

When you report this, you'll need to mention which file system you're
using on your NAS, since it's probably related here.  You may also be
running into filename length problems and you could try turning on long
path support.

Finally, something else you could try is to see if some other process is
using these files and if so, kill it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuup3wAKCRB8DEliiIei
gY6gAP0QWInF5cSed489Hdgsip1MZUgIQPm/HELwyOSwv16qJgEAlEjx+fiU+wUk
vjGFqVbidt5qFBBxaDHtnmo/FzN3owY=
=WFqN
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
