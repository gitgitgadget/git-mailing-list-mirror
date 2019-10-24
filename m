Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E0F1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504056AbfJXSYo (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 14:24:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39990 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437011AbfJXSYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 14:24:44 -0400
Received: by mail-io1-f66.google.com with SMTP id p6so22470491iod.7
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLMWHhvpgUt2idX0ww7c2d1MqH++6xG8cl03wLYvlKM=;
        b=DzLTF/HMP1RwMPtG/xD1D/2jjSa8MmcV0acca9rvSm5gufyagWAQSFIp8OqxMKPg6b
         EbmLwdbl+QOwk1xpSgVVR6R0Ah87JtPWj+HVGRYGnbB+lAV+zmNHv58MLu7ynUeaoWT7
         oUiFQOQWkEIo07gVG/kyQa1G+ykBa/p4pyWK0mcvZlAHf0R3QCCopVOZQ+A/kG+hf1Of
         Vl22g9GcLrBhT+FuvPwiMSpxA9WtWbNImqaz/44Jojdt7Lm1LMGgwH6XVR0RJtAPPZT6
         7QalfvZj05js9J1t/1J5iOzg67QmXYXyLPxcueFdu2sq3PXglTng1hWH9qAKcNPVU8F4
         aIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLMWHhvpgUt2idX0ww7c2d1MqH++6xG8cl03wLYvlKM=;
        b=G6yURZgKotH7x3NvKB0PHh4DSPLZ2ICQ7jVoOEFUPdbCgFQlFKq1F8Qmrq/hZp2SGl
         ga9ooDRNQNxHy8UJH9XFuKd4MezDB/wJ8aEvPx60lWRNbCVkkULerdpLwc/hszCWRq7p
         mSoXIVZHiNVEBMPDIiwYaKxXyoJ9QqFdUjxhtDHtu3ElH6bYhZUoGv2u+EehYoYM3uPG
         5udRY2C0jvqmB11B1GOGIC30nQizCiJhuEoIfQoM0S1lGYUyXv+afzI27QQ9vQ3HXUag
         RpDghPlw3TrGrNthQxG7ja2JYXanPeZVhPkM7sT05HDc4l1ELp7woGID16TWpwNs5q4w
         yhSA==
X-Gm-Message-State: APjAAAWY1w0pLyYcjlpysK9g3PRpYUuzmEkkVZ4JTcY4shyW1M5xvLL3
        ikbVpC34A5agvfMU03DuFUHQ6osYcWcJI2s63F0VAA==
X-Google-Smtp-Source: APXvYqwM2q4aY714n1o7DCnJ4rMo0lZr/YsWSoWqm4mcg472ZZiZLq7awDKwtmB1GIzSvtV79tH/cFVmUARIpZqBWLs=
X-Received: by 2002:a6b:f415:: with SMTP id i21mr10827222iog.109.1571941483292;
 Thu, 24 Oct 2019 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 24 Oct 2019 11:24:31 -0700
Message-ID: <CAGyf7-EyK0COjea2CPM7U5h6uekcFfL1eREQ6tatM3nQ21J_yw@mail.gmail.com>
Subject: Re: Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE] Git v2.24.0-rc0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 3:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Team,
>
> a couple of days later than I wanted, but at least it is now here:
> https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc0.windows.1
>
> Please test...

I've run both the Linux and Windows 2.24.0-rc0 candidates through
Bitbucket Server's test matrix (~6,000 forked git processes,
exercising various commands and verifying behavior/output). No issues
found.

Thanks again for these early builds!

Best regards,
Bryan Turner

>
> Thank you,
> Johannes
>
>
