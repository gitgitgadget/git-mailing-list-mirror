From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git User's Survey 2007 summary - git homepage improvements
Date: Wed, 17 Oct 2007 03:18:35 +0200
Message-ID: <20071017011835.GH18279@machine.or.cz>
References: <8fe92b430710141505y75ab61c4l50688fc9530e4f90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxYe-0006ev-U2
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbXJQBSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbXJQBSi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:18:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33345 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbXJQBSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:18:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 33BEC5A470; Wed, 17 Oct 2007 03:18:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8fe92b430710141505y75ab61c4l50688fc9530e4f90@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61301>

On Mon, Oct 15, 2007 at 12:05:22AM +0200, Jakub Narebski wrote:
> This website itself is tracked in Git as well - you can browse its
> development history or even clone it from
> http://repo.or.cz/r/git-homepage.git. The site is covered by GPLv2 and
> maintained by Petr Baudis who always takes patches eagerly. ;-)

Note that if someone is going to contribute to the homepage more
regularily, I can give him push access as well.

> Here is short summary of most common answers, with a short comment if
> appropriate:
> 
> Generic:
>  # Dedicated domain name / site name, e.g. git.org or git.com
>    to have it look less like mirror or unofficial page
> 
>    (git.or.cz still comes first when searching Google for "git";
>    current domain name was available to homepage admin - historical
>    reason)

See my other mail in this thread; if someone registers it, I can set
everything else up.

>  # Better design: make it prettier, easier to find information,
>    move more important things first, use sidebar instead of boxes,
>    perhaps divide it into separate pages (again). But make sure it
>    works on Elinks for example.
> 
>    (IIRC pasky is not web designer, so help is appreciated)

I'm not really unhappy with the current layout - I think it is pretty
enough but simple.  Dividing it to separate pages is question of taste
and opinitions simply differ; I personally think with the current amount
of information single page is fine. OTOH I think it would be nicer to
get more content on the page, then perhaps split it up. :-)

Sure, the webpage could be much prettier, with cute graphics and so on.
But I'm not a webdesigner and can't really do these things better than
how they already are. And is it really that bad?

> Documentation
>  # More documentation: tutorials, workflow examples, walkthroughs,
>    SCM commands comparison, interacting with other SCMs, HOWTOs, best
>    practices, recommended tools, fluxograms describing use cases
>    (graphics).  Make link to Git User's Manual stand out better.

Yes, please! Bring it on! ;-)

>  # Less emphasizis on Cogito, mark it more explicitely as deprecated
>    and slowly try to get rid of Cogito references in documentation
>    (e.g. crash courses).
> 
>    (Cogito is officially deprecated from not a long time; the process
>    of removing references to cg in crash courses is AFAIK ongoing)

Fixed, hopefully?

>  # Simple online demo. The demo could be an applet giving access to a
>    terminal of a running virtual machine with git and some demo
>    repositories.  The virtual machine is reset every full hour.
> 
>    (This might be a good idea, but I think it is a bit hard to do from
>    technical point of view; at least securely, securing against
>    intrusion and, perhaps accidental, denial of service)

Yes, and I don't think this is all that important since Git should be
readily available pre-packaged on all popular Linux distributions.

> Downloads:
>  # More up-to-date about new git versions.
> 
>    (With one person updating homepage, who is not git maintainer...)

That shouldn't have been a problem since May; there is a script being
run every 4 hours that syncs this up. If the homepage isn't picking a
release up in a timely fashion, that's a bug and I need to know about
it; I didn't notice anything like that yet, though.

>  # There should be links to download pu/next/master/maint branches
>    tar.gz trees (snapshots) from gitweb.
> 
>    (The source snapshot part is quite easy to do, but it might
>    increase load on kernel.org / repo.or.cz, unless snapshots are
>    somehow cached)

Why would anyone want this? Adding extra useless or seldom-used links to
the homepage is actually harmful, the important ones must not get lost
between those.

>  # Results of nightly builds and tests.
>    Static binaries for other OS (FreeBSD, MacOS X).
> 
>    (There is a matter of machine park. Somewhere those nightly builds,
>    perhaps together with nightly running of test suite, have to run.)

This is not something for the Git homepage itself. If someone volunteers
to run a tinderbox-like thing for Git, cool. I can link to it. ;-)

>  # Information about MS Windows version(s). Link to MSys Git, marking
>    it as under development; perhaps plea for help?

I'm not sure what in particular the MSys people want... They may want to
send patches, though. ;-)

Maybe we could merge the (largely artificially separated anyway)
subproject subsections to a single alphabetically-ordered subsection and
include MSysGit there?

>  # Provide processed man pages to install.
>    Provide PDF documentation, at least PDF version of Git User's Manual.
> 
>    (Having PDF version is quite new; there is no manual.pdf target in
>    official Makefile.)

I think it's more appropriate to link to this from inside the k.org Git
Manual site.

> Information, new links, new features
>  # Link to the latest release announcement (RelNotes) on download page.
> 
>    (Links to relnotes are in HTML version of git(7) manpage, but I
>    think it is not enough. Happily we _have_ release announcements)

Done.

>  # News section, info about where things are goung (roadmap)
> 
>    (Junio has a hard time maintaining TODO, and git doesn't have
>    roadmap AFAICT)

Maybe something like the News section could be nice, but someone else
would have to maintain it.

Then again, what would be the contents? Just aggregating recent
announces? Cc' posting-restricted mailing list on these and link to its
archives, and you will make more people happy.

>  # Provide 'A note from the maintainer' as a prominent link probably
>    named as 'How the git project is managed and how to participate'
> 
>    (That is a good idea I think, better than having it on GitWiki.
>    We can put direct link to SubmittingPatches nearby.)

Yes, got a patch from Michael Witten for this few days ago, applied now.
Thanks, Michael!

>  # Links to more tools, GUIs, version control interface layers.
>    A somewhat related request: copy pages like FAQ or Tips and Tricks,
>    or discussion about branches from GitWiki when they are mature
>    enough.
> 
>    (For example there was requests to put links to / info about Guilt
>    and Giggle on git homepage. Giggle has quite a bit of users among
>    GUIs).

I can't remember ever getting a patch. If I missed it, I'm sorry -
please resend.


> Code and design
>  * More prominent links to documentation on how to get started with
>    GIT.

How much more prominent can you be? :)

>  * The layout and the organization of the sections. It's pretty hard
>    to know why should I use git just looking at the webpage.

This is one of the things I tried to optimalize the layout to. If it
doesn't work, I'm sorry but I'm not getting it and you need to be more
concrete.

>  * Hide the rarer commands and special tricks deeper and emphasize the
>    best usage practices.

That's rather about the Git manual?

>  * Download link needs to stand out more. The homepage appears rather
>    'flat' that is nothing stands out as more important than the rest.

Maybe this improved a bit today.

>    In order of importance, I think there should be:
>      1. Download
>      2. Git Quickstart Guide
>      3. Documentation

Funnily enough, this _is_ the order in which the information flows.

>  * The lines are too long. Try to find a better proportion.

The sidebar would help here, I guess. Counter-argument is that sidebar
would take up space for the main content. ;-)

Opinions? Should the lines get a bit shorter? I'd almost agree.

>  * It doesn't look like a project home page.
>    Mercurial does a better job with the look of their page IMHO.

I actually find Mercurial's homepage much uglier, personally.

> Documentation

Many suggestions here are for the Git manual, actually; that's a good
sign that the integration isn't working so badly after all.

>  * 'git for svn/cvs people' could use an overhaul
>    (at least they did a few months ago)
>    The Git for SVN users tutorial is incomplete and does not explain
>    for example how the index works and why it's there. Thus people end
>    up thinking that 'svn add' is like 'git add' whereas it's not.

Yes, this would be nice to get improved; however, the surgery needs to
be very careful in order to avoid complicating or confusing things up
too much - I already got few patches that tried, but the end result
wasn't really working well. Maybe the whole crash course should just be
rewritten along the lines of the Git tutorial?

>  * Add some material for presenting git to others (slides)
>  * Perhaps making some pages like FAQ or Tips and Tricks, or
>    discussion about nature of branches in git taken from GitWiki when
>    they are mature enough

This touches a subject that I'm kind of surprised wasn't mentioned more,
that is the homepage-wiki duality. Are people happy with the current
setup? I kinda am, or would be if I got more patches. ;-) I'm personally
not too fond of having project's main homepage in wiki -
*especially* if it's made obvious by half of the screen space being
occupied by wiki-generated metalinks. But if everyone else thinks that
we should just move the main page to a wiki format, I won't stay in the
way.

I'd like to use this space to also repeat that I never seriously
intended to maintain the technical side of the wiki, I've set up just
because it was so damn easy. I have grown to just hate the wiki engine
we use, and if someone wants to take the wiki over, you are welcome!

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
