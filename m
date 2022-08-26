Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A76BECAAD4
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 11:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiHZLoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHZLoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 07:44:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E24D21D7
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661514238;
        bh=NqKkT5eZkA4C2vgngl7oARGob2L4l8XGho7ULUbmi4I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZNM8coJTkVEV4fOjREOaIj1ZLEqQR9s4/4yuwMaKUPC0GqT2JAwlYiATWxrlZMoWr
         W1Yi6Hor1yXE4KV2JYPmWUi+XpQcBIQOEQCjsjCD6fd5PucNPfpX/yF+X0zvpra3VA
         mX0mi1+s35JRBGmQb5O//0eaUbKa3bRGO1GoZ7tM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1pHSPg3rnp-00uX0Z; Fri, 26
 Aug 2022 13:43:58 +0200
Date:   Fri, 26 Aug 2022 13:43:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] built-in add -p: support diff-so-fancy better
In-Reply-To: <241d3760-5b7a-fb3e-00dc-bf54bda92c82@gmail.com>
Message-ID: <818s0453-677s-sos7-24r2-qq66o4r81r4q@tzk.qr>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com> <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <241d3760-5b7a-fb3e-00dc-bf54bda92c82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-788647694-1661514239=:189"
X-Provags-ID: V03:K1:nPqNEr1zXHHUAiA6JrfZTrGvFTXFXOdBdNHwj0wajAoOdRTyjl7
 TeIzxuxIDY93B0Kah2l1TD0Ug9qcydnbLnkChoowUgX+jlw7EC42AkxRVxiADaPL1A+R6/3
 ly6jyevEk5I7CV9zVfQaxHIXzwo87/RqsIwKL4Agx/dR9o1Me3f2UweV7T/fxh08+5xdDbh
 sylQ/PgMNifjfeQkEl0FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eZso2zgMo/I=:ivW8Z/zxun5E8aEn/t7bvJ
 9snALLv97vxMiQZLctt4G9bK2IOgy6MWT1YtrOq1A0phovoSbQIBtcyudLP2fUee5vIGdEzwu
 3CmJoGE9DWu4CWL+ytPI/NjnIWRsq+wncrkj4/pYm67IPXvgWOONalXgS1d8nR1a4JI/tc4a/
 X07MwVZ7Z05LztBUAZBKs2fvejYOKSJs0soutGThpQSKDqnr7YH4uVoSkCQ/9oRSUdLxyHvQw
 uYGOhW0+qiYE2UswSckH8ni83DKKYMjiw+rwuEBEWiUCyqoyqKyIUFa4AK/XueZez9J1PyeWe
 EfCZ8rf1D9BcedSEOaA9izKEzZGafHEL9UzTTH0FgLOoRHa/+Zd02ifgt1d9TaVaWty5EBQb+
 xVy6k119kcaFEqRwQpPbsFXPbpFzwO/8yV6o3Yf5zZnQ6ZUtERT31kTAU7qXF40GpwUTco6Of
 TrqSAtKuM1nisfstku8xjnjG6I6fTi43gg5J/sCYRPMLVB1T27iZPI86gLQuMrhA+MWpbHpeA
 lt4VVIS72ti1TR8Xz4IYb0iSUqu8a/Jbw1Bq9e6VsZwkCOA1uiL5jahkA2sFWsV8AkGcy9+to
 9ZP7f1dR4PDTUtBKIf0e2U6La727eS5L/IVFpuKe2nvnnKU00Btq5fxRiO92LzS3Wl25Jqj2s
 Zk42V3bFo2NiKjGSuzNqdnSEF0A3U7SeQki37XwT6ydZVEA1UCu2GQbY0J8iG8eYO+l5o7QFd
 h9td9GN53w9dghbqTf/KnHedLsgWT2tmojhFh3E+5DxIKwamdmsiB+MIL02SxUQyO2hNrOE8S
 gEZ1b+NUjRmy1Tew4Qhm0+5QsEczhRR4NZgy0g+xhCSTn5Gic/hIcKT5bLYbEj7G4xFPBZnNq
 fGr7kN0xiY41z9+hXCFmHp3YwudFbkEj0U/l+AqdagMbjGTIlAzUu7FkElTlwPG0gORMsMwQR
 OFMoDp/gSBgGJ5jJs+ko64wiORaXxQ7W9Xe4dXcMOzRpZxfwXrpgIs5LwD4W74yDA7Vc/nC4x
 0INfkQCAHqgL2twW7SASnvrJAHOJr5huMtPzztE+yGyWMyT2y+qUJg+ZWjM1Ghh+PGiX0wFrd
 nis6qQSdcTeIHDIhEe0avWANpWo5ZWeCm8Tqvtpk3liPYtNC7i3KR2IWQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-788647694-1661514239=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, 24 Aug 2022, Philippe Blain wrote:

> Le 2022-08-24 =C3=A0 17:21, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > Philippe Blain reported in
> > https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail=
.com
> > that there is a problem when running the built-in version of git add -=
p with
> > diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colo=
rizer.
> > The symptom is this:
> >
> >     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ f=
ile:1 @?[1m?[0m'
> >
> >
> > This patch series addresses that and should fix
> > https://github.com/so-fancy/diff-so-fancy/issues/437
> >
> > Changes since v1:
> >
> >  * Added a commit to ignore dirty submodules just like the Perl versio=
n
> >    does.
> >
> > Johannes Schindelin (4):
> >   t3701: redefine what is "bogus" output of a diff filter
> >   add -p: gracefully ignore unparseable hunk headers in colored diffs
> >   add -p: handle `diff-so-fancy`'s hunk headers better
> >   add -p: ignore dirty submodules
> >
> >  add-patch.c                | 24 ++++++++++++++----------
> >  t/t3701-add-interactive.sh | 24 +++++++++++++++++++++++-
> >  2 files changed, 37 insertions(+), 11 deletions(-)
> >
> >
> > base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336=
%2Fdscho%2Fdiff-so-fancy-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/ds=
cho/diff-so-fancy-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1336
> >
> > Range-diff vs v1:
> >
> >  1:  74ab50eeb1c =3D 1:  74ab50eeb1c t3701: redefine what is "bogus" o=
utput of a diff filter
> >  2:  b07f85a0359 =3D 2:  b07f85a0359 add -p: gracefully ignore unparse=
able hunk headers in colored diffs
> >  3:  9dac9f74d2e =3D 3:  9dac9f74d2e add -p: handle `diff-so-fancy`'s =
hunk headers better
> >  -:  ----------- > 4:  540ce27c38a add -p: ignore dirty submodules
> >
>
> Thanks, 4/4 fixes the mismatched output bug. Just after I sent my last e=
mail,
> I asked myself "but why does 'git add -p' presents dirty submodule to th=
e user,
> as they can't be staged?" :)
>
> A small question about 2/4, any reason why you did not use a "Reported-b=
y:"
> trailer ? Not that I care that much, but I think using such a trailer is=
 more
> standard, and makes for easier statistics as it's more parseable :)

Good suggestion.

How about adding your review? I'll then add a "Reviewed-by:" trailer, too
;-)

Ciao,
Dscho

--8323328-788647694-1661514239=:189--
