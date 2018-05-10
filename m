Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00861F406
	for <e@80x24.org>; Thu, 10 May 2018 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeEJTRM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:17:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39819 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeEJTRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:17:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so6195378wmc.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2LH7nnwztZWbYqSPpEZ5H7XHPbeeI8kvy/7xeE/CU4A=;
        b=OJbGWChaF3Kph8k8gSUUjNA5PsYrweiekgWptR4XrT0S4Edir/2EyYsjx5f/ozwzh/
         jkkJR9mCL6i0FNNOyJ4tcAv4ziDZP2U8e0id2yNVKIxGVhR1pALKYSUALqCeYe3MCXW6
         3DI6Bx515Vn0tyq9zDLHqE82nFrYU/eFK4ybrYKwPBkSQZxFq3ZGnq+n3aarmmLaiTLY
         2zQWaEWzTpzZjkuCc1QROv2OuIqVIa2jNCUocg9ZvNHqF7ZX9kiUh0Xsody7H0DiZxpt
         UV23JRDj72BDTkIPgkfI4OFfFJ/RsLnEXCScs4y5nBZeMUldJs36X87oucb9Rh8JgCSN
         rWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2LH7nnwztZWbYqSPpEZ5H7XHPbeeI8kvy/7xeE/CU4A=;
        b=FturMiva0LMdnKD0g8naqNczVdkJUdmWrun6bZh6omn7hOeypay7cNnMhFQJ6egwWy
         Vwi0DBjUHxzozmUSoo9IqYUuqBxBIwQis5ld4Y9+nlX2pG7MI90N4yToH4BOG+gk+5xb
         oFifPqxklZWnhAq5+aQxOoxLwgPk5nfg9fNiMwCqa2kVnC1nCWtkhDP0Sk8vfJCm2YCu
         6lCEaqf7uVIslMJwDXaKxen8PCqBa23ut8jwIuZa2F8SHHHArYaWGG5d8z+SX9c2816Z
         MynJ+0/KllrthZ8hANuRYTYSPzKMI7jKCkdkFA5aYTwfNZ5MLsFqfQ2yQhItxRpc+G59
         lnxQ==
X-Gm-Message-State: ALKqPwc9jODPYBLxYbZVUidxnmQ+OO5ddIOWx7EkeuHZKaMQjKdu6c0g
        ynWp9sSnjSeaA9LiYGmd51A=
X-Google-Smtp-Source: AB8JxZrdFnR8GGrwrMwP/pS+FPp/r8Ej+724mHIpyoW+e1gWGEQjmbCp57B5jW6DLpRGmkoC+/muCQ==
X-Received: by 2002:a50:d70d:: with SMTP id t13-v6mr3861236edi.260.1525979825789;
        Thu, 10 May 2018 12:17:05 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w26-v6sm833649edq.77.2018.05.10.12.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:17:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180510173345.40577-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180510173345.40577-1-dstolee@microsoft.com>
Date:   Thu, 10 May 2018 21:17:03 +0200
Message-ID: <87mux72uds.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 10 2018, Derrick Stolee wrote:

> The behavior in this patch series does the following:
>
> 1. Near the end of 'git gc', run 'git commit-graph write'. The location
>    of this code assumes that a 'git gc --auto' has not terminated early
>    due to not meeting the auto threshold.
>
> 2. At the end of 'git fetch', run 'git commit-graph write'. This means
>    that every reachable commit will be in the commit-graph after a
>    a successful fetch, which seems a reasonable frequency. Then, the
>    only times we would be missing a reachable commit is after creating
>    one locally. There is a problem with the current patch, though: every
>    'git fetch' call runs 'git commit-graph write', even if there were no
>    ref updates or objects downloaded. Is there a simple way to detect if
>    the fetch was non-trivial?
>
> One obvious problem with this approach: if we compute this during 'gc'
> AND 'fetch', there will be times where a 'fetch' calls 'gc' and triggers
> two commit-graph writes. If I were to abandon one of these patches, it
> would be the 'fetch' integration. A 'git gc' really wants to delete all
> references to unreachable commits, and without updating the commit-graph
> we may still have commit data in the commit-graph file that is not in
> the object database. In fact, deleting commits from the object database
> but not from the commit-graph will cause 'git commit-graph verify' to
> fail!
>
> I welcome discussion on these ideas, as we are venturing out of the
> "pure data structure" world and into the "user experience" world. I am
> less confident in my skills in this world, but the feature is worthless
> if it does not improve the user experience.

I really like #1 here, but I wonder why #2 is necessary.

I.e. is it critical for the performance of the commit graph feature that
it be kept really up-to-date, moreso than other things that rely on gc
--auto (e.g. the optional bitmap index)?

Even if that's the case, I think something that does this via gc --auto
is a much better option. I.e. now we have gc.auto & gc.autoPackLimit, if
the answer to my question above is "yes" this could also be accomplished
by introducing a new graph-specific gc.* setting, and --auto would just
update the graph more often, but leave the rest.
