Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77894C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6247B613BA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFBKrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:47:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhFBKrB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Jun 2021 06:47:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3F65F60400;
        Wed,  2 Jun 2021 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1622630688;
        bh=dpPmFC65jwZBCrCb19wuIui0oF85SWCKEfYAqrR3Woc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TCC/r+9S+rShPlVDrkL8ntoIZcJlNsLMdmeVze7YW1ARfMfuU4hyrntxhV/0NjqJr
         mHDAwO70eBBOffSpj7LKhUTKMhwLy/JQMrjJMMk5fHgHvAhwNwkmnupsyBPlM/BCzP
         WeE9mWuN3jHWckIUaacEdpyo+qWdp/eqTKR/NcYCXuBwxSLDcDPQtzDUY9EQsP3mlX
         NElJyPTSshD+zlmPIdeLSstxi6PD0z53p1nwTnNrqn4L1kFPttVFeZmym+Yg1B4YqO
         NtQmO05kb5p/WWj7F6uir5M0lxngjO6MAqc+8MZrooKtQDVK4k11zg3paHfnvYvZy6
         R1DeGY8Hmfeo83zFQykEjLQYMflhJ9VI6D1pfLPs99BJcsf2oUIlecvvIN9mYLeoh0
         UyozTw/PRArUfOLxnZq5YAma8lwa+A/0MSOiVcdcYF9xvqau6IWmdQpfTs/ZdikB4K
         KTZ/IDNKWiuY7QDq6VvBgwVwgk4B5U/qyeVXc7rHRZAPEjrPyNN
Date:   Wed, 2 Jun 2021 10:44:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Somogyi Henrik <Somogyi.Henrik@eqnet.hu>
Cc:     git@vger.kernel.org
Subject: Re: getting git.exe for Android Studio on Windows
Message-ID: <YLdhGa8eWs9uyh4A@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Somogyi Henrik <Somogyi.Henrik@eqnet.hu>, git@vger.kernel.org
References: <773cf7ee-f897-a568-92be-9ee7c2813c3b@eqnet.hu>
 <YKcI8BGHBgkanYPk@camp.crustytoothpaste.net>
 <80336a2e-fb75-5fc1-1516-f1d1d96ff529@eqnet.hu>
 <ba109d68-9953-569f-56a7-a2f557bf971f@eqnet.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KuEXEJjd9zujrGUW"
Content-Disposition: inline
In-Reply-To: <ba109d68-9953-569f-56a7-a2f557bf971f@eqnet.hu>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KuEXEJjd9zujrGUW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-02 at 05:53:55, Somogyi Henrik wrote:
> Hello Brian,

Hi,

Please keep the list in CC so that everyone can see the discussion.  I'm
not that familiar with Windows and may be offline for a few days soon,
so if you CC the list you may find someone who is better able to answer
your questions.

> I have installed "Git for Windows v2.31.1".
>=20
> I only need the git.exe so that Android Studio can use it for dowloading a
> sample Android app from GitHub.
>=20
> But now I got 4 git.exe programs:
>=20
> F:\programs\Git
> 	\bin\git.exe
> 	\cmd\git.exe
> 	\mingw64\bin\git.exe
> 	\mingw64\libexec\git-core\git.exe
>=20
> Which should I specify in Android Studio as the needed git.exe?

I believe you can go to a command prompt and type "where git" and that
should print the proper location.  If you've installed the portable
version, I believe the one in the top-level bin directory is correct.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--KuEXEJjd9zujrGUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYLdhGAAKCRB8DEliiIei
gW2wAQChh75B9ubrvPoxaQIibXNN2A+7GJBxS0F8Ii44kfDRiwD+PFbrCPt6NMiv
T9hergjewdsSZWcL4vEYrxJNbEr0QAE=
=srKO
-----END PGP SIGNATURE-----

--KuEXEJjd9zujrGUW--
