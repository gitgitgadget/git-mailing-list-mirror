Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997CC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 01:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEADF20709
	for <git@archiver.kernel.org>; Thu, 21 May 2020 01:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g5dJpUAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgEUBx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 21:53:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgEUBx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 May 2020 21:53:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 09EEA60482;
        Thu, 21 May 2020 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590026008;
        bh=6w9YTNt0wMwQ+4N1q4kANck0LKtRRSM5tLPH9ymiB2k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=g5dJpUATQ4ghX+NaYCH9IOFOTPqfYmlOkq2TvBshhsCT37vMjAaym4hmDkpEWlnUd
         LhN7PqVUeu0LcRBLbGSia3vo+5MhU2+Kq63aQG4M7OBBmMM6TU844HdU4TpA/LErQE
         +Z7ytTdvhHP2SSFvjc8DTLs5oxUh/s2oYevcJ1hwtgov8h1fZHt1LC96jpiM9pNSLl
         n62tefXYzBmJj0B4Yf1EdQHrShNgpvMW7qKITPh4V6z0VkorjxEtEA7+5DIFaqbUVy
         0YkRjinqqbs1JJXenBxIvoNgn3a1PdTBEkZ5UKwKYZmGHhhQljCEgs6bOY6xGIlBOq
         Iws0f3ifrFUNApdWpnrUJULEQmNX9ghzbI0ALvXK8rs0uBYuDM8krmcdoVzHnWWWfD
         9frW98ryksR+XP7g81Zw0wKDWXVNu/llARS2OKjPh1owQkn/OCE0LA4RF5gnMTKM/E
         sL3CgZV7fH6QPjSq5COZPE2Q97GUzJjhN17NTbYy/vHIVm2iYud
Date:   Thu, 21 May 2020 01:53:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] command-list.txt: add gitfaq to the list of guides
Message-ID: <20200521015319.GU6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.639.git.1589985889076.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dwN3S3mscniL3FCL"
Content-Disposition: inline
In-Reply-To: <pull.639.git.1589985889076.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dwN3S3mscniL3FCL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-20 at 14:44:48, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> When 'gitfaq.txt' was added in 2149b6748f (docs: add a FAQ, 2020-03-30),
> it was added to the Makefile but not to command-list.txt.
>=20
> Add it there also, so that the new FAQ is listed in the output of
> `git help --guides`.

Thanks for catching this.  This seems obviously correct.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dwN3S3mscniL3FCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsXfDwAKCRB8DEliiIei
gQ2YAQDtoAu3Ot9/rzdhFz/zahvAhDtSFS63/Yo4fIqjHA9V/gD9EZdel0WuTIAe
dGEJS0tT2TWfLYjXTx4WZuercbvEvA8=
=noR9
-----END PGP SIGNATURE-----

--dwN3S3mscniL3FCL--
