From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 14:10:19 +0530
Message-ID: <CAFZEwPMSpJGgTeHm41FYXiXgx7whFT0BsqUEBJ2ZJOsfydKxVw@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<CAPig+cTBxH7BAs2M+PBwTHfVJvH0ADL1OSEKdHQY59L-WiYosA@mail.gmail.com>
	<CAFZEwPPNMtopk9a3nVaCuujWoyeA5+39vEj3Mct1YckCXLh1-A@mail.gmail.com>
	<CAPig+cStkyOE4MwmFpq9V8h5M=6j=FWbDTkyMGXZsf8sBH=9pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 10:40:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak6FN-0000Du-F7
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 10:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbcC0IkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 04:40:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36032 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcC0IkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 04:40:20 -0400
Received: by mail-qk0-f193.google.com with SMTP id e124so8982134qkc.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=C3lSeNsIJc4BVYUSLnphruQVB1DBYiZNZFERx/FjYRM=;
        b=Bh+qsYlCEijlMygbZyo9C5kk0AqntIZYt1S473zyPpTheQYbnsqGXmU6co2iugrzBD
         QbQ/hg+54dzA4wtoWpyLz3B+XQzVgJz3TObijs028B2ksm+Z/inKzKk+TfqKbYz2Eqo3
         lJpHPtnczKHMeYJDHWPPNu9twTyffgl+1JcIhe3szLpL5tuuF/Zew6afeXVYckvsbasr
         vsbV9CsFY/CzZiFCvz4iW6wCD2ggVEi00iab151LqA0yTcDy669+/Je+RPEHWqowuZMq
         aSVk+qxJGGLN5m/U4sqp/YnqqtZHGkSHzW/PHPlWZqbGHshIJKV2gwMlXTdT1eSvb2Jf
         WHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=C3lSeNsIJc4BVYUSLnphruQVB1DBYiZNZFERx/FjYRM=;
        b=mvbzgD9mqD3NUrsOtLMvBREDva6trqO0H1Tx4vbhBZLQHwVOtrCIYPXEz4lRcjMHB6
         LJ8NIqaDs3daRMYBZ3Y2NJBThAHYVAn70v721wcP9OV2hRDYKcikeMQ2XGOTFcIttLTW
         c+Ifa4jFQmO6z4wsurKXeOlbwWy1vQDjBI5QV9sIII9e/+rw9QuaN96lWYTakXugDIvg
         3IVuCorF4fHn+1fMLk12vdUxipvgj/9vBfD1W9ifn1uldGqNvJlzb+zxAaHhKoX2XhJE
         7+HwbnXAGIh0jrJ7K9B+MKIGUHpOVD6LYh7tKIPnFGcv+KCe9ysF0ZNb1VBkV2ftTEMz
         GwPw==
X-Gm-Message-State: AD7BkJJ/c/iSES7Q8LAtWRwtrqKnqZXN9VuzpyU8lcgx+R9v8UWqPNVwwIW626LER0SK4Y2tp3NxG/941ThgEg==
X-Received: by 10.37.1.196 with SMTP id 187mr11035322ybb.53.1459068019145;
 Sun, 27 Mar 2016 01:40:19 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 01:40:19 -0700 (PDT)
In-Reply-To: <CAPig+cStkyOE4MwmFpq9V8h5M=6j=FWbDTkyMGXZsf8sBH=9pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290001>

On Sun, Mar 27, 2016 at 1:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 27, 2016 at 3:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, Mar 27, 2016 at 9:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +test_expect_success 'commit.verbose true and --verbose omitted' '
>>>> +       echo content >file2 &&
>>>> +       echo content >>file &&
>>>> +       git add file2 &&
>>>> +       git -c commit.verbose=true commit -F message &&
>>>> +       test_line_count = 1 out
>>>> +'
>>>
>>> Why is this test so utterly different than it was in v9 (even though
>>> the title is the same), and why is it so different from other tests
>>> below?
>>
>> This is because the "editor" in v9 checked for "# Changes"... While
>> this "editor" checks for 'diff --git'. And submodules don't give a
>> proper diff to verify (I tried this out and noticed this behavior by
>> tweaking some parts). In fact submodules don't give diff at all. But
>> they do give "# Changes"... So its important to setup up a little
>> before getting started. If this seems unnecessary, then should I move
>> all the tests which were introduced here above the submodule test?
>
> Let's ignore submodules when discussing this since they don't need to
> factor into the issue. What you are actually saying (and what took me
> a while to understand due to the "submodules" misdirection) is that
> you need to do some additional setup to test the "-v -v" cases. In
> particular, you need to introduce some change to the worktree which is
> not in the index.

Sorry for the misdirection. And you understood correctly. I do need to
introduce some changes in worktree.

> The typical way to satisfy this requirement (which doesn't require
> relocating tests) is to add a "setup" test before the tests which
> depend upon that additional setup, rather than adding that setup to
> the first test which needs it. Just about the simplest setup test
> which satisfies your needs is the following (inserted just before the
> first of the new tests):
>
>     test_expect_success 'setup -v -v' '
>         echo dirty >file
>     '
>
> And, then you can restore the "commit.verbose true and --verbose
> omitted" test to its simple form:
>
>     test_expect_success 'commit.verbose true and --verbose omitted' '
>         git -c commit.verbose=true commit --amend &&
>         test_line_count = 1 out
>     '

Having a additional setup test seems a nice way to go about.


> By the way, now that commit.verbose is no longer a mere boolean,
> you're going to need some additional tests beyond the
> commit.verbose={true,false} ones you've already added. In particular,
> you should be testing commit.verbose with several numeric values to
> verify that it works as expected. For instance:
>
>     commit.verbose=-2
>     commit.verbose=-1
>     commit.verbose=0
>     commit.verbose=1
>     commit.verbose=2
>     commit.verbose=3
>
> The -2 case is interesting; I'm pretty sure the current implementation
> of this patch will misbehave since the only negative value it's
> expecting 'config_verbose' to be is -1.

-2 case will fail. I should probably expect 'config_verbose' to be
negative instead.
