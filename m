Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B93C49361
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5034C611C0
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUCC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 22:02:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhFUCC6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Jun 2021 22:02:58 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7846460424;
        Mon, 21 Jun 2021 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624240814;
        bh=KnHeir3/W9QXzJpZSxp/8mTE9yrur/xgsCowhMV9nyQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pAbQRxNCcoCqzALeXUSimg9/VUGcRecc0HvtQqNuPHuPHRn7uUDbxuuq1Apqi7KxT
         1fXMf6aazlIhgYkYnjcj6b4kkt99h8BMqOilwmWiUVx/nEQun/6AlghIxvT0Wvryb5
         Yi5YB+I333uCvZVAYDf/IS7/AHOGsDvX9tXYHa5B5x3MpWBYEjPGNaPiuxyzDmDIEY
         iO6qKS0GwCI9nx7jBiEF20FcEDT1qzuaFgXvmccCfsdjrLcaEP9NN+m2frxstv4t/C
         kcIjwuC2xfq7Y8+vjNAPy1rfamAyLF3RtQpMdTXL668keeJVQr5VQZNdfOS7Bxe+Oy
         gcsN576FNFO8XQ2Rf7bGEtCJkLPth5hxKqBVLs5mqfxLf2psrIAaDVTGKOQluPdkYA
         atn6IrfTZyM7BSLqOpM5iaK+43R/OvEahsAcuXH+zuFnwZGDjEyb8CpkQ+kFskJJB/
         uY7jDIJlPBZKm2XNQgVImqoMuiVpCOE2ZpEw5hVkgxcYSzK48KQ
Date:   Mon, 21 Jun 2021 02:00:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Roland Hieber <rhi@pengutronix.de>, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Message-ID: <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <877dio3vg5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fj5VZIciGB7eNKDT"
Content-Disposition: inline
In-Reply-To: <877dio3vg5.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Fj5VZIciGB7eNKDT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-21 at 00:35:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Jun 20 2021, Roland Hieber wrote:
>=20
> > Currently, calling 'git bisect' from a directory other than the top
> > level of a repository only comes up with an error message:
> >
> >     You need to run this command from the toplevel of the working tree.
> >
> > After a glance through the bisect code, there seems to be nothing that
> > relies on the current working directory, and a few hours of bisect usage
> > also didn't turn up any problems. Set the appropriate flag for
> > git-sh-setup to remove the error message.
> >
> > Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> > ---
> >  git-bisect.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 6a7afaea8da0..20ba0ee7c18a 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -32,6 +32,7 @@ git bisect run <cmd>...
> >  Please use "git help bisect" to get the full man page.'
> > =20
> >  OPTIONS_SPEC=3D
> > +SUBDIRECTORY_OK=3D1
> >  . git-sh-setup
> > =20
> >  _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>=20
> How does this affect out-of-tree scripts that will be run with "git
> bisect run", is the cwd set to the root as they now might expect git to
> check, or whatever subdirectory you ran the "run" from?

I'm also interested in this, specifically as a patch to the
documentation and a corresponding test (and a commit message
justification), since folks will rely on whatever behavior we implement
and we won't want to break it.

We'd probably also want to add a test at least that the user can invoke
git bisect outside of the root of the repository, and maybe that it
performs correct results for at least one or two known cases when
invoked outside of the root.  And I'm also wondering if maybe there are
other cases that deserve a test along with this change.

As for the idea itself, I think it's a good one assuming everything
continues to work.  It will certainly be more convenient for a lot of
people.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Fj5VZIciGB7eNKDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYM/ypwAKCRB8DEliiIei
gVEdAP92rHoiVWMWWdVmVXCkO/uo4J1OGfzHA2zFGGl7xQgyBwEAh6lkpFtez+VM
7PUEQL0G4tvQhubnKarJTUzu7JT18Qc=
=5bET
-----END PGP SIGNATURE-----

--Fj5VZIciGB7eNKDT--
