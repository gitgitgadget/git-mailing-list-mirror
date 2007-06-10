From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 20:38:03 +1200
Message-ID: <46a038f90706100138g46d872f7o463418631585bf13@mail.gmail.com>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	 <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	 <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIw9-0004Pd-IZ
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762833AbXFJIiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762824AbXFJIiG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:38:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:56663 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762812AbXFJIiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:38:04 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1131254wxc
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 01:38:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kjQeuKETfTNSM8wWSY/3XfrSCALO77DTgiTvyS2OLM50U3AQUZYe+Bd/E2OCQkSqYTYWU41VB5tbgdkeJhDfwVoUQ/RVjFSEq0G7sCn0npa4OBJTpDVwifXZdFK8RY6WRuYLOPsuLrEhqY/5/DWM9Ea2S8V6ZA4kShNdjRqV5Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X9kvUXJqzUFCpd6hFjiSZmk5vS89FMDTRmwuEa04ie0s4kVDFpGwwxnesP2D9J2+ja+gooINNCSW3kRgCcdwo8TrPnxIcR/2JK4QdXDtXNpU985+yBZeqyKH+Bm7B9d2g814vdJT75MZOzOaSMK4H0CzuOGbVKxhuOSH61uj0QM=
Received: by 10.90.36.3 with SMTP id j3mr4304331agj.1181464684011;
        Sun, 10 Jun 2007 01:38:04 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sun, 10 Jun 2007 01:38:03 -0700 (PDT)
In-Reply-To: <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49677>

On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> > what is going to make the difference. Most of those have already the
> > ability to "link" to one or more commits -- after the commits are done
> > and in GIT.
>
> You are a brave person to say this (no sarcasm --- I wish I
> were, too).
>
> On one hand, I very much applaud and appreciate your comment for
> injecting sanity to the discussion.  On the other hand, if Linus
> had such an attitude, we might not be hacking on git right now.

Thanks for the reply - sorry for being a bit of a stirrer ;-) Yes, I
do appreciate the irony and I'd have never started git. If anyone
really wants to do their own bugtracker... be like Linus not like me
(a mere follower) ;-)

> After looking at the above existing alternatives, some brave
> soul might decide and say, "Hey, I can write something better in
> 2 weeks" ;-).

Definitely. But that takes a deeper look into the above alternatives,
and probably a good perspective. I hope noone takes offence if I say
that -- as a user of several bugtrackers over ~10 years -- I haven't
yet read anything in this thread that is exciting.

And "it's closely integrated with git" can actually be a misfeature.
Cool if it's what gets you going, but not enough for world domination
;-)

> All of your examples are going from a single bug to commits, but
> from a release person's point of view, you are never interested
> in a single bug, just like a top-level maintainer is never
> interested in a single file.  A release person would want to go
> in the reverse direction: from a commit range to a set of bugs.

That's right. It's not that hard to correlate commits-in-the-changelog
and ask the bugtracker to produce a "tracker changelog" showing all
the bugs/tasks that link to the commits (with that liberal view of
"links to" discussed before). Formatting of the tracker changelog _is_
tricky but that's due to the ambiguities in those relationships.

(In Moodle I use JIRA, a non-FOSS tracker, and it does exactly that. I
think it has some notion of CVS branches, and where tags sit, so you
can ask for a report of which bugs are fixed in the release you are
preparing on branch X).

> What bugs were fixed and what regressions were introduced during
> this release cycle.  While embedded ticket numbers in commit log
> messages would certainly help, a change made to fix a particular
> bug may fix another as its side effect, and the develeoper who
> did the change may not know about the latter when the commit log
> message is written.

I agree it's useful, but I don't think it has any benefit having it in
the SCM _at all_. Having them in the BT is a lot more flexible -- and
the fact that git has stable commit IDs makes it easier to integrate
in a BT; as the BT can spot that the commit fixing bug 123 is now
merged into head ZZ as well as head YYY.

So the BT holds "external tags" to your commits. Lots of them. With a
ton of data. And that's great -- in fact there's no stopping it -- the
stability of SHA1s means that the whole internet holds tags to your
repo. Every time a SHA1 (or output of git-describe) is mentioned in a
mailing list, wiki or forum, there's a tag.

Now, to rule the world, BTs gain a lot more from being able to
integrate with different SCMs, automated test systems (like
tinderbox), MTAs (debbugs), wikis (traq), stats tracking for PHBs
(bugzilla), etc. So loose coupling wins here, and git's SHA1s are
great for that.

And at git's end we can get the smooth integration using/abusing that
loose coupling strategy. So if git-log/gitk/qgit grow some hooks that
can be used to perform a lookup... I can think of a perl script that
gets events for each SHA1 that git-rev-list produces and returns one
bug number, url and title (or more than one) that then git-log / gitk
/ qgit / annotate can use to further "decorate" the commit info in a
similar style to what gitk is doing now with head names in each
commit.

Would that fit your vision of a nicely integrated tracker?



martin (who's now thinking how to craft a proof of concept)
