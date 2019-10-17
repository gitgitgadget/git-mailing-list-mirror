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
	by dcvr.yhbt.net (Postfix) with ESMTP id 688321F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393046AbfJQKXP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 06:23:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:48185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfJQKXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 06:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571307785;
        bh=cZkdGlrHapfPj3NrsYMB5e5PCnf7fLkRCoZ5k3Os+0s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H/uedCRkPt7MsdTeEcqssXfXKD0PiGL5XN2TZL0QR1JWDFlxeMegcnL12HR/8oNPi
         r8OPaG4tikoaDS5ynqHmZrD6k3riFRFxnJ0J3kMYf7PDc+zM4h+pi9U6cqkRb6Um6O
         Pe5w0gHSU/4Hfh35yHv7s1eEK6fOrg8yM/qNIzJs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1iFbxl2oxw-00GWO0; Thu, 17
 Oct 2019 12:23:05 +0200
Date:   Thu, 17 Oct 2019 12:22:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] ci: update caskroom/cask/perforce to new location
In-Reply-To: <pull.400.git.1571160721.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910171220300.46@tvgsbejvaqbjf.bet>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X4hLDgCX/GGy2d2XOmhi1lORZ+G29V4z8qXxnXU/ElAYlias4/u
 dmnu02caYOnFbBVyOIPe3V74Fcs6WMvawKCVittruWghIGZRFxqGJtlv1NBS/z6mF3249PR
 Hz1kb9eccwlou9Q1aOr2x74ztM1gGIY64zY2A/Thtr5zdtap1BnYP9dqPCb23pzyv71UPaZ
 Rw1/IiB+6ZR0/qcpVcxEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nnoHp+hdZqs=:2O48GreQzbQp285TvtyXZy
 sxVWFO7ZcK2bCxAGesxtXhg3ohLhHYyM/skbHL8ReSjAfGcCLmaBErMQ+1fuCqQ/UK6dnFPOY
 T7+iigjuKKxDcPoqNBmHiGABzdNuMjLfi8BOR2xvKlIbN6YdzvFV6U5okBKd/k6WWB168Yl1Y
 Br3A/8ehyM8uD9sVhovIJKPoazl8CODHFikLLBn/jaOZ12OYsLY1Ivzq5as89UWpsTlcFD8En
 X3CnFY8uOm1dHQjkgRGUjRGtwNdQFRFfLUuXV6QJ5+EZcPlU8P/cLyQLYPGydqxphR1hGTQvv
 wg01eRaFI5jCZTSrshptJvfn5zWwArCuz1X/V1n+9s2cBLH70DOuUO2zspWo9c0w37BKshnnc
 AONl9uulkpxTcV6yOE9mCmPv9sCKTYobKvEoMcGT6cl+otdjui0yEPqpfoFlurHBa5YIZ68Mq
 C/MkAQLA1J8do8zq9KNTu4YFMk4G6/ijUrCBv0Qc1octxWkvqSFQChcuWhYcK2Pp324ljSrfv
 KJzwFSiIwko9skOsjUBhcgKX6QTa83YtjTiiMLcxT/2Yy2SbhZSG+pKDc48ORZYXQDSBz5VGn
 Rp7xhDMR7KC+aPe0XQWmJyhs2b0tm9Wk4FgLdcsyK33mZLO0l+p3czgrgqlZ0tL5z0JUpKD78
 IW6dzt82STDXs+17Sau3Oc17IHSylm25puudpqOap/Q5vlOuIRRNTngx1oXVdn/bLSld3oi0b
 4f/DHhHcmAig7dQ5KGaSTinpJpgR6Ggxsjdod94Xbw8hANW2Bi5kSwn8rTzVYbW28uSp4Hi3x
 SKuYgC5jXI7ZBa3WQlGbrT4QAgclXyRoRvXyJkh596XD8txf0/8gYaSjhHWAJx8m/Zq/uxZk7
 wiOTKLARloKVhMDFGoPHBpFUxrlJH6FDPFFfCj/t2ZKUPw39RLSRXwN+y0+2iws4F31TrCP0t
 z6HTViVRnTFPqYgGO3L9jvN3+z4Pb/FeyPKdlio9MBeuaup1rg0O+2yy/AijQaYtodKJTcJw4
 Yx0vUjEd+3vpbwmRSsfgz6gaRsg05pMjl899PD1F4N5w8HTcA3TBgf8srgeNUFY5ZyHCul2tF
 S4+O5Hy3BbMJ1zXbGxZk1Xj4G6F1ZEpylOtm9LuBKEwzSR6rSRhC/9kcFTZP+x5tb3wNudcsU
 FMOG8FlPnhdscrcirQ/TDSDsMlrCkWz+gby/iS7cKgHtgmOBNmelfhCep1LGX4c4GYigkA5qo
 CbfpHrlSdhdNvz/dC1kbQWZ/aivHfXnELaBOG1IyVlvpxYqzjLj2U8ueaHfQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 15 Oct 2019, Derrick Stolee via GitGitGadget wrote:

> Running CI on Mac OS X in Azure Pipelines is currently broken due to a m=
oved
> homebrew package.

It seems that the exact problem we tried to avoid by staying on caskroom
rears its ugly head: all of the macOS jobs are failing in Git for
Windows' builds (but not in GitGitGadget's, which is probably due to
differences in the "up to date"-ness used build agents).

I am investigating here:
https://github.com/git-for-windows/git/pull/2359

Ciao,
Dscho

>
> Thanks, -Stolee
>
> Johannes Schindelin (1):
>   ci(osx): use new location of the `perforce` cask
>
>  ci/install-dependencies.sh | 1 +
>  1 file changed, 1 insertion(+)
>
>
> base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-400%2F=
derrickstolee%2Fci-caskroom-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-400/derri=
ckstolee/ci-caskroom-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/400
> --
> gitgitgadget
>
>
