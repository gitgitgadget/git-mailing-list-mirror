Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB7120899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbdHNSHb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:07:31 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34052 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbdHNSHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:07:30 -0400
Received: by mail-yw0-f173.google.com with SMTP id s143so59512302ywg.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VaNTkpR3teTxDvwgxw8IqaOM+iUvJqSjqgqfDCq0nGo=;
        b=WDnOMd0P/Xi8nFyNory1juBzMeopwn+ydgBI15aLCtTjWJnQk3IYqvKlGkuLAlIb6V
         Nnumi6W5wosCx9jiqxw7viXNy6MJbrAvDe1F6XZyUFiIIU9IhFHE8IKr+48hgpxJuOaV
         eikfS0pT6m/tHx7IJeKePJz1JPkhjAypGriH0TV85CJWomHQwQAgSVyN+tX4K5eKRdeI
         Lm2a/s+ApKLn7h8ZW/0ey3+Vlk740MZ9frjGRC095SYuxeCwB9ZjUUxbJlvvIExyrXFa
         ps8BD44Ng3aFvg1IU4A5dB2q3zD7uqp+zpRZrQ0db4BPvpqT9oRo9NiElkWD3C1b3WWP
         4/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VaNTkpR3teTxDvwgxw8IqaOM+iUvJqSjqgqfDCq0nGo=;
        b=joCEEjp8XYnw3wMwRk5RYDWOaHFtcQtWkyRpfBvG1+uqOgCsV8BCY6ox8AD9CIdGlD
         sz14OZRuufveAU2K+LgXgjURNdaJOFkXtxdX6NDlqbQ62MGd5yKJMvf4va8FIcZEwENe
         ivq5GUpGmzGisSJbP95F2JosfS675yGOywwqx6FAZeeYbzXIVw5CWX+8VMDVEBNGaLsx
         KK0kD1P1BGLDdTm/9KAEt59UEZ7t+OZdO1XSJ4iXYVfsIWEFg2EqYTg3Ygn9sz/5c3oH
         UHZRrjhiro6uYXtGcJZqfXz5mxWI8qO2c6gv9IPhJLkg5SijfYc1lwPtkt3mrlorzGpK
         Op2g==
X-Gm-Message-State: AHYfb5hJ2XqiNtsnknJTsC8K8+fopIL/z7AysHTVjbkW9T5xlLxuWD22
        3vwhH1ZpQx1TzmRi44X2QD8brjWs70IB
X-Received: by 10.37.123.129 with SMTP id w123mr21168212ybc.305.1502734049725;
 Mon, 14 Aug 2017 11:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 11:07:29 -0700 (PDT)
In-Reply-To: <87shgx3khv.fsf@local.lan>
References: <87mv7773tp.fsf@local.lan> <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
 <87efsj70d7.fsf@local.lan> <CAGZ79kZN1-DuiaS=bFgNUXBonAR3BHqtAFSqoJ+MJ4esMdmz-g@mail.gmail.com>
 <87shgx3khv.fsf@local.lan>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 11:07:29 -0700
Message-ID: <CAGZ79kaCuaxgGwuw7AHKTjsmwsTBuv=gWzeGDJv3TJv+b25Uvw@mail.gmail.com>
Subject: Re: Not understanding with git wants to copy one file to another
To:     Harry Putnam <reader@newsguy.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 1:41 PM, Harry Putnam <reader@newsguy.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>
> [...]
>
>> Ah. Sorry for confusing even more.
>> By pointing out the options for git-diff, I just wanted to point out that
>> such a mechanism ("rename/copy detection") exists.
>
>
> [...]
>
>>> What am I missing?
>>>
>>
>> https://www.reddit.com/r/git/comments/3ogkk1/beginner_disable_rename_detection/
>>
>> "Rename detection is just GUI sugar".
>
> Thanks there is a nice full explanation at the cited url.
>
> What is still a bit puzzling is that in that same commit, there are
> files that are true copies of each other, just in different locations,
> But nothing pops up about them in a git commit.
>

The heuristic to find the renames/copies only looks at modified files
to be fast(, the assumption is that each commit only touches few
files, but the project consists of a lot of files).

For that git-diff knows about '--find-copies-harder' that looks at
all files even those not modified. This would point out the true
copies, I would assume.

I don't think we'd want to include the '--find-copies-harder' flag
to status or commit, as it may take some time in large projects.
