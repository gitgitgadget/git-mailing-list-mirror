Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F732208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbdHJSsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:48:00 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33142 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdHJSr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:47:59 -0400
Received: by mail-lf0-f53.google.com with SMTP id d17so7424304lfe.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cuTuQph0I+LNnM2EVAKf6peWvDsR8FGoUV/FWTmHSeI=;
        b=Ww4SSRJt56C1Owo3XJIXXd0uCbHz5O31aaoqgoXkEpFfAHTIdGKScUqn8B7QZ/uwFZ
         oLXiwz9/rJTYTzfDoXMFXI1RkR16h1+oknA0AN6belIs6/aUPHNJ4nsDUJ7EhnOFw7RH
         9n6lUUKub/1hUICHxjnBGnZDKX+B4dha7gd56q4w0O2Qd8OvcTYo2WySc7FIjDiRJ5AQ
         buHl4TYZ3k4euJvFkPSVFmoVK9EYJyt48LuQqIQFzN8CuO53L2ma75+VYiaXNWpXYx9U
         ODQLBAoxJg8nTj0K3/681eI5OAmSdgDxZ6jM9MvvqZtG1MMfAHWJOGDdfr/wozkJvQlJ
         EXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cuTuQph0I+LNnM2EVAKf6peWvDsR8FGoUV/FWTmHSeI=;
        b=gDKF3fStsicp3j/CI+LZyDkbMqXw0Y1vtF5qTOxcDoUVY3vUlDpr8uhZaAGmZGXLGH
         Ts0P9kS7rMiVxOiQHj7HT0SUZVMo39YRW5t3j7afezhWyv5WiFMqTNRcmVwfS0ewFnYO
         wlovJO9EYESO68jsMLEQiYX/QSKSCx5r9ig4faWfAi0lOHx8N1mRieY8Pso4F2PjuZ3R
         CFzl+anDZyB1Yi8NO6fne6b4XYh3UIs0T4rIvSCZiHphbJo9gdWGhsmnQeByxn3RxwPR
         sDlQ/QuDW28Be8uBQHwVE0hNRU3jvVn8YBhEE/oFLKgaPE+FN0y3s7aDF/aN2A+5FRrD
         OANQ==
X-Gm-Message-State: AHYfb5iFRbpQYTYvq1KcvcSJIpZgIishtzUsGpdaLbY7tKp51MaZBISq
        4WWn4zBXmO2VN3MXegJfcjXZCzst1zTC
X-Received: by 10.25.228.206 with SMTP id x75mr3902494lfi.94.1502390878255;
 Thu, 10 Aug 2017 11:47:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 11:47:57 -0700 (PDT)
In-Reply-To: <87efsj70d7.fsf@local.lan>
References: <87mv7773tp.fsf@local.lan> <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
 <87efsj70d7.fsf@local.lan>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 11:47:57 -0700
Message-ID: <CAGZ79kZN1-DuiaS=bFgNUXBonAR3BHqtAFSqoJ+MJ4esMdmz-g@mail.gmail.com>
Subject: Re: Not understanding with git wants to copy one file to another
To:     Harry Putnam <reader@newsguy.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:18 AM, Harry Putnam <reader@newsguy.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Aug 10, 2017 at 10:03 AM, Harry Putnam <reader@newsguy.com> wrote:
>
> [...]
>
> Harry wrote:
>>> Here are two that are at least kind of similar but would never be seen
>>> as the same:
>>>
>>> < 192.168.1.43      m2.local.lan       m2       # 00-90-F5-A1-F9-E5
>>>> 192.168.1.43    m2.local.lan        m2         # win 7
>
>  Stefan B replied:
>> The diff machinery has a threshold for when it assumes
>> a copy/move of a file. (e.g. "A file is assumed copied when
>> at least 55% of lines are equal")
>>
>> https://git-scm.com/docs/git-diff
>>
>> See -C and -M option.
>>
>> git-status seems to use this machinery as well, but does
>> not expose the options?
>
> Well, now I'm even more confused.  What actually happens? Is either
> file changed? Is only one file kept?
>
> On the surface it sounds like complete anathema to what git is all
> about.
>
> However, I know a tool this sophisticated is not doing something just
> outright stupid... so must be really missing the point here.
>
> I get the way you can make -M stricter or not... but I didn't call
> git-diff to see that copy thing comeup.
>
> I called git commit.

Ah. Sorry for confusing even more.
By pointing out the options for git-diff, I just wanted to point out that
such a mechanism ("rename/copy detection") exists.

The output of git-status is similar to a dry run of git-commit,
and apparently this detection is used there.

>
> There must be some way to set stricter guidlines to calling things
> copies.

Well from Gits perspective it is really hard to tell if it was a copy, or
if it was similar incidentally (because the format/content of these files
happen to follow some strict guidelines).

The user could have moved/copied a file outside of Git (instead of
git-mv, you'd use tools provided by your operating system to copy a
file). Or the user could have written a file that is similar by chance.

However that doesn't really matter, as Git tracks the content, and not
how the file evolved.

Consider the copy/move/rename detection as a heuristic, that wants
to help the user, but may be mistaken.

>
> But then I must really not get it because it still seems almost silly
> to consider one file a copy of another if only 55% is the same.
>
> What am I missing?
>

https://www.reddit.com/r/git/comments/3ogkk1/beginner_disable_rename_detection/

"Rename detection is just GUI sugar".
