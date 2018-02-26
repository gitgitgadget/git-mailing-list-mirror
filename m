Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8296C1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeBZLTN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:19:13 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34119 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeBZLR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:17:58 -0500
Received: by mail-qk0-f173.google.com with SMTP id l206so18576816qke.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qEE/GCmt1LKVBzxo/sRGPEGYo7EWPvqi9gjwoDoeJzQ=;
        b=oWuWTki4WKnhF4Yr+cmdXnGcWRN5cAC9efGLWK/1j5kZWRsPHEuQBuUTZsdu5h1oWA
         9X0dK8DhcSDaRpnzFgF37gsx1qI1cjQl6pptEmlx2QNkDQW5ui8fnnEsx7djBFOqLLdM
         C3A4XPJHFVQhcaqOl7peY8KiLsRGl2ag2DUCmkMM1npfzgIfMB9QseNccrYU9apxcuX4
         0mZCUR388R8Oc1p55KnQTxlo9Bv2ZLmUwfLw81O0jmeKhxLUoQ+6PWSlNWFre9QQ30B8
         XKQ3cjViiAoo05ei/WRW7tWD09JcbB053mSRGCWrzLPPismLvp3bPApeFZJFYcDYg85T
         d6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qEE/GCmt1LKVBzxo/sRGPEGYo7EWPvqi9gjwoDoeJzQ=;
        b=YoMnj+nklH+F5dh2AmgPC/K5DhHkF/nC77VdNUAb6c7TIxyLzCCUgP+BJATbyt9fdv
         0fBl/AMDMtVuzyhzjQgISKe04dQxrFg6z8Xzi3NH1jBI2lHsP/A1AxhhXVuaaHONcH/s
         WVZ22L+XYS6kcD/OCiE6uWmeCp0Q0uA93HAhB9HYCXLvj2cn5Jo4Nyul9PZjsjemFU6k
         0KHWmcFjP8YbPeJkI1fsAhyXQLV0+B4XFSEjLOMfStyAOjKTOdD8i1NjwE4gy/yHhXrO
         qd0k6LsN0GRncZJUbdKQ0+Prm+P+iQP0JRwHDzpl/rIgyluyb3sRABjeThhhkMru43/A
         aXNg==
X-Gm-Message-State: APf1xPBPrNRmPWUshQNcNuQ/GyEeqw7eT0FE0fRZAwQFrRy3jZTpMMSf
        RM/04wNCvtZOouhlUaST17zCwo1d7Nq0Gl0nO20=
X-Google-Smtp-Source: AG47ELvbZ9VvhPYgNE1lW8DK5MbAo9WiRqLL8gNwlRSO3UQbfeEc65O8Wmyal0S2GeQsxUaGYuPnj0JqUqlxAIVtOYc=
X-Received: by 10.55.132.67 with SMTP id g64mr16747944qkd.28.1519643877532;
 Mon, 26 Feb 2018 03:17:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 26 Feb 2018 03:17:56 -0800 (PST)
In-Reply-To: <CACsJy8CxvabA5+GF62==w6KSi5Vm+kLjs5+grPbWJsf_bfCT0w@mail.gmail.com>
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com> <CACsJy8CxvabA5+GF62==w6KSi5Vm+kLjs5+grPbWJsf_bfCT0w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Feb 2018 06:17:56 -0500
X-Google-Sender-Auth: zkifNo2TZCXFxWae7IUr6JObgv4
Message-ID: <CAPig+cRgr4MfHcPdhSpVNYpF2MQYC7u0phf91eSPZPEf1uZf_w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 5:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 22, 2018 at 7:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/worktree-move (2018-02-12) 7 commits
>>
>>  "git worktree" learned move and remove subcommands.
>>
>>  Expecting a reroll.
>>  cf. <20180124095357.19645-1-pclouds@gmail.com>
>
> I think 'pu' already has the reroll (v2). So far no new comments.

I've been meaning to take a look at v2 but haven't had a chance yet.
Based upon the interdiff, though, it looks like all my review comments
from v1 have been addressed.
