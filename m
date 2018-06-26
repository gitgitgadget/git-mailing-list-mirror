Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC1D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 15:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeFZPlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 11:41:47 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40502 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeFZPlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 11:41:46 -0400
Received: by mail-io0-f194.google.com with SMTP id t135-v6so2650221iof.7
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YqrYVqW+rLFJFWiTq+tJsigQBt9AyTRAeX7xTw+MuKE=;
        b=ja/gIc4veIAQQDh25C5iqstO/pMIvQ2zHGBlhIdUAQMX5SCtp6cAYvR0Ybbtjff5Iy
         SL58pHsSVKx6JCzP0cyR9ntEml0ml4mVKsBIejS/NofovxGEkQLE7w9HttPB0XkuQtF6
         SVAUbW3aF6L18/ANvQ9q7aJbv0f14A/O9bfPFsKo+IKYcC6kr/2X2d6J6bQNOA2w5orn
         lNUhtBMagFfTovF1oq4V8v7JPPWYbn9hbW3Dalzqx1MTy5PFxsmvOqFIJQFzMZ8b/U02
         lTG+ds77SVU6ljnC61F37iugvtbDe2D7FjkHp9GzFsXMdMjxG/gAj3foYYEY9BGbdsGI
         RD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YqrYVqW+rLFJFWiTq+tJsigQBt9AyTRAeX7xTw+MuKE=;
        b=hoogpKjvSAo84vmEB4yERAt3zlT9UojkYvpJa4VK2TK7JalPeM7Wiuf6osPL+3+seJ
         1KWq6FWJ91moQy5vj+Om5mR6csXvuzRUZVoqVPf78NvLFbiml25q3kLn1tFeSN5mHaI8
         Epah41Cb326S7GpuPR5sHutzp6ina3lHYQif9znuZmufEo6bIVfoB7HiOkSAsLv8tciI
         xloB2ECmtU7PeLbwILZgvwQK9LwC2XhU4gPY4moBlTk8mqNq7ynlinX4rdPjgO/KHzjp
         nlEdxabcy0E+sJGgELN+E9iqIiVVUPJHA9knd2R8pvrUSAKq9J4Fn89aQ+1brgDGH22D
         zDNw==
X-Gm-Message-State: APt69E0uhY2dSgbuXZYMnX041LHFbIIvPwS719dgIme1sL1fxrx9qdyl
        JwAazvVhbx9yV8PgeQzNysm2qIt6gr0JR8tgaQtzl9z6
X-Google-Smtp-Source: AAOMgpdaM/b/LCveTUL5YXxuEX66AI1/sIHAgBaVlCA6ryU357O64vvs8rgxhYvq5P1qk9xVtAR7QeP/+jkHp6l1shQ=
X-Received: by 2002:a6b:d00c:: with SMTP id x12-v6mr1724679ioa.5.1530027705231;
 Tue, 26 Jun 2018 08:41:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:41:44
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
 <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Jun 2018 17:41:44 +0200
Message-ID: <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Jun 26, 2018 at 4:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Tue, 26 Jun 2018, Christian Couder wrote:
>
>> On Mon, Jun 25, 2018 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > I hate to say this, but the above looks like a typical
>> > unmaintainable mess.
>> >
>> > What happens when you or somebody else later needs to update the
>> > graph to be tested to add one more commit (or even more)?  Would it
>> > be enough to add another "rev-parse" plus "dist=X" line in both
>> > expects?  Or do we see a trap for combinatorial explosion that
>> > requires us to add new expect$N?
>>
>> What about the following then:
>>
>> test_dist_order () {
>>     file="$1"
>>     n="$2"
>>     while read -r hash dist
>>     do
>>         d=$(echo "$dist" | sed -e "s/(dist=\(.*\))/\1/")
>>         case "$d" in
>>             ''|*[!0-9]*) return 1 ;;
>>             *) ;;
>>         esac
>>         test "$d" -le "$n" || return 1
>>         n="$d"
>>     done <"$file"
>> }
>>
>> test_expect_success "--bisect-all --first-parent" '
>>     cat >expect <<EOF &&
>> $(git rev-parse CC) (dist=2)
>> $(git rev-parse EX) (dist=1)
>> $(git rev-parse D) (dist=1)
>> $(git rev-parse FX) (dist=0)
>> EOF
>>     sort expect >expect_sorted &&
>>     git rev-list --bisect-all --first-parent FX ^A >actual &&
>>     sort actual >actual_sorted &&
>>     test_cmp expect_sorted actual_sorted &&
>>     test_dist_order actual 2
>> '
>>
>> This feels overkill to me, but it should scale if we ever make more
>> complex tests.
>
> I *think* that you misunderstand Junio. At least when I read this:
>
>> $(git rev-parse CC) (dist=2)
>> $(git rev-parse EX) (dist=1)
>> $(git rev-parse D) (dist=1)
>> $(git rev-parse FX) (dist=0)
>
> I go: Huh?!?!?!?!?!
>
> What's CC? Is it Christian Couder? Creative Commons? Crudely Complex?

I agree that the name of the commit could be improved.

> The point, for me, is: if this test fails, at some stage in the future,
> for any reason, it will be a major pain to even dissect what the test is
> supposed to do.

I think the test is quite simple and there is an ascii picture, so it
is not so difficult to understand.

> This is no good. And you can do better. A lot better. You
> can write the test in a way that the head of a reader does not hurt, and
> at the same time it is still obvious what it does, and obvious that it
> does the right thing.

Obviousness is often not the same for everybody.

> One thing that makes the brain stumble for certain is when you deviate
> from the conventions, especially when it is for no good reason at all. In
> this case (and I am not sure why you, as a long-time contributor, did not
> spot this before public review):

Please note that I never committed myself (like most of us who are not
maintainer actually) to reviewing everything bisect related (or
everything that Tiago works on).

> - the titles of the test cases leave a lot of room for improvement,
>
> - the lines are too long,
>
> - the convention to end the `test_expect_success` line with an opening
>   single quote is not heeded,

If you take a look at the beginning of the script you will see that
there are those problems there too.

I know that we should try to do better, but here I am mostly
interested in moving forward a feature that people have requested for
ages, not cleaning up those tests. If someone else like you or Junio
thinks that it would be a good time to clean things up a bit, then I
am ok with it, but that's not my main goal here.

> - the graph is definitely written in an unnecessarily different format
>   than in the same test script!!!

Just above you complain about things that are similar to the previous
tests and now you complain about things that are different...

> - speaking of the graph: there is a perfectly fine commit graph already.
>   Why on earth is it not reused?

Perhaps because it is more complex than needed to test this feature
and/or to understand what happens. And I don't think we require
everywhere only one commit graph per test script.

> In this particular case it even feels as if this test is not even testing
> what it should test at all:
>
> - it should verify that all of the commits in the first parent lineage are
>   part of the list

It does that.

> - it should verify that none of the other commits are in the list

It does that too.

> And that is really all there is to test.

I don't agree. I think that when possible, especially when testing
plumbing commands like rev-list, it is a good thing to test as many
things as possible at once.

> You can even write that in a much
> easier way:
>
> -- snip --
> test_expect_success '--first-parent --bisect-all lists correct revs' '
>         git rev-list --first-parent --bisect-all F..E >revs &&
>         # E and e1..e8 need to be shown, F and f1..f4 not
>         test_line_count = 9 revs &&
>         for rev in E e1 e2 e3 e4 e5 e6 e7 e8
>         do
>                 grep "^$(git rev-parse $rev) " revs || {
>                         echo "$rev not shown" >&2 &&
>                         return 1
>                 }
>         done
> '
> -- snap --
>
> To test more precisely for the order or the distance would be both
> overkill and likely to be unreadable.

I don't think the previous version was either overkill or unreadable.
Yeah it had other (potential in my opinion) problems, but I was trying
with my suggestion to find a good balance between the different
requirements (readability, complexity, maintainability, testing many
things).

By the way with only the 2 requirements you list above, I think the
simplest would be sorting things like I do it in my suggestion without
checking that the (dist=X) are in the right order with just:

test_expect_success "--bisect-all --first-parent" '
    cat >expect <<EOF &&
$(git rev-parse CC) (dist=2)
$(git rev-parse EX) (dist=1)
$(git rev-parse D) (dist=1)
$(git rev-parse FX) (dist=0)
EOF
    sort expect >expect_sorted &&
    git rev-list --bisect-all --first-parent FX ^A >actual &&
    sort actual >actual_sorted &&
    test_cmp expect_sorted actual_sorted
'

> To test `--bisect-vars` here would be excessive, as the part that handles
> that particular option is not even touched. All that is touched is the
> logic in the bisect algorithm in conjunction with --first-parent. And that
> is all that should be tested here.

I don't agree with that. I think that as we now enable --first-parent
with all the --bisect* options, we should test at least once all the
--bisect* options with --first-parent.

> With a test like the one I outlined above, I only have one more gripe
> about the patch: the commit message does nothing to explain this part of
> the diff:
>
> +                               if ((bisect_flags & BISECT_FIRST_PARENT)) {
> +                                       if (weight(q) < 0)
> +                                               q = NULL;
> +                                       break;
> +                               }
>
> And I would really, really like that to be explained in the commit
> message. Because to me, it is completely opaque why this needs to be here.

This was suggested by Junio in a previous iteration and I agree that a
comment would be welcome.

> The rest of the diff is pretty obvious, though.

Thanks for taking a look anyway,
Christian.
