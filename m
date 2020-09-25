Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72968C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A3A2084C
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c7sln7jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgIYJJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:09:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:42219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYJJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 05:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601024976;
        bh=j8h63gLjdWXueORHKDSnbF/NoytPEFdLindlvk59mYs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c7sln7jnhSfhl25Cr6ljvnOv9bPi6jE0saUtJqSgi6jP2+c8TGVBlKDPBKMCxDAtx
         TYRjbekrQ7783GMtY7gDs6/M/O2Ag6xi9E4esjY/go0r4eg+j4bMQhfFo9EYbe4/JS
         cTiAph8jsV41XoM0RrHeciNrc5ObAvEjsM+5VEbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.158]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1jupCI2nVm-00SBJR; Fri, 25
 Sep 2020 11:09:36 +0200
Date:   Fri, 25 Sep 2020 07:02:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <20200924103437.GA18952@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2009250650280.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet> <xmqqft7fnlxr.fsf@gitster.c.googlers.com> <20200918155015.GA1837@danh.dev>
 <xmqq7dsrnjhi.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet> <xmqqr1qsjxgb.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet> <20200924103437.GA18952@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1368141848-1601010132=:5061"
X-Provags-ID: V03:K1:s8AjpzVCG87J8wxBeBlTYriAFpLPXTeMDUBkNNW+/pF3JA9ktXD
 xBnIjA30ue7vHgOKg7fQ26FO2yDaEwOBDKHfRojJCWAK9FRziDLAy13xc49+4sFMIbYnIo4
 BYnevsFmv1dAE3C6QX6SEoucNNcnA+SCF6TO7zca+ZgJPA6k5gNdZoDBe09GQ88IDitUobI
 xCC23j2e6ZGF56WdD6HMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1WUdYx31Xfk=:k5zFcoV1obbh1FpbyMviYx
 2RJh/nWf3od68/rCxym2c16hj7E3lOuqHKIhfG/yUtnZd6iaXmxH2Gzn8RIg3r1gbOlcOBjLK
 oEIOs3Md4i4iwhAVGPz7MQvYrCLmaCU1tp/LKtEO7lmj0ijlKWEqsffSImETkfdTGpCR3wGEx
 mkmPqt7XfxQKoCsEXbGcRqEcePtUyRQ/4P/WXf1880Bb3Gj5hY+6F98H3mjJrkoot+2nm6mBl
 SVwA7hK8+ntX7puhQIPJjzoDntxKycikUxBESEjq6WKW3zJau9uRKotcNbKtvM8RkD0+jdu0A
 QjWtVA5nbiHpWD5mRV6CjWIqxWuQPD4X/RlFs75OYRiIRDHxWDg9/PFWX3AVmpAysiyC+0CSJ
 BJF9CzoshgxcYMBgi94kOQEdjzw61tjnXjCp7enLlTi5rVmZ8bfwykFIxjyQa0xG46VZkYUIB
 EcmRGovL8+aJiVpbyxDwk1iQ7ztb70BucHGfl7Jn2E9wpkgQmYlkscdthFGmbmvapFDO5a+aM
 aw0W5d40OcchMRh6Vfw6L4dbxXq/RnBVASVH/PC9wKl83WU11Ym7Wo3ieSrjADRVHZm2ip2/J
 NBK6gawXiuVI4KsFfrUdkcT+ZjRrAM/f/94L+Yh0zOph3Ht1MaoU275Z+S1x97OlIZCvw67VZ
 LPQBa/+plC/JYplC+9ZynFpsVqGK1J+DixUo/cmzlJb7hsoS39ygaqYOdo/vtcVlOfsjnbCdf
 l3sh/27aFvMJ+sYRGKgsDZY52cye5Z928BDomrERd4aajALvBmR+hu8rKdiCiBxsGXpzDHaYL
 ghy419sqdXcgnXGa4Q2Tq8F1VcxBsRf/TY4SP3WRuj/aqc649vdgzqg29Lk+AmxRDhfvUvNEn
 BOZzi3F+hDipUIiDPZXsmY1AACvJxpYc3eiW186WcOwiEpgFgGiTeR1yUy3U6zZL+RJPStyQT
 G3lK8xvAxPp9bRr5+ZND845yctWLd9eRLanB/K7wc5ehAUetqit/SEw4GSQ/o4qzUBGAOD+Sc
 VJlG+EbBbvSMdqiFSoemoIEDoVoH7bmXxJTLB1BN8LGdxVQ3xp87rNi9M/IphTSUODst99tof
 g8YkqofRj1f32Mo9zTaw6yAnMZCPfbGkbwSi4swzZ2wafJy4fytMcj7WNDJ1s6dQVlL4WC4P3
 Sxihy7xKTDdYheYatXp5Qv+w+xbW71bxVfvc+BF8QojLJmjUM8phXzEZI5P4WIS2lRs88mmmj
 AFkeMQvAgVW3/s4t815/u/qJpWntuGrsA3WQiWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1368141848-1601010132=:5061
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Thu, 24 Sep 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-09-23 22:27:17+0200, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
> > > ... the above sounds like the argument concentrates too much on
> > > where the build directory is (i.e. between "in place" and "a
> > > throw-away directory next door"), which sounds like much smaller
> > > point compared to the other things that needs to be improved in the
> > > VS users.  And making a choice against what is recommended as best
> > > practice...?  I dunno.
> >
> > All I want is for the CMake support to be easier to use, yet we go in =
the
> > opposite direction: instead of allowing to use CMake under more
> > circumstances (which actually *works*, we just don't have the appropri=
ate
> > patterns in our `.gitignore` yet to avoid adding and committing the
> > generated files), we now seem to intend to require a separate build
> > directory.
>
> I've left Windows development land for a long time.
> So, please take below discussion with grain of salt.
>
> When I was there, CMake Users on Windows mostly used CMake-GUI to
> generate build system for CMake since running CMake as CLI in Windows
> takes too much hassle.
>
> When I was there, CMake-GUI shows the option to choose build directories
> explicitly, and whenever the source directories changed, the build
> directories also changed, with some [-/]build added into sourcedir [1]

In my tests, the build directory was left empty. When I clicked the button
next to it, it defaulted to the same directory as `CMakeLists.txt`:
`contrib/buildsystems/`.

I might be holding this thing wrong, but if I don't, then we would
actually have to add a _different_ set of patterns to `.gitignore`.

> I heard that nowaday, CMake is supported natively with MSVC, I don't
> know what is the default option when using CMake with MSVC, but from
> the history of MSVC always supports building out of tree, and
> information for Microsoft Docs [2]:
>
> 	Click the Show All Files button at the top of Solution
> 	Explorer to see all the CMake-generated output in the
> 	out/build/<config> folders.

Oh wow, I missed this. And it looks promising: when I open a fresh
checkout of current git/git's `master` branch in a freshly updated Visual
Studio 2019, it finds the CMakeLists.txt file automatically.

But that's where the happy news end: it stops with the error message:

CMake Error at [...]\contrib\buildsystems\CMakeLists.txt:46 (message):
  sh: shell interpreter was not found in your path, please install one.On
  Windows, you can get it as part of 'Git for Windows' install at
  https://gitforwindows.org/	git
[...]\contrib\buildsystems\CMakeLists.txt	46

So there's a bit of work left to do for me.

> I think the default UX with CMake on Windows is building project out
> of tree.

Indeed, it _does_ create `contrib/buildsystems/out/` and starts outputting
files to `contrib/buildsystems/out/build/x64-Debug (default)/`.

Seeing as using Visual Studio's built-in CMake support is much more
convenient to use than a separate CMake installation, I reconsidered my
original idea, and now think that y'all are right, my current patch isn't
the best way forward. I'll rework the patch into a proper patch series
that takes into account what I learned today.

> > That's the opposite direction of making things more convenient for Vis=
ual
> > Studio users.
>
> So, I don't think we would provide them more convenient with this change=
.

Indeed. And more convenience is what I want, I don't want developers on
Windows to struggle with the tooling when all they want to do is to
contribute to Git.

Thank you,
Dscho

>
>
> 1: https://cmake.org/runningcmake/
> 2: https://docs.microsoft.com/en-us/cpp/build/cmake-projects-in-visual-s=
tudio?view=3Dvs-2019
>
> --
> Danh
>

--8323328-1368141848-1601010132=:5061--
