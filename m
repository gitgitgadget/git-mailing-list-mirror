Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AEE1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 02:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeGZDXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 23:23:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44991 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbeGZDXG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 23:23:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id g6-v6so85584lfb.11
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=78noBlFzoOrP+aXrkVFxoB74nkKu8I9qqTd3Y9Avbzg=;
        b=hGkO1wCJft20cS41067FuC4xQbnFlbUJm7SjCa19/FIRDlQRGYzP+PtoW/dP6kRZO4
         D5LG/29MoHdlG5W0Ml3eG3lAL2ABOqDBcboQouEw7Xef66Wt3Ifhf8UOVvBKrG2HwXJb
         UmuRl2pqIEFhhc96mzuwq4oJ20GoMR935tSVlzf50FHZtxb/eokkU6955VdmANSubhZz
         keYx7JTgJubmyKD+0msKhcpQvTi2SwS4LznFOWMV6oIToZIJXeY9gnd9J4AwTQ5LKetq
         rszfnihxnBt461dUdTHqy0K3Qo6/iYvvdWFd1gecgCVZ2SXxyZ0pLrZiNmcwZyHcVOUr
         u4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=78noBlFzoOrP+aXrkVFxoB74nkKu8I9qqTd3Y9Avbzg=;
        b=iVyABZofspZWSFJLNn70LPhWwzKvs+loHvSBnAfZYAKGIw6xVLgtrBvV4KyGRqpblZ
         brhmQJ99TEO2BceQLi0DdICs1F1baBnQmsr4E8mP7vwy6WLK7dgbsQgS8DtxrzU8Rc8e
         TVFF019grWg+90PFLRBkthCrjr8oAZ98lXEf+DDjISuXTWLv8F38mSU/QdJROjtJVNWz
         ptEziO0nl5sVfFuMCXqx3jfjsaz80ipagK/aZrQRYEVycUbumAbHZb/dHg7RgdNBGH44
         WRd4SjMFrGEJsR6s+xP+yfdPBtnAtQIRK2eXfZQ91HmvglAsa5ag5i1ma5LYaRm5prMC
         hExw==
X-Gm-Message-State: AOUpUlE/AjtNdOUIEmfHdhR1F1gW3Zs+J+bXB+s643hQ2E+2JhcqBdDy
        qef0djN1tUZbE1QDJUwT+q5pjpvghcGwmyE13EYfzg==
X-Google-Smtp-Source: AAOMgpfZ8dIk+lH5MTI9+QThslnuforu2/UKifatnp0CYbJhOGwmx2u+XikkcPkeBjH/tI1TEpyoZb3OH3oxnNSYDHE=
X-Received: by 2002:a19:c1c4:: with SMTP id r187-v6mr11714lff.90.1532570916286;
 Wed, 25 Jul 2018 19:08:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:88d7:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 19:08:35
 -0700 (PDT)
In-Reply-To: <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <20180725134345.8631-1-chenbin.sh@gmail.com> <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Thu, 26 Jul 2018 12:08:35 +1000
Message-ID: <CAAE-R+_BWJAB3zsZUZ+=Zn6SiSkzrWG0EYwBF_OcX_V+2idCww@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.

The hook does not receive any information or input from git. The
original requirement
comes from my colleague. He want to run unit test automatically before
submitting code
to remote repository. Or else CI server will send the blame mail to the manager.

The hook actually stops the submit process from start instead of abort
submit in midway.
So nothing is touched when hook exits with status 1.

I'm not sure whether `git-p4` should print some "hook rejection" message.
Current implementation is same as other hooks (`pre-commit`, for example).
Only hook itself is responsible to print error messages.

Personally I don't have opinion whether we should print out hook
related message inside
`git-p4.py`. I just try to following existing convention of git.


What you guys think?

Regards,
Chen

On Thu, Jul 26, 2018 at 6:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 25, 2018 at 9:45 AM Chen Bin <chenbin.sh@gmail.com> wrote:
>> Hook pre-p4-submit is executed before git-p4 actually submits code.
>> If the hook exits with non-zero value, submit process will abort.
>
> Bikeshedding: Should this be named 'p4-pre-submit'? That way, if
> git-p4 ever grows additional hooks, they can all be grouped under the
> "p4-" prefix.
>
> More below...
>
>> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
>> ---
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> @@ -374,6 +374,13 @@ These options can be used to modify 'git p4 submit' behavior.
>> +Hook for submit
>> +~~~~~~~~~~~~~~~
>> +Hook `pre-p4-submit` is executed if it exists and is executable.
>> +Exiting with non-zero status from this script cause `git-p4 submit` to abort.
>> +By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
>
> Does the hook receive any arguments? Does it receive anything on its
> standard input? Those questions ought to be answered by the
> documentation.
>
> Also, how is the hook supposed to determine whether the "submit"
> should proceed? How does it know what is being submitted? Perhaps the
> documentation could provide some explanation of how the hook should
> glean such information (especially if the hook does not itself receive
> any input).
>
>> diff --git a/git-p4.py b/git-p4.py
>> +        # locate hook
>> +        hooks_path = gitConfig("core.hooksPath")
>> +        if len(hooks_path) > 0:
>> +            hook_file = os.path.join(hooks_path, "pre-p4-submit")
>> +        else:
>> +            hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
>> +
>> +        # Execute hook. If it exits with non-zero value, do NOT continue.
>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
>> +            sys.exit(1)
>
> Nit: The two #comments merely repeat what the code itself already says
> clearly enough, thus don't add value (so can be dropped).
>
> Should this be emitting some sort of message letting the user know
> that the operation was aborted due to the hook's "rejection"? That
> could be especially important if the hook itself is silent (or buggy).
>
>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>> @@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>> +# Test following scenarios:
>> +#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
>> +#   - With hook returning 0, submit should continue
>> +#   - With hook returning 1, submit should abort
>
> Testing three separate cases would normally be done with three
> separate tests, making it easier to figure out which case failed. But,
> perhaps it doesn't matter here.
>
>> +test_expect_success 'run hook pre-p4-submit before submit' '
>> +       test_when_finished cleanup_git &&
>> +       git p4 clone --dest="$git" //depot &&
>> +       (
>> +               cd "$git" &&
>> +               echo "hello world" >hello.txt &&
>> +               git add hello.txt &&
>> +               git commit -m "add hello.txt" &&
>> +               git config git-p4.skipSubmitEdit true &&
>
> The wholesale removal of the $git directory by cleanup_git() when the
> test finishes is undoing this config setting. Ditto regarding the
> hooks created below. Okay.
>
>> +               git p4 submit --dry-run | grep "Would apply" &&
>
> We normally don't use a git command upstream in a pipe since the exit
> code of that command gets lost (so, if it crashes, we don't know about
> it). Instead:
>
>     git p4 submit --dry-run >out &&
>     grep "Would apply" out &&
>
> Also, if "Would apply" is localized, we'd use test_i18ngrep (but you
> don't need it in this case).
>
>> +               mkdir -p .git/hooks &&
>> +               : >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&
>
> It might be clearer to readers of this test to use an explicit "exit
> 0" here (complementing the "exit 1" below). The current asymmetry
> required extra cognitive effort to realize that this is the "returning
> 0" case mentioned in the comment above the test.
>
>> +               git p4 submit --dry-run | grep "Would apply" &&
>> +               echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&
>
> Use write_script() for this, which takes care of the #!/bin/sh line
> and doing chmod:
>
>     write_script >.git/hooks/pre-p4-submit <<-\EOF &&
>     exit 1
>     EOF
>
>> +               git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"
>
> More idiomatic in this test suite:
>
>     git p4 submit --dry-run >out &&
>     ! grep "Would apply" out
>
>> +       )
>> +'



-- 
help me, help you.
