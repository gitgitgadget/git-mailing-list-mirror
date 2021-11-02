Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAEBC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD53E60EB8
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKBQuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:50:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:60999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhKBQuP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635871660;
        bh=88nwHN9ZdQ0d0lfNOojqwlU9sih2QY4NkwdzGPuS73c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g2OEZFxmdaDoSjQmsx7107D73zaiXhbAJug5IOQSZlC1mvceG+lq7lC8s8mjcxT2I
         CJ3K9X8aQEhSlkLig3gbU/hte1kspvC/km8FrXQi4xKenN2VkqH6vaFhtZvEUx7fzO
         Y68hHIi2PGYvUDX8mzsn8M55vQeQ9QqJPwoCBQv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1mdrfO3vH9-014z1H; Tue, 02
 Nov 2021 17:12:34 +0100
Date:   Tue, 2 Nov 2021 17:12:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: disallow directional formatting
In-Reply-To: <YYFdu/+j8ba+hjCF@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2111021706230.56@tvgsbejvaqbjf.bet>
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com> <211102.86tugu1svc.gmgdl@evledraar.gmail.com> <YYFdu/+j8ba+hjCF@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2048999746-1635869553=:56"
X-Provags-ID: V03:K1:g+wSv5EuBso04s4Nhgec6m4WyWxv3aAKUcPpSQ7UoPm0vmuHHLV
 XKXAsUf57Bw/e5C0ZH7uvKv5Lc1UT945JAnBRRt2jAqxKzViIquVazaesGMyVTxT733RDBQ
 hQOe2QSJyXqGVRy6v1pWmAivIJke/PlwwVMaALqpT1YIAksZmJ26jrOdQsxKOruKv143Cxx
 hWgsU/43v0r3dusFis3bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iKtsp4XrNro=:lhwv7bBQ+AHlzMmo8BwUNi
 ZL2efxuQA3lKuRIH8OfABea8Jta1B4u2LyoOom7wR9+vWDQXTODkmStcs2DTxV90iC2YDzXIx
 uOFqu871OOMUD0JW6gjKnmLh3XZ/6oG1kYnl5Y1VYxk3U3BHyQi6UkFcH8ehESSGCiHqO1M92
 iDsrOL6K4EEpTbxVTrEP64HhVECl+V64ifbRZBcp+P62nOV3G8Z1TVEcB7pWXRZSeea0UHnpY
 7E8GMtWUsWxPQjnL7kq7kZ4hRYS0XBIdk2qUPfrXGB26vcZRqxlSfQR4K5LJjoJnvAjgm7l7G
 zvyHxhqIMbAC9tQlV0GMWTZu1rcsaRQNNQZ6w/Krbsz4q+enW3oDc8kcsdiTMXtF1z+MX6LqB
 ojohlO2u2BBMG/xjqltX18xsTuG5UtuYq7fTPqMhJ4+vk3iXgUxD1CbwXl9T8ObfGhvtZhX9K
 vlksBXBFD/fkgICTyeasT6v6jp38zmfIGmK7+oyBRRMuKoM9i9E56DDC7AwkiMJRBU2aP3tUZ
 wiHOzPjK2A26dIFNSaEbo3GMue+/XZYi7TR/ZSMel76ZF8oJNXAm/rG4NJmyOOrJAHIMyh5hV
 LpGV1gFYqJTozP8fq2v6J53ng7bmn2zx1gdzruCFdzimnytXVmefXfy7BTpOtUzsmfoWUcZmy
 9r/Fi3nbiiSmWIb/oHT1bw/fFI4n5sLp4ZD7CRayewlIyfF/Ujbuk9uaZJbNC1DqVjDzKZrVG
 GDuwaKpStPs3Ka2ampDSYBQrhvfj5iZDoG7Mg0dhlkYBqIp03gWJlYrWLsepJ67QV2RrsVHF3
 gWrf6JN5nVT9R4U+dN/QBDOGoR49qC5tNjnu49JsTeMg7zIk6ek1E2sUIKq2LM5pHf3bm8zxP
 f1vw/6mEny2p+FJH8QjYectXiey/hLF3265kTzzs9FN0HoHmLMGxmLuc6GqXLrw3wr/vetp0q
 V4wQFsZcg54DnGy4i2GLbs2XykeYv99IH0zXLZIz6O3xKm6P0QutaUYULTSICVR1iOT7zcsq6
 UZRsZkXsqu68NopfyaSOknQRUOvdANLO4xnLtaQgC0QYx/YlNWmHNsr90j2h58SlBUPFw9ZsI
 Qq3W15eTZRN8Ok=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2048999746-1635869553=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Taylor,

On Tue, 2 Nov 2021, Taylor Blau wrote:

> On Tue, Nov 02, 2021 at 04:01:57PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
> > There's a parallel discussion about doing something to detect this in
> > "git am", which for the git project seems like a better place to put
> > this.
>
> I don't think that one impacts the other necessarily. Having `git am`
> guard against this would probably be sufficient to protect Junio
> accidentally apply something containing directional formatting to his
> tree unknowingly.
>
> But the idea that we rely on the import mechanism to protect against
> this doesn't sit well with me. Ultimately, we should be relying on a
> static check like below to ensure that directional formatting hasn't
> entered the tree by any mechanism (not just 'git am').

Yep, the `git am` change and the CI change are addressing two very
different concerns.

> > > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > > index 6ed6a9e8076..7b4b4df03c3 100644
> > > --- a/.github/workflows/main.yml
> > > +++ b/.github/workflows/main.yml
> > > @@ -289,6 +289,13 @@ jobs:
> > >      - uses: actions/checkout@v2
> > >      - run: ci/install-dependencies.sh
> > >      - run: ci/run-static-analysis.sh
> > > +    - name: disallow Unicode directional formatting
> > > +      run: |
> > > +        # Use UTF-8-aware `printf` to feed a byte pattern to non-UT=
F-8-aware `git grep`
> > > +        # (Ubuntu's `git grep` is compiled without support for libp=
cre, otherwise we
> > > +        # could use `git grep -P` with the `\u` syntax).
> > > +        ! LANG=3DC git grep -Il "$(LANG=3DC.UTF-8 printf \
> > > +          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\=
|\u2067\\|\u2068\\|\u2069\\)')"
> > >    sparse:
> > >      needs: ci-config
> > >      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> > >
> > > base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
> >
> > It would be easier to maintain this if were added to
> > ci/run-static-analysis.sh instead, where we have some similar tests, a=
nd
> > if it lives there we could do away with the double-escaping, then it c=
an
> > also be run manually.
> >
> > Also, can't we just pipe "git ls-files -z" into "perl -0ne" here and u=
se
> > its unconditional support for e.g. unicode properties in regexes.
>
> I agree that the double-escaping is ugly. I think that this would be
> easier to maintain if it lived in ci/run-static-analysis.sh or its own
> script like ci/check-directional-formatting.sh.

That's a good idea, I will put it into its own script in ci/.

> And yes, constructing a byte pattern is a little odd as well, but I
> think that it's the best you can do if you're limited to running 'git
> grep' without libpcre. I wondered if we could depend on perl being
> around during CI, but as far as I know we can since install Perl modules
> in ci/install-dependencies.sh and use Perl extensively through the test
> suite.

Perl alone won't fix anything. A crucial part of the `git grep` invocation
is the `-I` option: ignore binary files.

Ciao,
Dscho

--8323328-2048999746-1635869553=:56--
