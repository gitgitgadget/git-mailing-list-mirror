From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Wed, 5 Dec 2007 22:47:01 -0500
Message-ID: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>
	 <20071205.182815.249974508.davem@davemloft.net>
	 <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
	 <20071205.185203.262588544.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "David Miller" <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 04:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J07iL-0003Vt-P7
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 04:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXLFDrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 22:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbXLFDrF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 22:47:05 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:62003 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbXLFDrD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 22:47:03 -0500
Received: by py-out-1112.google.com with SMTP id u77so190545pyb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 19:47:02 -0800 (PST)
Received: by 10.142.128.6 with SMTP id a6mr1456340wfd.1196912821404;
        Wed, 05 Dec 2007 19:47:01 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 5 Dec 2007 19:47:01 -0800 (PST)
In-Reply-To: <20071205.185203.262588544.davem@davemloft.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67227>

On 12/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 21:41:19 -0500
>
> > It is true I gave up quickly, but this is mainly because i don't like
> > to fight with my tools.
> > I am quite fine with a distributed workflow, I now use 8 or so gcc
> > branches in mercurial (auto synced from svn) and merge a lot between
> > them. I wanted to see if git would sanely let me manage the commits
> > back to svn.  After fighting with it, i gave up and just wrote a
> > python extension to hg that lets me commit non-svn changesets back to
> > svn directly from hg.
>
> I find it ironic that you were even willing to write tools to
> facilitate your hg based gcc workflow.
Why?

> That really shows what your
> thinking is on this matter, in that you're willing to put effort
> towards making hg work better for you but you're not willing to expend
> that level of effort to see if git can do so as well.
See, now you claim to know my thinking.
I went back to hg because the GIT's space usage wasn't even in the
ballpark, i couldn't get git-svn rebase to update the revs after the
initial import (even though i had properly used a rewriteRoot).

The size is clearly not just svn data, it's in the git pack itself.

I spent a long time working on SVN to reduce it's space usage (repo
side and cleaning up the client side and giving a path to svn devs to
reduce it further), as well as ui issues, and I really don't feel like
having to do the same for GIT.

I'm tired of having to spend a large amount of effort to get my tools
to work.  If the community wants to find and fix the problem, i've
already said repeatedly i'll happily give over my repo, data,
whatever.  You are correct i am not going to spend even more effort
when i can be productive with something else much quicker.  The devil
i know (committing to svn) is better than the devil i don't (diving
into git source code and finding/fixing what is causing this space
blowup).
The python extension took me a few hours (< 4).
In git, i spent these hours waiting for git-gc to finish.

> This is what really eats me from the inside about your dissatisfaction
> with git.  Your analysis seems to be a self-fullfilling prophecy, and
> that's totally unfair to both hg and git.
Oh?
You seem to be taking this awfully personally.
I came into this completely open minded. Really, I did (i'm sure
you'll claim otherwise).
GIT people told me it would work great and i'd have a really small git
repo and be able to commit back to svn.
I tried it.
It didn't work out.
It doesn't seem to be usable for whatever reason.
I'm happy to give details, data, whatever.

I made the engineering decision that my effort would be better spent
doing something I knew i could do quickly (make hg commit back to svn
for my purposes) then trying to improve larger issues in GIT (UI and
space usage).  That took me a few hours, and I was happy again.

I would have been incredibly happy to have git just have come up with
a 400 meg gcc repository, and to be happily committing away from
git-svn to gcc's repository  ...
But it didn't happen.
So far, you have yet to actually do anything but incorrectly tell me
what I am thinking.

I'll probably try again in 6 months, and maybe it will be better.
