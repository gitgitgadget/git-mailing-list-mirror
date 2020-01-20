Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4644C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B908422314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QHNpGNBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgATTWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:22:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43142 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgATTWL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 14:22:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 828EA6044F;
        Mon, 20 Jan 2020 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579548129;
        bh=pTpruoFbUOaljcsOvmcatTNYg3JcGF0+x1LtQAAmmIM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QHNpGNBRlb6XpvVew0i4jANLS2gqSkaF5ulzAZax+WRLJsyPuuMqGrochvh2deUt4
         3KFMYySlemjNW4/ZxP4IhRpanh6n7atI0tZVNy954Y6/wuRGyiAoT5tbw9wYEw7N04
         0nEqv3EIECAmGNn+F75pdQmQNUWNDSxZKF/H79QpQSIjC+RbvRAS12zulmKme7EeVk
         lWP82c4xlW4uSezFe6dDZz+GZg2882SiIOE3Oohf7LFn8xbjDZeBaVnN0ByUGslhcc
         Oo++Lzt5npsJa90FnKNWmQjeCwC32RmOOEUfsHReKqNjktXPLJdDSydyPmWknURkAv
         QKD37tOxp1VdmMbTC5CejDhwLp+dxL3UcBAR60AuIXhkTJEspVpl/Wn0JB5h3rvSqI
         RlqnSVPXQJYk/5HxRYUuhY55m0A70JdyxkhLAAkG6XMkFZjZz5PdFopSDcokj9vNmq
         Vk27PThoORK2MIMoX/C1qtjv71CcLaXVeOr4txo1L1J5/DwRyoC
Date:   Mon, 20 Jan 2020 19:22:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 1/5] doc: move author and committer information to
 git-commit(1)
Message-ID: <20200120192204.GD6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
 <20200120173343.4102954-2-sandals@crustytoothpaste.net>
 <20200120175210.GA3989@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6nK9RR+X1IX2pXa"
Content-Disposition: inline
In-Reply-To: <20200120175210.GA3989@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f6nK9RR+X1IX2pXa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-20 at 17:52:10, Jeff King wrote:
> On Mon, Jan 20, 2020 at 05:33:39PM +0000, brian m. carlson wrote:
>=20
> > diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-comm=
it-tree.txt
> > index 4b90b9c12a..adc2e0d4b7 100644
> > --- a/Documentation/git-commit-tree.txt
> > +++ b/Documentation/git-commit-tree.txt
> > @@ -42,6 +42,10 @@ tend to just write the result to the file that is po=
inted at by
> >  `.git/HEAD`, so that we can always see what the last committed
> >  state was.
> > =20
> > +A commit comment is read from stdin. If a changelog
> > +entry is not provided via "<" redirection, 'git commit-tree' will just=
 wait
> > +for one to be entered and terminated with ^D.
> > +
> >  OPTIONS
> >  -------
> >  <tree>::
>=20
> This text got moved up, which kind of make sense to me, but...
>=20
> it stayed here, so now it's duplicated. Should the old one be dropped?
> Or is moving the new text a leftover mistake from rebasing (IIRC, in
> your original you dropped this whole "here's how commits work" section).
>=20
> Other than that, the patch looks good to me.

Thanks for pointing this out.  I'll fix it and if nobody else has
comments today, send out a v5 later this week, probably tomorrow.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--f6nK9RR+X1IX2pXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4l/dwACgkQv1NdgR9S
9ovzMBAApuEVFmflJnoKhZFk5j/R/OqdDqRtOFHThh0mgWoYgoZMrWdufO4/paTJ
vCn6aHEWMOLlnlrX8D0qJQShv4htMs0x9rg0qhXpsWQLos+TH0EibNN6pxdeYSSA
baXm4q2kYHznGhtTIZVgDfIzNxqP1vke3BdFjThXx7wDnGyNJqCz7dOShylfO2dX
1wG1bgzEPe6amlutsABk7j9HMSThLsJvhhIgu1g8GfrI6qprus84LHPLaPZy0m1g
q7+xD9jFwHfieLiqxKnehvstnkA/RECutkrQqohWUK0vOMJ/GTJjMP65NOpl9vXK
w2FY74SnArCTKyj1KklMUPF1Ipvkiv1XlGeMyeCslb4wrpQihbxOClV/03FmUWW7
jBg6pJjPDyS6xudbk0Hy6+ZcVD8xdh/VO/RCSADFDi8C94o/jmsPWvNEbE6i0c5h
uynXRJt6PzprFgMpyK1jffwXetTNPFBXTv4rOS8kH72CQd5TIt/fvf8LbROP6lpA
1a1lao2o3ymgZa2n7/pPx9FVLQNbt20r9ezl73joHtbcYpTmczyKyu1j8NP3ASMx
9BAbZhu4FClhCNnmHsGguA12qBe8Utbd9qG+plaKScQKlK4kM5WUvZCTXNNBudqr
+8AxX4FOnKq1+TMKkEESQ5+wp1M3pOrRjbT3RZhcXnI9jt5elE4=
=u1If
-----END PGP SIGNATURE-----

--f6nK9RR+X1IX2pXa--
