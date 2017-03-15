Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E79202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbdCOWNE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:13:04 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32768 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdCOWND (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:13:03 -0400
Received: by mail-pf0-f173.google.com with SMTP id w189so14736700pfb.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IQJhmroGjPuRbKNqfZj2nrJAw06m4rpkp/75wYqmQdg=;
        b=iu4et9GwU7+lbbhPzCCi2n5eDl0VtLJWBd1YXCAR10eotd95bsBwGV0C8MY/QEeOwq
         1VjqnQcSpw4vPYzqhBKzLw+7zOMso6CcB74nw6I7S6vspyKUPSaUYMrHu8HTe/xc1kjn
         fsfflZgcL9jsWzJcMyiQkyQMtrmV7T2Q/x7Js894/WA56PZ1ZvSYr/nDa6wdIGlIfiZ1
         jlwyjAIhsFpHp7FrcGBWOmh1uDqA4zPzu299pHEvBrmUWnP8mfd0xOqh262TysL1LHu0
         W/OB7XDpo2xLFBwpQfiZEh45tBskONUceicCqwlDt96UGBmiUKd/c+CSremZUodncWpD
         qR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IQJhmroGjPuRbKNqfZj2nrJAw06m4rpkp/75wYqmQdg=;
        b=NaejGsvd52siS+VD8Fdl1e+X0TfU+JVfej3Kwf/4pA89Sljhv/UKKL39foD/LFj545
         1y3PCImUkOcCdBK4GX/q5DYxmficviDXWqpGt3rUrr9sjP8FEmJZBgEoHQ1jov/NFuUL
         +SY3BTMxeiTUWct0+D6VbxdpW3qW57aKLq8wPRg9rH4IT6kPB2DApe7KjLZRl6Y6svlc
         po1Yp/b7VyXpm2MKnJ7Bt2L7NjE8gLQotRq2kL5eqBD3Pe8qajI8lTLzp5oWxfBhus4Z
         a7Joydm6tmf9FU01okTGW04wp6qWeuFfdbvfpnt4LmHP074Dkvb4yzMskGgW1F+Jg8Cb
         iN3A==
X-Gm-Message-State: AFeK/H39HAAwEf8315hf27PSCkhyXs657iorH3MkVXX/NYH4hA8/JeYFHFtVXtIRcBzpzLFHcIngasPcE6TggZaL
X-Received: by 10.84.172.193 with SMTP id n59mr7612124plb.63.1489615981469;
 Wed, 15 Mar 2017 15:13:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 15:13:00 -0700 (PDT)
In-Reply-To: <CAME+mvX6EH+R6xRiCCYAg_gaguv4yeFD1T765+q7F8YMppeOhw@mail.gmail.com>
References: <CAME+mvW1x6fnGKt1_auGOp+wFYFR=Y_Qhxfd50E7KFe6t+X4kw@mail.gmail.com>
 <CAGZ79kbfNBbHgc4FrGoNNc54p65-xkQUQ6X3Ef9Ew9pioMzz7w@mail.gmail.com> <CAME+mvX6EH+R6xRiCCYAg_gaguv4yeFD1T765+q7F8YMppeOhw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 15:13:00 -0700
Message-ID: <CAGZ79kbV9oJp0ewp8=qz1Yts_RTDPsRW9LYcuNBQr5EFzK+VYA@mail.gmail.com>
Subject: Re: GSoC Project | Submodules related work
To:     Prathamesh <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 2:28 PM, Prathamesh <pc44800@gmail.com> wrote:
>> What do you mean by catch here?
>
> By catching commands, I meant that we identify that the user has entered
> the command in an unpopulated or uninitialized submodule and respond
> to the user accordingly.

Well in that sense, we do not do that, yet. I see what you mean.

>> However to detect if there is a submodule, we can to check two
>> things: if there is a .gitmodules entry and if there is a gitlink entry
>> recorded in the tree. Depending on the command we'd want to
>> do one before the other. e.g. git-add most likely doesn't need to
>> load .gitmodules, but may have the objects already loaded.
>> So checking if a given path is a submodule is cheap compared
>> to loading the .gitmodules file, so we'd probably want to do the
>> cheap thing first.
>
> Adding to this, we may use here this functions is_submodule_populated()
> and is_submodule_initialized() from submodule.c

Not quite, IMO.

is_submodule_initialized checks for the existence of
submodule.<name>.URL in .git/config; but it sounds as if we want to
check for the existence of submodule.<any name>.path in .gitmodules
instead. So we'd end up using only

    module = submodule_from_path(null_sha1, path);

only from that function.

is_submodule_populated checks if there is a .git file/directory at the given
path, which at this point we would know is not the case, already?

We'd roughly need to
module_list_compute(... prefix = "", pathspec = prefix, ...),
i.e.

    struct cache_entry *ce = lookup_cache_entry_for(prefix);
    if (ce && S_ISGITLINK(ce->ce_mode))
        /* this is an uninitialized submodule */
    else
        /* this is just a normal prefix */

>> I think even when the .gitmodules file is missing, we want to have
>> some sort of warning here, as it is a confusing state to run git
>> from an uninitialized gitlink'd repository. The user may assume they
>> run the command in the gitlink'd repo, so it may be better to bail out.
>
> Can you please give an example of such situation ? I would like to
> reproduce it and think further.

I think you can create such a situation via

    git init tmp
    cd tmp
    git init gitlink
    git -C gitlink commit --allow-empty -m "initial commit"
->  git add gitlink
    git commit -m "add 'gitlink' as a gitlink"
    rm -rf gitlink
    mkdir gitlink
    git -C gitlink status

Note that we used "git add" instead of "git submodule add". git-add
doesn't care about submodule, i.e. doesn't create a .gitmodules entry
for you (unlike "git submodule add").

Also note that the "rm -rf && mkdir" is just a placeholder to produce this
state. An alternative ending after the commit could have been

    cd ..
    git clone tmp tmp2
    cd tmp2
    git -C gitlink status



> (As even in the case where the superproject is initialized using gitlink,
> .gitmodules is in the same folder as that of the .git file containing
> GIT_DIR path)

I do not understand this?

> Also if it possible, I would like to
> work on a smaller task related to my project first, as it will help me
> understand about the project more, and which also will help me write
> my proposal for the project.

Heh, that is the beauty of open source, you don't have to ask permission. ;)
But I guess this is meant as a question, on what this smaller project
could be? Well as this proposal is heavy on path computation, I'd
look for pathspec related leftovers at
https://git-blame.blogspot.com/p/leftover-bits.html

Thanks,
Stefan
