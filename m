Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA791F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeCZSoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:44:09 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34251 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCZSoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:44:08 -0400
Received: by mail-lf0-f43.google.com with SMTP id c78-v6so24977793lfh.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CkntvKLgF+YiBXf8mxZivdRCLL9aSnUIxUI3KpgA5v0=;
        b=HuUALEeWz16RDqHTN2vnnb4oleNDmyLhF9v3FlCzoNVm1UNHev1a9UMk+8j6GouDtQ
         dbmx09QrWzWHMCSrDgSwJPW/M1iEqeSQbcHuJtwhGvyr4SxPVw10WMi/6mr0VSDoywqg
         UF8QOaexuUSvzW2mQqCz6vNRXBaSIkqPLuXQrzk+ZY4k5Zn1nd4O/k5tIWP0l0UDTB43
         oBmr9laXVol0ah3J7WrAvDuUhA9iSNBmm5Dj7TBsW6gXTj1ABDMbZPn9yklNcIFkN15t
         MLTyK2W2sty83+8I+hDrijkAQmGHlUusHSYZugsRyJ+fc0Xr7xgCzDYiG4/yzaz6lf59
         wsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CkntvKLgF+YiBXf8mxZivdRCLL9aSnUIxUI3KpgA5v0=;
        b=QRhCNnbtUgdoSqTO5Xo/nHEGEHlg+WXyYsli5/eVbivFbDDWWknVAqC/9Qd2ZrVEzO
         VEwReBWtprm5gY/7A8nJlzDKl9wv4D+38dgBe3WHeC2QMrUAzaWvtB0TSt2yYHm9eYll
         9LyVF94XiioGFHhgLiuF2b93rjqiIZhEA36CXqpYVz6WyXztmL2bJhBIi7dodQAvAYxG
         XIDjMp+B/9Tk7yWdBc+QqE6Jux0bM0AwVkcu0X1gKkHBgOpnLA9yhVUyYheJUOPZSYhv
         r3m18vxfNReHqnPzqjvMYgOSoPRHi3ir2uaTCo0YAE9PvC3tIWZnAXSkElEa78QQccAC
         fcEg==
X-Gm-Message-State: AElRT7FURYvRTxs/l5xa4/1r1KTY1LUzGmLLM1m4UA6B4/DXDZb3bvp3
        60jH+B89B+dsPm/buzhhSDqbB2ENy7d4fDi2cVN43A==
X-Google-Smtp-Source: AIpwx48bj9T4wT1UqoKsjixBOBiYCeFVJOSSK+Z/HbGXEBeU7yIydp06U+gXkY/uJPzDNhcsn09jXaqcRIfCgkHnIn8=
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr8781789lff.45.1522089846910;
 Mon, 26 Mar 2018 11:44:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Mon, 26 Mar 2018 11:43:46
 -0700 (PDT)
In-Reply-To: <3d845e99-e392-a62f-b83e-33b58482fc54@jeffhostetler.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com> <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
 <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com> <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
 <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com> <3d845e99-e392-a62f-b83e-33b58482fc54@jeffhostetler.com>
From:   Wink Saville <wink@saville.com>
Date:   Mon, 26 Mar 2018 11:43:46 -0700
Message-ID: <CAKk8isp_qx1ajgRryhBw6TYBoaa8fJU6hP3JyUWAx20knQSLXA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was just going by what the reported compiler error message was.
> It said that "unsigned long" didn't match the uint64_t variable.
> And that made me nervous.
>
> If all of the platforms we build on define uintmax_t >= 64 bits,
> then it doesn't matter.
>
> If we do have a platform where uintmax_t is u32, then we'll have a
> lot more breakage than in just the new function I added.
>
> Thanks,
> Jeff

Should we add a "_Static_assert" that sizeof(uintmax_t) >= sizeof(uint64_t) ?
