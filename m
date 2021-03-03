Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99960C433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EAD64EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448796AbhCCGf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32908 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235819AbhCCAnY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 2 Mar 2021 19:43:24 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5DE4660DF4;
        Wed,  3 Mar 2021 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614732151;
        bh=dcP6/liGT6Hg4biDKnHgVsszXpoz+H0MSVxYum0Azok=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iNJSNwULDu7we+f81xbs8SU5FwqMgQqWcD6he9BxFzY8fl9TnAGLJ/Dx7WNSvqxaT
         7Mlapz9DF16lO+ZayjxDQhAwkXudG42Ah0X478Y3mNHdvHDMhFDGffVViygk1I2P86
         i/e8c7HKV4+U0/WtJrNfxuSt3Z2cQCu+DEsL9qQtX9o6BvOsaRmEMefAWvahd43qfV
         h0C2ODYmMwcLZv1BqzF2VYnaLLBQY//Z7/kSNj4FicxacnnbjRIKSV4rcujXqEd9jf
         PtSI8cuFe8yRJUQy+SecEJQgyCO9vSFgUtUEzDg4R6/bb/NhaGCQsx7MyEp5DJe35V
         P4ojaYqv9EkP5swczvRSlMpKDO1qtUmkoIG3PTNsC9/KIWzXfB+cjEfMa7AIyWiO6/
         1ZkKhRG+yn0VN6iWFyEU6iUdldxW8ubMIjFaenR1ZoHMpS5Wtb4SZodB5OV393bWfn
         Q7lDvinYzDKg2ukmX3jh7st4g+nRL49HTAhbTmigHK3an7XrQ2G
Date:   Wed, 3 Mar 2021 00:42:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: Argument list too long when fetching many missing objects from
 partial clone
Message-ID: <YD7bczBsIR5rkqfc@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
References: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
 <CAGyf7-GJQU1s4H-pgVMEc_WB3C4ehppLieT2oiyxa5B8=yyjxA@mail.gmail.com>
 <f185e87e-d8d2-3ac4-9ca1-7b96ffb30562@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PnB5Ga0uOI6D8V/D"
Content-Disposition: inline
In-Reply-To: <f185e87e-d8d2-3ac4-9ca1-7b96ffb30562@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PnB5Ga0uOI6D8V/D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Note: we generally prefer inline responses.]

On 2021-03-02 at 06:55:27, Bagas Sanjaya wrote:
> After trying your suggestion, I now get:
>=20
> error: RPC failed; HTTP 413 curl 22 The requested URL returned error: 413
> fatal: unable to write request to remote: Broken pipe

Hmmm, this means that your local Git server is unhappy with the size of
the request.  That means your request is probably very large, and it's
likely that it is kindly asking you not to DoS it.

> On 02/03/21 02.22, Bryan Turner wrote:
> > On Mon, Mar 1, 2021 at 5:20 AM Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
> > > Inside the partial clone, I tried to convert it to full clone. First,=
 I gather
> > > list of missing objects:
> > >=20
> > >      git rev-list --objects --all --missing=3Dprint | grep -oP '^\?\K=
\w+' > .git/missing.list
> > >=20
> > > Then I fetched those:
> > >=20
> > >      git fetch origin $(cat .git/missing.list)
> >=20
> > Since you're on Git 2.30, instead of trying to place all the object
> > IDs on the `git fetch` command line, have you tried adding `--stdin`
> > and having it read from your `missing.list` directly? Something like
> > `git fetch --stdin origin <.git/missing.list` might do what you need.

You may want to try this:

  xargs git fetch origin < .git/missing.list

That will batch the requests to fit on the command line, which will
probably also have the pleasant side effect that it makes each
individual request smaller to avoid the 413.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--PnB5Ga0uOI6D8V/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYD7bcwAKCRB8DEliiIei
ge/2AP46ICm00fZt/Dcr6ojyHb1m/Bja0rJ/8ACUr6agrjXvnwEAwDK0lnK9ilh8
OnM5Fh5mJ8D4nHzlQvscK/Su170OCgs=
=jsWX
-----END PGP SIGNATURE-----

--PnB5Ga0uOI6D8V/D--
