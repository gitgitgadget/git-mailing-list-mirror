Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512EC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBD02064C
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fNQQB/Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBSUKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:10:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:57797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582143052;
        bh=PfUqMxYAwj+gbi8JK+YuGh6gKmeaQUHAPCbUzVOoq6Y=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=fNQQB/Tn0pw3rb30BE5plAzImPrc6dzWoqqhflduvNAqElcbKdlW7iuK/17fDILEK
         xdHCeSjdkVuq48VUzV1VXhWjMhsl3+HglRZIQafpc8N92NG6kD/eWSBwzfTmrN3niR
         Wkvx0Bc1Ju46i1c+g3/BgSBLcEiI164vPvrc0RlU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1j83vH0TuJ-006LI1; Wed, 19
 Feb 2020 21:10:52 +0100
Date:   Wed, 19 Feb 2020 21:10:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.25.1
In-Reply-To: <20200219185329.6640-1-johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.2002192110230.46@tvgsbejvaqbjf.bet>
References: <20200219185329.6640-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MMe/loO2ufIlKalN/5Rm1JUPjEdw5xJFVNl5Mld1BVa2Ju2vIIT
 ZGdny4TEet3Ver5PlWl4pAaXhR5MXbAfl+8F1SFAOKkzHQZB0Jfs7STPtfA2i+mrJevB4uN
 kDpOoRXPW+2ZibU8U/EZxue0TEmiSky+E3llw1Macsb3tiCciu0sz48wSXybWeYD4GWJifl
 IrK0srWpuZTO6Z9Ck/vcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3awgg2sIkQ=:+xW9lZKhGj8OfDRaT2jUCV
 /zcxEX6K/bjWsUHu7XazeleIkkmZljrR7Z6wcA3g6y+m4XXz4yYJ/LL9OMFoUxHXHWWkYSOy4
 azdf/EaVfiOwSGhiewD+zBeEKWEuTYPqDTVvwIEhn/ILYcjr/jOTfxwABVDzOWdobACviGySE
 1foFsgNn/wm31G6w1LfWOQNj2Y86Vaav9fZcAUtcUbw40YhAP2KOdRoj/dp1Nd/VhrACwvafZ
 Q6N5WFwuUtK3RMVOzbhfBGpGV09DrF/zIp6sRAmkKVTEWkkeA0w0GY9IECSkHWuWTIg4iIHQ7
 q8FuNyGhqxHdxK9N7h1Z9yx/qyNjUgE8UXe6v8aAXntYckZqviCizxYlO6pYXuhL/G+3zbRrf
 fBLeWcl6NckiHwa3RGjw4/Y1ARr/7xFt8Bxcy9OLLOy4k4CNaOnoHfBhkY5kVc9Z1fFXGEf2D
 IdMezSKNRvclrXVv/JW3qQUNqfmJCyYybzpZtVHBfWQmhDMXtD4+JlL9OWvKbwxuziHYXMrl0
 SSmgR+Z9st99TF7BNxkSOHj+S383S7yUlf92rX85/ybThMUAFgSp/0SeInkYZdUqJ5RkbQsn0
 em53KQskSjXqFcogrwwFMgZSRMBf9UXBUpTLTV776TIryBGHBHTRRDuCRpK/ekRHlL4WDhitn
 IafOLHTQOyzX+6OXONqmJNz9sdMP9UESdV9aB/TEEzSulhw0MIyiU8ZrJfivmTo48JhyrKcb2
 /n5+1i03Kg84UMcgbCH0pexwGJnvdAs4C4itakHAUjufsPM0Sizr3archpAElIXg1ZD+YXINh
 P0cqxDD98/KPjC/sTjcNCnpm5gIYM46V09sURGxwGh1lIpNGw7w8ZEGq0kMk9KjA5vgWdiBOW
 xth5xecUQDJcq86JtiYK8XzBNU4e6nl9GL7CPzrCChECzAXeIJ1PFKG3Gl7OCsX74Jhiha3yV
 bn/EsArAHHHV/kUFo02dDt2v7nPd/IhcS8rVlzFS/WQ4RZ9ll5qQm64mHxFaso1fAMVYQXrMr
 j7fn/TuZICagzyrpsqR3wZiViSQ1KZmVEm06xwUJ2VZlI+M8GO0Y+6kcccrvzjcrY2z5FZc9R
 x3xn70unbPdqjuO4p8PT5h2hh279IraXqCGKP3PaKwhIPOxvR4GJTkZ8pw8d+VUBHZAn3IZqv
 LEEOBqNuiY4rMGVxBk2cchoTk2nIkqpYD+eD+rTK1gfD7/QWZF7z4iDnjPfOeN6vVeBvAJAch
 uF/nVNMBfCh+vktLr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Me again,

this mail was unfortunately a bit incomplete...

On Wed, 19 Feb 2020, Johannes Schindelin wrote:

> From:

This line is of course bogus. And...

> Dear Git users,
>
> It is my pleasure to announce that Git for Windows 2.25.1 is available f=
rom:
>
> 	https://gitforwindows.org/

... here, the release notes should have appeared. So here goes:

Changes since Git for Windows v2.25.0 (January 13th 2020)

New Features

  * Comes with Git v2.25.1.
  * The Portable version of Git for Windows now defaults to turning on
    the FSCache just like the installer does.
  * Comes with Git LFS v2.10.0.
  * Portable Git can now be run from a RAM disk, too.
  * The deprecation of Git CMD has been reverted: the security issue
    (git show would execute a git executable or script in the current
    directory instead of the intended git.exe) was fixed already in
    v2.20.0.
  * Comes with OpenSSH v8.2p1.

Bug Fixes

  * Some corner-case bugs in the built-in git add -i were fixed.
  * The file name COM0 is no longer mistaken for a reserved file name.
  * The curl.exe included in Git for Windows can access SFTP/SSH hosts
    again.

The reason for these two glitches is the same as the reason for the delay
(Git v2.25.1 has been released almost four days ago, after all, and I try
to stay relatively close with Git for Windows releases): for technical
reasons, I had to move the automation that I use to publish new versions
of Git for Windows, and I used this excuse not only to make it public
(https://dev.azure.com/git-for-windows/git/_build?definitionId=3D34) but
also to modernize the pipeline as well as to split it into a build and a
release pipeline.

This required a lot of refactoring of the huge automation shell script
(https://github.com/git-for-windows/build-extra/blob/master/please.sh),
and every refactoring has some fallout. On the positive side, the new
pipelines should be more robust and a lot faster, too.

Here's hoping that future releases go smoother than this one :-)

Thanks,
Johannes

>
>
> Git-2.25.1-64-bit.exe | 9e442131f7dc0de24db1369a4fe02659c2d642bf60ce6d88=
e31340eedaa18da1
> Git-2.25.1-32-bit.exe | 4408525b8b314f2ec8cf8f3c00e8bae27cb4071790af2390=
8e6c908a7d48e5e1
> PortableGit-2.25.1-64-bit.7z.exe | a3f594440431bddbbc434afc88b8acef286c3=
4dcaa20c150a884e274e8696b36
> PortableGit-2.25.1-32-bit.7z.exe | 9054e283465ca1153043bae4cf515782b3e0a=
3bd95c28bfb20f66de3922da1d0
> MinGit-2.25.1-64-bit.zip | f59da958ee779ef1454e4d0cb24cb51278049c578c4e6=
d01ba9e1b6f61dfcb1a
> MinGit-2.25.1-32-bit.zip | 91ae315d7f5ceedbdba5644521c65b9889027877a0965=
891da988707917ad9d5
> MinGit-2.25.1-busybox-64-bit.zip | 602389feca195968935c61482e977072f226c=
7de0b3fac98923622fe706f1175
> MinGit-2.25.1-busybox-32-bit.zip | 18888012944e6239783d66db101fad402fd90=
7d29980a020bbd32dfa959173ed
> Git-2.25.1-64-bit.tar.bz2 | dfab87d6bcaa54e179544d7a343c7e4f5b45604573de=
31203542e87899962c1b
> Git-2.25.1-32-bit.tar.bz2 | 6e1a06b5a8d7e47eeaf3228333bf1c1b834ec6dca0fa=
d61434783f2ad2c9da46
>
> Ciao,
>
>
>
