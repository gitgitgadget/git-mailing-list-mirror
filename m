Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60CC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DF61355
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhEUBNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 21:13:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47344 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235906AbhEUBNn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 May 2021 21:13:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9DD4F6043F;
        Fri, 21 May 2021 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621559540;
        bh=4YI4m88hCOOiphYwVIvS13145xuaC8KV36f6w8noAu8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=caP6I421M943HvqqfjVDGhM0S1nH5iDcGJNP2jkU6HbglsGGxPMPJbOcDv93N8Wr3
         EHgEiFkUAK9mLt6mstHfvz6BYrSqz0ZSXjVJ15pbPMrR2pUgKnfnAGLvFeu2vWM+x3
         mOFr6ODARYjV4IrLgkxzkQRWTKqOPeaEobZrruj57h9qMnhUgjFAbdzPSWChGy/zXf
         uBATn1viRKA9J5uy59Mp5kJq/Y9ceXUdjGJ7p7q6fn9cVejTeKO6hQK2VnlkKOgmKZ
         0xTgUYNhHyp/1DRX7SPNKeGBqZuBQAbllAAcFcnDI4IDtrMRKACCTc7mn9CU1YttE+
         1Oi2YYfngQZqNAm6QDWpqYoSto6Mr13dhLKcAGg8zYkasqNWzklLdLOjH0okLqQvd5
         4E5qjhshSMoOxezx7ibtn9K86lJzPF0LJUDgCOj8pi5oqJo94tJMcf9Gu2rOY/kam6
         dqVPrIsEB0gBKI/aWO1sMP25fIiSHCkVS4laHLoD8cShuC0xAIi
Date:   Fri, 21 May 2021 01:12:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Somogyi Henrik <Somogyi.Henrik@eqnet.hu>
Cc:     git@vger.kernel.org
Subject: Re: getting git.exe for Android Studio on Windows
Message-ID: <YKcI8BGHBgkanYPk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Somogyi Henrik <Somogyi.Henrik@eqnet.hu>, git@vger.kernel.org
References: <773cf7ee-f897-a568-92be-9ee7c2813c3b@eqnet.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t41oB6CHcdqKzbNH"
Content-Disposition: inline
In-Reply-To: <773cf7ee-f897-a568-92be-9ee7c2813c3b@eqnet.hu>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t41oB6CHcdqKzbNH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-20 at 05:22:33, Somogyi Henrik wrote:
> Hello Community,
>=20
> I have just learnt, that I can dowload an Android app example from GitHub
> into my Android Studio.
>=20
> But I do not have git.exe installed on my PC yet.
>=20
> What shall I install on my PC to have this git.exe?
>=20
> I wish to install only the bare minimum needed for downloading the exampl=
e.
> I would like to avoid the install of a fully fledged Git with all the
> whistles and bells to have an own "github" on my PC.
>=20
> I do not find this info on [Git - Downloads
> (git-scm.com)](https://git-scm.com/download)

Most people using Git on Windows use the standard Git for Windows
edition.  If you'd like a smaller one, the Git for Windows Portable
option is also available, which can be run off a thumbdrive if you like.

Because Windows lacks a standard POSIX shell and POSIX utilities which
Git requires to run, you need more than a single binary.  Git invokes
the shell when you spawn an editor and run certain types of aliases,
among other activities, so a POSIX shell is absolutely required for Git
to have normal functionality.

Even on Unix, a reasonably functional Git installation requires
additional binaries, such as the HTTP helper, so having only the single
binary would result in substantially reduced functionality, and I'm not
aware of anyone shipping such a configuration.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--t41oB6CHcdqKzbNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKcI7wAKCRB8DEliiIei
gaCjAP9pTnbW5e01AhiWKy/i0QqlU0mL+p7JxG6YbLLNq6wcHgEAziL5VjWgURTF
Egd8C5ovycjCGFiQSSr5aaqyL59RnwY=
=0sgL
-----END PGP SIGNATURE-----

--t41oB6CHcdqKzbNH--
