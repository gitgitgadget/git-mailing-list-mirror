Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC5AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C794D611CB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhGMMW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:22:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:49625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235968AbhGMMW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 08:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626178774;
        bh=WnOvjmLNuBLC+8VUb80Ij17bdS+kAwlt6/kXFZbQo/Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XfFKPLWjb4fZ1oDy04WfSnudpKooWt0Kmxrbr4QbF39s4nrDL83CF3kOWUqvYhzz0
         2oAH/aLwo7GmIAoP9ftD63Xr5IFxVvfRJfi4Aygb8N1MgJJ6DTr0h9i+X+3hvfu4/Z
         iQ9CPEBUZGNBB9r4hmtMXod7v9i6G780VnMqopA8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1l2p2f0F2l-011hWs; Tue, 13
 Jul 2021 14:19:34 +0200
Date:   Tue, 13 Jul 2021 14:19:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
In-Reply-To: <87bl7i8ou8.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com> <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com> <87bl7i8ou8.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1572550024-1626178774=:76"
X-Provags-ID: V03:K1:D3A1hPmR8nVCsMmN3BOss425PmOt/Ki279UteKxQu6XDSsud+yj
 ZdK5gTb0wWsDIYvnsZMl35QsEa/MimD2ihMJAVNDN3MpW968CIl6a92q6LKACO/dCtTsuyx
 sjftoCt4VplWgrQLBP3Pz0ZrQwSOqdN4H/vPVV0W4WgXduqV3nNO9GP6ESWYbNwC1e6NfST
 B2qB+uj0XRoUiM4iOaytg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXVNWlHBBpo=:KUkYX0uu3emZxe5OqabCIv
 uOzL/yKpBqWrsegHmf779tbPMU8Vj839NWu8/DOiZF9+tuGn6enMdtXta9RX7WDvbzF3QAjdP
 KapSI9u8UONRliMw1Q2bKe7emQu5YhMVuCfdJfymTLcXCTRxh5wce96rvqLj6fLEsPFPi2DTF
 Lg4gVPDvdfjeIplJYpogNhnI+2EHEYEIuXsJGtLHqn+GEWUCQAaknXNnoAOynJLuddwI4Qzck
 uRH583l74SRYFYMfUuGhOT02c/GMlxRiPa+LQ19cfUsi799oakf1VeH3AGwgU4divAAmrdAgT
 D/bbL8k5uzyAE12Csev5of3fzW/6AO0/mgxFI7tpeLgrbOnFUD1RoC9ZnKtllj2S2pzjOvMsq
 AZiKGLEvgf04bkocjTiT5Ywsk0XnxwBoT7cohLJxoujGXVbGpBU5v3+mqaqiOpHAkrWTlDBcw
 CCLop2ivalRut60MTcapsfHKxQkh2FU2rjPJ+vyMCCDnvPe2EuyFc7KvEg8XmOaCoWxeCL6gP
 0qvLll0sGtzqEngnT2o/3IQdFGvch+7+qEke7VX7J2M0QM7lDJ3TVW0Q2L3h364bKkPYa0G9i
 v5hR+ys3kKe2j/4ju1J2dFNWiF5I1Jg46hhISjfIuNR+i5ucqsi4H3Pt4N44FZMefyE839JpT
 XtScn58GunK+GlGicQ/37fpTvFkEJpdUilFLuGyalEn7HHKUDfR5c1Xk+MY1v1SUDdOE1iABY
 mZY8px4MELXzlLdjuRJBWtPT53p8BaHgCPG81N45NVC1ix8xp120QsrDk1aNOHL1TfNH3MlyG
 6TcI0PYBUVKGr70KUWe/VfTqSSDhQ6s1jMGAvwlrZ6n8SPp8Bka6lkXf0KIm/MpViM7g2yIla
 fxuTh7dskrRb1fw1NbAYbn6+afXBMx9fmtzdmxV+fLQf4S6pasK4VzX2K/4YwvWgmNs3izhIf
 tLWSqZs6etxVy2IUABvxTTh1ij2tnCdrtSDAacRzMeUJPjdsrQpwPsrr9UezqmB/adP0C2rZc
 nfe7p+TMtBCcmrd7b7p1yfvXAts8qlunnf5jleIvxTiOHN/HixmKU2zYhYTC0bOr3yYon6575
 ZmZNcru0zS6M94ZzPTIW/B3Ui7cN7hy4oS+DJePc4VUNUewYhbMTagA0g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1572550024-1626178774=:76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:
>
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 0f7516c9ef..3b40c677ab 100644
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
>
> To a first approximation isn't the point of CI to test a diversity of
> setups?

No, the point of CI is to find breakages.

And in this instance, a careful analysis will reveal that the artifacts
generated via `msgfmt` are not even used, let alone tested.

Even more careful analysis will reveal that Git for Windows does not ship
with translations. Therefore, it would be pointless to test the
translations here. Doubly so because Git for Windows is not even built
using MSVC, and this `vs-build` job is really about verifying that we can
build with that compiler, and _iff_ we used `msgfmt` here, it would not be
Visual Studio's (because it doesn't have any `msgfmt`) but the regular one
from Git for Windows' SDK. Triply so because the regular one from Git for
Windows' SDK _is actually used_ in the `windows-build` job, therefore we
_really_ do not need to repeat the same exercise with the same gettext
version and the same git/git revision in the same GitHub workflow run.

In short: there is no diversity to be gained here. (Actually, that is not
quite true: by using gentler language on a first-time contributor instead
of immediately going into full critic mode without any fanfare, we could
have invited more diversity onto this list. Maybe you could pay more
attention to that in the future?)

Back to the issue you pointed out: could this be described in the commit
message? Sure. But I think there is no much worth in it, the surrounding
code and parent commit makes it clear that the `.mo` files aren't used,
and that it would therefore be a waste of electrons to generate them in
each and every `vs-build` run.

Ciao,
Johannes

--8323328-1572550024-1626178774=:76--
