Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BD61F404
	for <e@80x24.org>; Thu,  5 Apr 2018 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeDEUGd (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 16:06:33 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46780 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDEUGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 16:06:32 -0400
Received: by mail-vk0-f67.google.com with SMTP id v205so13786216vkv.13
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B7MKANmGQakgkbBq8LAJl37KUyozbCVbu+nQ/b7SAik=;
        b=a0NkKzPSNlxDxUpqbGH7qYXKVKx6i/0ykEMfj+3R59c842trgYYQf7MHo13Ka/csmN
         jMR8TgutudZtj/aoqE+xHfpmJlm6kOJ564o67CVViC/SeT1/KDgrA6qgP7hO9Gb240a1
         P9CLLvgh2LPbtDu6YaSlskWd6YjPJHYNYt+EbwxCOBv6o453eEiPFEwlc6gvg6kTPIGQ
         8wFFJju1WePoU8FbllkR78QfN//kUf0h7AvHQev6XkSdRO1m28PGO8ZrkP7vIqkAwuOi
         Xrsxn0YoeCidHskkm/Sd/l1JA64DFUubQzvdheWxsr8Njoihs1nFHtITsqTnJoq44aBy
         jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B7MKANmGQakgkbBq8LAJl37KUyozbCVbu+nQ/b7SAik=;
        b=i3ZT9fwi5j9uov01G9LIRXfBPWZ27CDM8LCIGYTKxbfA6kQnV3JYnyMCZzX7/TI7+H
         JVCVqtc+xqtgdd6OG4GPPZ8vXJjjOmdALBSeQ1hr+Cb39pZ6LMP9ijfisYzBnHyqN6zJ
         2nf518Dv/D2BC6l6V6N6dOzmFFhNlFbZhaETOq4PYRx98CmmFhtQ6cCZzgeJocTPY/0o
         KI0dTK63s3qwXu2X5ngsCduXW97DdKAPwTkoTTc+l5ncE2syJGvDG/J7fUF/kaD2OoRC
         f8cUqQntxY8zsvTKbAfO5e1TTYVm8f6YSN8OtkrZP2EjO6mGVNea7ckHoB9dmIZvDpkv
         /vog==
X-Gm-Message-State: ALQs6tChuNNk+5RRUbtyFvLTiw5+rP6Kdj+nglPhFl6PofoFRqrQd+r1
        ChEGS2uPEE0OFP2amQDzOjfM6lgS0GH1rDSfCrk=
X-Google-Smtp-Source: AIpwx49v/Zupx6gmRVz1fiCJ6P9PY1vnpjWrXactRBm9e6h7Q+gChrCCQYRf3sbmvwX/6N8z182aX+JLAUfpi65/65U=
X-Received: by 10.31.150.143 with SMTP id y137mr3205340vkd.118.1522958791031;
 Thu, 05 Apr 2018 13:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Thu, 5 Apr 2018 13:06:30 -0700 (PDT)
In-Reply-To: <20180405190446.GB21164@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com> <20180405173446.32372-3-newren@gmail.com>
 <20180405174925.GA19974@sigill.intra.peff.net> <CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com>
 <20180405190446.GB21164@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Apr 2018 13:06:30 -0700
Message-ID: <CABPp-BF0GaYMubkckqwRSo_2J_JNtd+xOtSUOLUZH3xhE0rRHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] dir.c: fix off-by-one error in match_pathspec_item
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 12:04 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 05, 2018 at 11:36:45AM -0700, Elijah Newren wrote:
>
>> > Do we care about matching the name "foo" against the patchspec_item "foo/"?
>> >
>> > That matches now, but wouldn't after your patch.
>>
<snip>
>> So I should probably make the check handle both cases:
>>
>> @@ -383,8 +383,9 @@ static int match_pathspec_item(const struct
>> pathspec_item *item, int prefix,
>>         /* Perform checks to see if "name" is a super set of the pathspec */
>>         if (flags & DO_MATCH_LEADING_PATHSPEC) {
>>                 /* name is a literal prefix of the pathspec */
>> +               int offset = name[namelen-1] == '/' ? 1 : 0;
>>                 if ((namelen < matchlen) &&
>> -                   (match[namelen] == '/') &&
>> +                   (match[namelen-offset] == '/') &&
>>                     !ps_strncmp(item, match, name, namelen))
>>                         return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
>
> That seems reasonable to me, and your "offset" trick here should prevent
> us from getting confused. Can namelen ever be zero here? I guess
> probably not (I could see an empty pathspec, but an empty path does not
> make sense).

Right, I don't see how an empty path would make sense.

> There are other similar trailing-slash matches in that function, but I'm
> not sure of all the cases in which they're used. I don't know if any of
> those would need similar treatment (sorry for being vague; I expect I'd
> need a few hours to dig into how the pathspec code actually works, and I
> don't have that today).

If it'd only take you a few hours, then you're a lot faster than me.
It took me a while to start wrapping my head around it.

The other trailing-slash matches in the function are all correct,
according to the testsuite.  (I'm not sure I like the
DO_MATCH_DIRECTORY stuff, but it is encoded in tests and backward
compatibility is important.)  In particular, changing the earlier code
to have the same offset trick would make it claim that e.g. either
"a/b" or "a/b/" as names match unconditionally against "a/b/c" as a
pathspec.  We need it to be conditional: we only want that to be
considered a match when checking whether we want to recurse into the
directory for other matches, not when checking whether the directory
itself matches the pathspec.  Thus, it should be behind a separate
flag, in a subsequent check, which is what this series does (namely
with DO_MATCH_LEADING_PATHSPEC).

To be more precise, here is how a matrix of pathnames and pathspecs
would be treated by match_pathspec_item(), where I am abbreviating
names like MATCH_RECURSIVELY_LEADING_PATHSPEC to LEADING):

                               Pathspecs
                |    a/b    |    a/b/    |   a/b/c
          ------+-----------+------------+-----------
          a/b   |  EXACT    | RECURSIVE  |  LEADING[3]
  Names   a/b/  |  EXACT[1] |  EXACT     |  LEADING[2]
          a/b/c | RECURSIVE | RECURSIVE  |  EXACT

[1] Only if DO_MATCH_DIRECTORY is passed.  Otherwise,
    this is NOT a match at all.
[2] Only if DO_MATCH_LEADING_PATHSPEC is passed,
    after applying this series.  Otherwise, not a match
    at all.
[3] Without the fix in this thread that you highlighted,
    and assuming we apply patch 7, this would actually
    mistakenly return RECURSIVE.


Now for a separate question: How much of the above would you like
added to the commit message...or even as a comment in the code to make
it clearer to other folks trying to make sense of it?


Elijah
