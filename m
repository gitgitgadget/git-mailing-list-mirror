Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F48C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 19:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCTTUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjCTTUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 15:20:04 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1996029169
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679339532; i=tboegi@web.de;
        bh=3Jw9wujMQeZj2xb6BtyM908qLDuyYALGlzsdsLwz2XU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UJiXcZcrLpR+pgG9GHVrmScubjbNQ2Qi9DnEi8nslLFmaHjRyeJf3MjS87+3hpmUu
         SvhK/MeOn0blAdUehWOw8MqZfv/4LrGz7FwmilCWbsqSvBeHr+G1GOvyAwof6s5N+u
         Rfe8mepws+J7Mzw1YTE/DHLMq/SbwE56sIeFvpOEMceAM0Lgsa3SkECCMI2M4JIyQY
         LFyJsfhlMm1O8ba++pDb435l+YWiCKgvv1hHSPZs1JBekvrZc1NHuA48p/aL3mYtqG
         DXYObww+jpKz+R5ySnE6inM4yxdh6N/CpsFg/EQQWaq/jCs359cSv85N7/puF/hLdo
         2RMMbulVNzEww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1pm0yF470m-00C9qO; Mon, 20
 Mar 2023 20:12:12 +0100
Date:   Mon, 20 Mar 2023 20:12:11 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     dooagain <dooagain@protonmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git pull output and case sensitivity.
Message-ID: <20230320191210.jzzq5c2ssxcltvoc@tb-raspi4>
References: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com>
 <20230319062239.w37x64knfhfapbsn@tb-raspi4>
 <20230320171602.GB2615782@coredump.intra.peff.net>
 <_XGWc87b9HPBCDZ95pSmwNOFcZO21Y6bVyNnhhNuowPcM2Fhs5HmCynAqq2nME257bMhQ4w7Qta1dICTCHTlxbQ2NHN_iPYO0NkBYmS9vTI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <_XGWc87b9HPBCDZ95pSmwNOFcZO21Y6bVyNnhhNuowPcM2Fhs5HmCynAqq2nME257bMhQ4w7Qta1dICTCHTlxbQ2NHN_iPYO0NkBYmS9vTI=@protonmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:vWdxvkdxKsLxLkweWDXBjATnZRj+S4YnWHyXR3hUxO+M+i6/lb0
 ZjUDClGp1+rfKYBa3PzbFgQYW5QL7rYVGcWK7ukkVnFv8b3SDJ+f+MtL2Mn/qE/mvAWthWd
 mH6OX1ZfmdNcb2Aj2H0SIdqkqCVlsFn9BVMdvLz1C3FTVicIwUSB/gqUWHD0UmP63c5qmNR
 enhtn/9fECAZN0YXaJpiQ==
UI-OutboundReport: notjunk:1;M01:P0:naF/ar19+Uk=;BhkSKOD1LNUKQm3eJsH3ZNiWzwo
 utY/e+QtXxe1MzQhNohwpTkcpD6C8jUfKKo5lBsV5OyfLoAotfW+uopDn1IFx9BwyZbg9Xxpf
 2j/gnywHgdZOIGgUnLZDF6gnSgExu2ycgqqTxXqNPvkcEv5/p8nE4PAEd0oA3FABjKewEsYIH
 XzSJSDaNegho5rKbFsxVmYQJYTC2bHnZVm2EQX1VNVAYzBMO0SYv6FvZU+lfCmZAmG+xyRr1d
 04dHrbeDYqvVytfkc+TFWwBGsMHvZ3s3E+rJTsYLTK/w7JCm84jusucYkeRAVtwbR2BTQ0fvc
 y2bjlRag9Layyq91GJVd4/IgqIuJLlOCZz5ULsm9lq613vbAZAlUIQyOooiULGjJVu9/D31FQ
 W4fqaGyJuqz3Qk8vj7z9QmESRxEmk/aJOtlA3BtclNhZQCOaUGIannbweB3x3o1SyGICB2lTL
 YY197KxF19EV/ULY4Xr/HurdhS8td1ozjQ9ztEjUNCQZobxSt1sEfLjBndW9AFomeuDVfGHet
 JadOdb3P6H3lR1052IxcSWyp7WPgiGWudK54y/kwrsXwYKNllIG99Bbfegavet3CtT+hyG5Mg
 BJoGsMIwFhtKXLfo4jiB6MlJb5Nk7tUOgCg4/KYis4bkugK8Jkl0vjm9bkv70iUpnXQHxAQ2F
 ewXOUsnM/GAIjUVNu2ufyvBDTeyw/w1TYcp/Zro72l7jEfRJ5ZTzpDn5P9gZ7zxEd1Tvx7rol
 ue7vDrH2J0U/9PHqd+AW5K06RHd/LVgnDYxI0XJgdLlT2NTvqzV4FtVeE3kHgxJb1gQzrl9wx
 oxZwIS9727R38d1VIKrR0rPjl3s7l3Kr8GyN0UOsZ0Z/lmGUVgggyjSQUD8ps/l1iFVPsogqh
 OygtzO/zZC125PlyYAwMq0NU0wQHRuRmOuupw/ihuNk2QSaKEsuquoWn10YSOD6JQ8SD6TFFc
 UXOToJmEuQ3eP8nVpD2xI7/DRvE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 06:01:30PM +0000, dooagain wrote:
> I'm not sure if this is helpful, but I documented a simple way to recrea=
te the issue I am seeing in the README in the https://github.com/spencerdc=
arlson/test-casing repository.

It is helpful,  thanks.
In general, we prefer to have all informartion in emails ;-)
Anyway.

To reply on Peff's comment:

>So I think this is just a known gotcha, and the path forward is probably
>a new ref storage format that doesn't rely on storing names directly in
>the filesystem (reftable, or some system based on packed-ref slices).

Yes, it is.
The thing is, that Git at the moment is unable to handle to branches
like Foo and foo on case-insensitive file systems.
Because branch names are stored as files, and that doesn't typially work
well under Windows or MacOs.

As a workaround,
git pack-refs
can be used.

side-note 1: a better backend for refs may make it's way into Git
in the long term.

side-note 2:
I always recommend to stick to a naming convention when working in
a cross-platform project.
You can keep filenames only lowercase.
That is debatable, some people prefer camel-case rather then snake-case.
So go for either way.
But the same restriction/recommendation is valid for branch names as well,
stick to one convention and avoid possible collisions under Mac or Windows=
.

Or run `git pack-refs`, but be aware the the performance may suffer,
if you use zillions of refs.

HTH
/Torsten

>
> ------- Original Message -------
> On Monday, March 20th, 2023 at 11:16 AM, Jeff King <peff@peff.net> wrote=
:
>
>
> > On Sun, Mar 19, 2023 at 07:22:40AM +0100, Torsten B=F6gershausen wrote=
:
> >
> > > On Sat, Mar 18, 2023 at 07:21:10PM +0000, dooagain wrote:
> > >
> > > > Thank you for filling out a Git bug report!
> > > > Please answer the following questions to help us understand your i=
ssue.
> > > >
> > > > What did you do before the bug happened? (Steps to reproduce your =
issue)
> > > >
> > > > I configured my git repository to ignore case by executing `git co=
nfig core.ignorecase true` then I executed `git pull` multiple times.
> > >
> > > What do you mean by "I configured my git repository" ?
> > > The answer is already there, so let's re-rephrase it:
> > > Are you working on a case-insensitive file system ?
> > >
> > > What happens if you create a test directory, like this:
> > > mkdir test-case
> > > cd test-case
> > > git init
> > > git config --get core.ignorecase
> >
> >
> > I think this is kind of a red herring, isn't it? The bug report is abo=
ut
> > refs, and I don't think those really respect core.ignorecase either wa=
y,
> > and inconsistencies are known to happen on case-insensitive filesystem=
s
> > (because the refs are sometimes case-sensitive and sometimes not
> > depending on whether they are packed or loose in the filesystem).
> >
> > So I think this is just a known gotcha, and the path forward is probab=
ly
> > a new ref storage format that doesn't rely on storing names directly i=
n
> > the filesystem (reftable, or some system based on packed-ref slices).
> >
> > -Peff
