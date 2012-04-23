From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Mon, 23 Apr 2012 08:20:04 -0700
Message-ID: <xmqqr4velbkq.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SML3n-0008SN-Da
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 17:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab2DWPUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 11:20:08 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:60593 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab2DWPUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 11:20:06 -0400
Received: by ghbz15 with SMTP id z15so1335566ghb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 08:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=WHfLH4zJq57E4ai8REBYBp71gnVceE4q7WkTvyNUGNY=;
        b=Wt3hHgYUhYuOhblCECj1lLJILOQBk/Dokt9sfUM3z1QgKjpu1uBVqM8e5iOku1YPV0
         vUFA/RwPWucOSA0M6ZXgj8TqoPAPkP+TrkTr4dAtZIIoN0BhcNPhril2pvru/YGCWQ50
         m5BO1O+O2qzx9XZUr/s3uRoFnLyE/JvcCwEqsOUB1lFMAhsF+sahHrZG6vb2vlfJMxjJ
         AP0IEUgymrRgeAXYcw8r6RQ4/2ximxJYYwqMgaGz7qGTyHF9CVTc3Tfq+qFhfsyT2RtP
         3hWKqq+aU2REcdmYAueo987FvIOFjf20FIWb22c4uxijOgvMXABmSjTz5QLvC57n8skR
         oyrA==
Received: by 10.236.165.99 with SMTP id d63mr20051911yhl.7.1335194405986;
        Mon, 23 Apr 2012 08:20:05 -0700 (PDT)
Received: by 10.236.165.99 with SMTP id d63mr20051878yhl.7.1335194405827;
        Mon, 23 Apr 2012 08:20:05 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si15189930yhg.2.2012.04.23.08.20.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 08:20:05 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 927AC1E0058;
	Mon, 23 Apr 2012 08:20:05 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 276D6E120A; Mon, 23 Apr 2012 08:20:05 -0700 (PDT)
In-Reply-To: <1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 23 Apr 2012 10:37:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnp1cM6iU/ZXaSYu6L5Kl5X+en0cb7TTOoIx6lOFjV/sbRaxECPfbHy1FKAfV/EBx/cITMeo1sBGZ/4nKx61Gef/ehGDghH4tYHdHUTUu/19zYWIh7nBrsc6h4TePYBthHTg00HAaB6Haotpy5FzqSJMvY8c0+MrSYQdXtSDGwsBj1TibM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196129>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The previous documentation was explaining _what_ the options were doing,
> but were of little help explaining _why_ a user should set his default to
> either of the options.

Thanks.

>  * `nothing` - do not push anything.
> +* `matching` - push all branches having the same name in both ends.
> +  This allows those who prepare all the branches into a publishable
> +  shape to push them out to a non-shared repository with a single
> +  command. This is well suited when pushing to a non-shared
> +  repository, but may give surprising results when used on a
> +  repository shared by multiple users, since locally stalled
> +  branches will attempt a non-fast forward push if other users
> +  updated the branch remotely. This is the default.

The thought does not flow smoothly with the repetition of "non-shared"
here.  How about rephrasing it a bit, perhaps like this?

  * `matching` - push all branches having the same name in both ends.

    This is for those who prepare all the branches into a publishable
    shape and then push them out with a single command.  It is not
    appropriate for pushing into a
    repository shared by multiple users, since locally stalled
    branches will attempt a non-fast forward push if other users
    updated the branch.
    
    This is the default.

> +* `upstream` - push the current branch to its upstream branch. See
> +  "branch.<name>.merge" for how to configure the upstream branch. This
> +  makes `git push` and `git pull` symmetrical in the sense that `push`
> +  will update the same remote ref as the one which is merged by
> +  `git pull`.

Reordering the sentences may make it read better; first tell the reader
why and what enough so that they can decide if this is good for her and
then tell her how to configure it.

  * `upstream` - push the current branch to its upstream branch. 

    With this, `git push` will update the same remote ref as the one which
    is merged by `git pull`, making `push` and `pull` symmetrical.
    See "branch.<name>.merge" for how to configure the upstream branch. 

>  * `tracking` - deprecated synonym for `upstream`.
>  * `current` - push the current branch to a branch of the same name.
> +  +
> +  The `current` and `upstream` modes are for those who want to
> +  push out a single branch after finishing work, even when the other
> +  branches are not yet ready to be pushed out. They are safe when
> +  pushing to a shared repository.

Do we really want to say "safe" here?  I think it is misleading in
multiple ways.

 - If your current branch has a name differnt from its upstream, using
   `current` when you meant `upstream` may result in the embarrasing
   fast forward discussed elsewhere, which is hardly "safe".

 - If you always make everything on your end ready before pushing things
   out, `matching` may attempt to update remote branches other than the
   one that corresponds to your current branch, but that is exactly what
   you want to see---there is no danger here.  You can make it dangerous
   with --force, but that is a separate issue.

 - An attempt to push a stale branch in all cases will error out without
   causing damage to the remote repository.  If you do not keep your
   branches up-to-date and still use `matching`, you have more chance of
   seeing this when used against a shared repository. It is unclear if
   the use of word "safe" in the above description means this "you are
   behind" error "a risk to be avoided", but

    - if so, `current` or `upstream` will see the same error in a shared
      repository where the same branch is updated by multiple people, so
      "They are safe" is not quite correct; and

    - if not, then `matching` is not less safe than others (it is just
      as safe and unsafe as `current`).

There is a high correlation between use of shared repository and the
style of "working on one branch at a time, pushing the result as soon as
that single branch is OK", so I am perfectly fine with saying that these
single-branch modes are most likely what people want to use when working
with a shared repository, but I do not think `safety` has much to do
with the choice.

	
