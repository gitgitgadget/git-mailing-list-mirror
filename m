Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A771F404
	for <e@80x24.org>; Sun,  8 Apr 2018 12:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeDHM2R (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 08:28:17 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39761 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeDHM2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 08:28:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id q71-v6so5123092oic.6
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ln+EUefhpot8pQ+dzp9yn9A9N15q2Cfj5Z+a50iJr34=;
        b=moJIl19KJxra0UJ/AKtBoMI/6862SR75aMey9+CBtv6jjuj4EiVGwhcEyk+e/O0Xqi
         ixj8TMJzQato5RRzOWj47F5oFh2t+LonN4AoBo5dteTA7xBzwnWYkZpYLWH+h1RgSkxy
         NPDpdXSVJqdyFhkOCvuu7b6MmCxBUdf5ynWpRiMfAMkxpDEXOBi6uB/vmbIi4nJ5a4xu
         XzSzxy1Vq5//EKHlLfAs4N84p1iYhFRQigOlOePczXea8M8CmzXdIx36k1ZrGzM8JekP
         UOAWbvV/ygtIjIMGFYQ2wpibHwxayqkopUPk/8ZgwbW9NKbY6PMy2AFYS0y/b106WXMh
         tHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ln+EUefhpot8pQ+dzp9yn9A9N15q2Cfj5Z+a50iJr34=;
        b=oms40IlILCHqDkuCUT5pBEXabenxZLe22D7hDVMnRt1SxMz5pDc3OXaJOPYERIz5YQ
         j6xC21eBgxIHfdXGu7WJIpubvilsmXZufIo8PKRv8ZQzJhHjnS2aZYcY/A92s2tPRmLW
         WqV2PQMZWIJCI5EG0PG0oDtOeVrw4IAQ3vc00SeumlQ04iq9h08Fk00upig4+tx6WhVy
         ZMBpGgE9Lz4RARsMRBGc3N8crPnK4HjN3WShUtomsrl3YSxT0aorHCx+BEROrL/rSUZM
         kmUmKq5ayome0U0fg7D3oC2pdPHmMkGUHCfRHZwGRWwn8wlYzy9jZ09gIqYD8VVGqgF0
         RQkA==
X-Gm-Message-State: ALQs6tBsaOQBP9l6IQURAf+WAWqqM+dcvyrz+13NCz9fUU2RTnW7AM7A
        kAiaB40DZaFgtgZvamAsFN+tCqU4uOvCXErCZ4o=
X-Google-Smtp-Source: AIpwx4/Q8OGj0CHZVusBNROG1vT1mKyGmn1tnePg335SqV57AP/VWvtBjyCF+iLKKLvN6PJnWRj2f/vdsdqcLh5jac4=
X-Received: by 2002:aca:b5c2:: with SMTP id e185-v6mr18398564oif.166.1523190495766;
 Sun, 08 Apr 2018 05:28:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Sun, 8 Apr 2018 05:27:35 -0700 (PDT)
In-Reply-To: <CAPig+cTQ1ZzWTp6Qsj96nE8QwhuRuqB51orTNsCQjGKD=_veyg@mail.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180407164250.54303-1-haraldnordgren@gmail.com> <CAPig+cTQ1ZzWTp6Qsj96nE8QwhuRuqB51orTNsCQjGKD=_veyg@mail.gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Sun, 8 Apr 2018 14:27:35 +0200
Message-ID: <CAHwyqnVWhwmDKhgoJ1p-UuxL-=pAczMCe3KdDbkhayh4n88jPg@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] ref-filter: use "struct object_id" consistently
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your very thorough review Eric! I think I address all the
points, but if I missed something please let me know.


On Sun, Apr 8, 2018 at 3:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>
> You incorrectly dropped Peff's sign-off[1] when re-sending the patches
> he authored in the series. And, your sign-off should follow his.

I just rebased on https://github.com/peff/git/tree/jk/ref-array-push
where there were no sign-off tags.

But I amended the commit messages now to add the sign-off. And also
added my own sign-off.

> Also, if you made any changes to Peff's patch, it's a good idea to
> state so with a bracketed comment at the end of the commit message
> (before the sign-offs). For instance:
>
>     [hn: tweaked doodle blap]
>
> or such.
>
> [1]: https://public-inbox.org/git/20180406185831.GA11108@sigill.intra.peff.net/

As a sign of respect I probably wouldn't want to tweak the patches.

They currently work well together with my implementation, so there is no need.

> This "last becomes primary key" feels counterintuitive to me, however,
> I see it mirrors precedence of other Git commands.
>
> In what situations would it make sense to specify --sort= multiple
> times in the context of ls-remote? If there are none, then I wonder if
> this should instead be documented as "last wins"...
>
> To what does "Also" refer?

This was copied wholesale from Documentation/git-tag.txt.

I minimized the text now and removed all the references to using
'sort' multiple times. Although you technically could use multiple
keys, since 'ls-remote' only outputs two columns, I guess it's never
needed.

> What does "not work" mean in this context? Will the command crash
> outright? Will it emit a suitable error message or warning? Will the
> sorting be somehow dysfunctional?

This will be the output when trying to sort by commiterdate:

    From git@github.com:git/git.git
    fatal: missing object f0d0fd3a5985d5e588da1e1d11c85fba0ae132f8 for
refs/pull/10/head

I added a a note in the documentation saying that it will "cause a
failure". Should we be even more explicit than that?

This is one side-effect of borrowing the ref-filter logic in this
patch. We inherit things that won't work on remotes.

> It seems like the sentence "The keys supported..." should go above the
> "Also supports..." sentence for this explanation to be more cohesive.
>
> Finally, how about adding a linkgit:git-for-each-ref[1] to give the
> user an easy way to access the referenced documentation. For instance:
>
>     The keys supported are the same as those accepted by the
>     `--sort=` option of linkgit:git-for-each-ref[1], except...
>

Added a "linkgit" to git-for-each-ref. And a "See also" section at the bottom.

> Can we have a more meaningful name than 'array'? Even a name a simple
> as 'refs' would convey more information.

I think 'refs' would be confusing considering that the return value of
'transport_get_remote_refs' is stored as 'ref'. I renamed it to
'ref_array'. I hope it's not a problem that is shadows its struct
name. But I've seen us this naming paradigm in other places -- and in
this file.

> Do we need to worry about freeing memory allocated by these two lines?
>
> More generally, do we care that 'array' and 'sorting' are being
> leaked? If not, perhaps they should be annotated by UNLEAK.

Since 'cmd_ls_remote' is always (?) called from another process I
don't think we need to worry explicitly freeing the memory. I added
UNLEAK annotations to my code.

> This test script is already filled with these hardcoded SHA-1's, so
> this is not a new problem, but work is under way to make it possible
> to replace SHA-1 with some other hashing algorithm. Test scripts are
> being retrofitted to avoid hard-coding them; instead determining the
> hash value dynamically (for example, [1]). It would be nice if the new
> tests followed suit, thus saving someone else extra work down the
> road. (This, itself, is not worth a re-roll, but something to consider
> if you do re-roll.)
>
> [1]: https://public-inbox.org/git/20180325192055.841459-10-sandals@crustytoothpaste.net/

Added 'git rev-parse' calls to my tests do decrease the reliance on
SHA-1's. For the test

    ls-remote --symref

I couldn't figure out a way to extract the hash for
'refs/remotes/origin/HEAD' so I re-used HEAD. I tried different ways
of fetching origin, making another commit and pushing, but origin/HEAD
is still unavailable.

By calling 'git fetch origin' before the test, at least I am able to
extract 'git rev-parse refs/remotes/origin/master'.

This all makes the tests a bit more complicated, so I hope it helps us
in the future! :)

> Do we want a test verifying that multiple sort keys are respected? (Is
> it even possible to construct such a test?)

To add to my previous point: Since 'ls-remote' outputs only two
columns, I don't see a use case for multiple keys.

And I don't know what the test would look like either.

>> @@ -131,7 +167,7 @@ test_expect_success 'Report no-match with --exit-code' '
>>  test_expect_success 'Report match with --exit-code' '
>>         git ls-remote --exit-code other.git "refs/tags/*" >actual &&
>> -       git ls-remote . tags/mark >expect &&
>> +       git ls-remote . tags/mark* >expect &&
>>         test_cmp expect actual
>>  '
>
> Why this change?

I added the asterisk to 'mark*' because without it, the test

    Report match with --exit-code

will fail because the input 'git ls-remote refs/tags/*' now gives
gives back more tags (mark, mark1.1, mark1.2, mark1.10). So I think
the asterisk is the cleanest solution to not have to create e.g. two
separate setup functions.
