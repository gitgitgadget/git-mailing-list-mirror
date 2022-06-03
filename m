Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C3C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 10:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiFCKEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiFCKEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 06:04:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403ADF15
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654250667;
        bh=X7XDnEUDJYi3Q3osbLd5UB38pUeYUOpCbgUPZgEAJNg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CpFyCGdQNXmOsdp3kydM/Y+1gkIDPD7uDM+KUjZPIXZ2s2H/9xRJxxHsE9PZD/kJi
         HCxmq754h06TJ/vJuDBm4U4KLySXNqFNzKisxWboFHvNo6iTH+u240ceyImBUap1HX
         U4BuN5VO01D8ylM7IA6M6zUruYvffQ7FAS1hTb2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1nW0Gr2gP8-00lzXS; Fri, 03
 Jun 2022 12:04:27 +0200
Date:   Fri, 3 Jun 2022 12:04:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <derrickstolee@github.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
In-Reply-To: <d59b51fb-029f-8232-9dd8-2f7f1b410aa7@github.com>
Message-ID: <nycvar.QRO.7.76.6.2206031147220.349@tvgsbejvaqbjf.bet>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com> <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com> <220602.865yljywtf.gmgdl@evledraar.gmail.com> <d59b51fb-029f-8232-9dd8-2f7f1b410aa7@github.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1331807075-1654250667=:349"
X-Provags-ID: V03:K1:K5XC+EFTZisnJ/SpB4SgpgwdOzKyZwBOmBDCFHUdrfgF3Bt8hvr
 KsMtRYJHPz9HzFYFcE3O2GJv6Jw3xihRreKdyd/yNHtuR5LzSzmRMFtz1iFJD4wr/Ti9m5D
 0FW3tBY9QlsXzQmh4dik/AGlTJTtfZo9t9Qkpf40KXtxSEydXEyFlMgy1gUNXKL3H9hTOsU
 dQyZy3lpkDefPRCrWi/KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8+9RoI5NHs=:YMtnPXFKgs8DYpVqw2MjMI
 FNo3YTIq12Q1gavUAxDCppAwLyfqYGq2dxnHr/3P97tW2vKeU6TtaRov2l58hyWdC21IGrdvT
 SU1EDX85kEusTo98ybriOqF6OqySX8JxEXlx538FgvWrdlNgNLjrpPGO5JT2wswlyB7o1FgZu
 BfYFATnCXHZLry7CXRLE5ZkdrPN3uC6boUyvm78/5tQLNjcm7vbVy/cX9HH8MsK6xbn5YXYUP
 ZgnpPLFgRQJriT3+HZdOKt6clnfksuzmftD8jxaUKZS5x6Z0ap2GSAyK6RqO+yIrJxeGgrNbf
 6v04ySlNVOECRkorESwlCE0B5GhOwQboLbspcVMInx8nArplDtkNJWHWAK9UUHa3ca0H5SKs8
 HS7ZrJq2AXx0HFPKe2f9Dsljv9Ho7gSr4xlGuv/SlvV0IyYC0cJDjuAM9XJuIXQllrbY1FO2L
 N7Y1bgSn/CeBkhoqwfaL7xpLNMeEedoxLSCm2R0ygSl9pWtdlpITUv89kjIOxr6eQrlkZMkrN
 T/IAcusbfofFzB9ahc6kHofCR/0LvY7IiTd2MWwpj6tQ27ZViFsFm/tqSn/HtqJHDw++Dolcv
 qm9NdqvmrfXSlqhBcS3SPu1h3qAmYD5jeCqi5s8P++2EUCN8iQ0Kl1XISgN5ME3C+av/lj38M
 TDYNMamIAV8wvk/iI9oGVNv+DWrF59hByqbZvkPk3cNSOcOu2JCOi/82Y/lvUcCPGqTxK9pkx
 X1DTll3YQiCogZ1kJFV5nGtm2B9hRBVxrORkYtJypiiIhf8kNUbkoQRr9OUr+NKKWR55yP5Mv
 ISrOI8Uc1hVI/CVUuS8xdTnmiNK5WPjxRlOPPRVNfsr6FVjWeHpuMyKZPlr9dncLSyuXio2Hr
 c1T5iGfwKaFHGPm5CEClpc0eodftTs4lJUYaB4F6SUg/u9Xzm/npuDewgfs+Ka3X7CZL9+e29
 4TfsmS/7l8Ud40c5y1ts44uCW5aCmOZXvuI1uDn0vP4FnOeUbThntMxsd/JQyTBE+VGJmjSQA
 SCjBsw86Npk3jufB0Ef2l7D61ghRPfCHA7rAqgRecntDlkBvJS07XzU/LY+Do1Z8Vs1AGu+sE
 inXmI4SX1aCa56rgvT5FK8MNCXh00TB5T1oqR6r2xHK2Ir2jhzf7yr8ag==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1331807075-1654250667=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Thu, 2 Jun 2022, Derrick Stolee wrote:

> On 6/2/2022 10:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Thu, Jun 02 2022, Derrick Stolee wrote:
> >
> >> On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
> >>> Note that the changes to the GitHub workflow are somewhat transient =
in
> >>> nature: Based on the feedback I received on the Git mailing list, I =
see some
> >>> appetite for turning Scalar into a full-fledged top-level command in=
 Git,
> >>> similar to gitk. Therefore my current plan is to do exactly that in =
the end
> >>> (and I already have patches lined up to that end). This will essenti=
ally
> >>> revert the ci/run-build-and-tests.sh change in this patch series.
> >>
> >> I expect that this won't be a full remote, since we will still want t=
o
> >> exclude Scalar from the build without INCLUDE_SCALAR enabled.

We had this `INCLUDE_SCALAR` condition in microsoft/git for a while but
since I got the sense that many regulars were in favor of treating
`scalar` like a top-level command (similar to `gitk`), I've since changed
the over-all course to compiling it unconditionally.

The only remnant is the CMake definition, and only in the transitory phase
while Scalar is still in `contrib/scalar/`, and only because I could not
find a better way to encapsulate it.

But yes, if we decide to go with the `INCLUDE_SCALAR` approach, it won't
be a full remove/revert.

> > Scalar (well, scalar.o, not scalar the binary) has been included in th=
e
> > default build (including CI) for a while now.
>
> I'm talking about scalar the binary being important. I'm glad that
> scalar.o has been built already.

These are the raw logs of the `linux-gcc` job of the most recent CI build
of `seen`, as of time of writing:

https://github.com/git/git/commit/7f1978ce8bfe41074df4fc96ff7f2a28e5807fd1=
/checks/6718714644/logs

When I download those logs and then let my browser search for the term
"scalar", it comes up empty, even if, say, "range-diff.o" is found. Which
is exactly according to my plan: no part of Scalar is to be built unless
explicitly asked for.

The only job that touches it is the `static-analysis` job, which is a bit
unfortunate. But I cannot justify the complexity of the patch it would
take to address that.

In other words: The statement that `scalar.o` is included in the default
build, without any qualifying note about `static-analysis`, is quite
misleading.

Ciao,
Dscho

--8323328-1331807075-1654250667=:349--
