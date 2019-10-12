Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8F91F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 18:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfJLSlc (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 14:41:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:38981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfJLSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 14:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570905686;
        bh=CdtrmlWMZFuWw+EvxyXdfnLsDzaLNIZBn12NL+gxvbk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z3KbPFVpB0kL2epEG2mcvOQtGYPYfB659dPNOwuCqLl8WvUW9KIwtv9hG3DqYpIWM
         gmyBSE8vBvI44ElOKxzlSDvvzPu6JhLsKhFje1fftPuIbkx7gNqXN2s7ydy19c6n6d
         GclP0ltyQCbeUPhZLjGQ7mDeulLkF2kiZRu604uA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MORAU-1ii8yW1wEQ-00PrR2; Sat, 12
 Oct 2019 20:41:26 +0200
Date:   Sat, 12 Oct 2019 20:41:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Dir rename fixes
In-Reply-To: <pull.390.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910122035350.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4kiqUUxixEBOXX49VQScfAu2a/EcGrsYKsMQqrWyos41Y+HMSqs
 mG2W17V3Dubod0QIsgicG57OG793UzODgafT/luZPsXlnwcVBmPJowSh3PwX4wY2m4zIG8l
 2NxrGelsk/d7Qk7PTi1Y+RLmWaEX87XFA/pfHxVexbtgbOb2RL4Jo8r0swGCFlBb3DrmmmF
 e938OiI1Ohl9uhcnnOmcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wLUVc3xBbM8=:aqCSqbYvqMbr0vzt3WPefQ
 TUcPHoG72MHZWwOf3fEeBZjNQkojvf0EgC89dNLPLrKrM/oIh6vFi2vNDDusLWPm9Sjm87Tjo
 ZmYBzmjQMcq5XTaHHEiqVhbD+DGGFK95HtOpykKkzJ2rYn08g6X1iF5Aoaz+CKqctzGnPxwqJ
 PnIIFR77KT6CfpoPFfNb/V0kvhwXvF7ZQEtQVlt+pq1DTdtsdEvWa0CrgM6ICcB5R0lFZyWgq
 74/z6B6d8pCvm+AHXddhX/DSiYiagDnFmDKf7fKzEMYHPFr/CBQFeqTwwlpRLG+PovXSuGrzq
 89MiZ4eFGhAmm8wyA8eJcTTtbNl3fOlhBu4ytCzw1VRK9ZwITdvVHnEWFGHL58mnc7lvbQVhx
 35pA8jE5EA0u8yfgmpiQSkO3tFeRpPvw7mrhWrCRQ7Fhk/9b0Gn73clH3nxHc0pKjs4xf6M2l
 hAwgpJrpkEnj7q1qrLITECyFc6WKuKpGlwz+K4enYyaZtJ9y9PuCnCositaWc5xLTpjetylTT
 qwfV1G//ormMGbTPgAyF+e9aAHaDVr/YLqPaW8sVRPgePhJxEZnU47cU/bt3+ihvtOT+SHoiw
 hj15nMAI3SJOWW1zB2PAiDQJTTW6+cUR5aj7IVQN4xLzI+k9G0oqQmIZImn/rs3uvOayS3r8V
 +Nm435nuYCFVIv5oAhQrePp5zGnCLrSZkOwoctb3D20A4UIDYrTaG3wQyR4Nh/rkIh9/7YJJU
 4pgE9/y+x4+Y8QwqVpfXr1tfm3m9W9hKhPORaG0vgBDAzn1y4GfH5s6c8iYE7CmerQz9GbueB
 JPiMKBjcWyB05DCkuaZzff+iYX3/ue7mEPWlwO/8V/LDr1BAJHUvK45olN8dh2Vuiv7TCnrw9
 q089VFCkodcfhCVV+Mfh8feCy5MDcykk5td0+qu0lu9mK7bN9ULWkRh+Qof5dJemMwwG4GriA
 CstUvgyHD/SRH0Eb5f2mQA2iSMyh8gJ8AIZ1DENxbbIFtL423TbB/X0EH35WuTLeyDZMTG84D
 fp5Mjw8Ftxd+cUyakuAo8rdHZtrwToOtEgh2Qhdq5Gl05P87sKpuLij022Cab+TPfWreTD+sn
 dbp6C0oZyjX91lw77qcEaGXmCj1dA4t/BiE3K0EhxWBrLLBFpLmNo8k68N/x4Z1J6QetWGzQH
 k87TwmLO6q5xOEcKHuuZto3mVMX/1yEmqE64eyGaTpwc2qHtylC3lnPx4+bEXefCuueJq+8gV
 zOG2lrHKjeE9QUkqunyZ4v7KVVB1LeGiZw36dR0Qx6dB2sJRyYd87Fa7usX0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 11 Oct 2019, Elijah Newren via GitGitGadget wrote:

> This series improves a couple things found after looking into things Dsc=
ho
> flagged:
>
>  * clarify and slightly restructure code in the get_renamed_dir_portion(=
)
>    function
>
>  * extend support of detecting renaming/merging of one directory into
>    another to support the root directory as a target directory

Will have a look in a moment,

> First patch best viewed with a --histogram diff, which I sadly don't kno=
w
> how to make gitgitgadget generate.

Currently, there is no way to do that yet. It should not be too
difficult to implement code to pick up a footer in the PR description to
do that, I just don't have the time right now to do so.

Essentially, it would have to imitate the already-existing code path
that picks up the `Cc:` footer in the PR description.

If you're interested, have a look at the `parsePullRequestDescription()`
function in `lib/patch-series.ts` in
https://github.com/gitgitgadget/gitgitgadget/.

Ciao,
Dscho

> Elijah Newren (2):
>   merge-recursive: clean up get_renamed_dir_portion()
>   merge-recursive: fix merging a subdirectory into the root directory
>
>  merge-recursive.c                   | 89 +++++++++++++++++++++--------
>  t/t6043-merge-rename-directories.sh | 56 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 24 deletions(-)
>
>
> base-commit: 08da6496b61341ec45eac36afcc8f94242763468
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-390%2F=
newren%2Fdir-rename-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-390/newre=
n/dir-rename-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/390
> --
> gitgitgadget
>
