Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5EC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17F720719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Qf87PVDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgCWXyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:54:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgCWXyF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Mar 2020 19:54:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B02336077C;
        Mon, 23 Mar 2020 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585007644;
        bh=8wzgoLc4dQvlXKMa3EWYQM+Jehkx/yJZF+Kzl2pQfBo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Qf87PVDPMnpm3a/hMzVsELzMxSWbeRkZBRC0zAZ4TP/aZsgP11AxegBssNzA1nB+1
         Z4NKrm26nAUxStuGZ/ArNr2ygQ+Z/uaUzB5uD+18cMmdqxEeJLmUhrtVga6gRXzgwh
         W8DUL7b5uUfteLK4U/pw198W+HqYRgLPkB7LNOrDf2qvNscKwuBjMLodK+B9sJt6nR
         3tyk50ZMiKD5kTFVdVTyyWl4jGqKg6AoXYsfCvrN1nfQrrAbFJmv3fuJ9oKREOaUAD
         qFf/8mgwcnKwjXUAUt4WaxGaw0hNjSC1RZ/TbfLvOSYF1jm+oavhUduNgqcBjjVSIG
         ayOlFvFB6xr2PDSk08GqSZoviwNfw5df89qTgxrDQFh/R6Pv+UJYX6Q7qvhArSkrP9
         mrHdyLtIpBVS7bHB6SpdbDE5+NvwJKxs/wi0vq6nU2nbAbwUwWiG85bxSpXiZq910p
         RckEzaWyd+WosoByEthSt4E1fph0bkj9vhNOoteGN67Emgw6pqm
Date:   Mon, 23 Mar 2020 23:53:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Cc:     git@vger.kernel.org
Subject: Re: Relative url values in .gitmodules confusingly sensitive to
 clone via ssh vs https.
Message-ID: <20200323235358.GF6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
 <20200323011117.GC6499@camp.crustytoothpaste.net>
 <CAAjm7GZXNXcGMp7p2f+UoDUWMPY+Z4aFHv35tynteVSKDf2Fqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <CAAjm7GZXNXcGMp7p2f+UoDUWMPY+Z4aFHv35tynteVSKDf2Fqw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-23 at 15:09:39, Benjamin Shropshire wrote:
> $ git --version
> git version 2.20.1

Hmmm, it looks like that version has the same test, t0060, which has
this:

  test_submodule_relative_url "(null)" "user@host:path/to/repo" "../subrepo=
" "user@host:path/to/subrepo"
  test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "user@=
host:subrepo"
  test_submodule_relative_url "(null)" "user@host:repo" "../../subrepo" ".:=
subrepo"

I have confirmed that your test case does work for me on the version of
Git I mentioned above with the following repos:

  bmc@castro:foo/foo.git
  bmc@castro:bar/bar.git

And foo.git having the following .gitmodules:

  [submodule "bar.git"]
          path =3D bar.git
          url =3D ../../bar/bar.git

It's puzzling to me that this isn't working for you on 2.20.1 but it
works for me on a 2.26 prerelease, yet both versions have the same test.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnlMFgAKCRB8DEliiIei
gWGhAQC7vpi9IE+7hhRdQovOWzIYkNvboF4xq4KSxO2WT6waRAEA0jwGvzI/N/kb
2hE4ayjBueynQFF492Fo/emCQcu6qw8=
=/XyS
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
