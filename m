Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA471C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC5E2086A
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TLXgWM8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgICKP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:15:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:58661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgICKPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 06:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599128122;
        bh=yzCv5tiu4LzU7hoFD/ZfJ7w2tk9Oe9XlEjLxZy+eIJg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TLXgWM8JzHIQLJlITbWcmVLdvU9c5/y/KYe0ZXXTVhCswdEdSPuUoOWnRR/mJy8HL
         VWK9Zz6XOTl9Xl0ph7Zy9imqKhAoTpYGaOI8/+wLRMlQkkSBfNS/rT6p65KrLhUSNZ
         sg/BJAZMrvGFt+TxjUlXwnAzybWankqmWc1FtOpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1kJsfU1Yyk-00EwEL; Thu, 03
 Sep 2020 12:15:22 +0200
Date:   Thu, 3 Sep 2020 03:50:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] vcbuild: fix batch file name in README
In-Reply-To: <pull.721.git.1599077900986.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009030349000.56@tvgsbejvaqbjf.bet>
References: <pull.721.git.1599077900986.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bL8oTHqKBnjNlve77jeHtSuue3vDCjqCfLusEVBHOLztvyzypU6
 ddgREwwfTu8rCtMXoUSNxEBjE6T9TTdMDRYLMka5R0uZGtt9TbI2VPzJznHj8S66D5HwJKT
 Ai01+1xTZABLlFcltpDZuvndgYkeUKa/Da5O1r246cUhUxSSKuITLjV+QH/i0uMa23yereM
 3G1CN63Rm8c6WkBytrg2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XWV7ASPMBv8=:AnfzeNzqqB5B9GVJ2+HtQO
 /vTGu+9LER/fKBkFJJ05Ioo5+H0u1YiwMFGaVziR2j/XMNrg39STZJX0yGukfhH2MeVrSDhIf
 LeO8/KOxOSZ1o7Fn7Tvq140WPmB748EuIiXyuOtnKSTLGYxgdkm9YfpHbgqcr4/HTYUtM3Tq9
 HHZvFEb4vQkyx+zW2RtBHUwK5/IRn1EEPP4VKPJJpK9r2inFZmTAAc+iNGyTsNkzSUHb2JygH
 OXl7P4O7WFKuawppxo5Nbe5IDgY11rMAs5yUqUOlIl1aiHh/chngipiTdzMQsbZD1+BObupAv
 OCYb/kr8Sf0Bn9jXALzW8gcbkwx35HozO1q93IHB3U2GIbo22w/xTWALYlaTS8+xxm5Ywn/RC
 HsfQyehJ5Fkc/CFaDdQ8RitfaQbdPWNgvCTEJ0VZrPDf9is51Np3DVYezJVk8dDsrZXOyn4CR
 Uo7gwEXtEfXaNe7jUdV3TxZgyGlNWtL7Hu0jj3fsdejyck57a5Nm7ZWn9Tm2nEC8+ZR51+lgr
 5VtBbDbt0/Tgoqlq+MSpvYiH7RJZgPFkJ8L4Iq2fZL7hnrspE3Je5cybtp2SIFDMqpxxCUUzH
 lLxkRcWdAvqWeHVIbE2wh/r+isYSpEfqRCcbJjhgHgkiZmDMkKPto+bijgI2W9VdklJm6JB4+
 KxZM/4LHyb9boSPXaGMAEwJgmHHVw7n7KW/oy81waWIVg2Xn8b0uNjQ2lmiGa8bcd9nyPJRni
 j57ypdCR8nkjTWYkgiLDIw8XxZRv0wnd16cJ2qE8lmUuTfUv1FHrz15LZMA+myFEu16PNpPLF
 SMXI76M64dzIoyyFvMcs1aMurOLrM7W8B7S2qyALBgnafVFTjJObv542tZmGfzWobJZC7IPlE
 5Jy2Qha43kIdL9CGvRpVSDJV6oOaqjJochjOJyBaoKu0tRB2SoBr1seMR97SlWxBB7Y5rnL1a
 apap0zZkR/ciJtRSOef4hH6s80dgOE2F4gNE7yEUu1HBL0rqqWbRhc/gDjpJ1jLwRpHKpjeYw
 FLuLAoqiCYH2Ng5MLDUlYez021vc7iAGBMfPr+UpUGn8n5eX09gsY+mEobta7xuWxNPTt9wqF
 6uXlfE9Bzgdj7I2p9o5FPp++DOhiBUws2xv5tuXZ09ydN7mkGgwrd43KPe+brL8E/IcNNaEX6
 49EMADaPI7W2DriQM5ehuM9AXMySVrXN+b/0Hsar5mwJt5+nb8KRjIxHfWKOKnyrAeCWee8eY
 YGkU2MIQCR2J4crcScil8V4BLlDAlWC8CMyBkLQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Wed, 2 Sep 2020, Orgad Shaneh via GitGitGadget wrote:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     vcbuild: Fix batch file name in README
>
>     Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-721%2F=
orgads%2Fvcbuild-readme-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-721/orgad=
s/vcbuild-readme-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/721
>
>  compat/vcbuild/README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 42292e7c09..51fb083dbb 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -26,8 +26,8 @@ The Steps to Build Git with VS2015 or VS2017 from the =
command line.
>     Use ONE of the following forms which should match how you want to
>     compile git.exe.
>
> -   $ ./compat/vcbuild/vcpkg_copy_packages.bat debug
> -   $ ./compat/vcbuild/vcpkg_copy_packages.bat release
> +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat debug
> +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat release

Good catch! Somewhere in my refactoring spree, I must have overlooked this
reference.

ACK & Thanks,
Dscho

>
>  3. Build git using MSVC from an SDK bash window using one of the
>     following commands:
>
> base-commit: e19713638985533ce461db072b49112da5bd2042
> --
> gitgitgadget
>
