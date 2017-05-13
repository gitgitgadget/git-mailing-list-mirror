Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234F820188
	for <e@80x24.org>; Sat, 13 May 2017 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbdEMNWy (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 09:22:54 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35379 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755245AbdEMNWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 09:22:52 -0400
Received: by mail-io0-f178.google.com with SMTP id f102so53354457ioi.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aqJgcqKZWcMMqwjJ2e0kZxnToIPvaQmfd0jNCZEhaNE=;
        b=hplgPtPHY9zkTgpG5ke4Bc0600MlZnDibVUWFReLLZqotMTdDp2RlpwQaQ7QDP13S5
         jTgV9t7rULe6ZFlKlooQ8K7f80aFsOzFyZGWdW1xUKDfgA8KV9AIgvXZ/mnS8jUO6JjU
         n+6DUsX6hMF5CWANqRtP0vsuIaQg/mYJscXTmcE0M5C6i7WLoPZflaaBG61E/N9g5BKk
         EKNIb1YXJBPsQ5Yyo8kSTSs3kYr7TCphNgiTZvGIqfYWRlyTbk3UJjiTNXcN/+HGu6VD
         KbyapXX+pDeBonYIFyFMqFJiJyB/OQeUfU8bnFrNn/XOOMwnxmSQrdLHoS90N46GjW0O
         /GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aqJgcqKZWcMMqwjJ2e0kZxnToIPvaQmfd0jNCZEhaNE=;
        b=QtkH5BSnZ9GPiU0T+7r+q2lES3DhpXWlkVcmnoV1S2czSrvRPPoCb6mN3S3Fo1/EgS
         SPC+1j9DU50kd4Va02PtymbMRz6lO5pitLRZqX49tN22TMhV+bBy/d46uaJl1Ri60RS4
         V3oTkKJVTYLrVFxLF1ffdR08e5tS9P1nM4UnrNJ+Ps8JdlDXB0IfBUFEe9hiAihJuZKw
         AblI39zSElWjqFxH+stUQbsqY9H7WR/3+HMr/Yg3tYp9r1ltI7WZeIgPOdOvEaI9ldkm
         oacJ54Wr3WvTmlaRzLbTWdW9qkE/vV3rmPLJaELJbY6NUneI+7tGdI3+X7BxFT9UqkN+
         73QQ==
X-Gm-Message-State: AODbwcCmFFF5tUYzbOGbNuqB1NyjqLxh4ESNLVbL9ex8K+ohsw6PPlYP
        bkXEbkskQ5RE25hdGhYTrmbKJl30rQ==
X-Received: by 10.107.178.12 with SMTP id b12mr8342240iof.50.1494681770943;
 Sat, 13 May 2017 06:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 06:22:30 -0700 (PDT)
In-Reply-To: <20170512234414.GF27400@aiede.svl.corp.google.com>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
 <20170512234414.GF27400@aiede.svl.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 15:22:30 +0200
Message-ID: <CACBZZX4LXkCCkHTaEw5YKsVHFcE6GsE3JRzLR5gd56DxGHxptQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 1:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Johannes Schindelin wrote:
>
>> On Windows, `(1|2)` is not a valid file name, and therefore the tag
>> cannot be created as expected by the new test.
>>
>> So simply skip this test on Windows.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I wouldn't be surprised if there are filesystems used places other
> than MINGW that also can't handle this test.  Isn't this what some
> tests use a FUNNYNAMES prerequisite for?
>
> In this example, it's the pipe that's not allowed, not the
> parenthesis, right?  (At least I have some memories of naming files
> with some parentheses.)  Would something like
>
>         test PIPE_IN_FILENAME '
>                 >"a|b" &&
>                 test -f "a|b"
>         '
>
> work?

It would, but as indicated upthread I'll just amend this so the odd
tag/filename won't be needed, since the test doesn't actually use
that.

(B.t.w. I meant "[odd looking] tag or file" in my last E-Mail in this
thread, not just "[odd looking tag]")>
