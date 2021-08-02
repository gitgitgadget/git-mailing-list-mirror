Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADAC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E899610FB
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhHBUR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:17:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:34403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHBUR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627935463;
        bh=fYgzGOcNvgXeNwt0dS6vOXW7TRVUyk6J5vEVbh6RGKo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DB6jUpnKio3nn/Ee4q3PxRcfR8b/bjiKdZfF665L8vXKCYy9Pnyl47rcrqE+488j+
         3Y+mD0IpVAhklGh81AyJkK/UVdgRnqEscBcoG5zlTkdHOfq3TdR8ecLl6lcKnbcPaz
         Lzi9Bn9cZrzCv6yW8n8wyKd8fUEEDX4hGb1a9XgM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1mlufg0xlv-00bNRl; Mon, 02
 Aug 2021 22:17:43 +0200
Date:   Mon, 2 Aug 2021 22:17:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: align symlinks-related rmdir() behavior with
 Linux
In-Reply-To: <xmqqo8ak51mt.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108022216590.55@tvgsbejvaqbjf.bet>
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com> <xmqqo8ak51mt.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QSizAmhFevuK2YpV0FZKH6aPs5VjefyCJ6tiVl7CIUjXnUltRwV
 bWYKUBrgz6jIFLpNHLZpFE36x0HBrhafp6p1G2L0HrPnrAS0c043Z/tEOfzkohuL38EbEm6
 XjIG0j5KPCEMEBDj3JmK+JZmlxD71CTSadCWsI37KTVED+scdyg+JIKJzseIBSRoxR605rV
 y6gHMelmZVqauunN4Q5gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DiW1WWhZPIY=:IBy0HFZUSQGKlg9bCtzbuo
 qy+e6PqAAhzib/2T61vymhgHPbjlbmBvxrgTebVKi19cohOiv4TOHEbqZN2R96ggaK8mTqpd+
 WKvtoZMnef2968Q7dygZ3HdFXy67Rp9EI0VKDrjDb7s74vF06pL67fOllNbQLjSNp14XIkuHX
 f3hVS1zGSMl3+5s3HtTULP+EeVc0I5bqpJtz7NJyWVISgCX28bUMfb5CaGZdyYPZ483r4zbbe
 wuM1wAfFpIk+bp1oHCE0d6RE9ymBUNihiMpJ/BlQXj7dzfsy6AcLQWrKV16V6BAME7SVfJ4VA
 lZv/n66s/dq1+iPv/KPRTZn9GkPjwR4juRYvHjrBXclq+Ct8+QP1CdC6+hKllff4AmRA74HDv
 wt2FOBLbKE5poVTxNs/RyvuFdzsWo8yiXYOE0X3Q0CbV/Yeiwml64trxb9RZM4D84p0XAibra
 VHqOiusEx01yQRHQt1E3lOuAzIebcuwx2a8Y0l0XNQCXR8fOgD4WpDd3dXXRHsgMIUiNJ1LAc
 x3DjS5WxMFN7hn+Qi5hkhI3y0BoXrKVRstxSGrIt9bMaNlLNkLazQC0KtmPEYm/gHag9QRPBI
 6Lgv0rBmdJ1gTAg4DPcW4aczFEi0DbhAYIjRnD/ND1bRh7jx+eoTzrmfFU0A7OaZkCUNHuxHU
 M4c84Af2fgRKWRITfSV7uo+EQnR1nVsNOVdR6zyfpjfqRycCnGrsarWZDjKKzmzHnUTuqJLyG
 YpqSn7coWQg2Y0QJMB8XSZ+edEovo1wZ19N6Lf8SNJd6lEbs9kH1NbmEgiB1u10rxaaD3fkZz
 act4uIkA2C9d2G36JH8WbK6X6/9ISo7Fw3nelF7CqaEfegEVza833U6+2JV4LG1nMkfJWYInF
 V8oj1uNSfRvyZyGnjzElkIX+6rVL2uFHcmLfzZ3UdqqjDQODCUH+F7G9z9tC7/8PjEV+0YSiB
 0rin+9jdfCnm68UrpkmDUpqZvoLNr734QsRUZh0qOzVieQ0UFs77iWyK2nUVI7hW2eRPBISCv
 2tSE348vIK+wRHwrbMTejInHvsnkWlDrd8OYnIP595oR7M6hgy6mZj5tQpqkNJEyOXVhRy3kt
 buwWyM2MY9nBXXI4Iq4JMJkQPpRyK8LqQySMCr4NYZCsl2xcdXTSLS8dw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 29 Jul 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When performing a rebase, rmdir() is called on the folder .git/logs. O=
n
> > Unix rmdir() exits without deleting anything in case .git/logs is a
> > symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
> > and RemoveDirectoryW) do not behave the same and remove the folder if =
it
> > is symlinked even if it is not empty.
>
> The distinction is understandable, and I can see this justifies the
> patch really nicely.
>
> It is curious why "rebase" causes rmdir on the reflog hierarchy,
> though.  It is also unclear if "rebase" is special in having this
> behaviour (and if so why), or just an example the problem was
> observed with and other subcommands may benefit from the same fix.

I augmented the commit message in preparation for v2, specifically to
address this concern.

Ciao,
Dscho
