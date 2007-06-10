From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 11 Jun 2007 11:14:03 +1200
Message-ID: <46a038f90706101614h48112deel70d848f4312c88d7@mail.gmail.com>
References: <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
	 <20070610083754.GC4084@efreet.light.src>
	 <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	 <46a038f90706100138g46d872f7o463418631585bf13@mail.gmail.com>
	 <46a038f90706100155q1da663d7le3bf0345c68e47ae@mail.gmail.com>
	 <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	 <20070610101616.GF2951@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWbq-0002qw-8C
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942AbXFJXOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXFJXOH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:14:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:34369 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760710AbXFJXOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:14:04 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1259159wxc
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:14:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KKXrUqcF3oNLwfjkvggiglwu4msZl+Bm689kvcJsIMPmu4w6BhHoXxXyA8K1cpVorxHZMd4k34DKBEXehOem4WT0JN68OBdMQlyYlNy2bZYDACvThusNFEWs34DZdaz2jkErcSyRX4seGCKqWHYd4YFy2yjSIrBuJFetaLNOI4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W7s7RpDlt7RQvkQJ0zRZ/Zg49C0HzuqiIOphZkpUGjnhY0y92OuATbXFmBS8+pYe5IkLIWdgfRg2q30VQJPlACiyRRpxJCzYH24XkTwkvOcqSJjiqISzoreaGkZ3qgkMFGPPZmgudfNQ7c5TesfYTQTQ3BIOb+L8HKoiBk9H5HI=
Received: by 10.90.63.16 with SMTP id l16mr4698509aga.1181517243959;
        Sun, 10 Jun 2007 16:14:03 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sun, 10 Jun 2007 16:14:03 -0700 (PDT)
In-Reply-To: <20070610101616.GF2951@artemis>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49787>

On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Sun, Jun 10, 2007 at 06:59:13PM +1200, Martin Langhoff wrote:
> >
> > Call me a fool, but writing a <new> bugtracker looks like a
> > boil-the-oceans scheme.
>
>   Sure, what if I like it anyway ?

Be my guest. It might turn out to be a beautiful project, but has low
chances of helping GIT-BTS integration in general.

> > Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> > what is going to make the difference. Most of those have already the
> > ability to "link" to one or more commits -- after the commits are done
> > and in GIT.
>
>   Sure, you can do that and still inherit from the many downsides of
> those tools: central, needs another separate tool to work with, and a
> tool that nowadays tends to eat 500Mb of your memory if you take the
> most hype implementation of it (Yes I'm describing a web browser), that
> is slow like hell (because yes, there is many clients at the same time
> on the central server, that is overloaded like hell), and so on.

Most usable BTSs work on lighter webbrowsers, and can be tuned to work
reasonably. That's not a dead-end per se.

>   You can like central web UIs, your choice. And I suppose if grit works
> well, there will be one at some point.

Bugtrackers are communication tools between developers and users. In
many spaces, they are _teaching tools_, teaching the users about info
developers need. That's why BTSs have explicit fields asking for
important variables like OS, Arch, and version you are reporting a bug
against. That's also why the BTS gains a lot from being web-based:
extreme portability, reachability, zero-install for users.

> > So you can tell your bugtracker
> > - which commit fixed it -- usually auto-linked if you include the
> > bugnumber in the commit message
> > - which commit added the test -- auto linked as above
> > - which commit introduced the bug -- if such thing exists and someone
> > digs it up
>
>   yeah, that is what bugtrackers already do. Though, that's of no use
> for release managers. What is useful is what people call "milestones" in
> trac e.g., meaning a set of bugs that has been flagged as needing to be
> fixed. And what a release manager need is a tool to deal with this set
> of bugs as a whole.

Hmmm. Most BTSs have milestones, and the integration of the above with
milestones is useful for release managers. How about the _rest_ of the
BTS-using populace?

>   That's the same argument that Linus has against per-file tracking.
> Also atm when you e.g. backport a patch that fixes this or this bug,
> you're no BTS helps you tagging the bug as fixed in that branch as well.
> Not to mention that BTS I know do not make any use of the commits DAG.
> And for a very good reason, there is no real DAG in many existing tools
> (svn, cvs, ...).

Making the BTS DAG-aware is overkill. The BTS can ask for every update
on every branch "what commits does it bring into branch X?" and that's
all you need. If you backport a patch and mention the original patch
SHA1 the BTS can do its job.

And all of that can be done SCM-agnostic - except for the regex to
spot a commitid.

> > And definitely, if you use git as an alibi to write a new bugtracker,
> > don't use the "works only with git" as a feature. It should work with
> > as many SCMs as possible.
>
>   No it should not, because it can't. I want the distributed and
> Bug status spanning-DAGS be a central feature.

But you lose portability. And gain... what that you can't do portably?
>   You're a lucky guy. All bug trackers I've used suck a way or another,
> that impedes my workflow a lot. Let's cite a couple:

Ok - but BTSs are a compromise, something that must work for users,
and developers.

> > Bugtrackers are co-owned by developers, users and (where they exist)
> > project managers.
>
>   That's exactly why distributed rock. Because everyone could _really_
> own _his_ bugtracker. This solves the same range of ACLish issues git
> solves with respect to the code.

Don't think I've seen politics over who owns the bugtracker ;-) but I
_have_ seen politics over specific bugs (developers close unfixed
bugs, flamefests ensue). I guess with a DBTS everyone can have their
own status for the bug... but does that help the user? Or the
developer?

> > Well - hmmm. Git's database is great at tracking _content identity_.
> > But a bug's content identity (description+comments+status) changes all
> > the time. I don't think it's naturally a good match.
>
>   Oh, because the code never changes. Doh, how stupid I am :)
>   No, really, you name your bug after the sha hash of the first report,
> I think that's pretty obvious. That gives you a bug name. Then you ask
> git for "what's the current sha for this bug in the tip of the BTS
> branch", then you ask "so now what this new sha is pointing to in the
> code". That's a small indirection that I suppose is bearable.

Of course, you _can_ map the DBTS storage on git's storage. But git's
storage has been designed to match the task. While I'm sure there are
some good tricks to reuse, I don't think that it's a good fit.

> > And at git's end we can get the smooth integration using/abusing that
> > loose coupling strategy. So if git-log/gitk/qgit grow some hooks that
> > can be used to perform a lookup... I can think of a perl script that
> > gets events for each SHA1 that git-rev-list produces and returns one
> > bug number, url and title (or more than one) that then git-log / gitk
> > / qgit / annotate can use to further "decorate" the commit info in a
> > similar style to what gitk is doing now with head names in each
> > commit.
> >
> > Would that fit your vision of a nicely integrated tracker?
>
>   Honestly ? No, because that would be horribly slow (but I'd love to be
> proven wrong).

What part would be slow?

cheers



martin
