Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863FEC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5147020639
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E/GlJkPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHZBoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:44:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47556 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgHZBoc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Aug 2020 21:44:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B3A960457;
        Wed, 26 Aug 2020 01:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598406271;
        bh=S+KvxEOqyAt+1fjEba3/VnndP2WZ0zlQhyzWI4tH50Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=E/GlJkPviYJzRIOKpbVh7SX/n9jxBMpdQuBMYvqm0SJKdwfBnAo6MO/J2bkR7PsMW
         qvxUuKO5ZfJvhaTdbxormvWVlEjjCmUJ9zbqG+1bVAKSz91sWF6VrPYMbkLyVyqF/2
         1Ct72pVzJr4T3WMY+VE5mzEFvJyKaFmfdg6mJQ0uv/sbZnP4K0uskmxckIRGnLKsSP
         2ZwWTwjXyP3GlHTZNN1KQUo1/VmqHTyxh5XZNuNovY+dhGMz7TEIDMhunc7I5WwGOA
         M/O5FeXAUlnNDzJsQXeFlpxytJ6Ca3ojw8lS2eYUZ7SnseuOkpfNW4HbBXGk0BJ/FT
         kDkE3eXs2GBMTbWlHTotDtqSxTseikLxKdLg+kSe9Hhxl6mi91/q5Q/IBbsTRBuG+B
         9FlcADgCkSw+vg5vWdtr3sbFizSi1ayHJhZXVpbFkkh7YyqT1Glw65NNRJ1FvD3D3u
         sESpvOa82EQZmjkJbwbWNGs2nnZgwWL/9DJRUPRcnFSBEcw4Txu
Date:   Wed, 26 Aug 2020 01:44:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Peterson, Alex" <alexpete@amazon.com>
Cc:     git@vger.kernel.org
Subject: Re: Temporary credentials timeout during long operations
Message-ID: <20200826014426.GB7678@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Peterson, Alex" <alexpete@amazon.com>, git@vger.kernel.org
References: <18381efb749d43d097665960021a76ef@EX13D10UWA004.ant.amazon.com>
 <20200713231153.GI8360@camp.crustytoothpaste.net>
 <1f95e9da5e734dd3a8f94c1337f8c756@EX13D10UWA004.ant.amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <1f95e9da5e734dd3a8f94c1337f8c756@EX13D10UWA004.ant.amazon.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please keep the list in CC.  Other people may have important
contributions to the discussion, and due to weather, I may be offline at
some point in the future and be unable to respond.]

On 2020-08-26 at 00:18:05, Peterson, Alex wrote:
> Hi Brian,
>=20
> Unfortunately, even if the server returns a 401, git will retry but with =
the old expired credentials which will fail.  I believe it is because of th=
is line that checks if a username/password already exists (which it does)
> https://github.com/git/git/blob/07d8ea56f2ecb64b75b92264770c0a664231ce17/=
credential.c#L338
>=20
> In my test I cleared the username and password to force it to re-request =
credentials and that worked OK.

Ah, yes.  In that case, it looks like we call credential_reject and then
return HTTP_NOAUTH.  I think the assumption is that the credential
helper returns a consistent set of credentials and once we've told the
credential helper to reject them, then the user can push again and be
prompted for new credentials.

I would be open to seeing a patch which, the first time through,
returned HTTP_REAUTH.  We wouldn't want to do that indefinitely, since
that would mean that the user would get stuck in a loop if the
credentials were wrong.

I will say that my gut tells me that it's generally a reasonable
assumption that credentials are valid for the life of a push, whatever
that is, so while I'm not opposed to seeing a patch to improve this, I'm
not especially sympathetic to using credentials that have such a short
lifetime that this occurs, even if I am in general in support of
short-lived credentials.
--=20
brian m. carlson: Houston, Texas, US

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0W+egAKCRB8DEliiIei
gbZRAQDwbuL2igV4U737WUW8JZQC5MoUK25ugbspJrwBclBWIgEAhecOVEBxcEUf
AcM/a4rxE/CSh/cCdMj8oc62KM6cJw8=
=ifbI
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
