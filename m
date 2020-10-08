Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16CC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6A21734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="alVwwqrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgJHIzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:55:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:53355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJHIzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602147336;
        bh=Kac3I5I11/CgAtgyMXzLhlhigb6jmiMxyLnr3aDkg+M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=alVwwqrkSj2tgIe+1BbZd/pdO2QDjSG3acW05Azf8p9bLU+LqlLU5T7/IEuoJJFU6
         9UW8tDXZBInk0XF/uIxF0YGCFnLm+wlJp8nTt4hWtNLvbYVc+4S6VyCJxiMqHoVk4p
         RUVtGdYUzbFsX3bEf8/elvrRQ9bPRCB3tnQ6YzbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1k9y7Q034u-00GcPA; Thu, 08
 Oct 2020 10:55:36 +0200
Date:   Thu, 8 Oct 2020 10:55:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.29.0-rc0
In-Reply-To: <CAGyf7-Enk2Dk2gzGssW+6FEQe6vn7PazyEEJMAQfRzULQ1cHqw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010081054250.50@tvgsbejvaqbjf.bet>
References: <20201006092535.6419-1-johannes.schindelin@gmx.de> <CAGyf7-Enk2Dk2gzGssW+6FEQe6vn7PazyEEJMAQfRzULQ1cHqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F6KW8gu9gSSle8HZQmSRhX+Zs00zfhRPyghRb376Ju2VQ1HGQgu
 KrNMpNWP1Lk+39xIx+VW6AigA20EAIO1si8rA0bT1pq+88zR/OKWa89m8BxPRUeFqvG36X1
 ktTLPYCfR2Rwc9lGHXV4TEnO/YOHM9ztlb78Ft2c7h9NdbCwjl3k5hQtFTOtL6Cb63XIl5l
 eZ27knyw2Mp2Fb5cSnlzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:slCQZuXBegs=:skF+ZfcV7UAeErII2mYKfh
 CftmJpz9JiT2ddj02/xC21xb1+jJTly0r2YU7/Qfw9UUzyFhpTVLyYGhd8iFe5S7xHCiw9uit
 ArgGHv4Irn4nwAnzvbsNtTpngcITgaoyj4XAV2fY5b0adQsTsIHDNxNCn6dF9I7qwKSFmqeBe
 Cl/HdcO442MXMQOI5URe+DWVsMWSBOFmNWsiCqzadtFiitu3JWtFSMGB9xlnayVKwMRFEIpks
 mxdRsF1aMzYbYFiHGGDJy4dllhzq8euwLBJ4J8vptNa+cWC8LR01b3BYoBRsodtumZSNbZDzL
 FLkli5gN/9PKrfZrSp0MNFf3dlpBX0vySCu5zny/EqftzayAR5leTkWlL1w3SQxLvDD/vRHYP
 I1LvUrxqBfs45U+mpZuF0KIFqlaevCL9SHOAF/GQSVXe7nAu44CQRxlwJ6Ru8KDApZkIMjD+/
 GpqqfWVpbFX6slhNatDy9QMo52LzdrIqrWLyKU0EfgcDbB2Yn1jRTf46noRDqjOcdApjPsepz
 GcL/YLHIclS+Kv9wYwZOvFxRxWCX9tsl+uYizOJWnS5OhNNxqqFTYs1uVR1JzEZnzb+B2KC3c
 62eW/dRmcNDbM3+wNHhMlfEYw2skxCceR2Jvdi4OUh4w7UBHlG2lxf4UtC281v2CDHGb3S/E2
 BR8t0HlbYKQ/GEKyN42cpA1x3MKPNqbNs0AFs68qo+bEcZBYwtvLS/WmEpCwsk4c/0oTHPMOM
 odnJ+AOLNgKQwx495lMQgkDZgLF2h4SIacB1SbpYeQogFag693/3BHn6k0BEAEWCRQh1yy40A
 LkNZ/kCBCTSVdymd/m1q3uvd3DkoqwBoYFBET1KuQuUqyIcMzatqC9mINhZy3C+rQuxzaHzvP
 jd4YNwAhf3/6KI+gUNVSmcFsCGr6LyGxH/CTUo6P7p4e/5zp3fz4t3TjzUWFZ7t/9TTbqSkrg
 276lxA1FSo42I6YYRaDOTqn9y77Q1Gkzb4BjYSxVWYY7/tQVKFKSfjsCPF8caS5JZHrrQjVTb
 WaIVpJSP3ln573rRcHsNsTStwdJNpfiE+oDBYpnG2S4cI6T246LavucZqoesquldOAeTKjli9
 zGQlXWyMtY6SHwCu2SPhO3aw688mxEjv/gWOudPMkSjWAwbl7iPMycoGGWKrcKbsg5rl7SR6s
 vyM4LaiX9mp6Rh/X/XPzwxinyKZet8hcG0LQ3AIRyyokvMHpBmaxaxgIjsPKD9SlScHeD8HET
 RRXlxBSVnaTajEanqHtEYacLMkXxZyXQdclLNmg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Wed, 7 Oct 2020, Bryan Turner wrote:

> On Tue, Oct 6, 2020 at 2:25 AM Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >
> > Dear Git users,
> >
> > I hereby announce that Git for Windows 2.29.0-rc0 is available from:
> >
> >     https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc0.wi=
ndows.1
>
> We've added Git for Windows 2.29.0-rc0 to Bitbucket Server's test
> matrix. No test failures to report.

Thank you so much!

Since one of the biggest changes in Git for Windows v2.29.0 will be the
automatic upgrade from GCM(W) to GCM Core: do you override and/or exercise
a custom credential helper in that test matrix?

Thanks,
Dscho
