Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE091F462
	for <e@80x24.org>; Sat,  1 Jun 2019 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFAVWW (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 17:22:22 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46770 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfFAVWV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 17:22:21 -0400
Received: by mail-qt1-f175.google.com with SMTP id z19so5263202qtz.13
        for <git@vger.kernel.org>; Sat, 01 Jun 2019 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jR2J8yi1jz0SRs9eGYkwvLJ4/H98H8mztM9h/UsBRH8=;
        b=vl8q/6T8HxWUhzItU6V178QNU5qcYK43RhQpSn6Va8P/cB5zva0RLIdBzM/bLfj1R8
         g5GAfXHImm1mcdHP4pnwFpIWxFYWnPI9uotdabpnx27tHYMlvDXBqxH8w974uBWGE4zt
         5YUrxTV9XJvLNcYeWDVJGB9/LXwXminQ9vp6TDUeAxyBp/couDJlaFWrS5dT2dGj0k21
         4JvIWqWOlpRap6yC0ETRqoegPcv3eEyDQy0QwR9JcL06dGDaU3I2jbn6CxlqA0DwJpAD
         i02Xjw1V+czW7plNBcRt6WqQKDywYR3e/qr48ycy3N1EYX7t8KdFy1XJ1ZwHfY0XRzgk
         i3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jR2J8yi1jz0SRs9eGYkwvLJ4/H98H8mztM9h/UsBRH8=;
        b=kBcDk9IOkrCwGBiq724l3GTuh2eXE41mYgDS9eCPQo2+6OVRfx8kPhnYsnwOYrTz+W
         likaNjLAj025ts9PvdTTQBIEp4BwDoKoSnRvDzmrAaYMc2HJ9X+Go1EeqmSk3aiBZ13o
         dDxiqHPuGW0Io7UbT1zm9VxPU4K6mKu3bJXRAUdLqCbtjowYIJhyAZDLEnCuKTZexBmj
         aLVX+ZOXl2VUNp+xP88qU2iGDxYsHlLtsThwRMoFcGkX0KeFbm9wuzwovgXWag5ipV/s
         R7TlGJRuVp6Bv8lHu6+xJdD1MOZRBl268fbUI4sHbXZZi2MQQ7ITzavLeobXD644ZMQx
         Tstg==
X-Gm-Message-State: APjAAAXxVZigSHNdWWj3/HI3SqTWZeg2NFmcggdanA6sL9lVB+amYFZS
        2s2f+0l1TAL4Ns2iPZpvLpj13FSu1ODgw88ofs4=
X-Google-Smtp-Source: APXvYqz7kJlziIXbLNr0bCg+4YX6rIGcVjAAnpZirTHplWive4u7Lvs/UF5uqv8uJsFchmRJND+NoFdkOsRPcSnsO7o=
X-Received: by 2002:aed:3e0f:: with SMTP id l15mr16549861qtf.251.1559424140667;
 Sat, 01 Jun 2019 14:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com> <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
In-Reply-To: <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sat, 1 Jun 2019 22:22:09 +0100
Message-ID: <CAJDYR9QAWVJxn7cf1DQbnZTKeSGJPCXcTJT9FVNEDpf1bimtGg@mail.gmail.com>
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Barret Rhoden <brho@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks very much for this Derrick. I looked into it and it turns out
that the missing coverage in blame.c for "certainties[i] =
CERTAINTY_NOT_CALCULATED" was due to earlier code overwriting the same
value in most cases, thereby defeating an optimization. I've deleted
that earlier code and now coverage is as expected. I posted the patch
here: https://public-inbox.org/git/20190601210925.15339-1-michael@platin.gs/T/#u
I also deleted the other uncovered code that appeared in the same
patch as it was unreachable.

> On 5/30/2019 8:52 AM, Derrick Stolee wrote:
> > blame.c
> > 170072f9 846)     (result[i] >= most_certain_line_a ||
> > 170072f9 847)      second_best_result[i] >= most_certain_line_a)) {
> > 170072f9 848) certainties[i] = CERTAINTY_NOT_CALCULATED;
>
> This section appears in the following block:
>
>         /* More invalidating of results that may be affected by the choice of
>          * most certain line.
>          * Discard the matches for lines in B that are currently matched with a
>          * line in A such that their ordering contradicts the ordering imposed
>          * by the choice of most certain line.
>          */
>         for (i = most_certain_local_line_b - 1; i >= invalidate_min; --i) {
>                 /* In this loop we discard results for lines in B that are
>                  * before most-certain-line-B but are matched with a line in A
>                  * that is after most-certain-line-A.
>                  */
>                 if (certainties[i] >= 0 &&
>                     (result[i] >= most_certain_line_a ||
>                      second_best_result[i] >= most_certain_line_a)) {
>                         certainties[i] = CERTAINTY_NOT_CALCULATED;
>                 }
>         }
>         for (i = most_certain_local_line_b + 1; i < invalidate_max; ++i) {
>                 /* In this loop we discard results for lines in B that are
>                  * after most-certain-line-B but are matched with a line in A
>                  * that is before most-certain-line-A.
>                  */
>                 if (certainties[i] >= 0 &&
>                     (result[i] <= most_certain_line_a ||
>                      second_best_result[i] <= most_certain_line_a)) {
>                         certainties[i] = CERTAINTY_NOT_CALCULATED;
>                 }
>         }
>
> Note that the first for loop includes the uncovered lines. The logical operands
> are backwards of the conditions in the second for loop, which are covered. This
> seems non-trivial enough to merit a test.
