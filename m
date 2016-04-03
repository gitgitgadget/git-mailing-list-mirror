From: "Eric N. Vander Weele" <ericvw@gmail.com>
Subject: Re: Bug Report
Date: Sat, 2 Apr 2016 22:20:55 -0400
Message-ID: <CAGhVqYthSWCqXW2=3dSUweZ2hqTRSHJiHGNWsmQxUxtmAbnzYw@mail.gmail.com>
References: <04bf01d18d3f$4ce38410$e6aa8c30$@u.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Benjamin Sandeen <benjaminsandeen2016@u.northwestern.edu>
X-From: git-owner@vger.kernel.org Sun Apr 03 04:23:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amXgs-0000X4-DW
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 04:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbcDCCV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 22:21:26 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37774 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcDCCV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 22:21:26 -0400
Received: by mail-ig0-f174.google.com with SMTP id l20so34731957igf.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iISkrNWPjfH4udQDjTIIgbmp+7PRByrz3+6qpcoBjX4=;
        b=xQpKXe5FefryPik5bkNubOAMD1XAeUIsOkunpmBxB2rlJBeKMjvxEURtW4B5CWDwjQ
         APEaou4rTvj11pS56Webkqca0A6/QuXZhwwaqPZN72cCRlxS9l/4UFwG2xsjEZtXIl/a
         QfFvOdd8PxTt0+4xpSjquOn0r70IoLk+DBwRYPYge+T5onIscvSfxIinT7u5CFOHnkBt
         g0SCyMc9ilTOgPjSCdspWvpRKQJ6YMaswd/IPlfXFNB44co9QO3PDSQHflO9beTml0w7
         Jp/tDKDjps+I/T4xW7z+HZzkNqg3PTKGpjMZFeVFPkOHa4wfis9enY434s7LNayTnzA9
         DrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iISkrNWPjfH4udQDjTIIgbmp+7PRByrz3+6qpcoBjX4=;
        b=J+GPECGvZtOuztG/Q6QcQo4zglMyd0Yr73s+COks9zBzKvE+jEgAdpnHkuOpMz2Nt3
         YwjAcmZT1B13YPCOUTqqOuyvHujuD9/BkqAf9gJ3jtnMxZJpPxDbNK2ry4FcMbIU+gUY
         c6i6H837JHR/Jo+HpsiC7nziCM8YJ9u65Nq1ydpF5uldOGjbICbGkDZPKnDQo0lm3lv7
         b4+UJLp11TqZ2E4oPgwJz+C4V1UHn1d63xKRnj9DvGZ1dWnCajdnmhyEX69NPLoqQObz
         xrTwOy56dDgtvx6aq4Z/XIf/eay8LxBJXLSdkZ5iREc/7SZudxn4TM0RNSdBlnSgqjn2
         DQpg==
X-Gm-Message-State: AD7BkJLCto2hdXOuVT0oXGKk4J6Xxmfam91IDRI8Tz0oyvQX3Qc5ZusDmKiPEvptZkLhgXxc/v6VtJ1RiQHDHg==
X-Received: by 10.50.64.146 with SMTP id o18mr4679651igs.51.1459650085065;
 Sat, 02 Apr 2016 19:21:25 -0700 (PDT)
Received: by 10.36.44.3 with HTTP; Sat, 2 Apr 2016 19:20:55 -0700 (PDT)
In-Reply-To: <04bf01d18d3f$4ce38410$e6aa8c30$@u.northwestern.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290620>

On Sat, Apr 2, 2016 at 8:25 PM, Benjamin Sandeen
<benjaminsandeen2016@u.northwestern.edu> wrote:
> Today, I managed to create a duplicate branch in a git repository.  While
> this may not be a bug per se, I do think that it is confusing and some way
> of preventing such issues in the future may be helpful.

This can be confusing.  I'll hopefully try to help and explain below.

> I first cloned the repository:
>
> $ git clone https://github.com/CodeForChicago/superclass.git
>
> Then, I created a new branch (or so I thought):
>
> $ git checkout -b lesson_page

At this point, you created a *local* branch called 'lesson_page' which
points to the current HEAD and then switched to that branch .  This
local branch is independent of the remote branch called
'origin/lesson_page'.

> However, this branch has already existed for about 4 weeks, without my
> knowledge.  I proceeded to do some work on the files it contained, and when
> it came time to commit and push, and when I pushed, I got the following
> message:
>
> To https://github.com/CodeForChicago/superclass.git
>  ! [rejected]        lesson_page -> lesson_page (non-fast-forward)
> error: failed to push some refs to '
> https://github.com/CodeForChicago/superclass.git'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Integrate the remote changes (e.g.
> hint: 'git pull ...') before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>
> Given that I had believed that I had created the branch just a few hours
> prior and was the first to attempt to push to it, this error was
> consternating.

The non-fast-forward push is preventing history being rewritten- this
is a good thing :).

> I may be wrong (I am aware that my understanding of git is limited), but I
> believe that the git checkout -b command is simply supposed to create a new
> branch and then switch to it (I'm not aware of any subtle behavior that goes
> on behind the scenes if the "new" branch that the user is attempting to
> create already exists).  This is why I said it "may not be a bug per se".
> However, I expect most people who use git to expect this command to create a
> new branch and then switch to it (this is what most sources online will tell
> users to do to create a new branch), and as such, it would be extremely
> beneficial if git were to, at the very least, alert the user to the conflict
> in some way or another.

The `git checkout -b` command is working as expected.  `git checkout
-b <name>` is equivalent to `git branch <name> && git checkout
<name>`.  If you were to execute `git checkout lesson_page`, you would
get the desired behavior you were expecting because in the presence of
one remote, git will actually execute `git checkout -b lesson_page
--track origin/lesson_page` - more details can be found in `git help
checkout`.  Effectively, it checkouts 'origin/lesson_page' as a new
local branch named 'lesson_page'.

However, you indicated that you did not know there was a remote
branch already named 'lesson_page'.  After cloning the repository, you
can use `git branch -a` to see all remotes to determine which form of
`git checkout` to use.

> Thanks,
> Ben
>
> Lead Consultant, Northwestern University Information Technology
> Research Assistant, Center for Interdisciplinary Exploration and Research in
> Astrophysics at Northwestern University
> Phsyics, Weinberg College of Arts and Sciences
> Computer Science, Weinberg College of Arts and Sciences
> Classics, Weinberg College of Arts and Sciences
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
