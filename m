Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EFC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419072311B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIRVeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:34:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgIRVd7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Sep 2020 17:33:59 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 17:33:58 EDT
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EC5EF60489;
        Fri, 18 Sep 2020 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600464374;
        bh=gADSpVPMfruXpqe8sVPUyttT86gpXxFYdS/oMQqJ504=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rF4iRdT/poInbIZDkG2Zy/QB9q5dI6BVpwj1mr48JrRG0NMyV0+D8fJQfMPK3Gr+z
         ILZMbf9XqKLRYgVDqLy02CeIVKDzVzjQ1Ueo8MdSIrr9PZjouxmpIf4MHaTDKpSJa9
         83IQaqJbeXZb+4RwJKmy92T7+pGDm3g+/sKM0OwX/uSimD6/ffeHerjNVYutxv5Cgb
         Voci/KOJkNJJ6qXSUB4fO2gn9JSFx0l3YVYVs0W1KBCpIoAolWYOBF6iuDrcnvjgk8
         LXgoF1pXdWiUKJtonuZyzXXemseaQKqFYLXh7nD1P5YGQ6I09+9BOCd3DjHzM93G9m
         mfC89h/oZSDa+vYTxSJMP8MYxMU3rfpeerq5hUmAkK8Do2ch9NAnweazwB1VmXwPRZ
         fmbuYPCTwQmj0YB0ssjqEHpRifR1d0O5N4lp54EErIdb7MTypW0fMpVR0awfsk1k4w
         2RYJaXPxs9Kz/CefmsernbZw3KEn051kKN3kiC6TQQsiRtpQFpS
Date:   Fri, 18 Sep 2020 21:26:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200918212609.GC67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20200918141125.GB1602321@nand.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-18 at 14:11:25, Taylor Blau wrote:
> Hi Denton,
>=20
> On Fri, Sep 18, 2020 at 04:19:03AM -0700, Denton Liu wrote:
> > When a user needed the null OID for scripting purposes, it used to be
> > very easy: hardcode 40 zeros. However, since Git started supporting
> > SHA-256, this assumption became false which may break some scripts.
> > Allow users to fix their broken scripts by providing users with a
> > hash-agnostic method of obtaining the null OID.
>=20
> I have not been very involved in the hash transition, so please take my
> comments with a grain of salt (and if they are misplaced, feel free to
> ignore them).
>=20
> This '--null-oid' thing makes me wonder exactly what it does. Yours
> gives a type-less object back, but what about scripts that want the OID
> of the empty blob or tree?
>=20
> Would having something like '--null-oid[=3D<type>]' be useful for them? On
> the one hand, it seems like a thing that would be useful, but on the
> other, those aren't *the* null OID when 'type' is 'blob' or 'tree'. A
> more appropriate name in that case might be '--empty-oid=3Dtree'.
>=20
> So, that's an argument that '--null-oid' and '--empty-oid[=3D<type>]'
> should be two distinct things. I think I like that best. Do you have any
> thoughts about it?

So I definitely want to distinguish between the null (all-zeros) OID and
the OID of an empty object, and I think using "null" and "empty" are
fine.

What I typically do when I write shell scripts, and which may obviate
the need for this patch is turn this:

  [ "$oid" =3D 0000000000000000000000000000000000000000 ]

into this:

  echo "$oid" | grep -qsE '^0+$'

This is slightly less efficient, but it's also backwards compatible
with older Git version assuming you have a POSIX grep.

If you still want this option, then that's fine, but please make
--null-oid take the same arguments as --show-object-format (and default
to the same value).  Git will soon learn about writing SHA-1 while
storing in SHA-256, and it makes everyone's life better if we can plan
for the future by making it understand these options now.

I'm not sure we need an empty tree and empty blob object, because it's
pretty easy to write these:

  git hash-object -t tree /dev/null
  git hash-object -t blob /dev/null

That's what I've done in some of the transition code at least.
--=20
brian m. carlson: Houston, Texas, US

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2Ul8QAKCRB8DEliiIei
gUE1AP9JOq/u9LolYbVey+zRVolufzVbg4zq8XIo88wEhsSyCAEAyXrdlKryQRnZ
rvIup4Rpca8y1qSeGSUwaQ8O/9jpXgs=
=OesF
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
