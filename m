Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810F9201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 00:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdKNA5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 19:57:34 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:49721 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdKNA5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 19:57:33 -0500
Received: by mail-vk0-f46.google.com with SMTP id t184so11235606vka.6
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 16:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OucvlYix9452F7f5SPQLx3nR5B5Shn+NdFh3w/hEd6I=;
        b=XA7gWEVx2RcIeAH+VPlTylibFkDwU6ZGzZUTG5zDg4nP/cW9I/YLl5S3IASWzW/Vl+
         915fJUiaUkYX/d2iPb2a9U3uyakEPslVuSxwd4C+n4SucXhyJ8gQM0vGaR9QSBOrBfKs
         4YVVbEtHpb/jb5JuvRPVqmSYl52TNPdClabumC2jJVZqYtTnGlyW7czyj2kXA/gJ2o4s
         /M3dFme+ghvwP3kwUFavPJCPZkrRG7tSx+6StvRfKrNL/TYOLqznJHf6t+c0TBNLSpAX
         DjfxKEjNa/7tjE8dCMINyImE9gBKXCKrQ/V9nEibrNTfCKV6HGM/NojCUVcUBqRCBu1A
         aSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OucvlYix9452F7f5SPQLx3nR5B5Shn+NdFh3w/hEd6I=;
        b=tLfQqw8+Xi7F34CmzVeyN3Yruw8Lb+DOQ/EeUxClkjBv1sZPuge+T2eqNlX/y0fZvp
         dRwOOGzE4/ypj1RIiouLLd4D3IyzXSH0ofPVAhFetHptWialbCBMgj6ShiyvDvMPUarJ
         470jZaQ87vBDIhQi6CpblJSzqFpPYyDvaJN7qPZuBlQSCVtGyB3+l0cI8l12OBq0TaAY
         EPu3tIus2RCNxetijJywycvrodvGRKze9f6udLIFbzvHzFRXvPv0fNeuKmZfS0JrjGri
         6sjilkM64OAvmvp/ogiEg6Ut7KlX2qHm/z+Zasan/ziDpg2rD5dWpD6GMvCgbkq9mQe0
         x1uw==
X-Gm-Message-State: AJaThX5LSvTt/lrJ7nN029z+4SNw6pLjdNQz8TSKCzp1b6mOTQ8VGy4C
        3O6Slpf1WxrGvh75NKGPQgeS+ExPzo8ImR5rYik=
X-Google-Smtp-Source: AGs4zMYbLvPtK98jPFaG+mfzyGCPk2jEOkpVNEiR1Y5wUn5+dJEmJmfABICqpSbE0iepT495sxonwC6zCv1yPDf4rqU=
X-Received: by 10.31.61.11 with SMTP id k11mr8245476vka.153.1510621052092;
 Mon, 13 Nov 2017 16:57:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 16:57:31 -0800 (PST)
In-Reply-To: <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-5-newren@gmail.com>
 <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 16:57:31 -0800
Message-ID: <CABPp-BFKiam6AK-Gg_RzaLuLur-jz0kvv3TqsHNHg5+HTv_uzA@mail.gmail.com>
Subject: Re: [PATCH 04/30] directory rename detection: basic testcases
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 2:04 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> (minor thought:)
> After rereading the docs above this is clear; I wonder if instead of A, B, C
> a notation of Base, ours, theirs would be easier to understand?

Sure, that'd be an easy change.

>> +test_expect_success '1a-setup: Simple directory rename detection' '
>> +test_expect_failure '1a-check: Simple directory rename detection' '
>
> Thanks for splitting the setup and the check into two different test cases!
>
>
>> +       git checkout B^0 &&
>
> Any reason for ^0 ? (to make clear it is a branch?)

Partially force-of-habit (did the same with t6036 and t6042), but it
seemed to have the nice feature of making debugging easier through
improved reproducability.  In particular, if I had checked out B
rather than B^0 in the testcase and a merge succeeded when I didn't
expect it, then attempting to run the same commands gives me a
different starting point for the merge.  By instead explicitly
checking out B^0, then even if the merge succeeds, someone who again
runs checkout B^0 will have the same starting point.

>> +test_expect_success '1b-setup: Merge a directory with another' '
>> +       git rm -rf . &&
>> +       git clean -fdqx &&
>> +       rm -rf .git &&
>> +       git init &&
>
> This is quite a strong statement to start a test with.

It was actually copy-paste from t6036, and achieved two purposes:
  1) Even if one test fails, subsequent ones continue running.  (Had
lots of problems with this in t6036 years ago and just ended up with
those four steps)
  2) Someone who runs into a failing testcase has a _much_ easier time
figuring out what is going on with the testcase.  I find it takes a
fair amount of time to figure out what's going on with other tests in
git's testsuite because of the presence of so many files completely
unrelated to the given test, which have simply accumulated from
previous tests.  For many tests, that may be fine, but in particular
for t6036, t6042, and now t6043, since these are mostly about corner
cases that are hard enough to reason about, I didn't want the extra
distractions.

but...

> Nowadays we rather do
>
>     test_when_finished "some command" &&
>
> than polluting the follow up tests. But as you split up the previous test
> into 2 tests, it is not clear if this would bring any good.

test_when_finished looks pretty cool; I didn't know about it.  Thanks
for the pointer.  Not sure if we want to use it here (if we do, we'd
only do so in the check tests rather than the setup ones).

> Also these are four cleanup commands, I'd have expected fewer.
> Maybe just "rm -rf ." ? Or as we make a new repo for each test case,
>
>     test_create_repo 1a &&
>     cd 1a
>
> in the first setup, and here we do
>     test_create_repo 1b &&
>     cd 1b
>
> relying on test_done to cleanup everything afterwards?

rm aborts for me with 'rm -rf .', but I could possibly make it 'rm -rf
* .* && git init .'

The test_create_repo might not be so bad as long as every test used it
and put all files under it's own little repo.  It does create some
clutter, but it's at least somewhat managed.  I'm still a bit partial
to just totally cleaning it out, but if others would prefer, I can
switch.

>> +       test 3 -eq $(git ls-files -s | wc -l) &&
>
>     git ls-files >out &&
>     test_line_count = 3 out &&
>
> maybe? Piping output of git commands somewhere is an
> anti-pattern as we cannot examine the return code of ls-files in this case.

Um...I guess that makes sense, if you assumed that I cared about the
return code of ls-files.  But it seems to make the tests with multiple
calls to ls-files in a row (of which there are many) considerably
uglier, so I'd personally prefer to avoid that.  Also, why would I
care about the return code of ls-files?

Your suggestion made me curious, so I went looking.  As far as I can
tell, the return code of ls-files is always 0 unless you both specify
both --error-unmatch and one or more paths, neither of which I did.
Am I missing something?

If you feel the return code of ls-files is important, perhaps I could
just have a separate
   git ls-files -s >/dev/null &&
call before the others?

>> +       test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
>> +       test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
>> +       test $(git rev-parse HEAD:y/d) = $(git rev-parse A:x/d) &&
>
> Speaking of these, there are quite a lot of invocations of rev-parse,
> though it looks clean; recently Junio had some good ideas regarding a
> similar test[1].
> So maybe
>
>   git rev-parse >actual \
>     HEAD:y/b  HEAD:y/c HEAD:y/d &&
>   git rev-parse >expect \
>     A:z/b    A:z/c    A:x/d &&
>   test_cmp expect actual
>
> Not sure if that is any nicer, but has fewer calls.

Sure, I can switch it over.

>> +       test_must_fail git rev-parse HEAD:x/d &&
>> +       test_must_fail git rev-parse HEAD:z/d &&
>> +       test ! -f z/d
>> +'
>> +
>> +# Testcase 1d, Directory renames (merging two directories into one new one)
>> +#              cause a rename/rename(2to1) conflict
>> +#   (Related to testcases 1c and 7b)
>> +#   Commit A. z/{b,c},        y/{d,e}
>> +#   Commit B. x/{b,c},        y/{d,e,m,wham}
>> +#   Commit C. z/{b,c,n,wham}, x/{d,e}
>> +#   Expected: x/{b,c,d,e,m,n}, CONFLICT:(y/wham & z/wham -> x/wham)
>> +#   Note: y/m & z/n should definitely move into x.  By the same token, both
>> +#         y/wham & z/wham should to...giving us a conflict.
>
> If wham are equal (in oid), shouldn't this not conflict and only conflict
> when z/wham and x/wham differ in oid, but have the same sub-path?

Good eyes, I should have labelled these as wham_1 and wham_2, since
the testcase did explicitly make them different (having contents of
"wham1\n" and "wham2\n"), but it could make sense to add a test to the
testsuite where two such colliding files are identical.

I thought about that, figured it wasn't worth it, and didn't add the
code to handle it.  I could add a testcase for it, though I'd be very
tempted to just leave it as test_expect_failure and let someone else
come along and implement it if someone feels so inclined.  Note,
though, that the situation is made slightly more complex due to the
fact that it might be N colliding files rather than just 2 (due to the
possibility of multiple directories being merged into one on either
side of history).

>> +
>> +# Testcase 1e, Renamed directory, with all filenames being renamed too
>> +#   Commit A: z/{oldb,oldc}
>> +#   Commit B: y/{newb,newc}
>> +#   Commit C: z/{oldb,oldc,d}
>
> What about oldd ?
> (expecting a pattern across many files of s/old/new/ isn't unreasonable,
> but maybe too much for now?)
> By having no "old" prefix there is only one thing to do, which is y/d

I'm not following.  The "old" and "new" in the filenames were just
there so a human reading the testcase could easily tell which
filenames were related and involved in renames.  There is no rename
associated with d, so why would I have called it "old" or "new"?

>> +# Testcase 1f, Split a directory into two other directories
>> +#   (Related to testcases 3a, all of section 2, and all of section 4)
>> +#   Commit A: z/{b,c,d,e,f}
>> +#   Commit B: z/{b,c,d,e,f,g}
>> +#   Commit C: y/{b,c}, x/{d,e,f}
>> +#   Expected: y/{b,c}, x/{d,e,f,g}
>
> Why not y/g ? Because there are more files in x?

Yes.

> I can come up with a reasonable counter example:

Oh sure, of course.  You should also be able to come up with
counter-examples to the "correctness" of git's content merging of
files when it fails to report any conflicts (e.g. one side added
another call to a function, the other side changed the number of
parameters the function took).  In short, this is just a case of where
we need to come up with simple predictable rules since we can't read
minds.  Here's the situation we're faced with, and my line of thinking
in coming up with this simple, predictable, but definitely coarse
rule:

  * Users sometimes rename directories on one side of history and add
files to the original directory on the other side.
  * We would like to "detect" the directory rename, and move the new
files into the correct directory.
  * We don't really have any hints for detecting directory renames
other by comparing content, i.e. basing it on the file rename
detection we already have.
  * There is a possibility that not all files in a certain directory
went to the same location.  It's possible that a few may have gone
elsewhere.
  * Only in weird corner cases would I expect renamed-file location to
be split nearly 50-50 (as in this contrived testcase) -- although for
such cases, as you point out, there is a much higher chance of us
getting the merge "wrong".  Thus, our rule should be simple so people
can understand and expect what we did and have an easy time fixing it.

So, what to do?  There are a few options:
  1) Don't do directory rename detection at all.  Just declare it to
be an anti-feature.
  2) Try to guess why the user moved different files to different
directories and try to mimic that somehow.
  3) Only allow directory rename detection to happen when ALL renamed
files in the directory went to the same directory.
  4) Use a simple predictable rule like majority wins.

I think 2 is insanity.  Choices 1 and 3 don't have much appeal to me;
I'm strongly against them.  I'm unware of any remaining choices other
than 4, but 4 seems pretty reasonable to me.  It won't always be
right, but neither is simple content merging.
