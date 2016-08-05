Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8E72018E
	for <e@80x24.org>; Fri,  5 Aug 2016 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948824AbcHETTn (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 15:19:43 -0400
Received: from smx-7fb.smtp.startmail.com ([37.153.204.247]:43821 "EHLO
	smx-7fb.smtp.startmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1948590AbcHETTk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 15:19:40 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Aug 2016 15:19:40 EDT
Received: from smx-8a9.int1.startmail.com (smx-8a9.int1.startmail.com [10.1.137.139])
	by smx-7fb.smtp.startmail.com (Postfix) with ESMTPS id BC67AB7A78
	for <git@vger.kernel.org>; Fri,  5 Aug 2016 21:11:03 +0200 (CEST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=dkim; t=1470424263;
	bh=qsYobabSEBb4tSZYZXlX1OMSjDJxhbq7ptNSFD14NuE=;
	h=To:From:Subject:Date:From;
	b=XChOPvRULsGXLF/+ulmskXavsCO0esUxE1BXwBhS/0OXc5ejanJHqLv0OjkN8n0+T
	 43cEf/XuD8dGLjqHHe4gB3oP/SEILq8B852YEwDtkKbK1mA5/3tHWllpDTuTIYoI4p
	 JKWKicJSavpXxGyiOYXJgevd/brmFv7tmFYiJhj7MHaM88zYQ2HsoFfj7z1MHRXAaz
	 6KOxUHtRdvTpV66TmfAkLqbmT/ihofXgK8DJTdMsRI9AeqCNQlrYgBfrGWG/axhUXs
	 27pvpCnsj4JnKpXqrGrYM2MXTB6Q40S5jtjTmECYJwrOGzSRaAAt1ukvRHQA10Upqh
	 l3OUNGqTaJd7Q==
To:	git@vger.kernel.org
From:	OmegaPhil <OmegaPhil@startmail.com>
Subject: git fatal error on fetching
Message-ID: <3c9671f0-782f-c5cb-08ce-a0f428994fb4@startmail.com>
Date:	Fri, 5 Aug 2016 20:10:57 +0100
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x077QXtMGhkdF78OC6MjgdlJat8sER19c"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x077QXtMGhkdF78OC6MjgdlJat8sER19c
Content-Type: multipart/mixed; boundary="mTXtmEV40lNiWLOTiHKmEIPVmsSdadQVE"
From: OmegaPhil <OmegaPhil@startmail.com>
To: git@vger.kernel.org
Message-ID: <3c9671f0-782f-c5cb-08ce-a0f428994fb4@startmail.com>
Subject: git fatal error on fetching

--mTXtmEV40lNiWLOTiHKmEIPVmsSdadQVE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Debian Testing with v4.5.5-1 kernel, git v2.8.1.

I seem to have a broken git setup somehow on this machine - I'm
currently testing the ability to fetch PRs from Github following [0],
e.g. testing with a PR on dattobd[1]:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

git clone https://github.com/datto/dattobd.git
cd dattobd
git fetch origin pull/41/head:pull_41
git checkout pull_41

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This works fine in a VM, but on my main machine, the fetch fails:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

fatal: failed to read object 0000000000000000000000000000000000000000:
Bad file descriptor

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I moved my local config out of the way ('~/.gitconfig'), but nothing
changed. Any ideas for how to debug this?

Thanks for any help.


0: https://gist.github.com/piscisaureus/3342247#gistcomment-1625076
1: https://github.com/datto/dattobd/pull/41


--mTXtmEV40lNiWLOTiHKmEIPVmsSdadQVE--

--x077QXtMGhkdF78OC6MjgdlJat8sER19c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXpOTBAAoJEBfSPH39wvOP/XsP/3ZA6k17vSlzKmPP2oIcWmFx
FsMcq4lsHsCaTP8i8ssK/OY9vjAQhLLRr/z2SG/m/kIUaU6SgE291MsxUmUMgxcG
4mkdFXDkpYndax571yQdf0dlBft8xAB9c1fuVj/GNj9/a5ooQwyex4PhEFXqlB2Z
ohMDtOV9NfULxrlu5TV92YdCAW9jTf//TnVK3ziOz8S/fDUf2BonHMU6U1hnMc88
oqMw5l9FgqoFapAtnJujdGqM1Qc2353h9WPceT1Jp6++srImL2SI+R14f8/hkL43
ujOySVpb+Jymb8+wHH37TU7yIprwwNBm6zAofwtN26kWY5KYmTzb/3SHEbECOF54
Cp67QZC8sIkwTVDkxjT7TYEfnVgb9qsYJUo3mBRRbyohXY8XrkjG2+LA0QJEo+vo
C4O2Bo35gZq/APN/171XtVq2Of66ofrdJ1Dya9RHBHYGdZCbzU2KkxBRGRuykqJ5
tT9FJxeKt34h8E0rEOL4WwYQcIzDG3rqeK93+JuqHTl7SC2lXOasBqz+/0yzYXpR
UwOA4ZGYs4UM/Iq2USnOV41q36I19e9hbE0V1cm+Ml4e17VejNpyGyFPCQ04nOOU
mb24DsynpJbGgblQyYuVIGWpgJeQ3Wtubg580qPJWN5gHpt1eiKJ3EV2whF2K9Dr
ayHBiUbaQ2MssgXyFjZY
=6H8v
-----END PGP SIGNATURE-----

--x077QXtMGhkdF78OC6MjgdlJat8sER19c--
