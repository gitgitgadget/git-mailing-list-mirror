From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Wed, 25 Feb 2015 23:40:53 -0800
Message-ID: <DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com> <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com> <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com> <xmqq4mqapo9r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:41:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQt49-0004go-QP
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 08:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbbBZHk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 02:40:57 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42974 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbBZHk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 02:40:56 -0500
Received: by pablj1 with SMTP id lj1so9557216pab.9
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 23:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=aGOZvHAu9Y7JLn008JX77iJaiLT2Sh3tkDXHkE8BeUE=;
        b=Sp0cYiEMfZgZzOW8T/8jsHUluqxHJ95OIL1tP/JjUeqhicEIkbKCRlLfoj/dXVPGuP
         ZA33o9AYsTZej47JHurm00lu56HFUEmvjz7lRjAhD6ouVV9GhHtN+1L7B3ujDPCF+OVR
         W/2tMgFDMGmcFORC+kYpnarVl1W7uuuhQxqWSyv1EdgDC4Pm5ZXwu6yx5uU9gcfX3+D1
         bO/2uFv4YatFEMrgJoCCU8rY5SQWl35HOUjCPT3so8TN+lJuY+/TvUBFrLAHsffJwBsJ
         AkrRtxBYs0icWme9m6JU14ro5N18W8ng/SRbcTJIqEDuKUsr8gMVH9LJByMtm9/khvNT
         Y9BQ==
X-Received: by 10.70.123.40 with SMTP id lx8mr12711990pdb.42.1424936456355;
        Wed, 25 Feb 2015 23:40:56 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id 2sm113163pdp.0.2015.02.25.23.40.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 23:40:55 -0800 (PST)
In-Reply-To: <xmqq4mqapo9r.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264425>

On Feb 24, 2015, at 21:13, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>>> I can designate ;-), but I do not think I'd be the right person to
>>> maintain or long-term-support it.  Are you volunteering to oversee
>>> the "LTS team"?
>>
>> I could not promise a team of more than one member.  And that would
>> not be full-time 24/7 either.
>
> Heh. Making noises to find like-minded people would be the first
> step to build a viable team, and hopefully you are already doing a
> good job here ;-)

Doesn't seem to be catching much interest though.  Maybe they're all  
just watching silently peering through the blinds waiting to see how  
it turns out.  ;)

>>> It would involve:
>>>
>>>   - Monitor "git log --first-parent maint-lts..master" and find
>>>     the tip of topic branches that need to be down-merged;
>>>
>>>   - Down-merge such topics to maint-lts; this might involve
>>>     cherry-picking instead of merge, as the bugfix topics may
>>>     originally be done on the codebase newer than maint-lts;
>>
>> I've been cherry-picking fixes for a while now onto older  
>> releases.  I
>> don't suppose down-merging would be that much more difficult with a
>> fallback to cherry-picking.
>>
>>>   - Use the tip of the maint-lts branch in everyday work.
>>>
>>> The last item is the most important of the above, because I do not
>>> have time for that.  I can help with the first two to some degree,
>>> though.
>>
>> That's pretty much all I use at this point -- a slightly older  
>> release
>> with cherry-picked fixes.  While it did cause me to find the problem
>> with the first version of the loose alternates fix, having only one
>> person use such a release doesn't provide that much coverage.
>
> That is why I used the word "team".
>
>> It occurs to me that if the "maint-lts" updates were limited to crash
>> fixes, regressions and security issues then often the pre-built man
>> pages and docs from the release it's based on could be used as-is  
>> with
>> the exception of the new release notes which might save some time.
>
> Cutting release tarballs including the pre-formatting docs might
> consume a lot of machine time, but it does not cost me time at all.
> I have Makefile for that ;-)
>
> Judging which fixes that have proven themselves to be safe and sound
> (by being in 'next', 'master' and hopefully 'maint' for some time)
> are worthy enough of down-merging to the LTS track is something I'd
> want to farm out to the LTS team.  I am already doing the "safe and
> sound" part by deciding which topics to merge to 'maint' among the
> topics that have gone through 'pu' to 'next' to 'master' branches,
> but not all that are worthy enough to be merged to 'maint' may be
> important enough to bother downmerging and updating LTS track with,
> and picking which ones matter to the LTS users is what the folks who
> are interested in the LTS can help.

If I were to keep a maint-lts up-to-date somewhere (with suitable down- 
merges matching the manner in which you maintain your tree) that you  
could pull from and potentially make releases from.  I would not want  
to pick up anything that hadn't already made it into master or maint  
and I don't think any actual release based off maint-lts should have  
any fix that has not already appeared in another non-maint-lts  
release.  So any given maint-lts release date would be expected to lag  
behind the corresponding master/maint release date that contained the  
same fixes (except possibly for a coordinated security fix release).

That said, there's no reason I couldn't also keep a pu-lts up-to-date  
somewhere external to your tree that interested parties could grab  
that would include fixes making their way into maint/master that I  
believe would be candidates for inclusion in maint-lts once they  
graduated.

I would like to better understand how the various heads are  
maintained.  I've read MaintNotes and I've got the concepts, but I'm  
still a little fuzzy on some details.  It looks to me like all topics  
still only in pu after master has been updated are then rebased onto  
the new master and then pu is rebuilt.  MaintNotes doesn't get into  
the rebasing details.  None of the graphic log viewers I've tried are  
much help -- too many lines running around although the graphiclog on  
repo.or.cz helps a bit as it shows --first-parent links as a bolder  
line, but still after the first page that's not much help either.

I vaguely recall you may have explained some of this in more detail in  
the context of explaining how you used the scripts in todo to put  
everything together when someone asked a question about it on the  
list.  But I can't seem to find that message anymore.  :(

I think I mostly understand how master, next and pu are maintained.   
But MaintNotes says "Whenever a feature release is made, 'maint'  
branch is forked off from 'master' at that point."  What happens to  
the previous maint at that time?  Is it just renamed to maint-X.X?

Also, how do you handle a down merge to maint when you have this:

* (master)
* merge topic foo
|\
| * topic foo
|/
* c
* b
* a
* (tag: vX.X.X, maint)
*

And you want to down merge topic foo into maint (where foo is a topic  
that didn't even first enter pu until some time after the vX.X.X  
release).  Won't doing 'checkout maint', 'merge ":/^topic foo"' pull  
in commits a, b and c as well?  I can think of several things to do  
here, but how do you normally handle this situation?

-Kyle
