From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 12:30:02 +0530
Message-ID: <CAFZEwPPNMtopk9a3nVaCuujWoyeA5+39vEj3Mct1YckCXLh1-A@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<CAPig+cTBxH7BAs2M+PBwTHfVJvH0ADL1OSEKdHQY59L-WiYosA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 09:00:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak4gD-0000vm-A3
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 09:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcC0HAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 03:00:04 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34717 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbcC0HAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 03:00:03 -0400
Received: by mail-qk0-f194.google.com with SMTP id u128so8731153qkh.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9srPIm0516XIlMDp8POv0QU1dIU6jWGZE+pAp0A2YJI=;
        b=RpPInqPB0eiK2SxdKcwMEmG3aBpYQ/zPCLkcyuGHPPC+bgoHCxzVCBu0bQ+zeWbZTM
         HQ0e4H+XYAhxeznkrLxGL7mzZl1xURBm1Zhi5PU9AxE7Vh+1/auce3segk564/DCznKP
         hua0JLjS39MoyvXSZhwHygdCMcgeunOJo50XwV42cARztcgVYOYLCC8P8SzqtpoadSgy
         uVlBGHNnHfOr6enI5fCJDZEMeWSh9CjBPju+NKCXM7R7MvFSmEODxTAwAiJhJ6utoGAK
         Sf6eemWyXhLAEzMd8g7ccFjdPv91TpJUDOzcQm5Q8vNGphKFDAQxONa1xvFCWMFTn/sV
         Mrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9srPIm0516XIlMDp8POv0QU1dIU6jWGZE+pAp0A2YJI=;
        b=kcLLgXVQBOvEigTNvKceSrBxIgDSvYIKC/3ZpvZ7IafXFsGmQCkb8DtE63IDkOZQLA
         yPX2bwoEntawwyjONykfWyB8j3JFQkecHDogERo+K+sD0SsViAMAJSdAs4/VdHr2Zu/s
         B7jFo+getqizcLI4Ex8ekQ3uZ8q7ePS6sWF2HHaqa2j+oyA0XgffLv6sj3gjFTAecAMP
         Ct6tp8vFACytt4vo4nHcmejxhP5qRxMQjb079Jrz3mu7HFl6MGFeWwXRnecA7c4FMaJM
         hH+2dfIg1ZNQGVemHag3DE8h6TbnDcF2/CkfVINCTRApLyfEiOQGE0LdMBxDC0Fbgj58
         GT3w==
X-Gm-Message-State: AD7BkJLbbQz/o7sKbnx43vFCRYjyIZiPe+VYzPDzlV97fZ9C4KuTql+2Y3GHLK94LvVvhLcIcxZ6L7cTXaepOg==
X-Received: by 10.129.37.3 with SMTP id l3mr10518365ywl.128.1459062002232;
 Sun, 27 Mar 2016 00:00:02 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 00:00:02 -0700 (PDT)
In-Reply-To: <CAPig+cTBxH7BAs2M+PBwTHfVJvH0ADL1OSEKdHQY59L-WiYosA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289996>

On Sun, Mar 27, 2016 at 9:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Add commit.verbose configuration variable as a convenience for those
>> who always prefer --verbose taking care of multiple levels of verbosity.
>
> What does "taking care of multiple levels of verbosity" mean? I
> suppose you mean that commit.verbose specifies a verbosity level
> (rather than being merely boolean), but that phrase is difficult to
> decipher. And, since it's obvious from the patch itself that verbosity
> is not a mere boolean, there isn't really a need to mention it here.
> The commit message would be perfectly fine without that bit, so
> perhaps just drop it.

I will drop it.

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> ---
>> Changes with respect to the previous patch:
>>  - Fixed a status related bug pointed out by SZEDER
>>  - Change some tests
>
> Please help reviewers out by being a bit more verbose when describing
> the changes. For instance, what bug did you fix pointed out by SZEDER?
> And, "change some tests" says nothing useful. What did you change in
> the tests?

I will try and be more specific henceforth.

>> ---
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> @@ -1355,6 +1357,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>         finalize_colopts(&s.colopts, -1);
>>         finalize_deferred_config(&s);
>>
>> +       if (verbose == -1)
>> +               verbose = 0;
>> +
>
> Nit: It might be good to drop the blank line above this new
> conditional to make it clear that it is part of the
> init_config/parse_options processing (the tail of which is visible in
> the context above).

Sure.

>>         handle_untracked_files_arg(&s);
>>         if (show_ignored_in_status)
>>                 s.show_ignored_files = 1;
>> @@ -1654,6 +1664,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>         argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>>                                           builtin_commit_usage,
>>                                           prefix, current_head, &s);
>> +
>> +       if (verbose == -1)
>> +               verbose = (config_verbose == -1) ? 0 : config_verbose;
>> +
>
> Nit: For consistency, dropping the blank line above this new
> conditional wouldn't hurt either.
>
>>         if (dry_run)
>>                 return dry_run_commit(argc, argv, prefix, current_head, &s);
>>         index_file = prepare_index(argc, argv, prefix, current_head, 0);
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> @@ -101,4 +101,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
>> +test_expect_success 'commit.verbose true and --verbose omitted' '
>> +       echo content >file2 &&
>> +       echo content >>file &&
>> +       git add file2 &&
>> +       git -c commit.verbose=true commit -F message &&
>> +       test_line_count = 1 out
>> +'
>
> Why is this test so utterly different than it was in v9 (even though
> the title is the same), and why is it so different from other tests
> below?

This is because the "editor" in v9 checked for "# Changes"... While
this "editor" checks for 'diff --git'. And submodules don't give a
proper diff to verify (I tried this out and noticed this behavior by
tweaking some parts). In fact submodules don't give diff at all. But
they do give "# Changes"... So its important to setup up a little
before getting started. If this seems unnecessary, then should I move
all the tests which were introduced here above the submodule test?

> More below...
>
>> +test_expect_success 'commit.verbose true and --verbose' '
>> +       git -c commit.verbose=true commit --amend --verbose &&
>> +       test_line_count = 1 out
>> +'
>> +
>> +test_expect_success 'commit.verbose true and -v -v' '
>> +       git -c commit.verbose=true commit --amend -v -v &&
>> +       test_line_count = 2 out
>> +'
>> +
>> +test_expect_success 'commit.verbose true and --no-verbose' '
>> +       git -c commit.verbose=true commit --amend --no-verbose &&
>> +       ! test -s out
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --verbose' '
>> +       git -c commit.verbose=false commit --amend --verbose &&
>> +       test_line_count = 1 out
>> +'
>> +
>> +test_expect_success 'commit.verbose false and -v -v' '
>> +       git -c commit.verbose=false commit --amend -v -v &&
>> +       test_line_count = 2 out
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --verbose omitted' '
>> +       git -c commit.verbose=false commit --amend &&
>> +       ! test -s out
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --no-verbose' '
>> +       git -c commit.verbose=false commit --amend --no-verbose &&
>> +       ! test -s out
>> +'
>> +
>> +test_expect_success 'status ignores commit.verbose=true' '
>> +       git -c commit.verbose=true status >actual &&
>> +       ! grep "^diff --git" actual
>> +'
>
> The fact that v9 broke a number of tests in other scripts which use
> git-status (as SZEDER pointed out[1]), due to initializing 'verbose'
> to -1 in builtin/commit.c, suggests that you probably ought to add
> another test here to protect against that sort of breakage, as well.
> Specifically, git-status should remain non-verbose when neither
> commit.verbose nor --verbose is specified.

Yes, I should. I will include that.
>> +
>>  test_done
