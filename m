Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA75BC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB55861220
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGEMq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:46:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:55577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhGEMq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625489059;
        bh=NsBTWDG03pzO6tQ9wMX3nLyq1pO4kQiAr7efP3sUDQk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ldd9Eqib4I1KoPXAlAbBuN1TMR1eSgktWAhRF0e7kQ3WuDjn04H3AiyC+XuQpFCA3
         NQpmdBkZtRaEnHz/x2s0k9U1+aYaf/HXLavKC4ff1T6NpJEQmAyLykqRE92QCjg5lb
         AnknKQKmCIgGIVq6fSOgufgWswA1rPbtYhEKpAYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1m5aUe1cpj-006OjC; Mon, 05
 Jul 2021 14:44:19 +0200
Date:   Mon, 5 Jul 2021 14:44:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH v3 6/7] ci(vs-build): build with NO_GETTEXT
In-Reply-To: <87o8bh6yhf.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107051431440.8230@tvgsbejvaqbjf.bet>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com> <pull.878.v3.git.1625439315.gitgitgadget@gmail.com> <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com> <87o8bh6yhf.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-773851311-1625489060=:8230"
X-Provags-ID: V03:K1:8aKTb9UsUineTBXAXIbRf3YoLChKV4NQqbC81s3o0L0yxy3Z/RD
 Edkda9YbBEJrE6D0V/ui1HVjgCtg3+y9TAg8iUDJxlRNhERMgPq5DzRl5cFSEvV9QCrhb0/
 HxdYa94iiedQs+O/tzg0Tkb93ih5obmQA6s+hS2REHfqYhSAOAr+J7hbSRKEhKDqAlszJEQ
 JAg9yxTtKQdBRSXXr+PXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7s1dp7GLRZo=:uuLpr5/WkAwwIw9x6zvGDJ
 +Ih0cCV+uOovUf5ZNchDYE6he6cyUsbROchFNSxtQ7fnz7X062CwYPruviecVw64H1wwu++Y2
 UzazVaRkphG+oOe9ICPV6zyHbVfSO6NPFbCP2SL0TwRwtF6b/LEYtZGCL5rdGsxZeXUDAEo1x
 BU0L0N32FZC4h9FRzKWG9FT1p8WRt15Y+mm1zljf1ZImrmy2S6nniFINVhJIVR6Q68Us3LQ85
 c3Aw1YyG/wcse0ky9MCslyr50cXND11nbuIqPk5JsfbaAdnT9UQqQI+laIEZLVu008pRD6Yc9
 Cd5CJ39EyRSs85T8DcO0HTmxPOfiIbRxH02Y5uZT3CvG3sOgekRuKXifBWhL8ttr5veawENF+
 nbw+4l56BbIMC8L+GygqTcLNNca4LwmK/byiZNdN/cmSS3liNy6RopdXq00G2sooJCqIYOi71
 XjuhJUWZwigres3yQG1rIaOAYluWbudIFjPVtZ67bbvn+rOUS5AI+gIuwMdDRn+vBSJNF1bKO
 WJHBJ8ajxH3LfY8R1NpnGQ4C8TE+KP7CNXNsfRgm5+8tJto4pc5fPUnzxOE+pgK7z7xPzKBw/
 gca3oJjqi2r6qxCSO93GbNZFqq2obBSPmZt8Jh1tBNX+t/WA+nLtjUDTR12wyNIkx0N4oPcbq
 4a6t9jShDOPKgOgr9XDouVnzfEG1/9eOmq8sl6sNcVjc7mRJB1pN/iAJLAkG98fjl93HMI7th
 mnkv0aNtvNupYyj9M/M7XDvEQu637KSH25WczWACskwFmVmiyKTXs/DiMSh0JZibnRvmRewhh
 xqZjS65xUANNRBPKlLVamh6J9dIAzcJnheRSKHScjv/tgFggV7j+8hEXkJi3UdPX5FWcZfN5T
 YZU5dzEzrGxY4KFxj3i+M9hD6kkMwPqbeFwxENGvy2B23q7BLx2eHMqBL0BITuQJQgR09BljD
 HumLz4pPFz2FGqwn+clXsld/yOwOwD1ABXRakTbYwRqjzJC3m8enHAEcdhOqgRXZktL96US1u
 mVU87wf7j/lEjP6kcuX8bkLnYL5+fNruMSiMGWmvcFPHVZC6a4GkJW3ZgA9xbQmxSD3D64OPo
 ePKrqexQg2P1ppELChnucPHhbPfwFo1qOuNE/fShSvq2oYf6whioSDUWQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-773851311-1625489060=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 5 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Jul 04 2021, Dennis Ameling via GitGitGadget wrote:
>
> > From: Dennis Ameling <dennis@dennisameling.com>
>
> Re the v3 cover letter & my v2 comment:
>
> > We already build Git for Windows with `NO_GETTEXT` when compiling with
> > GCC. Let's do the same with Visual C, too.
> >
> > Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
> > in that `make artifacts-tar` invocation because we do this while `MSVC=
`
> > is set (which will set `uname_S :=3D Windows`, which in turn will set
> > `NO_GETTEXT =3D YesPlease`). But it is definitely nicer to be explicit
> > here.
>
> Okey, so we never used it in the first place.

No, you misunderstood.

While it _is_ true that we set `NO_GETTEXT` implicitly (via `MSVC`) when
running `artifacts-tar`, that flag was ignored before this here patch
series.

> That makes the subject and first paragraph of the commit message seem
> really out of place. So we really mean something like this instead?:
>
>     ci(vs-build): be explicit about NO_GETTEXT
>
>     We already supply `NO_GETTEXT` implicitly due to config.mak.uname,
>     but let's do so explicitly to ???
>
> But if we're being explicit we also have SKIP_DASHED_BUILT_INS=3DYesPlea=
se
> since ef60e9f74b2 (ci: stop linking built-ins to the dashed versions,
> 2020-09-21) for CI, which has an even bigger effect on what's included
> in the tarball, so it seems odd to single out NO_GETTEXT=3DYesPlease,
> unless there's some other reason to do this that I'm missing.

Yes, you are missing the fact that the `SKIP_DASHED_BUILT_INS` flag is set
explicitly.

The `NO_GETTEXT` flag was _not_ set explicitly. It is set by the section
of `config.mak.uname` that is in effect if `uname_S` is set to `Windows`,
which it is if we set the `MSVC` flag, which we still set in `vs-build`,
for tradition, even if we no longer build with `make MSVC=3DOhYeah` but
using MSBuild.

I hope this removes any confusion.

> Hrm, isn't the real reason here that before 5/7 this would error out,
> because while NO_GETTEXT=3DY was implicit and we picked it up from the
> config.mak.uname, we just had the $(MOFILES) in the archive-tar list
> unconditionally.
>
> So after 5/7 that's not the case, so we don't need this change anymore,
> but we're making this change anyway? Seems like the result of this being
> the first try at a fix, and then re-sequencing the two & keeping the
> now-redundant hotfix.

Excuse me?

This here patch sets `NO_GETTEXT` when building Git in the `vs-build` job,
and consequently sets `NO_GETTEXT` when bundling up the artifacts tar.

It does so to accelerate the build which is legitimate because we already
test the gettext stuff in the `windows-build`/`windows-test` jobs.

There is nothing "hotfix" about this.

Ciao,
Johannes

> > Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
> > Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .github/workflows/main.yml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 0f7516c9ef3..c99628681ef 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -159,7 +159,7 @@ jobs:
> >        shell: bash
> >        run: |
> >          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pwd`=
/compat/vcbuild/vcpkg/installed/x64-windows \
> > -        -DMSGFMT_EXE=3DC:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -=
DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
> > +        -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3D=
OFF -DCURL_NO_CURL_CMAKE=3DON
> >      - name: MSBuild
> >        run: msbuild git.sln -property:Configuration=3DRelease -propert=
y:Platform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
> >      - name: bundle artifact tar
> > @@ -169,7 +169,7 @@ jobs:
> >          VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
> >        run: |
> >          mkdir -p artifacts &&
> > -        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=3DYes=
Please ARTIFACTS_DIRECTORY=3Dartifacts 2>&1 | grep ^tar)"
> > +        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=3DYes=
Please ARTIFACTS_DIRECTORY=3Dartifacts NO_GETTEXT=3DYesPlease 2>&1 | grep =
^tar)"
> >      - name: zip up tracked files
> >        run: git archive -o artifacts/tracked.tar.gz HEAD
> >      - name: upload tracked files and build artifacts
>
>
>

--8323328-773851311-1625489060=:8230--
