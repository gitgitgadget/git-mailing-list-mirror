From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Adding a commit to the front of my branch?
Date: Wed, 13 Jan 2016 11:19:46 -0600
Message-ID: <CAHd499A67diDmBB3cO_SYXNaZnohcxNtaQpmDAomwToG+MMOvw@mail.gmail.com>
References: <CAHd499Adtc3qMgvXywONpgK0Z5NzGMnZ-=5akbLo+i6m2oJpYA@mail.gmail.com>
	<1mgz4yx.94yt5g12q9hidM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:19:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP5N-0004TB-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbcAMRTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:19:49 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33764 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbcAMRTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:19:47 -0500
Received: by mail-ig0-f172.google.com with SMTP id z14so173130233igp.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gj4+cFExpjlCQz3vbGm2s5fH40SH1tJF526lPbGfJ7Q=;
        b=lCMvsRxE7eofoHNynko24JVm0TRw+i9yPhcr8q/MDj63JJjSLXvPUyoRMYFoQ/Kma6
         PNliTz7ajvppnfO2xpnfVCDbLPY40r6mQXf7vY+maj/PORsKZQFHATHo7G14zaz0kBzv
         bAFl/vW7JjsrP6Frit1nVnAyBCwNvX3oSg4vImJCorJcZ6Ndog1Dy/QPZn/L5FeHHHy7
         ppAr06+yL8UijhyPjmdvj2RPunIobh8wnzsppv2edq0Z10MldBfqN2DMlJcPh6Z40icd
         Xc34g0vcfU+DBTjnvZqA2QN4fiNshDXFil0dIhMXblDl7ZIKLhNk3eebsYpQEUZuESQM
         RXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gj4+cFExpjlCQz3vbGm2s5fH40SH1tJF526lPbGfJ7Q=;
        b=JWoMw0NxxD0uVQEVUfF6WBe4nqXKYaPGHrOoCAxw7+iAFEkO1jD5MkGSEdRz1hBhNN
         CZkbxG8ckatB1LsCwvwmwpt199uu1+9OmP+cN5yLxu5DeyNbPXmGoMjJTpp9y4pfvtvb
         NYbIc387NnIxrdrMYR7zmrT7q0gSo28sDK/F8VJ951GJ8RqbvuXCpWBd7RVZPsO7cZKu
         0wSwQ2Rgno2XuLsMFLvgyujdsTcyo3lfzza2yjjsgI0yAk1C2fEJ3ShZ6HJl7O43zW0s
         kApWhE4lQznaaYnZtV03PMaEbrmrDATCpI+CcUReJ4NWuCddi7sKAYmHRG+EcsWgUF/c
         YYrw==
X-Gm-Message-State: ALoCoQl/yMNlDdcskyTO95au0X6G/JaRZonVwlolBHxaRqqDpyctVQIH61fkvjFy69mB1jJDgGzW+a2ylMZGuiJ0mZ5bruIwkA==
X-Received: by 10.50.150.66 with SMTP id ug2mr23456391igb.33.1452705586956;
 Wed, 13 Jan 2016 09:19:46 -0800 (PST)
Received: by 10.36.83.83 with HTTP; Wed, 13 Jan 2016 09:19:46 -0800 (PST)
In-Reply-To: <1mgz4yx.94yt5g12q9hidM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283945>

On Wed, Jan 13, 2016 at 10:40 AM, Stefan Haller <lists@haller-berlin.de> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
>> On Mon, Jan 11, 2016 at 8:11 AM, Stefan Haller <lists@haller-berlin.de> wrote:
>> > Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> >
>> >> Normally to add commits on my branch, I perform an interactive rebase:
>> >>
>> >> $ git rebase -i origin/master
>> >>
>> >> I mark the commit I want to put the new commit on top of as 'edit'.
>> >> However, if I want to add a commit to the front of my branch, I don't
>> >> really have a commit to mark as "edit".
>> >
>> > Instead of marking commits as edit, I usually add "x false" at the place
>> > where I want to add a commit. With this I find it easier to see where
>> > the new commit goes, and it also works before the first commit.
>>
>> What do you mean "x false"? I'm not familiar with this. Can you explain?
>
> "x" is a shorthand for "exec" (just like "p" is a shorthand for "pick",
> for instance). "exec" will execute an arbitrary shell command, and stop
> when that shell command fails with an exit code not equal to zero.
> "false" is a shell command that does nothing except return a non-zero
> exit code, so "x false" just stops and waits for you to "fix" something.
> At that point you can make additional commits, and then "git rebase
> --continue" to go on.

Oh, this is pretty neat! So I assume it will stop BEFORE a patch is
applied, unlike edit? I will try this next time. However it would be
great to see a new 'insert' command for the TODO file, that will let
you insert a commit at that point (i.e. it stops before the marked
commit is applied).

Thanks for the help.
