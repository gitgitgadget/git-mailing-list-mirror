Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564321FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdEPR7Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:59:16 -0400
Received: from kitenet.net ([66.228.36.95]:38126 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbdEPR7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:59:15 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1494957546; bh=JP6cNcPadUxUr2OzczuSIn4YzexMP0JcBxGuH8vw08w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhJFqK4/IcEeoQV85SWSOq6PlCOTpUKuuOuTHLUZN5CEDz4ShO3pVVr6ywbVuHwnQ
         CTf5nZa5oK1KzhvZvWg3m4iPHby81foenevOFoscJAWUCz0mRydFAWyAuzAxrUKDX+
         ShDdSoUHv2sRjoV/XKtunNyhkaPgwwsGe5a+KkKY=
Date:   Tue, 16 May 2017 13:59:06 -0400
From:   Joey Hess <id@joeyh.name>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: reversion in GIT_COMMON_DIR refs path
Message-ID: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
References: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
 <CACBZZX5AgdMTceBAVftNp0goHpf2-hqx8GzvJshx2n1FtCGsBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="upqiwr3wraejkqxy"
Content-Disposition: inline
In-Reply-To: <CACBZZX5AgdMTceBAVftNp0goHpf2-hqx8GzvJshx2n1FtCGsBw@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--upqiwr3wraejkqxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Tue, May 16, 2017 at 7:10 PM, Joey Hess <id@joeyh.name> wrote:
> > Bisecting this test suite failure
> > https://git-annex.branchable.com/git-annex_in_nixpkgs_fails_with_git-2.=
13.0/
> > I landed on commit f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0 to git.
>=20
> That links's broken for me. Looking at your wiki it looks like you
> mean: https://git-annex.branchable.com/bugs/git-annex_in_nixpkgs_fails_wi=
th_git-2.13.0/

Thanks for correcting that

> I have no idea what this bug is about, but side-question: It looks
> like this is git-annex's own test suite that's failing with 2.13.0, is
> that right?

Yes indeed.

> It would be very nice to have a test in git itself to test with
> git-annex. I.e. some optional test that just pulls down the latest
> git-annex release & runs its tests against the git we're building.
>=20
> Thanks for annex b.t.w., I use it a lot.

If the git devs are ok with this, I certianly would be happy if such
tests were run, at least occasionally, on the git side!

--=20
see shy jo

--upqiwr3wraejkqxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlkbPeoACgkQ2xLbD/Bf
jzhUkA/+InklIcvS3CQ/MjNFZ47wMYZHb+oTQq/1ae7qQehMpP69HvLdPGMDsjZT
oYKnYMcePwbsm0STlyPhZz7MPGOmAIViOEaG2rEMJm8BhvDu8BIFCYmy6Z/QgD15
edr0dwSvdlwiY4ZYxK0+l33EfG0qAmrN8ZePVxdtX8/QjOLR5pchcgk+CoYG1c3x
ypUCAbYvcVhad5bWv1q/hD07EJQZf7Uvybyb1CkaRJqVHpFPT2ZyNM2sPZIq2bZO
6V41CgMEdVVWVfVWDe5L8gEc44dTpVWZSeOX3QkovuZvXIo37n/BO2hBrKopKk/C
fbPvq+k5NXhqBJA9PNmxEQ4sEdGNmVw0FmCImPEJV+/B8cNdl3GbvZuNH2j++qHl
7sHjIqBGrT6okAWclCIU9ddJj2EZxrROjFghhYQAJorS9RPc7nidIcSLFIjg7nYd
lM9d+V6yjyZEgqR23XmM8cQRzg73pHSLY0j8eibSmej2W6rzTJiBbMOiTZjbWIo/
LeRrv3zm8tBTfFDKILe46Pb3ZzXf//Y9mTl+qsmSI1FVSJqVFu9v5bh+Foh4Wq75
ElmMAccao+mNOEsKTC8AJ2bqBWMt+2BGG1V8x6uvgDPpMPlkk8hpojklekaVyuNb
u6R7L3cEqJAPrCZOJ20UPV4Rd/WWamPA+BWDb6gthH/5TeSMokM=
=zED0
-----END PGP SIGNATURE-----

--upqiwr3wraejkqxy--
