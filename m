Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C49CC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A4B207DE
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="F2eIv2n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgHSKUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:20:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgHSKT7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Aug 2020 06:19:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0DF9A60456;
        Wed, 19 Aug 2020 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597832397;
        bh=y2JuDSyaFkinL0GJxxVaKqm8VBhAKIJ6WTYSbnwXoDQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=F2eIv2n8Uis7fFuo5q02CN6Y0yTxjwDsJ9uCMkTdzEgmPHYZ48jfN6Jc6wy62IS9n
         ifWDO8thdmm/oi7D2M2SuCo/UiDv6Bf9yXWv47x/yeaJ3B6ggmZCG+E0Ro7ljm9SEg
         ERH+SfKVQRA20sRgw6rOnOr8Fs53I0l/bYUuH1xpBouWImwsdYVtPiiGSJnle2goA7
         9R3Sx61Ucg2bJyIdNlzmGnxzjPz89K9vbymkqCbz81u6P2pJFx9PJ6SqQtqsOzBXJU
         rhzM58sO7jhnsOPx7m7443/LyOQR6Gobky4SxuSPKMnp4IIZKS0mCe1yGWngtdyLMl
         uLsfk8XcYLdVLHeaHPRns4YNW7l9r69R8ryh0nagDMaWU0hDnk78I5h+vVlM5EzPTO
         anRtFIHFT5Daj5GBdA87m6ASHhQ5K5/rldlY9L1/Qski3BxIgNRYR5az60kM3ZGrAt
         C/ZQsyDePCcyiQi7TFwAbyHGSYGqJOcDM7c8Ds8CPfBuYrs7zmu
Date:   Wed, 19 Aug 2020 10:19:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jimit Bhalavat <jimit@rams.colostate.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Huseby <dhuseby@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
Message-ID: <20200819101950.GV8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jimit Bhalavat <jimit@rams.colostate.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Huseby <dhuseby@linuxfoundation.org>, git@vger.kernel.org
References: <43C81FDC-611D-45A1-9525-24640FEB2E1A@rams.colostate.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline
In-Reply-To: <43C81FDC-611D-45A1-9525-24640FEB2E1A@rams.colostate.edu>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-18 at 18:43:45, Jimit Bhalavat wrote:
> The proposal:
>=20
> 	1. We aim to achieve that instead of having C code that calls all the si=
gning tools, we will try to achieve that only one piece of code will do the=
 standardized pipe forking and take the values from the config file. The co=
nfig file will contain the following values: which executable to run, what =
parameters to pass, what regular expressions to use for detecting signature=
 type and pulling the signature out of commits and tags.

Assuming the config file is the standard one and not a custom config
file, this seems fine.

> 	2. The current patch uses a set of function pointers, but this project a=
ims to use a struct with the configuration data for the detected signature =
type such as PGP, x509, minisig, etc.
> 		a. When signing, the signature type either comes from the command-line =
switch or from the signing default as specified in the config file. The con=
fig file has different parameters: which executable to run, what parameters=
 to pass, what regular expressions to use for detecting signature type and =
pulling the signature out of commits and tags. The goal is to try and call =
the signing tools from one piece of code instead multiple C code. If the co=
nfig file does not have any values, it defaults to the GPG executable, GPG =
regular expressions, and the GPG parameters.
> 		b. During the verification process, the signature type is detected by u=
sing regular expressions from the config file. The regular expression searc=
hes for metadata for a matching signature, and the first one that matches, =
that format is returned and used for the verification. This design also ope=
ns up the possibility of having multiple signatures on a commit/tag.

Having multiple signatures is tricky, but I'm willing to reserve
judgement until I see this.  I'm not opposed in principle.

> 		c. Once format is determined, a signing_tool struct is initialized for =
the given format. The struct contains all of the config data for the given =
tool (e.g. program to run, regex=E2=80=99s, command line switches, etc).
> 	3. The project also aims to improve the signing-interface.c file to work=
 from the signing_tool struct which we created above which contains all of =
the configuration data for the given tool such as what program to run, regu=
lar expressions, and command line switches. The flow of the code should loo=
k like this:
> 		a. Pass in a signing tool struct to sign commit
> 		b. Instead of calling function pointers to the signing-tool-specific =
=E2=80=9Cdrivers=E2=80=9D, it will instead do what the existing code does; =
however the executable and command line switches all come from the config/d=
efaults instead of being hard coded..
> 	4. Create a struct for signer_identity:
> 		a. This struct will be helpful to load signer_identity from config (e.g=
=2E the existing signingkey config item) or command line.
> 		b. It stores the signing-tool-specific signer identity string/identifie=
r, so that it can be passed to the signing tool.
> 	5. All of these changes will make sure that we maintain backwards compat=
ibility. We are aiming to deprecate things a little but old options will no=
t stop working. We will preserve existing behavior. The goal is to try and =
call the signing tools from one piece of code instead multiple C code.

As Junio said, we prefer to look at patches rather than a proposal, but
I so far am happy with what you've proposed.  Assuming your code is of
good quality, I can see this being a viable design and I'd be happy to
see these changes come in.

I expect some conflicts with some future SHA-256 work I'm doing, but
that's my problem, not yours.
--=20
brian m. carlson: Houston, Texas, US

--yC91f7qSViS67v3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzz8xAAKCRB8DEliiIei
gYj9AQDKZSejdXV33oLl7b2hst44ItdQMWNwGTb+7HqIvr+0ugD/ShdZLsnkgbm1
gM96uv4RAMMl73aJxJyMQLgAY1oCFQY=
=zyyo
-----END PGP SIGNATURE-----

--yC91f7qSViS67v3c--
