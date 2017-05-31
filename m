Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43272027C
	for <e@80x24.org>; Wed, 31 May 2017 05:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbdEaF6a (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 01:58:30 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35871 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdEaF63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 01:58:29 -0400
Received: by mail-pg0-f46.google.com with SMTP id x64so2927759pgd.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ZsTvaYUW6sTcE8845p791CUvGlOGEnPJfOdBmeloSw=;
        b=gD06ZqyQahMzSq2jtjxXjXrBTBT1kYNYhY4b8LSLtptazWpw56WDea0LNXunPgTJ1e
         n4H9wXJrCCtyrQQLgMuW4MeCKy1RAcc+MheM9A7iObvaW8zcCwC88UnoWzid21YXPFSt
         KTdoz+Tzfa/wIWXosp4yWuW9FLQdaJ35yzYLM0I19TUUEh0GHguTR5nvlUwIYpvM0X6f
         s6GbtdrVpQTixvVFTBFWwotAP4zB/9tAL37BrsGLLwMnOVQ1goFjHi6kuBvCu/bBX4Q4
         208Kp5nEUhoQWht9ixsnfrlS89P79JiMcOmnWxseJiKaCdTMosZUyPzSw2iZLac3KzlZ
         1MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ZsTvaYUW6sTcE8845p791CUvGlOGEnPJfOdBmeloSw=;
        b=M8CIOr2yGQKhs6/v7yStZF7YwwAUIh3XoPzH/lXfs7Z8BH9xQotNOMBD8AiAMLbBNe
         tGwTI446RCPzU98WS0SnD/OSChNc3LR76FEc1Hpk1r/q+sNzItBPRf2kBL1iq1yts0iL
         i72MBUZsQkN9IOmHP3RylFxBBk69Okl/0u0uT3yXF5B1D/v5nQ/A0GwFT1FY4zeqGv9g
         PMjaMiDD6Ai/MBQTnK/j5pc3hUZ5Vj54xWZ0y9KdwHPnOSGQlHZ7fQXJXdkqJpx+z8xF
         pylxI3jgfIL4fZbYMv0h8W1pO59gm27w1R2sQTO0w5PSM2Ubw7jGr58Bk7g9hStXOx7C
         7Tew==
X-Gm-Message-State: AODbwcCvQSjvyLEkQEYE8APNUR/3brGY0hGgcYNN5NegfuSINgKehZOh
        OIaQcAlXSGlGPR8SemqCdRlPLzJKH0OV
X-Received: by 10.98.60.206 with SMTP id b75mr27927991pfk.19.1496210308505;
 Tue, 30 May 2017 22:58:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 22:58:28 -0700 (PDT)
In-Reply-To: <CAEA2_RJWnjiqinoAhd9aEM=zx9K4MxYpsoDcgoVwf0RnChsnUQ@mail.gmail.com>
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com> <CAEA2_RJWnjiqinoAhd9aEM=zx9K4MxYpsoDcgoVwf0RnChsnUQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 22:58:28 -0700
Message-ID: <CAGZ79kZDoW7DyLT0moeK1ApDHrzBt2pW-is_3pkSpvp=ENbz6g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 8:18 PM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:
> On Mon, May 29, 2017 at 3:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * df/dir-iter-remove-subtree (2017-05-29) 5 commits
>>  . remove_subtree(): reimplement using iterators
>>  . dir_iterator: rewrite state machine model
>>  . dir_iterator: refactor dir_iterator_advance
>>  . remove_subtree(): test removing nested directories
>>  . dir_iterator: add tests for dir_iterator API
>>
>>  Update the dir-iterator API and use it to reimplement
>>  remove_subtree().
>>
>>  GSoC microproject.
>>  Ejected as it conflicts with other topics in flight in a
>>  non-trivial way.
>
> I see this conflicts with Duy's
> fa7e9c0c24637d6b041a2919a33956b68bfd0869 ("files-backend: make reflog
> iterator go through per-worktree reflog", 2017-04-19) because his
> commit creates a new dir_iterator whose NULL value means something
> semantically. This would be perfectly OK with the old dir_iterator API
> (where NULL was not a possible return value from dir_iterator_begin()
> and could be "reserved" for this case), but will most probably
> generate issues with the new API, where NULL can *also* mean we failed
> to lstat() the directory we're trying to iterate over[1].
>
> I'll try to address this issue playing with pu, but I'm just wondering
> what would be the best way to send this upcoming not-based-on-master
> patch to the list. Should I just send it normally and signal it
> originates from pu rather than master?

pu is bad as that contains all series in flight.
If possible take the smallest set of series that this would depend on
(usually it is one in my experience and it seems as if you have identified
that series already) and just base it on top of that.

Thanks,
Stefan

>
> Thanks,
>
> [1]: https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/T/#m68286d783b5dfbad6921fbf012f685a629645c61
