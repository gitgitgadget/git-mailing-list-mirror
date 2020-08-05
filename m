Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940F6C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 02:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9B520678
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HNAuOk3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHECAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:00:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgHECAP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Aug 2020 22:00:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5360160799;
        Wed,  5 Aug 2020 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596592784;
        bh=oFlhixbVOh+2Fu7dIJjQzEV5DpIqnetiHAhmJ9pSegY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HNAuOk3kULOHhWf/TBcqaUNaapxaTRk1DcgrAy/cCTt5+b4k8h33mQifK3s0WjccB
         1hQYUlR60QqFDL/IYSw1IQ+nQZ5MIo/99W7VBmoLKAXlHbQxJWU0S9B3XUuF5rVTcC
         Mc9/DAJCveqNOfIv14ZOHJW9/ohcOwr4g4qC9RT53sgUzZlFJURBDa6CNyUACm1feV
         4nwy6R25eMVFIL4wzpFpeQhPDT0CClWtVEpbx11yefBEE7uLCUv/qRA5RREeFCJsVe
         A8cqwPw14Tv8AJ1EvViiCXS7NalTfl4aktJ8eBzpi3ZWe3JO45RW9O6+4wHBz1Vj2d
         AzYh0lqDjmfj8dAeyn/08eUJF9GlpLQUUEchwAFk3thjIfpZNdGX2dvC1ZkjsCfyvX
         jOzjQ7C8+dMKrkJtcckmr9iaKxzbcXbpgTq2nsbqHX4aSw9z0KtkDvJ2cNLU5yru4u
         sgKVGa+HCzOL3mRk4LqcuoA/ED4ZHHCqwh0V21mt0nVnGtryfin
Date:   Wed, 5 Aug 2020 01:59:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why is AuthorDate displayed on git-blame?
Message-ID: <20200805015939.GQ6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= <inoamsol@gmail.com>,
        git@vger.kernel.org
References: <CAAWR3A9po-zMVFdQfDs6R5F_rf0UvSyfByLj-vYZiXLb8+j4Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline
In-Reply-To: <CAAWR3A9po-zMVFdQfDs6R5F_rf0UvSyfByLj-vYZiXLb8+j4Ug@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-05 at 00:18:43, =D7=A0=D7=A2=D7=9D =D7=A1=D7=95=D7=9C=D7=95=D7=
=91=D7=99=D7=A6'=D7=99=D7=A7 wrote:
> Hey everybody, I wonder about the decision behind git-blame and
> git-annotate date that is being shown.
>=20
> If I understand correctly, the AuthorDate is displayed, and I'd like
> to challenge that decision. Consider the following case:
>=20
> A feature branch having commits authored last week, but merged to the
> main branch just today. And to the sake of discussion, let's say that
> the branch has a bug.
>=20
> When someone encounters the bug on the main branch, he would probably
> want to know when it was introduced - the date when the bug started
> to affect him. However, git-blame only shows him when the bug was
> originally authored, in our case - *last-week*, which is confusing
> since the main branch was working just fine back then.
>=20
> So I wonder why was AuthorDate the date chosen to be displayed under
> git-blame?

I can't speak for the original author of this, and I think Junio's
answer explains this well, but I'd like to add an additional thought on
why the current behavior is useful.

For me, I am primarily interested in using blame to find information
about the party most knowledgable about the subsystem or area, or to
find a commit that introduced a change (possibly so I can read its
commit message or pull request).  I'm less likely to use blame to, well,
blame people.  Consequently, it's often helpful for me to know about
when the code was written, since that tells me more about the author and
their situation than the committer information does.

For a project like Git, the committer information would not be very
interesting to me, since Junio, while very competent, is not the expert
for every line in the codebase.  Since we're displaying the author name,
we might as well display the author timestamp as well.

I'm in favor of an option for this, though.
--=20
brian m. carlson: Houston, Texas, US

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyoSiwAKCRB8DEliiIei
gTBWAP9+q3I3LVG8QPcyK7Bw9OaB9Qe5nHJZI0rwTQNrWwmaEQD+NqTYZsslsEj1
6ncFn6fStPDAWiqgjciELxsmZz1qKwc=
=VSvh
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--
