Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8569420437
	for <e@80x24.org>; Mon, 16 Oct 2017 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756818AbdJPTAN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 15:00:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:52272 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbdJPTAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 15:00:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id b15so14138260qkg.9
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jnM6AFIhNrsLmbThwoIcTLy1lFbOA2kxnyuQgrAkikc=;
        b=V79w+FT6H1uFJVDMtJv8BQesmxTE5NZZqsloCyc4/j9qmv2sJXKZzRmScy55gI9gR3
         hVoOyETuFqoJ3m3WuyeTw+PbNGabydjGsj5geFikidBGJ7FA3YegiPoFiRUEkirbgOaW
         OddDp2Vs07xoRiTAMtDZqcgyfEuCP49zMHIDXyGZ1azGpg6dM1JZrm+Xi6y6Gy49+ICM
         dIEtx/17NU1xg7g8gOSBq19T78pYY3AP9ZePVPMz7eHHmmHUg1sTNXwALtsl7pDxKV2/
         9ZXlFGY8j5afJwq15NwWwE6H3XnXAZWkNx0IQym6l5fjykbVZ2fEbY7il38BalCfBB2n
         lsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jnM6AFIhNrsLmbThwoIcTLy1lFbOA2kxnyuQgrAkikc=;
        b=siJRI3OcHMKlPrJ1m0yWxOapgPOb6mf7HRMLFSvDPYYSq5pJNPfLX+9LidwqtyUjKj
         MkR8dznMxjEXp54f2kQAEhpoC38mq7xNyowJBA9FK49WZMuUyWCbSI0ZylEb8/XoVHCq
         ponoTBqo8YUWva+fuLLTAVWwXnZb1R+Gw0Bdrf8/9ikHeE1x60I/4MeNkv3tg4U31HX8
         8f8K8IMJGWRHW/AC+V56Cx6r0EoQVgeUJUI6Y66FBRANz/lkAP1Ooh0ttizk88tzIkV5
         /9H7zG+gS+NolU7xCqRLXDeFtKxgwT3P4ouPtV12/mW3Q2FvPmQuwZHc3ctPpsVpazVl
         S3Ig==
X-Gm-Message-State: AMCzsaVEsTzqn3UVML0MW26ZO99cQFunxIqI92H+a9+Zd9mJcQb3nNEl
        iy9KAG6VExhw1x6BZLIaKniY95CdS/BSY06aZK0=
X-Google-Smtp-Source: AOwi7QDg9ACmvvlVXmy4Cz5S61qF8qByMWdyfK3yqy+vqGGN4vXFZcGmPiWxzsJqxV3r0SW2ZXI/ZP+KQPvSyDrKb4g=
X-Received: by 10.55.16.220 with SMTP id 89mr15629271qkq.286.1508180411329;
 Mon, 16 Oct 2017 12:00:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.47.238 with HTTP; Mon, 16 Oct 2017 11:59:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710161254430.40514@virtualbox>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de>
 <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com>
 <alpine.DEB.2.21.1.1710151710340.40514@virtualbox> <alpine.DEB.2.21.1.1710161254430.40514@virtualbox>
From:   Steve Hoelzer <shoelzer@gmail.com>
Date:   Mon, 16 Oct 2017 13:59:50 -0500
Message-ID: <CACbrTHcwjGLudp7WQta2bs_kitquj562rLqo8LAmRF5+d_RE=Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

On Mon, Oct 16, 2017 at 5:57 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Steve,
>
> On Sun, 15 Oct 2017, Johannes Schindelin wrote:
>
>> On Fri, 13 Oct 2017, Steve Hoelzer wrote:
>>
>> > On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
>> > <johannes.schindelin@gmx.de> wrote:
>> > >
>> > > It is my pleasure to announce that Git for Windows 2.14.2(3) is
>> > > available from:
>> > >
>> > >         https://git-for-windows.github.io/
>> > >
>> > > Changes since Git for Windows v2.14.2(2) (October 5th 2017)
>> > >
>> > > New Features
>> > >
>> > >   * Comes with Git LFS v2.3.3.
>> >
>> > I just ran "git update" and afterward "git version" reported
>> > 2.14.2(3), but "git lfs version" still said 2.3.2.
>> >
>> > I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.
>>
>> Ah bummer. I forgot to actually update it in the VM where I build the
>> releases :-(
>>
>> Will work on it tomorrow.
>
> I'll actually use this opportunity to revamp a part of Git for Windows'
> release engineering process to try to prevent similar things from
> happening in the future.
>
> Also, cURL v7.56.1 is slated to be released in exactly one week, and I
> have some important installer work to do this week, so I'll just defer the
> new Git for Windows version tentatively to Monday, 23rd.
>
> Git LFS users can always install Git LFS v2.3.3 specifically in the
> meantime, or use Git for Windows' snapshot versions
> (https://wingit.blob.core.windows.net/files/index.html).

Sounds like a good plan.

I think I have successfully updated to LFS 2.3.3 by copying the new
git-lfs.exe into C:\Program Files\Git\mingw64\bin. Is that right way
to do it?

Thanks,
Steve
