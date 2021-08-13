Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_DEOBFU_INSTR autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94F6C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE6F60234
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhHMG6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 02:58:25 -0400
Received: from wes1-so2.wedos.net ([46.28.106.45]:38137 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbhHMG6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 02:58:24 -0400
Received: from kuhadatko-gl552vw.localnet (stip-static-98.213-81-183.telecom.sk [213.81.183.98])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 4GmDsJ6lhxz70P;
        Fri, 13 Aug 2021 08:57:56 +0200 (CEST)
From:   =?utf-8?B?RHXFoWFuIMSMZXJ2ZW5rYQ==?= | ACRIOS 
        <cervenka@acrios.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Git merge improvement - "remove spaces/tabs from beginning of line and end of line"
Date:   Fri, 13 Aug 2021 08:57:56 +0200
Message-ID: <2184244.VR8AQ8LyVX@kuhadatko-gl552vw>
Organization: ACRIOS
In-Reply-To: <YRRZdmlfBjJTUimj@coredump.intra.peff.net>
References: <2632907.cDO7J6XS3R@kuhadatko-gl552vw> <YRRZdmlfBjJTUimj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5995028.89SDKktxoc"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart5995028.89SDKktxoc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: =?utf-8?B?RHXFoWFuIMSMZXJ2ZW5rYQ==?= | ACRIOS <cervenka@acrios.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Git merge improvement - "remove spaces/tabs from beginning of line and end of line"
Date: Fri, 13 Aug 2021 08:57:56 +0200
Message-ID: <2184244.VR8AQ8LyVX@kuhadatko-gl552vw>
Organization: ACRIOS
In-Reply-To: <YRRZdmlfBjJTUimj@coredump.intra.peff.net>
References: <2632907.cDO7J6XS3R@kuhadatko-gl552vw> <YRRZdmlfBjJTUimj@coredump.intra.peff.net>

Hi, Thank you for your respond. Actually in my case we have code formatted=
=20
before pushing, so we shouldn't have issues with trailing spaces (i mention=
ed=20
them as i they are doing some noise in comparison too). The issue is more=20
about spaces on beginning of line. Changing indention of code may result in=
=20
prepending code if some line with old indention match some line with indent=
ed=20
block of code.


On =C5=A1tvrtok 12. augusta 2021 1:12:54 CEST Jeff King wrote:
> On Wed, Aug 11, 2021 at 12:25:10AM +0200, Du=C5=A1an =C4=8Cervenka | ACRI=
OS wrote:
> > Several times it happened that i added or removed condition in code but=
 a
> > lot of code stayed. Only indention was changed. If there was also other
> > change on some line i had a conflict. And several times it happened that
> > a lot of code was appended instead of replaced (if some line was similar
> > with same indention). This made merging messed and confusing. If we wou=
ld
> > remove this spaces noise from beginning and end, we could get more
> > acquired merge. What do you think? Of course this is only for looking f=
or
> > most matching lines. At the end the code should keep all necessary
> > spaces.
>=20
> Have you looked at the whitespace options you can pass to the
> merge-recursive strategy?  E.g.:
>=20
>   git merge -Xignore-space-at-eol some-branch
>=20
> It may not do quite what you want, though (it sounds like you are more
> interested in matching context with whitespace changes than ignoring
> spaces on modified lines).
>=20
> -Peff


=2D-=20

=20

Du=C5=A1an =C4=8Cervenka | Software Developer=20
a: ACRIOS Systems s.r.o. | Razinova 2257/5 | Ostrava 700 30=20
e: cervenka@acrios.com | w: www.acrios.com=20
m: +421 918 715 117=20


--nextPart5995028.89SDKktxoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE+N59X/uQmQonbTmvX9i+KMGf63gFAmEWF/QACgkQX9i+KMGf
63jnkggAkGBQqlo9WIEscS9KXuIoUoZy9o4vAIh0FymJuBw9RGVo+t6yhetvwf5I
vqWexcpmeNnjRqTHPxQxL4v+V2hRp5r/IDBGNMg6/3nUXYmPTOF46kgatzWwmbh0
qmPiIUdgv+94pHmsO7NDOt5RyAZuFRCnyVIfWKvFNHTvflF0aUgxvUxK4p/sXvAG
JEa6Y2ednuY5d9TsWoVvrhfvHnZVPf+iTW2A9hJBggwQOfdXkFstodwk2MRmYmr+
Y6ncmf1wcazcbsTxaPS7DvnwnuiW8R35jHgUWlYlKoXbMMzUE0eRm3F+qkrneVcH
Vnj6yhxvlRl/f2dUZAAi49YXda9KAA==
=2Tyf
-----END PGP SIGNATURE-----

--nextPart5995028.89SDKktxoc--



