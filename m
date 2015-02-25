From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Tue, 24 Feb 2015 16:55:26 -0800
Message-ID: <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com> <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 01:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQQGE-0004EG-RH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 01:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbbBYAza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 19:55:30 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39561 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbBYAz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 19:55:29 -0500
Received: by pablf10 with SMTP id lf10so848412pab.6
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 16:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=KaYnGm+rSQKink/6irtEiMJrk5WJy7T7fSLAiHPcbG8=;
        b=xhLKPxtWUEfZN78uJOjVl6EbpLPd2t0JQmwDZKdTey8QszcmtjE9vHfjEKPU2cXCjr
         DMWI9IMRWjgjfdbZo9gsin9Nq/wyGt5i8IJPLVOHIfaCZJexT0zjyJQ6cl69Kg8YDT0c
         ilaDn1QjS4hC03WnOTy+WDCB0Oxi0wXIExWQ+LsBJK1rPJQ1ZndliuWmtwfRni/XT8FP
         IDUVMDNaeoPuZRmdSHA0ynXS/3UXwhO0khvcJ0RL7nAYNvnLaeVy4m3jqOxTE54Ekmsl
         TG4UATtnfCBARqvjPV09ehqBBzPNh3SOE6LuNDSd0xGPV3bU7UqIny/TpjOAw0Iz0xFW
         JVaw==
X-Received: by 10.70.138.68 with SMTP id qo4mr1152554pdb.8.1424825729136;
        Tue, 24 Feb 2015 16:55:29 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id je2sm39334037pbd.44.2015.02.24.16.55.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 16:55:28 -0800 (PST)
In-Reply-To: <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264365>

On Feb 24, 2015, at 11:52, Junio C Hamano wrote:

> Kyle J. McKay <mackyle@gmail.com> writes:
>
>> Which brings us back to the subject of this email, is there any  
>> chance
>> for a v2.1.5 release?
>> ...
>> It appears that the average support lifespan of a Git release from
>> initial release date through last released maintenance update is
>> approximately 2-3 months with the 1.7.6 release being an exception at
>> a little over 7 months.
>
> That matches my expectation.
>
> A typical cycle lasts for 8-12 weeks, and during that time, topics
> that are bugfixes that have graduated to the 'master' branch are
> merged to the 'maint' branch with some lag and then the tip of
> 'maint' gets tagged as a maintenance release from time to time.
> Some important but trivial fixes are further merged to older
> maitenance tracks like 'maint-2.2', 'maint-2.1', etc.
>
> But these topics downmerged to older maint-* branches have to be
> very trivial for an obvious reason: there are only 24 hours a day
> and 7 days in a week, and bugs that affect real world use cases are
> found by using the software in real world use cases.  Usually I use
> something a bit ahead of 'next' exactly for this reason---we would
> want to catch bugs before topics are merged to 'master'.  Although I
> sometimes have "let's use 'maint' for my work" day once or twice
> every month, I cannot afford to do that for anything older than the
> tip of 'maint' myself.

Obviously there would have to actually be some interest in having an  
older long-term-support release and some folks willing to exercise  
such a thing.  Unless we can figure out a way to clone you. ;) ;)

> The consequence of the above is this.  v2.1.1 may be more stable
> than v2.1.0 and v2.1.2 may be more stable than v2.1.1, but later
> tagged versions on older maintenance tracks are made by merging
> topics only after "ah, these are obvious enough" eyeballing without
> real use (at least by me), once newer feature release is made and
> there is a newer maintenance track.  I would not be surprised if
> v2.1.5, if it is made, has hidden interactions between the changes
> since v2.1.4 and the older codebase to cause unforeseen bugs.
>
> When I say "the tip of 'master' is meant to be more stable than any
> tagged versions", I do mean it.

Some fixes would likely not be back portable (e.g. to fix X you first  
need change Y which needs change Z which needs ...), not without  
ending up pulling in things that exceed the scope of a "maintenance"  
update.

> Having said all that, if I were to tag maint-2.1 branch as 2.1.5
> today, we would have
>
>    6aaf956 is_hfs_dotgit: loosen over-eager match of \u{..47}
>
> that does not exist in 2.1.4.  Is that what you want?

I suppose in that it fixes "false positives" it is a regression fix,  
but if that's all that showed up in v2.1.5, no, that wouldn't make it  
worthwhile.

>> If a v2.1.5 release is out of the question, would it be possible to
>> periodically designate certain Git releases as "long term support"
>> releases?
>
> I can designate ;-), but I do not think I'd be the right person to
> maintain or long-term-support it.  Are you volunteering to oversee
> the "LTS team"?

I could not promise a team of more than one member.  And that would  
not be full-time 24/7 either.

> It would involve:
>
>    - Monitor "git log --first-parent maint-lts..master" and find
>      the tip of topic branches that need to be down-merged;
>
>    - Down-merge such topics to maint-lts; this might involve
>      cherry-picking instead of merge, as the bugfix topics may
>      originally be done on the codebase newer than maint-lts;

I've been cherry-picking fixes for a while now onto older releases.  I  
don't suppose down-merging would be that much more difficult with a  
fallback to cherry-picking.

>    - Use the tip of the maint-lts branch in everyday work.
>
> The last item is the most important of the above, because I do not
> have time for that.  I can help with the first two to some degree,
> though.

That's pretty much all I use at this point -- a slightly older release  
with cherry-picked fixes.  While it did cause me to find the problem  
with the first version of the loose alternates fix, having only one  
person use such a release doesn't provide that much coverage.

> If the lts releases need to be tagged and published by me, then lts
> team can have me pull from the tip of maint-lts they are confident
> with and have me sign it and push it out.

It occurs to me that if the "maint-lts" updates were limited to crash  
fixes, regressions and security issues then often the pre-built man  
pages and docs from the release it's based on could be used as-is with  
the exception of the new release notes which might save some time.

> If the primary concern you have with the currently maintained
> releases is git-svn, perhaps a better way forward for you,
> especially if you are willing to maintain your own "release plus
> patches",

That was the discussion the admins had that we prefer to avoid rolling  
our own, but if there's no other option then we will do that.  Some  
other Git hosters obviously do not have the same reticence about  
rolling their own Git release (as can be seen from the capabilities  
returned).  There are several fixes not yet in a release that are  
needed besides just git-svn, but since the other fixes are all in  
master now they'll be out in the next release.  But, picking up that  
release to get those fixes also exposes us to new code that has not  
yet had widespread use and a "maint-lts" would hopefully pick up the  
fixes without doing that.

> might be to keep a patch that reverts recent git-svn
> changes back to v2.1.whatever and deploy the up-to-date release
> and that patch on top?

That has occurred to me assuming there's not some dependency issue  
there that causes a cascade of reversions.

>> Nice to have: The CVE-2014-9390 fix, but repo.or.cz does not create
>> any working trees so it's not mandatory.
>
> Even if you do not have a working tree, people who use you as the
> meeting place and push into you and fetch from you do, so I do not
> necessarily agree with your assessment.

Having the feature does no good unless it's turned on.  :)  How  
expensive would it be to turn such a feature on in terms of CPU  
usage?  Running `git fsck` is rather expensive and the name of the  
config option suggests it's related, is it also as expensive?  When  
someone pushes a 2GB pack, what impact does that option have on server  
load?  All existing repos would have to be checked first.  Do we eject  
any that fail?  What about mirrors?  Do we refuse to mirror from a  
source that fails the check?  As long as it's not too CPU expensive, I  
could see turning it on immediately for new push repos and after  
checking, existing push and mirror repos that pass.  Hopefully all of  
them just pass the check.  So we cannot just deploy a CVE-2014-9390  
fix even if we had it without first doing some work assuming the CPU  
load is not an issue.  But it would be nice to have so we *could*  
proceed in that direction.

-Kyle
