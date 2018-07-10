Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAD21F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeGJP3A (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:29:00 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46222 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754085AbeGJP27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:28:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id b14-v6so12675277vke.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ej1qI9OwsDVdwp2lbQdkelcxGr/KDF7iv+nGrvenTVs=;
        b=jRenGZSNYOypAxoCSuewzwcLx3E4mG8c3iIGIIbjyrDrhLSl6ptWKFgI7H5N8e/q3b
         Vl0SwGaCLxbC+yrix33e5C3CK5AKdFW90PG1zqDsbQS0G3mV4NFOTO0+DCRbKz2U9xFS
         m8gmXYsAmKecoEe0rKeFYIIi44Rkl9gkIhQT4yf3h6qvDZQ3+ugk578m37vzSEUYW9We
         09+OJB5N3Mc5VgqbEvEdofuMhsy2cx4euLdi0bkln1cka0xwo70lzJsaLGTLwg0Mn/Zp
         i+ifJYtc9Cvc2zH1Yk4upTPzlCnet0zMtCnCLvHD5rrqSETRWn6P+8TdxZj4STGqQLuw
         2pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ej1qI9OwsDVdwp2lbQdkelcxGr/KDF7iv+nGrvenTVs=;
        b=c1MKizQSTQPM95fOEIbsNfrkbyFFsCAv/pTWgrqMoZNdxKchiZUO4rUVOBJ7JrkIRT
         e6lwuV/1+VfCdFezfgG5SeuvjrAlX2RNfwFycbc4/2Vj+AY0RSdYV68/qtb9wUAb6Im+
         bx5RuyRyTbZQnQqKus+gAyNglvWowaz37ofEVOp6Hc59PuQkZAAfZiWh0jvMylgs872W
         caC3tljB+rECJgLy3GKj3g/yCn/OM1y7FnBq0L4euTJybQLH72DlctzXlpgyQSDcXs68
         wxlniIvQoQE4tbMxrX7aMVbBMrcbQlwVwHjPSSjgeFuPd2eFYpFXtFUagei5CVjP7RB8
         fmwA==
X-Gm-Message-State: APt69E2tnPQVRutWfHGz9Z6BOlCSiT9DRbzM7drRx/GEx1TjjmNgMKg6
        FKrXrU1axGMz5vNUYUNvlPC3iRcrZJfCMI+SUqs=
X-Google-Smtp-Source: AAOMgpffx3T1BA90ZqnlIOJZ3bPkHaihF+praLGqZFCQ3Z6LciqNhCyRLch6YBcPlcVQKFpEPnBOULkSkG0hS6szmFA=
X-Received: by 2002:a1f:3a89:: with SMTP id h131-v6mr13321273vka.184.1531236538852;
 Tue, 10 Jul 2018 08:28:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:28:57
 -0700 (PDT)
In-Reply-To: <CAGZ79kZ0xyHMT8SngGCUSAEf31NXdPvzkvdaPb8Khm27xRjgTg@mail.gmail.com>
References: <20180707204404.7208-1-newren@gmail.com> <20180707204404.7208-2-newren@gmail.com>
 <CAGZ79kZ0xyHMT8SngGCUSAEf31NXdPvzkvdaPb8Khm27xRjgTg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Jul 2018 08:28:57 -0700
Message-ID: <CABPp-BFjZZZ9uGXYe0gAA_VvcFmTsnurAknVrr-CytP2hT6wLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7405: add a file/submodule conflict
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 2:11 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Jul 7, 2018 at 1:44 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> In the case of a file/submodule conflict, although both cannot exist at
>> the same path, we expect both to be present somewhere for the user to be
>> able to resolve the conflict with.  Add a testcase for this.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>  t/t7405-submodule-merge.sh | 56 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
>> index 7bfb2f498..95fd05d83 100755
>> --- a/t/t7405-submodule-merge.sh
>> +++ b/t/t7405-submodule-merge.sh
>> @@ -279,4 +279,60 @@ test_expect_success 'recursive merge with submodule' '
>>          grep "$(cat expect3)" actual > /dev/null)
>>  '
>>
>> +# File/submodule conflict
>> +#   Commit O: <empty>
>> +#   Commit A: path (submodule)
>> +#   Commit B: path
>> +#   Expected: path/ is submodule and file contents for B's path are somewhere
>> +
>> +test_expect_success 'setup file/submodule conflict' '
>> +       test_create_repo file-submodule &&
>> +       (
>> +               cd file-submodule &&
>> +
>> +               git commit --allow-empty -m O &&
>> +
>> +               git branch A &&
>> +               git branch B &&
>> +
>> +               git checkout B &&
>> +               echo contents >path &&

This should have been 'content' rather than 'contents', given my grep below...

>> +               git add path &&
>> +               git commit -m B &&
>> +
>> +               git checkout A &&
>> +               test_create_repo path &&
>> +               (
>> +                       cd path &&
>> +
>> +                       echo hello >world &&
>
>     test_commit -C path &&
>
> or do we need a dirty submodule specifically?
> If so what is important, the untracked file or
> would changes in the index be sufficient?

Do you mean
    test_commit -C path hello
because test_commit needs at least one positional argument (which will
serve as contents, message, filename, and tag)?  Anyway, yeah, doing
this would remove the whole innermost subshell -- the cd, the echo,
the git add, and the git commit.

>
>> +                       git add world &&
>
> when observing this one in verbose mode , you may be
> asked to use 'git submodule add' instead
> https://github.com/git/git/blob/master/builtin/add.c#L323

Um, at this point, I'm adding a regular file -- not a submodule.  Also,
this git add will disappear if I use test_commit.  Perhaps you meant
one of the other 'git add's?

>
>> +                       git commit -m "submodule"
>
> Not sure if we'd need the shell it is only test_commit,
> the [submodule] add and commit, so maybe we can get away with
> 3 times -C ?

This also disappears with test_commit.

>
>> +test_expect_failure 'file/submodule conflict' '
>
> Which part fails here?

Addressed below...

>> +       test_when_finished "git -C file-submodule reset --hard" &&
>> +       (
>> +               cd file-submodule &&
>> +
>> +               git checkout A^0 &&
>> +               test_must_fail git merge B^0 >out 2>err &&

I probably shouldn't have redirected stdout and stderr here; makes it
harder for you to see what's happening, especially since I don't test
either in any way.

>> +
>> +               git ls-files -s >out &&
>> +               test_line_count = 2 out &&
>> +               git ls-files -u >out &&
>> +               test_line_count = 2 out &&
>> +
>> +               # path/ is still a submodule
>> +               test_path_is_dir path/.git &&
>> +
>> +               echo Checking if contents from B:path showed up anywhere &&
>
> This could be a comment instead?
>
>> +               grep -q content * 2>/dev/null
>
> Ah that is why we needed the specific echo above.

Yeah, if there was a handy
test_string_exists_in_some_file_in_current_directory I could have used
that, but seems like an oddly specific special test function, so I
just added an echo so someone watching the test output under --verbose
could see how far the test got.

> Sorry for being dense here, I am not quite following the last part of the test,
> as it is unclear what ought to fail in this test.

Hmm, I obviously wasn't nearly as clear as I thought I was.  Thinking
it over, two things may have thrown you off:

1) I had a typo ('content' vs. 'contents')
2) I didn't just check what was currently failing but other things
that should be true for this test.

For item 2, I've had multiple cases in the past where I created a
minimal test, only to find that if I had more carefully checked the
expected results that it would have prevented a future bug.  Also, it
was harder in the future to figure out, because I no longer remembered
the context for the test setup.  So, in this test I check the contents
of the index, make sure that the submodule is still present, and then
I finally check for the thing that currently fails:

commit B added a file called 'path'; its contents should appear
somewhere in the directory for the user to use when trying to resolve
the failed merge.  It cannot appear at 'path' (there's a submodule in
the way from commit A), but it should be present somewhere, and in
particular I'd expect it in the same directory.  So, I simply grep all
files in the current directory for the string (and ignore errors about
'grep: path is a directory').

Does that help?  If so, I'll submit a reroll with the changes and a
few extra comments.
