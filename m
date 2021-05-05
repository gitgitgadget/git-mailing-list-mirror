Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196CC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB58613B3
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEECAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 22:00:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229694AbhEECAT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 May 2021 22:00:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 220A360459;
        Wed,  5 May 2021 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620179933;
        bh=giSMqiYl8eLQYrl5y2M7Xo10lJGUkIKtWHf02SI3wVo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pg8564gF33VnC5IIVJkYw7bkAr171i8wS0xt1VURwiwDUqtw4f+c4sa/Vxd42MJg6
         jQCkmSmuIK291ZmutCDp5b5CD2hb1/+LdlPbS2KcSH9cTRkNNHTCsRz8bK2NkBIIzO
         uQqhrDaGdXpS3gIdNHk3kLuOTki9v9KqsVFwESIW0oxnJKZId1T62hOQxzVm2exk8+
         6z68DNqeQKLsNH2iyQTEF3s3niQ6YoJ+N2A7LIk9xbWq0PvdjcZuLplwwhIsddQua5
         m/Yacn4nY6x+sGiOPxLQnIox27y7z6BFSvq/fK504W6JIaAYaaTwP7TYy9lNhtR2vV
         zLrmGnXd9uD9zf2bThfzsVGe/f9arZ6sCcBZbH8LAyYBGfkuj2dCRDgVFvr2qDvLE/
         s0yYAfPparWKLy6v8wtINd0JP7wX8HYZyak0lT5t1UfRvDyngRR3tE2uEvAdql5YHf
         FeuO6BTQ6djj2f3HsQQbWoFzJOfPeAUt+Us0busHdZXGX4+WG3t
Date:   Wed, 5 May 2021 01:58:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Message-ID: <YJH712E2kT9yJkGT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g>
 <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
 <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
 <6091e1f12ddf9_cc8208b9@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iKpOVIhxbH8slrDD"
Content-Disposition: inline
In-Reply-To: <6091e1f12ddf9_cc8208b9@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iKpOVIhxbH8slrDD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-05 at 00:08:17, Felipe Contreras wrote:
> brian m. carlson wrote:
> > On 2021-05-04 at 15:09:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > My aim here was to discover if we had any reason to think that "local"
> > > was less universally implemented than other POSIX/C89-plus features we
> > > rely on. It seems that it's not.
> >=20
> > "local" is missing in AT&T ksh.
>=20
> It's not missing, it's supported only in "functions", which have a
> different syntax in ksh:
>=20
>   function f { local x=3D"foo"; echo $x; }; f

I believe there's a bash compatibility mode that enables this, but I
don't see support for it in the version Debian ships[0], which doesn't
enable that mode:

  ksh -c 'function f { local x=3D"foo"; echo $x; }; f'
  ksh: f[1]: local: not found [No such file or directory]

It's also possible that it may be aliased to "typeset" on some systems,
in which case it may indeed work.

Regardless of the specifics, I think we can both agree that it doesn't
work in sh-style functions, so for Git's purposes, AT&T ksh does not
meet our needs in terms of support for local.

[0] I believe Debian's philosophy on this is that they ship bash, so
    programs that need bashisms can just use bash.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--iKpOVIhxbH8slrDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHQEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJH71wAKCRB8DEliiIei
gVDvAQCCYBQ2rhyeRq4AHyb3PpnCOzEiDbmAPoXcyKoap99c/gD3TPWs+FLEHfCM
JupHkPjPGDvq1GswBP20BeZdAbWUCw==
=8Ut6
-----END PGP SIGNATURE-----

--iKpOVIhxbH8slrDD--
