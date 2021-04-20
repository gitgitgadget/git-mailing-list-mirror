Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B4C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1FE61408
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhDTWqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:46:05 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBDC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 15:45:33 -0700 (PDT)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id B4620335D19
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 22:45:32 +0000 (UTC)
Received: (qmail 10296 invoked by uid 10000); 20 Apr 2021 22:45:32 -0000
Date:   Tue, 20 Apr 2021 22:45:32 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Document how we do embargoed releases - improving
 mail template
Message-ID: <robbat2-20210420T223619-939869983Z@orbis-terrarum.net>
Reply-To: git@vger.kernel.org
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
 <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
 <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
 <robbat2-20210420T193302-520335089Z@orbis-terrarum.net>
 <xmqq5z0g4oc9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DH7EmFk1tbGiwgm+"
Content-Disposition: inline
In-Reply-To: <xmqq5z0g4oc9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DH7EmFk1tbGiwgm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 02:51:02PM -0700, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > As one of the Gentoo maintainer for Git, I was wondering if the
> > embargoed-releases process could be tweaked slightly.
> >
> > Specifically, in the embargo email, could you please publishing the
> > exact size & digests of the to-be-released tarballs, esp. the htmldocs &
> > manpages tarballs.
>=20
> HTMLdocs and Manpages are as far as I am concerned part of SOURCES.
>=20
> They are generated from the true sources, I do not give signed tags
> to them, and as a source-based distribution, Gentoo shouldn't
> consider them as such, either.  When release tags are signed, their
> sizes or digests are simply unavailable, since they have not even
> been generated yet (I tag the releases, run make in the tagged
> release tarball extract and that is what is tarred up as HTMLdocs
> and or Manpages).
I didn't say that those tarballs were tagged independently, as your mail
seems to imply.

As part of the embargo process, you're sending the tags out already.
All 3 tarballs are artifacts derived from those tags, directly or
indirectly, and you presumably have the same process to generate the
final tarballs if the tags are embargoed or not. I'm just asking that
the final tarballs are generated when the tags are, and the sizes &
digests of the tarballs are shared in the embargo email.

Alternatively, publish byte-exact reproduction steps from the tags to
the tarballs, so that we can generate them locally for co-ordinated
release.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--DH7EmFk1tbGiwgm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmB/WYpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQ/fBAAoQV8688bTStEjInuxXAi54naXSPnuA5sGFgtdd4P85EtQXGfUC0YnOGq
+vynsrDItWIR16RyOrTpCN2QaC0b7be2jPaAkeJV2A94gGyVWunfUUqa8+p7CNrt
ycX8E6XUXwTSxBCC4bmbYts64VR/32ppFpOMKy2FRG3M8QdvDvemVCYZtRTnX+VL
k1Fg4jEb88VW+MdE8U8Uzwy2z8xcTBB1o6IN9x6vgbDbFAeeBhHM3R9sQRItBCj3
HkvmLO1qoritq/DUO4fe6Zhxo5TzY1k2auv5Vt5WUunaB9xUAC4Z2yhEQmULv5if
nzjppRYkC/6qFj1zFCEsOfq25oUV3+3ALdqkH+UVUE8MllcUHEiGnu/4vlJ8VZJf
5a+lUtoNMHrsvvo+nmSTW1kSkV1n0qFYNkmPgCtIbpHkrgvENTqP+gUdks0WVGsg
7x9/eiGagby51Ht5jk+HXlp9AIIuLn892zOfC5of8g/jynIKduGRmyJK/lww+DdY
bYs5BJzo0/tZYM4EMOuttrxwPcghpM0PaPMbQIz3Hh9ZR3G3G4fkSCbwcPrFYun8
pmPCkKL6l5bcjsqWpJUrGE4Pi2fJZav3EceEY//Q6gPlI3nztHqfWKoBRKQv+k5J
FVJp134meLcHB7mIboSBQtm/DvDlutMvweHnPCtL4U4R7K5Cmkg=
=tFT/
-----END PGP SIGNATURE-----

--DH7EmFk1tbGiwgm+--
