From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: Cannot checkout a branch / worktree shows multiple branches for
 the same directory
Date: Thu, 14 Apr 2016 19:11:51 -0400
Message-ID: <CANoM8SULHrNv7R1COAZ1hq4qCFPX7H0t-v22m6AxUfwNsM_rrQ@mail.gmail.com>
References: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Krzysztof Voss <k.voss@usask.ca>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:12:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqqQs-0003v3-5I
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcDNXMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 19:12:13 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36743 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcDNXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 19:12:12 -0400
Received: by mail-io0-f174.google.com with SMTP id u185so119160607iod.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k2B/ePpN2V+9VAO0Nkd7MHTVkOYIxRroZHlE8hCd+Qc=;
        b=pcLswvqAA4iA586Q0oGigtWInrAfsZBk7K1k154gCSPVNjlUqjKujASvuIjmBieKEM
         xwAOLTb04UFM83iex7qkBB0PH3r2mu6k7bIU+bbRyI3Y+AYm6tClBU+4iHLLtttsMPg7
         6hC0PPzBAOUsn7FefqHiv9o2X9/uJdch4kddeUMshZAeBEDk0X/l2wSNZ1uWmkO5J0H9
         AJIAEMz6yBSVsg9doFXvrSLkZRD0OhHvV/lAe/2aJZPTvV/EJ7Mw9zcyvEeGYllNkvXS
         zPssleK4xo8ae3Bm0V64CeYC2pNl4HAyBHqFWK1zhVEkZGwn8C0FKP3ODcKnLu2vTUXM
         OvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k2B/ePpN2V+9VAO0Nkd7MHTVkOYIxRroZHlE8hCd+Qc=;
        b=Qpojugjr35O9vCz5TXR79kFNfbJdYMMZSqpxWaVeea4LHrf7sLkAwKhtAWYEbYIXx2
         pDemquEA0VwtAzDyiKivDkilwNFAw3er372uPjwVxvng9DYtCHx+dW9GJkOA3TxK+QoE
         hde+6wiVZJi0V81nh6z7RkRBzcGKyumrNZdlsk9/n+qiw78ENzi+1mV2Y99pWXzb2FWH
         ZFeVa2VUuZR72c88GXkSDMzKr9iNmD3U/Yc67KShBnYcb8NHvjjd2xgTNkpuoZMohnYX
         y2Nu6mvet2yI2hd8j3dGGzdUV0oAQe4YeVbv9OXEAT4cJDyj8scJGX2dm6YbK8d1yyDb
         jw6Q==
X-Gm-Message-State: AOPr4FVcnvNOeEO1MEFYXartFxC5Pzd67Q8K/1v9iUO0T7PEldfGSfVVTquKN0l1ibzjHt7AV8Aoq/YqfLYeWQ==
X-Received: by 10.107.168.233 with SMTP id e102mr21384822ioj.55.1460675530402;
 Thu, 14 Apr 2016 16:12:10 -0700 (PDT)
Received: by 10.107.7.193 with HTTP; Thu, 14 Apr 2016 16:11:51 -0700 (PDT)
In-Reply-To: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291579>

On Thu, Apr 14, 2016 at 3:51 PM, Krzysztof Voss <k.voss@usask.ca> wrote:
> Hi,
>
> I stumbled upon an interesting problem when checking out a branch.
> I had to switch to a testing branch to merge in some changes from yet
> another branch, but when I tried to check out the testing branch I got
> a message saying that I'm already on the target branch.
>
> I used worktree a few times, but the checkouts were always in their
> own directories.
> It crossed my mind that this behaviour may be related, so I took a
> look at the worktree list and noticed that according to that list
> there are three branches at the same time in one directory.
>
> It may be a conicidence and I have no confidence in saying that these
> issues are related.
> Can someone shed some light on this issue for me?
>
>
>     $ git --version
>     git version 2.7.0.235.g07c314d
>
>     $ git status -uno -sb
>     ## ticket-22444
>     M src/core/parsers/ParserBase.py
>     M src/core/parsers/test/ParserBase_test.py
>
>     $ git stash
>     Saved working directory and index state WIP on ticket-22444:
> 7c5edaa #22444 refactoring
>     HEAD is now at 7c5edaa #22444 refactoring
>
>     $ git co testing
>     fatal: 'testing' is already checked out at '/home/k/workspace/moyo'
>
>     $ pwd
>     /home/k/workspace/moyo
>
>     $ git branch | grep '*'
>     * ticket-22444
>
>     $ git worktree list
>     /home/k/workspace/moyo  7c5edaa [ticket-22444]
>     /var/home/k/moyo-lsf  349613d (detached HEAD)
>     /home/k/workspace/moyo  265b7f9 (detached HEAD)
>     /home/k/workspace/moyo  c852282 [testing]

This looks a lot like the `update_linked_gitdir()` bug that (I
thought) was fixed[1].  Is
it possible that you had this problem since before the bug was fixed
and are just
noticing it now?

If you look in '/home/k/workspace/moyo/.git/worktrees/`  I suspect
that there are 3 dirs
in there, two of which have a file 'gitdir' which have the contents
'.git'.  These _should_
instead point to the '.git' file in your other work trees.  It would
be nice to know the last
time that those bad worktrees were updated.

If you know where the other worktrees are located, then you should be able to
manually update this file in each of the worktree dirs.
Alternatively, you can manually
remove the bad linked worktrees (`rm -r .git/worktrees/bad_wt`).

[1] http://thread.gmane.org/gmane.comp.version-control.git/284284

>
>     $ uname -a
>     Linux k 3.13.0-83-generic #127-Ubuntu SMP Fri Mar 11 00:25:37 UTC
> 2016 x86_64 x86_64 x86_64 GNU/Linux
>
>     $ cat /etc/lsb-release
>     DISTRIB_ID=Ubuntu
>     DISTRIB_RELEASE=14.04
>     DISTRIB_CODENAME=trusty
>     DISTRIB_DESCRIPTION="Ubuntu 14.04.4 LTS"
>
>
> Thanks,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
