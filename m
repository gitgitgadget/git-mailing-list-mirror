Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095E1C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 14:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbhKZOE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:04:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:42283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348776AbhKZOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 09:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637935150;
        bh=JgPHakLMvOQ0BCEiqAwuqjvhAVF25mXnX2BEc6snng8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WloUTLMOMJBhZ1Qf1ZgDDWOE6D63oimLyFlovDET/zvKhslWFafFamx+ulQLQaKyn
         PEk3MtpzwamrPVcKaJCYtugfRitsAF5xQRIed7jlcCoXQfBadkA44LfY5iBIjicBJY
         enkubMgEWgPCl+GteY0Sn/Id2V3c/QVro4ZsuFEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1nCYUX4Bwu-00M0IT; Fri, 26
 Nov 2021 14:59:10 +0100
Date:   Fri, 26 Nov 2021 14:59:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
cc:     Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
In-Reply-To: <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com> <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1858230353-1637935150=:63"
X-Provags-ID: V03:K1:tIqOIJ0guDAH/Lqsz/MaQwl/z/8n9TqHsi3IQbk+pT3JC5okepU
 ae+SNnXL2U6ziU1ikMa916GXqP+WBFxvkAKqiX1EdlMuDahmc9vkx9IesZcmW7DqdOO4W3H
 b6KxsepFmlIhAtG1wtJyn3IxxKjgpGsyfAvSC4lfxuIU/WtdIc/3zAYiPTFjZSnHLlmRlKE
 I18Kxgue4qhx/HVr6bj7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M93mRTF1dOU=:47JhOfS+5F63Aq0g1CLQIY
 bf+ozSLd9S3yAuQNAULeB2Jvk8yqzFd6j/XTNUAqfP9vfL5yh0mFv46skRM5Kq8c4CkGVAAB8
 EY3xXHSGuXgm3RsWCyLDpOPFPcOP+3BHp+3pMw9Pi/D6jSJocmrZAo4Hvk7c/hzoBFM+bug7f
 1F9kHHjrcFgHN9YrZ96GUrRrozGRvvpTngbe+MIoCtL3hRP11XRa6h2mGrS2Cxhn50T+QcdS9
 D3+i/xOp5mCfAuJPhOlFkYUQeQNFT4J8KHDTvQP2dswEmq2zgeIqLCvLV+OKDQzL8ZaB1a1nQ
 2A99sZsmEEGanUL2HCHTZ+26AIb6SFwSIJxuCQtC2gVgwoho8WQj4gQGrjNHkBXrdrTq/gful
 YGFnhR/x/+pn0/i4Tk3Vstb3dMmf2ncFlKQVqaaCgDyeeqFIOPp4ZOsi3RpVc4Y1oB+/LddCx
 pCEkF67MkAWj4cNO0Qw8aHAjMcy9GM8EYeO7CSrnhaAj7QYViuUPZYhq5qPIayu5bP+z3Dkei
 fqbyVh0zgTfyarPNsNFviCYPGHRWndRO2dAuEJ70+G9kdT/eRXxnLfxCl9FGw0gg8Xr9NUDcO
 1JIpfCF6kZ8m66xzinUaXZd+zYBRxqJptyFG9nyE7hPWN5Vi2hE0s+pctHFyY9loWmpxMUWtk
 1nEVqBJOnilno3hm4UapYJv4dF/5+M52qUW2d9PpOBM+A/c8821w1Pr5Svsr/z2rKwl+jYE1A
 FnKazWatYJ1IknoJSgMhuyb4gV0hRJsLsQPMfHRG9KimXdpigzx3TLA8NIkJarIoR9liu1hpV
 PWBVifGf8/6F+YXWbdaFnjN0fraad7GYh/uG3Vx3bHOcZkNv0mGHZlKJEP+F8NTQMCGAEXyqE
 RqFT8AR3EEMJfJe7CTBl3Pa1gQ6g3fQ9SMreqrJgXygIO3OgSimVPzci+Pd361B0yWm5XIhBY
 hksKe6HNYvZ2su6agl/G42OMPyQ0VP3cPl89kLHnkR1Spc+0lxinuRe4I5VzzqRArbLj/LZ4M
 ouQtw2liu2Juh16m3kFh3Es0tNPc0NKJFvpzmPv6oXEMmPKXgVSQgqLw9DYSyGLs9DVPRU8n4
 +7PU0Ti+lrZemk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1858230353-1637935150=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 25 Nov 2021, Matthias A=C3=9Fhauer wrote:

> On Thu, 25 Nov 2021, Mahdi Hosseinzadeh via GitGitGadget wrote:
>
> > diff --git a/.github/workflows/create-release.yml
> > b/.github/workflows/create-release.yml
> > new file mode 100644
> > index 00000000000..711ba105e42
> > --- /dev/null
> > +++ b/.github/workflows/create-release.yml
> > @@ -0,0 +1,40 @@
> > +name: Create GH release
> > +
> > +# Create a GitHub release for each new tag.
> > +# The release notes are taken from the release notes file
> > +# modified in that commit located in Documentation/RelNotes directory=
.
> > +
> > +on:
> > +  push:
> > +    tags:
> > +      - v[0-9]+.*
> > [...]
>
> All in all I think this is too convoluted for what it's trying to
> achieve. I think we should be able to achieve the same result with
> something like this:
>
>  .github/workflows/create-release.yml | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 .github/workflows/create-release.yml
>
> diff --git a/.github/workflows/create-release.yml
> b/.github/workflows/create-release.yml
> new file mode 100644
> index 0000000000..5b9fdf0372
> --- /dev/null
> +++ b/.github/workflows/create-release.yml
> @@ -0,0 +1,37 @@
> +name: Create GH release
> +
> +# Create a GitHub release for each new tag.
> +# The release notes are taken from the release notes file
> +# modified in that commit located in Documentation/RelNotes directory.
> +
> +on:
> +  push:
> +    tags:
> +      - v[0-9]+.[0-9]+.[0-9]+
> +
> +permissions:
> +  contents: write
> +
> +jobs:
> +  create-gh-release:
> +    name: Create a new release or update an existing release in the Git=
Hub
> repository
> +    runs-on: ubuntu-latest
> +    steps:
> +      - name: Checkout the repository
> +        uses: actions/checkout@v2
> +        with:
> +          fetch-depth: 1
> +      - name: Get version number
> +        shell: bash
> +        run: |
> +          echo GIT_VERSION=3D${GITHUB_REF#refs/tags/v} >> $GITHUB_ENV
> +      - name: Create the release
> +        uses: actions/create-release@v1
> +        env:
> +          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
> +        with:
> +          tag_name: ${{ github.ref_name }}
> +          release_name: ${{ github.ref_name }}
> +          body_path: Documentation/RelNotes/${{ env.GIT_VERSION }}.txt
> +          draft: false
> +          prerelease: false
> --
> 2.25.1
>
> An example of the result this reduced action produces can be found at [4=
]
> (release notes for v2.34.1, but the tagged commit isn't v2.34.1).
>
> Best regards
>
> Matthias
>
> [1] https://github.com/git/git/pull/1146
> [2] https://github.com/git/git/pull/1146#discussion_r756854259
> [3] https://github.com/git/git/pull/1146#discussion_r756845042
> [4] https://github.com/rimrul/git/releases/tag/v2.34.1

One thing I had not thought of earlier: do we really want to do this in
every fork of git/git? I know for a fact that microsoft/git has a very
different workflow upon pushing a tag.

So maybe we need something like this, too:

   create-gh-release:
+    if: github.repository =3D=3D 'git/git'
     name: Create a new release or update an existing release in the GitHu=
b repository

Ciao,
Dscho

--8323328-1858230353-1637935150=:63--
