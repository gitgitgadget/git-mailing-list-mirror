From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:29:52 -0700
Message-ID: <4FA055D0.7040102@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKdy-0003Cz-By
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab2EAV3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:29:54 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:17317 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab2EAV3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:29:53 -0400
X-IronPort-AV: E=Sophos;i="4.75,513,1330934400"; 
   d="scan'208";a="13249426"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 14:29:53 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q41LTq4U018325;
	Tue, 1 May 2012 14:29:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <86mx5rmx32.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196756>

On 5/1/12 14:05 , Randal L. Schwartz wrote:
>>>>>> "Rich" == Rich Pixley<rich.pixley@palm.com>  writes:
>
> Rich>  I want to be able to fetch changes to the branch I currently have checked out.
> Rich>  Git blocks this because it doesn't know how to cope with the working directory
> Rich>  in that situation.
>
> It does?

Yes, it does.

> I can always "git fetch origin" in my repo, and the remote
> branches are in "origin/master, origin/foo, origin/bar".  Totally
> separate from my working tree.

Sure.  You can fetch other branches, (unless you happen to be checked 
out from them).  But you can't fetch to master if you're checked out 
from master.

> So, make a set of related names for your branches.  It's better with
> names anyway.

I disagree.  They only even need branches if they're different.  And the 
branches can be extremely lightweight.  With names, I have to manually 
track a geometric explosion of extraneous branches and branch names, 
just in order to be able to sync changes back and forth.  That's all 
work that could be managed automatically by the source code control system.

> Rich>  Pushing is blocked in git.  Git simply refuses some push requests
> Rich>  which have obvious and fairly straightforward semantics.
>
>   git push master:from-merlyn/master
>
> And now someone can look at "from-merlyn/master", and know that it's
> from me, and related to master, and either incorporate it into the real
> master, or cherry-pick from it, or whatever.  Solved.

Again, yes, you can push to other branches.  You could push to other 
repositories too.  That's not really what I'm talking about.

> You're asking a lot of an automated system.  I think you're trying to
> get a system to replace the communication you should be doing as a
> developer.

I hear that that's what you think.  But really, I'm asking for 
automation to replace the automation I already have in preexisting 
source code control systems.

There are a number of situations, like the ones I've described, that git 
just plain doesn't cope well with.  Other source code control systems 
have, and going backwards seems silly and frustrating.

My particular situation is that I'm developing a "feature" and to do 
that, I need to be testing on multiple machines.  Tens of them.  I 
really don't want hundreds of named branches that I must manually merge 
from constantly.

With mercurial or monotone or even subversion, it's trivial.  Branches 
can be shared.  And pushing between them is similarly trivial.  It can 
be done in seconds.  With git, it takes hours to do all the manual 
moves, track the manual moves manually, verify that they've been done 
correctly, and then later it takes hours to correct the ones that were 
done incorrectly because they were all done manually or because one 
machine happened to be down at the time and so got the changes in the 
wrong order, or whatever.

I'm not asking for anything new.  I'm asking for something that's as 
capable as what we've had for years now.

--rich
