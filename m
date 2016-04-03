From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Bug Report
Date: Sat, 2 Apr 2016 19:22:30 -0700
Message-ID: <CA+P7+xo_MifcB8ry846=j2n7ZRn_80Os7kH1Ns+HMjuQf0N_Qw@mail.gmail.com>
References: <04bf01d18d3f$4ce38410$e6aa8c30$@u.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Benjamin Sandeen <benjaminsandeen2016@u.northwestern.edu>
X-From: git-owner@vger.kernel.org Sun Apr 03 04:23:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amXgt-0000X4-8m
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 04:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbcDCCWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 22:22:51 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33836 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbcDCCWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 22:22:51 -0400
Received: by mail-ig0-f170.google.com with SMTP id sy18so42941270igc.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nbftG545hke7h8llcrQKHtGUA9sCAQ08FgPvO9lOLhQ=;
        b=QupPcIYGkMIrgpISyS9ZSl3qCBvzsPpIe0PAHdnxEdyiUKubCSlkQQuR1+pdGdkdL5
         5BB0sUAdE7tW+5P7RoTN2vzts4jsgzVdafW+EruQw/u/FTpsTf61ML0g+VZ7nSQi9Yon
         BqfK29g7av/N02BwXEMdfUyVCjYRme/aqcASuhgjGdmCXVdVk5RVVXzjPWmrfEkCezZI
         732/p25aM7yYwhrPzUFtbJ3LkDLcIcm+7Ws3XhpoSKIGbIzssk2luposBN04aBAKtkFe
         cSGrmllngVNwfkJZyNiwojmCfIwCNtzyY1brP+aBIfFe18ElwPzeipp61U8KbOlaOTD4
         Yrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nbftG545hke7h8llcrQKHtGUA9sCAQ08FgPvO9lOLhQ=;
        b=R4MS9uUK1TCzuCrYt7PXYIqI6U3BbcEIp2ULFg0vQalvJz/jf/s8wr+fh70B0eLaQb
         byJG6bntDs3j1if9BhMm1bEC/YKL34GQXJCk7jX7p7efRxgpVhOe7S9Tkb2zuBSNItM7
         j7a3r18Qoi6joZrsKMA3J4npnnQuyG1Ooaf7Wo5WEcmrpo6Vy/qtXLawwvlLO++9sxTD
         zAMHmnWRAxjIWZkEtvUFgTYrgkOX+fQr55owg2e5czcGbi4P63EPFVTNAP26BAIeotzY
         4Zj23sWK7q1v2cYqRdGVi1ZqxaxzSQsZFK2Gp3phK5XPjtSxf1sz/v0pY8GqV4JHqn8F
         y2iw==
X-Gm-Message-State: AD7BkJLTpC7N1gkDwWRbQDvIs0au/JN61wnGB5LbSdwazDE9QJ2Xlt/Q17rcRO6A5OUZaM/hDuu2Ad5HuTjx9A==
X-Received: by 10.50.143.102 with SMTP id sd6mr618429igb.73.1459650170247;
 Sat, 02 Apr 2016 19:22:50 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Sat, 2 Apr 2016 19:22:30 -0700 (PDT)
In-Reply-To: <04bf01d18d3f$4ce38410$e6aa8c30$@u.northwestern.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290621>

Hi,

On Sat, Apr 2, 2016 at 5:25 PM, Benjamin Sandeen
<benjaminsandeen2016@u.northwestern.edu> wrote:
> Today, I managed to create a duplicate branch in a git repository.  While
> this may not be a bug per se, I do think that it is confusing and some way
> of preventing such issues in the future may be helpful.
>
> I first cloned the repository:
>
> $ git clone https://github.com/CodeForChicago/superclass.git
>
> Then, I created a new branch (or so I thought):
>
> $ git checkout -b lesson_page
>
> However, this branch has already existed for about 4 weeks, without my
> knowledge.  I proceeded to do some work on the files it contained, and when
> it came time to commit and push, and when I pushed, I got the following
> message:

The branch existed in the remote repository, but it doesn't exist
locally. You never fetched a copy into refs/remotes/origin since you
didn't say you were interested, and git will fully allow you to create
local branches with the same name as remote branches.

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

When you tried to push this branch, it will push into
refs/heads/lesson_page on the remote, which already exists. Since it
cannot perform a fast-forward update, as your local work isn't based
directly on the tip of the remote branch, you either need to merge,
rebase, or start from scratch.

> Given that I had believed that I had created the branch just a few hours
> prior and was the first to attempt to push to it, this error was
> consternating.

Let me try to explain. You created your own local branch, which
happened to share the same name as an already existing branch. Had you
know this you could have fetched and checked out that branch. You can
view all branches using "git branch -a" or "git ls-remote".

>
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

git checkout -b <branch_name> will create a new branch in your local
copy of the repository. Git is distributed. You can do "git checkout
--track <branch>" to attempt to create a local branch which tracks the
upstream branch, and then git status will provide useful information
about the relationship between your local work and the remote work.

It could maybe be improved to notice that a remote has a branch with
the same name. However, git can support multiple remotes, so
determining which remote to care about is difficult.

In your case you have a couple of options to fix it. I would suggest at least

"git branch --set-upstream-to=origin/<branch_name>" so that git status
will give you useful information about the branch relationship. Then
you can merge or rebase your work into the branch.

The issue is in understanding how git distributes branches, and how it
could handle this. I suspect improvements could be made so that it
will attempt to warn you when you create a branch that already exists.
However, often you do this *intending* to make it track the specific
branch so I am not sure how much good a warning would do. Just a
message wouldn't really hurt anything, however.

Thanks,
Jake

>
> Thanks,
> Ben
>
