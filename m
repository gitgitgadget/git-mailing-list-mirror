Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3F9201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933462AbdKOROg (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 12:14:36 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:44622 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbdKOROR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 12:14:17 -0500
Received: by mail-wm0-f51.google.com with SMTP id r68so4489744wmr.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LPKxQFKgc7bFG8nvK/7llt6Y3PmiQqVjCWHQYEMw/eg=;
        b=vG0lNzhZG0y3xzDNck1qxss+o8+Wc+32z7vC9LZ+3oxheBe+/+DHjcYnpaa9HGywfp
         Fdf0nqtdjKKb6VWxGQ1e0EOG2D6W3HsCGxUGpzUyzy5f5J5PIpfyow+DgwLP+OfWfHNp
         sLYVt7H9LKeOVQLo1sR7kLIz1jX6mGxMz2Pq0UBApAnlUbyc5g6rvTKaBXjNiYnachO4
         dXIULZSFlnSee4XeKFBk+CC/iZkRJ0pfGCCIQuxV4wZOdjapZgk38Or+GHXdeZLF4wZJ
         emPkM9ljf6KVdF2tv9VEsWLWrjmXCovtgmeb8dFc+DXM4GAdTQatn9BfucVEas0W5yBH
         SNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LPKxQFKgc7bFG8nvK/7llt6Y3PmiQqVjCWHQYEMw/eg=;
        b=PtBxYPvzMr+XFtAfvqJqJBXZk/8h0PFp/DTqQBzESNYT1E1LyOXd26tQnkoEt8ZXkN
         w219jG/n7KhGZgLyIMqkPpS4o3UjleVizrNYWzwxD/IVFPOIh5OnyDeIo2T6ua8N8ulS
         tRXf0qZSoVbdBGDlmMnTjNW4ywgajImdVVPpoW6djKkhLnzoXd+lHr4xO4QilvW2/dFj
         0v9IHOJyysLllclattA++EpXBCgKWKkSW/k0kYkwX/Dl3LEIJzhJf6d8eJQfthRJF25W
         xQ4IbVSmVshHDq6pSLxke4dAfb6w650MIE1fJC/Qb0umUrBi09cLKQ4/v7+Vs7kuTJU9
         YZqw==
X-Gm-Message-State: AJaThX6ppaEkatN7IQcMrxVct/TGwDyvk62g/Es9Utresd429Q+Kaa+e
        dSHMaXcLw6VimNXaLOw2aN17VknGBrmU/7wXSpw=
X-Google-Smtp-Source: AGs4zMaLo0nDgYrBo+NB3zk+Htcejj3KU3k4S7C9L3W6wZt/2xn+IOKjuOLeleWBXsTx5AdGa+ZOosvlzL3WRSieD9M=
X-Received: by 10.80.217.15 with SMTP id t15mr23607801edj.217.1510766055800;
 Wed, 15 Nov 2017 09:14:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 15 Nov 2017 09:13:55 -0800 (PST)
In-Reply-To: <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 15 Nov 2017 09:13:55 -0800
Message-ID: <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 10:13 AM, Stefan Beller <sbeller@google.com> wrote:
> Thanks for your reply!
>
> On Tue, Nov 14, 2017 at 9:17 AM, Elijah Newren <newren@gmail.com> wrote:
>> On Mon, Nov 13, 2017 at 3:46 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Mon, Nov 13, 2017 at 3:39 PM, Elijah Newren <newren@gmail.com> wrote:
>>>> On Mon, Nov 13, 2017 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>>>> I wanted to debug a very similar issue today just after reviewing this
>>>>> series, see
>>>>> https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/
>>>>
>>>> Oh, bleh.  That's not a D/F conflict at all, it's the code assuming
>>>> there's a D/F conflict because the entry it is processing ("sub") is a
>>>> submodule rather than a file, and it panics when it sees "a directory
>>>> in the way" -- a directory that just so happens to be named "sub" and
>>>> which is in fact the desired submodule, meaning that the working
>>>> directory is already good and needs no changes.
>>>
>>> yup, I came to find the same snippet of code to be the offender,
>>> I just haven't figured out how to fix this bug.
>>>
>>> Thanks for taking a look!
>>>
>>> As you have a lot of fresh knowledge in the merge-recursive case
>>> currently, how would we approach the fix here?
>>
>> submodules and merging looks pretty broken, to me.  Backing off from
>> the current bug and just looking at merging with submodules in
>> general, makes me a little uneasy with what I see.  I mean, just look
>> at update_file_flags, when it wants the working directory updated, the
>> code for a submodule is the following:
>>
>>     if (update_wd) {
>> <snip>
>>
>>         if (S_ISGITLINK(mode)) {
>>             /*
>>              * We may later decide to recursively descend into
>>              * the submodule directory and update its index
>>              * and/or work tree, but we do not do that now.
>>              */
>>             update_wd = 0;
>>             goto update_index;
>>         }
>>
>> So, it just doesn't put anything there, so the working directory is
>> made out-of-date immediately.  Users are happy with that?  Maybe it is
>> what makes sense, but it surprised me.
>
> Submodules are traditionally not touched by git commands and we are slowly
> trying to get that changed. Some commands have a --recurse-submodules
> flag now, including checkout, reset; merge is missing this flag as the semantics
> are hard to define sensibly, yet.
>

Yea, figuring out how to represent a conflict with submodules is
pretty challenging, especially in cases where one side has a submodule
and the other side does not.

> Yes, introducing submodules into the mix is a big mess, because
> in the tree it is recorded as if it is a file (only the top level
> entry at path/)
> but on the file system a submodule is represented as a directory
> with contents, so the conflict detection is harder, too.
>
> I had the idea of introducing a command that can "internalize"
> a submodule. This would take the tree recorded in the submodule
> commit and put it where the submodule was mounted,
> The opposite is "externalizing" a submodule, which would turn
> a tree into a submodule. (One of the many question is if it will take
> the whole history or start with a new fresh initial commit).
>
> But this line of though might be distracting from your original point,
> which was that we have so much to keep in mind when doing tree
> operations (flags, D/F conflicts, now submodules too). I wonder how
> a sensible refactoring would look like to detangle all these aspects,
> but still keeping Git fast and not overengineered.

I think given how complex a lot of these code paths are, that an
attempt to refactor it a bit to detangle some of the mess would be
well worth the time. I'd suspect it might make handling the more
complex task of actually resolving conflicts to be easier, so the
effort to clean up the code here should be worth it.

Thanks,
Jake

>
> Thanks,
> Stefan
