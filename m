From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 03:43:56 -0500
Message-ID: <CAMP44s3SbaMy7c_5W72J-hMx+xq+4VB5dV7ttCK=TVSbbYcr8A@mail.gmail.com>
References: <20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908044329.GA15087@sigill.intra.peff.net>
	<CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
	<20130908052107.GA15610@sigill.intra.peff.net>
	<CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
	<20130908065420.GI14019@sigill.intra.peff.net>
	<CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
	<20130908075046.GL14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIabI-0001m3-ML
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab3IHIoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:44:03 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52759 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3IHIn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:43:59 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so4012875lab.33
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tDWoKojDvNsROo05aCDSGk326HwUwBaBja6agzhQFrc=;
        b=xS3Ku2GaqKCQDTSfEOfIe28z4r9E3aN0BPGmy3fnmkHqVvKstfcgoEj7Vh+v+EnfU8
         WQkO5J9WAxMUs4UkVxaSsVtCP+gAE1LBdfTvh6Q3GUBSL1nMlyg6QoBkV4hIKK4jtQF2
         HAraNzE7+RLcsbfXAuMgt8TzOs3VW+GQrMLdJlER0OqRbj6hcCK43qUwEHktEuytBrVT
         CGbuhstZnQ9J957Vfny9EHYFaGf0QFp/h3U0p7oVvy8bSZiTPzR/iRkb9H4Sb84Z5T0G
         kIfrGf76IcCj1ZUmKX9/UwQg1DMvsb9H7BjGyP4eVvlHp+Dn/SdpJvovoGS8Z+0EORBZ
         oM1w==
X-Received: by 10.112.143.3 with SMTP id sa3mr10957600lbb.12.1378629837098;
 Sun, 08 Sep 2013 01:43:57 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 01:43:56 -0700 (PDT)
In-Reply-To: <20130908075046.GL14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234226>

On Sun, Sep 8, 2013 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 02:15:17AM -0500, Felipe Contreras wrote:
>
>> > I think "the guy" may be git itself. For example, here is a possible
>> > session with jc/pull-training-wheel:
>> >
>> >   $ git push
>>
>> Who told him to use 'git push'? Certainly not git.
>
> Any of the hundreds of existing tutorials that teach basic git commands
> like "push"?

You can't use a tutorial out there that just tells you to replace svn
commands with git alternatives, go to work and mess up the repository
history.

I'm trying to take the point of view of your hypothetical user working
on a repository where history is not important, but it seems more and
more than this person is just not real. If it's OK to push crappy
merges, somebody must have told him that was OK and provided him with
the commands.

If it's just some random person that read some random tutorial from
'svn' -> 'git' working on a random repository that happens to accept
merges all over the place. Well I think that's a very very exceptional
situation.

And this person still wouldn't have a problem finding another tutorial
explaining what a merge is.

>> >   To ...
>> >    ! [rejected]        master -> master (non-fast-forward)
>> >   error: failed to push some refs to '...'
>> >   hint: Updates were rejected because the tip of your current branch is behind
>> >   hint: its remote counterpart. Integrate the remote changes (e.g.
>> >   hint: 'git pull ...') before pushing again.
>> >   hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>> [...]
>>
>> Why stop there? Post the whole man page already.
>>
>> Moreover, it's overly verbose on all the wrong and irrelevant
>> information. If you are going to waste precious screen state, explain
>> wth a "non fast-forward" is; people can figure out what a merge is,
>> and maybe a rebase, but a "non fast-forward" definitely not.
>
> Note that I was not trying to defend any of the messages, but only
> showing a plausible mechanism by which a user with basic knowledge that
> he wants to push may arrive at the question "what is the difference
> between merge and rebase?".

Yes, and this person would have to read it online, like everything
else, because clearly Git documentation would do a bad job at it.
That's why the online documentation was needed in the first place.

The first hits of 'git merge vs rebase' are rather useful:
http://mislav.uniqpath.com/2013/02/merge-vs-rebase/
http://stackoverflow.com/questions/16336014/git-merge-vs-rebase
http://www.derekgourlay.com/archives/428
http://blog.sourcetreeapp.com/2012/08/21/merge-or-rebase/
http://git-scm.com/book/en/Git-Branching-Rebasing

Notice how none of the results point to official documentation,
precisely because it's not really useful.

> If you want to suggest revisions for the push message, go ahead. The
> push advice _is_ an attempt to define non-fast-forwards in plain
> language without taking up too much space, but perhaps you can do
> better.

I definitely can, but you would disagree.

But anyway, you are relying on the user having pushed first, what if
he is pulling first, or what if he doesn't have write access and is
only pulling?

> You could even suggest omitting it entirely, but I'm not sure if
> that is a good idea. It was not added in a vacuum; we lacked that advice
> for many years, and people complained about it quite a bit until it was
> added.

I would have to see the evidence, as I have never seen any complaints
about that. The complains are about the UI, and they still remain.

>> > The user is pointed at "pull" from "push", and then gets presented with
>> > the "merge or rebase" choice. It may be that the advice you can find by
>> > googling "merge vs rebase" is enough to then help the person along
>> > (and/or we may need to improve the manpages in that respect).
>>
>> Yes, but that's not the use-case we are talking about. You mentioned
>> specifically a "svn-like" worfklow where the guy was told by somebody
>> else to replace the svn commands with git ones.
>
> No, I mentioned an "svn-like" workflow. I didn't say anything about how
> they were told. They might have been told by a co-worker, or read a
> brief tutorial on git, or read something like "Git-SVN Crash Course".

Once again, this doesn't make any sense. People can't just push crap
merges to any repository.

>> If we are talking about a guy that is learning git, that's and
>> entirely different case.
>
> That is certainly what I meant to be talking about.

If he is learning Git, then he will be looking for the meaning of a
merge and a rebase. The fact that the repository accepts crappy merges
wouldn't be relevant.

>> The purpose of this change in the code is not to change the user
>> behavior. The choice of merge vs. rebase is entirely up to the user,
>> and we are not changing that.
>
> Right, but by not doing anything by default, you are forcing the user to
> make a decision.

No, it would be a warning first, he wouldn't be *forced* to make a
decision, only after the deprecation period is over.

Then yes, if by then he hasn't learned that what he wants is a merge,
he would be forced to learn it.

> Right now, we strongly encourage merging by making it
> the default, and you have to learn about rebasing separately. But a
> message that mentions them both as equals is going to lead to extra work
> for the user; they have to figure out which one is most appropriate.

No, they don't need to figure out which is most appropriate, they only
need to figure out they have been doing merges all along.

My warning message achieves precisely that:

"The pull was not fast-forward, in the future you would have to choose
a merge or a rebase, merging automatically for now. For more
information read 'git
pull --help'."

The part "merging automatically for now". This teaches the user that
'git pull' is doing a merge, so by the time 'git pull' errors out, he
knows he wants a merge, all he needs to figure out is how to do it,
and 'git pull --help' would tell him that. Perhaps adding a "(git pull
--merge)" to the deprecation warning would help, but I still don't see
the need in the final error.

Once again, nobody is forcing anybody to change their workflows.

> My
> concern is that this is non-trivial for new users, and that they may end
> up arbitrarily picking rebase, which is probably not doing them any
> favors if they do not understand it.

Why would they pick a rebase? If git tells them 'git pull' is doing a
merge for months, why would they choose to do something different?

> For clueful users, choosing between the two is not hard. But some people
> seem to have trouble understanding the DAG. I don't know how large a
> group that is, and how any pain caused by this change might compare to
> the times it will help.

They don't need to learn what's more appropriate, they can keep doing
what they have been doing.

>> > If you are interested, I can ask the opinion of some of the GitHub
>> > trainers. They see a lot of new users and have a sense of what kinds of
>> > confusion come up most frequently, what kinds of workflows they tend to
>> > see, etc. Their experience may be biased towards corporate-ish users,
>> > though, because those are the people who pay for training.
>>
>> Ask. I'm sure they will tell you doing merges by mistake with 'git
>> pull' is an issue.
>
> I've sent an email. I'll post the response when I get it.
>
>> >> "Any more babysitting with essay long messages is counter-productive
>> >> to the vast majority of Git users."
>> >
>> > I think that is what we have advice.* for.
>>
>> I don't understand what that means.
>
> It means that some time ago, after many people complained that git did
> not give enough hints, we added many hints. Some people who did not need
> these hints would want to disable them, and we have the "advice.*"
> config options to do so. So we can have a longer message for new users,
> and a shorter one for people who do not want to be bothered with the
> long advice.

I don't see Junio's proposal being affected by this advice thing.

And I have used and contributed to Git for many years, used it since
day one, and this is the first time I hear about it. I doubt even a
tiny fraction of Git users know about it. Where is the documentation
about that?

-- 
Felipe Contreras
