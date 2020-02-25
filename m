Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053CEC35DEE
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 01:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFAF21927
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 01:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JCB3Q4kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBYBN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:13:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgBYBN1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 20:13:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BCBDC60448;
        Tue, 25 Feb 2020 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582593206;
        bh=n2rDP1ttZpUUfS+y2GouC4xCyAriFL0mmm1omjV5v10=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JCB3Q4kTUvttxX6BKcT/QQ4sv6M/I1VhbUwCnGCTyj1xcQX6vEubb8FcMSSfpwkTk
         d5NFb2C79pzbUtmbF8ISDb74VS+bNIY7lPdHJSpXhs/ALiqY8s7bbrqgyAGeApOhvW
         tFs2QEvPxRHFcaW7BVC/kkmjuihzr21+cfvssc+pwfAdcSDVnh0Uwh7AUkCLCmqHx8
         KQYmfm6KH7f2olShcI1z5NTct7iuqe3Qjv4zi5hbazWgRVybkwbriL/vPN58fuzaXV
         q9T0wx/Iil3ME8sG7ILGqyIHGUB6E71VNxFBMABcroBnEGFGAT/3lmfvOSz6R7CgMg
         K2Ln/vaKepzwC+zE6q8gyyOoNkQyzXgoDrPLCcs7P/Zt6UaLnioVAUJAOK4U3Tzj5f
         veQf29cgPpfFtG6MlnAvHFjfKA57scinHhvzKOEAVqWqhjTTmA8oXVM+ceIzMOiQvy
         pXElUBdPw6x1v7MTJu1c1/yNaMuNiPbW2t7lp0ONPlzP8R9OPrk
Date:   Tue, 25 Feb 2020 01:13:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan <git.kernel.org_20@green-sparklet.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug: 'git ls-files' doesn't work on submodule in post-commit hook
Message-ID: <20200225011320.GL6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan <git.kernel.org_20@green-sparklet.de>, git@vger.kernel.org
References: <ede4b653-35bf-d163-c27d-d23602dbd726@green-sparklet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6DVDhPhk1bqxDrC"
Content-Disposition: inline
In-Reply-To: <ede4b653-35bf-d163-c27d-d23602dbd726@green-sparklet.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g6DVDhPhk1bqxDrC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 07:03:15, Stefan wrote:
> So 'git ls-files' call in post-checkout hook works:
> $ git checkout HEAD
> A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gitmodules
> A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git-submodulerepo
> Git says my files are:
> submodule_file.txt
> ---------------
> Filesystem says my files are:
> submodule_file.txt
> ---------------
> =C2=A0
> A 'git ls-files' in post-commit doesn=E2=80=99t work:
> $=C2=A0 echo nothing >> rubbish.txt && git commit rubbish.txt -m "Add jus=
t rubbish"
> Git says my files are:
> ---------------
> Filesystem says my files are:
> submodule_file.txt
> ---------------
> [master e05efb1] just rubbish
> 1 file changed, 1 insertion(+)

Can you check to see if the GIT_DIR environment variable is set in your
hook?  In some cases, Git sets various GIT_* environment variables when
calling a hook or command, and if you want another repository, you'd
need to unset those values.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--g6DVDhPhk1bqxDrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlR0rgAKCRB8DEliiIei
geCYAQCTBfvpYfWwyyKq9W3TqyPRrkB+OjuIq6n9U9D0PotO5QEAu64DnEJFvbCA
mh1m8FdAL+tvpD5Yu3rt38KygEgIaQA=
=MnFS
-----END PGP SIGNATURE-----

--g6DVDhPhk1bqxDrC--
