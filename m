Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C784C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006FE61B54
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhKSPBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:01:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:35949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhKSPBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637333911;
        bh=Eak/rX+jBUpclKSyM7+88UZueuP50zG71QGxaNoJirg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ivOG8LXs9j3QM79ku8w9tDHMUekaqvDmBl4tLlrBS+J1u/rVKt4BbnbddZ0qlh9IC
         Ha1lt4akKf961/LfqHP5NHH2VuNoy69ySC6jqICjJhRCDox8kiw67QEHu6wbLPRN65
         cdtPU3bx6k5sfyQnpoGTbhMc90dZq4VuUwNYtYjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1muLgF3CPJ-00Fmzt; Fri, 19
 Nov 2021 15:58:30 +0100
Date:   Fri, 19 Nov 2021 15:58:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
In-Reply-To: <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111191556001.63@tvgsbejvaqbjf.bet>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1470439845-1637333910=:63"
X-Provags-ID: V03:K1:RYF/9KuZl0J/LGieU+JaSDWbZPTyD+tvWdE3E9kfSej6JU0wIKV
 J38ixS+pZ4gyArLorC1QdKJviv3YKtud9GZYKLIvh16jkt1cAttjVrJJa6QcIrkY1RDpfxb
 qWL8nk3pcEK7upmqYgbP/YlSWTpLy4LmSrBVbocgjQNqH/L8WtAi6c4xn5oznBuM5AYmaDM
 +d7veygqg8IRvbzvMR0sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HKSuZSTratE=:IYN7XKMJSKV1b8CBIWtZJg
 FKvYl+8pHwixi2cZdhgQNL8j+cOdIs+8CzQ1aKT9uDT0KZ8FW8Wsne6lopW1HqI5FtXN33LWj
 XbV6+OjpGOgrQepZjEfdGB1swb43KX0Rjby6WdMntzpfPyZDUqCo+ipPJcCa9BP0LTW2EyCkN
 UM0lKG2rxE0+9bEsWNdKCACobNQ+Edg6krugpB98eXsVjdE/zEpP9Vdkuzk4dRQHUovIpoTKy
 WZKDSIbEe3ye3GR+y+lmzmiMAMROdtTbrbu89jh7ioudxiJHWX9FrjPVO21KwuCIrPRhV9/tq
 keh/Fnhs/cn2DGeelj+GAvO1pG1R46RGxjMcIMp7oFMgz4Z4WnUoNwHfW9E61OLDlj5C/21Qv
 6vVJFTKAXtoppyaI+GxoUCv4s23JWHhP+AavRnlKIYlmsJKvPH53oQFTZYi1Hdas1oOhTILva
 pNTFCnhsGsatAPJkfTwDLm8Cp/ffsT6YnzeVMZY8icWXSypkrQrgwNDZpz0M3kOTTvE52pPaf
 EtX8X0xq3XhcySV4IvPNzzCE6uE7PlFdL9nAHFSPXP0Gy8/tMkuzNJOPRBA75G9RuTR30/dxZ
 VuP+/z4ILrUQW7RoiXWXJRGzolW6YY4pPse+VNsE4LSrnTUlHZs2zgMwWSAqskiBjdqW8fPED
 8zSq372EhJsttKnRBlyTyv+fTcyNEl02qKICzkG6X3gYG+Wm/MMQzdYMwCmx1HsEi+IwN3Ax5
 yUSrj68w88aq0dkXuoMTNBYbQsLm4OlRiJuhSACZrihMGmaTLEfZI7OKnNWZ62yqWoljDuC1o
 iA+PH4g89BO7TYOUiAmXH1NzJy/AzU0VOHB1hieRGyANj+vQcYA3WB3cn4kwQrrIuyFZQZ9P1
 VPSTu3IE4Bh2PxjNGklc+MXHpQ8ro9VHiuPRL6gSuKqMdPPBTwqYjd7c5DqfG7HnjuPvFgwkR
 JpcSUfvpz/Ux1ZY8iN4GOcFoxyBOqiFvRHmtFoudPQzZhpSvU/EVAnYvqIbQtQGYYEMTFfinW
 j1mB4S9t02yQWeI32zGRH3GB8CToU+LO1trW6lzHZDoils/zfJmhaoYmEOLdHZgKCF5YzSf7c
 AcZ8AhdXhUYxqE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1470439845-1637333910=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 19 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the names used for the GitHub CI workflows to be short enough
> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
> commit view. I.e. when mouse-clicking on the passing or failing
> check-mark next to the commit subject.
>
> That description is truncated to 24 characters, with the 3 at the end
> being placed by "...".
>
> E.g. the full job name (visible at [1]):
>
>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
>
> Will, when shown in the tool-tip be truncated to:
>
>     "CI/PR / regular (linu..."
>
> There's then a further limit in the expanded view where the job names
> are observably truncated to 44 characters (including "..."). I.e.:
>
>     "regular (linux-gcc-default, gcc, ubuntu-l..."
>
> With this change we shorten both the job names, and change the
> top-level "name" from "CI/PR" to "CI", since it will be used as a
> prefix in the tooltips. We also remove redundant or superfluous
> information from the name, e.g. "ubuntu-latest" isn't really needed
> for "linux-leaks", it'll suffice to say linux. For discovering what
> image runs that specifically we can consult main.yml itself.
>
> The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
> then becomes a 1=3D1 match to the "$jobname" used in
> "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
> added implicitly as before (from the top-level "on" parameter in
> "main.yml"). In the tooltip we'll now show:
>
>     "CI / linux-leaks (pu..."
>
> We then have no truncation in the expanded view. See [2] for a
> currently visible CI run using this commit, and [3] for the GitHub
> workflow syntax involved being changed here.
>
> We could avoid even more truncation with more compact names,
> e.g. changing "linux" to "lin" or "lnx", but I didn't do that since
> any additional shortening seemed counterproductive, i.e. "w32" is a
> well-known way of referring to "Windows", but "lin" isn't). We could
> also shorten e.g. "::build" and "::test" to "+bld" and "+tst", but
> those seem similarly to be overly obtuse.
>
> 1. https://github.com/git/git/tree/master/
> 2. https://github.com/avar/git/tree/avar/ci-shorter-names
> 3. https://docs.github.com/en/actions/learn-github-actions/workflow-synt=
ax-for-github-actions
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

My vote is to drop this patch: it does a lot of things, but I do not see
any benefit. Names that are too long in one person's setup are not too
long in another one's.

Also, it drops the "PR" as if we would not do PR builds at all anymore
("CI" is for "Continuous Integration", i.e. the testing of the current
`main` branch).

And `w32`? Really? *Really*?

Ciao,
Johannes

> ---
>  .github/workflows/main.yml | 13 ++++++++++++-
>  README.md                  |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..8f4caa8f040 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -1,4 +1,4 @@
> -name: CI/PR
> +name: CI
>
>  on: [push, pull_request]
>
> @@ -7,6 +7,7 @@ env:
>
>  jobs:
>    ci-config:
> +    name: config
>      runs-on: ubuntu-latest
>      outputs:
>        enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-=
redundant.outputs.enabled }}
> @@ -77,6 +78,7 @@ jobs:
>              }
>
>    windows-build:
> +    name: w32::build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      runs-on: windows-latest
> @@ -97,6 +99,7 @@ jobs:
>          name: windows-artifacts
>          path: artifacts
>    windows-test:
> +    name: w32::test
>      runs-on: windows-latest
>      needs: [windows-build]
>      strategy:
> @@ -127,6 +130,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    vs-build:
> +    name: w32/VS::build
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
> @@ -178,6 +182,7 @@ jobs:
>          name: vs-artifacts
>          path: artifacts
>    vs-test:
> +    name: w32/VS::test
>      runs-on: windows-latest
>      needs: vs-build
>      strategy:
> @@ -210,6 +215,7 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    regular:
> +    name: ${{matrix.vector.jobname}}
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      strategy:
> @@ -251,6 +257,7 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    dockerized:
> +    name: ${{matrix.vector.jobname}} (docker)
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      strategy:
> @@ -258,10 +265,13 @@ jobs:
>        matrix:
>          vector:
>          - jobname: linux-musl
> +          os: alpine
>            image: alpine
>          - jobname: Linux32
> +          os: ubuntu32
>            image: daald/ubuntu32:xenial
>          - jobname: pedantic
> +          os: fedora
>            image: fedora
>      env:
>        jobname: ${{matrix.vector.jobname}}
> @@ -310,6 +320,7 @@ jobs:
>        run: ci/install-dependencies.sh
>      - run: make sparse
>    documentation:
> +    name: documentation
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
> diff --git a/README.md b/README.md
> index eb8115e6b04..f6f43e78deb 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,4 +1,4 @@
> -[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)]=
(https://github.com/git/git/actions?query=3Dbranch%3Amaster+event%3Apush)
> +[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](ht=
tps://github.com/git/git/actions?query=3Dbranch%3Amaster+event%3Apush)
>
>  Git - fast, scalable, distributed revision control system
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.34.0.823.g5753b56b5c1
>
>
>

--8323328-1470439845-1637333910=:63--
