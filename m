Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB771F403
	for <e@80x24.org>; Wed,  6 Jun 2018 02:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeFFCKR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 22:10:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37444 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeFFCKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 22:10:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so8655346wmg.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8i4yPSt0Rj36qtn3px6Wxfu7ga0zUoOc1wfxums/ZHU=;
        b=Oiz5RaSChLC9kBCadvOm3a57/ob5lr+WpsaV2GcTwCY0+osLcveEiFQt9nV8Jq6xvv
         VTUsk9RvQ+Idb8ts3kOYTm0ESl94OdgmZYy8D0JuX99CCcGgO2g0HgwvXI0US/wDAj19
         k7Pnj9Tiy6PQDmD9lMM1mVbgCUfAibhsyaqUlR8xPhLRwINVfOpLjxEqQ98Xg9rWsxMI
         1bWjYEo2t+t+ZFVS40PerjOPNYK8S2WvLRTrvdqOmmYgEefhk1oz6nA6oeY6FZeTasSH
         lHCu7PfgrvR3tICofeJimsQBd1C/WESSq6X4ANDvsA7Uh65DQgpDJKVhj9MWBmvzY/sN
         4hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8i4yPSt0Rj36qtn3px6Wxfu7ga0zUoOc1wfxums/ZHU=;
        b=o6wZetgAtTzBWc393tNFPPMlB3EcHjnf4yCMV1SEVKnEqfS6GF2rA7yW70MxIzU9VN
         U9A6BhhUBoLtFaJahNX+4PUECON/JeEL4VY2gKVm5K2Of4JpLh0V6/qdgrNDPzNfHMRM
         tPLbJ8VwCSZFsbu6pYtGPkjk36FIi5secmxr0yQtI3xOx87/pTxeLS0+YMLiAS8MgEcR
         CrdOUpBY6ct/TNEVloClOqmiMa3r7AgCLWeCq/x9sZ8ZX6t0DN7M+H59JlPp+YvpLrAg
         6fC+5fD+AgBwhEDfhevsyXv3r4rDjxWH/ykv/u1DfnmntEhnh687aVUcQjR8i7BuV70o
         dViA==
X-Gm-Message-State: APt69E3OfK9RvXDyxCGlOOGRZBCA5IggG+NxWF40aKSd+4Sp8EjwWttD
        IRBZjwZMcrJEgBdGvijgSLovKEK7xvukfUAVgT3sZQ==
X-Google-Smtp-Source: ADUXVKJMtW11Xv6cb+ulqElmGXaFStn+mfzqicdQ7rcoke0eDTl7UZS/yL0vg8NsjYn2m6p281sRkFgULTSVKDiNBLs=
X-Received: by 2002:a1c:e146:: with SMTP id y67-v6mr360221wmg.17.1528251014954;
 Tue, 05 Jun 2018 19:10:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:e90d:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 19:10:13 -0700 (PDT)
In-Reply-To: <20180605233026.GF9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <8265d9485a2bfe0e81d68495afd3733879add992.1527894919.git.jonathantanmy@google.com>
 <20180605233026.GF9266@aiede.svl.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 5 Jun 2018 19:10:13 -0700
Message-ID: <CAGf8dgLJy5yKx3yD3-ADdMTBW8_8N984wMN8FfN4g2_xjAON4A@mail.gmail.com>
Subject: Re: [PATCH 3/6] fetch-pack: in protocol v2, enqueue commons first
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 4:30 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I get lost in the above description.  I suspect it's doing a good job
> of describing the code, instead of answering the question I really
> have about what is broken and what behavior we want instead.
>
> E.g. are there some commands that I can run to trigger the unnecessary
> "have" lines?  That would make it easier for me to understand the rest
> and whether this is a good approach for suppressing them.
>
> It's possible I should be skipping to the test, but a summary in the
> commit message would make life easier for lazy people like me. :)

OK, I'll start the commit message with explaining a situation in which
these redundant "have" lines will appear instead. (The situation will
be the same as the one in the test.)

> This is subtle.  My instinct would be to assume that the purpose of
> everything_local is just to determine whether we need to send a fetch
> request, but it appears we also want to rely on a side effect from it.
>
> Could everything_local get a function comment to describe what side
> effects we will be counting on from it?

You're right that there's a side effect in everything_local. In v2,
I'll have a preparatory patch to separate it into a few functions so
that we can see what happens more clearly.

> nit: this adds the new test as last in the script.  Is there some
> logical earlier place in the file it can go instead?  That way, the
> file stays organized and concurrent patches that modify the same test
> script are less likely to conflict.

Good point. I'll find a place.

>> +     rm -rf server client &&
>> +     git init server &&
>> +     test_commit -C server aref_both_1 &&
>> +     git -C server tag -d aref_both_1 &&
>> +     test_commit -C server aref_both_2 &&
>
> What does aref stand for?

"A ref", "a" as in "one". I'll find a better name (probably just
"both_1" and "both_2").

>> +
>> +     # The ref name that only the server has must be a prefix of all the
>> +     # others, to ensure that the client has the same information regardless
>> +     # of whether protocol v0 (which does not have ref prefix filtering) or
>> +     # protocol v2 (which does) is used.
>
> must or else what?  Maybe:
>
>         # In this test, the ref name that only the server has is a prefix of
>         # all other refs. This ensures that the client has the same information
>         # regardless of [etc]

Thanks - I'll use your suggestion.

>> +     git clone server client &&
>> +     test_commit -C server aref &&
>> +     test_commit -C client aref_client &&
>> +
>> +     # In both protocol v0 and v2, ensure that the parent of aref_both_2 is
>> +     # not sent as a "have" line.
>
> Why shouldn't it be sent as a "have" line?  E.g. does another "have"
> line make it redundant?

The server's ref advertisement makes it redundant. I'll explain this
more clearly in v2.

>> +
>> +     rm -f trace &&
>> +     cp -r client clientv0 &&
>> +     GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
>> +             fetch origin aref &&
>> +     grep "have $(git -C client rev-parse aref_client)" trace &&
>> +     grep "have $(git -C client rev-parse aref_both_2)" trace &&
>
> nit: can make this more robust by doing
>
>         aref_client=$(git -C client rev-parse aref_client) &&
>         aref_both_2=$(git -C client rev-parse aref_both_2) &&
>
> since this way if the git command fails, the test fails.

Will do. Thanks for your comments.
