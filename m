From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Git workflow with upstream repository
Date: Fri, 23 Jul 2010 21:43:56 -0400
Message-ID: <AANLkTi=82NDSfizCCjoJ-Sj05DzwXfa35ro60MiWSQdz@mail.gmail.com>
References: <AANLkTinyUGLMTQ=ruk69pptDUQ3VyaQ7CwtO+QfeJUVC@mail.gmail.com>
	<AANLkTik5U0oh8p42hK-871iwnTA5a66Yj-8pU4xSZS40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 03:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTmU-0007za-QM
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955Ab0GXBn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 21:43:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63573 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678Ab0GXBn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:43:57 -0400
Received: by qyk8 with SMTP id 8so584905qyk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:43:56 -0700 (PDT)
Received: by 10.224.110.193 with SMTP id o1mr3314035qap.298.1279935836233; 
	Fri, 23 Jul 2010 18:43:56 -0700 (PDT)
Received: by 10.229.184.204 with HTTP; Fri, 23 Jul 2010 18:43:56 -0700 (PDT)
In-Reply-To: <AANLkTik5U0oh8p42hK-871iwnTA5a66Yj-8pU4xSZS40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151598>

Thanks, I'll check those out! So, I take it there is not a way to get
a simple message like what git status tells you when you're local
branch is behind the remote branch:

"Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded."

Is there even a concept of a fast-forward merge when pulling from a
remote repo that is not the remote to which your branches are
tracking?

Is it possible to rebase based on a branch that is *not* the branch
you're currently tracking? Is that what the --onto flag is for?

- Bradley

On Jul 23, 2010, at 9:24 PM, Avery Pennarun <apenwarr@gmail.com> wrot
> On Fri, Jul 23, 2010 at 8:58 PM, Bradley Wagner
> <bradley.wagner@hannonhill.com> wrote:
>> If I'm working with another remote repository 'upstream' that I
>> perhaps don't have permissions to and then my branches are not
>> tracking against, how would I do something similar to be able to first
>> see how my branch compares to the remote and then either rebase or
>> pull/merge.
>
> # show the commits in my local branch that aren't in upstream
> git log upstream/master..
>
> # show the commits in upstream that aren't in my local branch
> git log ..upstream/master
>
> # a cuter way to show the commits in upstream that aren't in my local branch
> git shortlog ..upstream/master
>
> # summarize the differences in upstream since we diverged (not
> including my own changes)
> git diff --stat upstream/master..
>
> # summarize the differences between my branch and upstream (including
> my changes and theirs)
> # (note: three dots)
> git diff --stat ...upstream/master
>
> Have fun,
>
> Avery
