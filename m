From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 09:45:37 -0500
Message-ID: <48889591.9020208@freescale.com>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM26M-0002uX-Vs
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946AbYGXOpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757720AbYGXOpv
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:45:51 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:64127 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbYGXOps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:45:48 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m6OEjeio008094;
	Thu, 24 Jul 2008 07:45:40 -0700 (MST)
Received: from [10.213.161.24] (vpn-10-213-161-24.am.freescale.net [10.213.161.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6OEjdMd012415;
	Thu, 24 Jul 2008 09:45:39 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89891>

Jakub Narebski wrote:
>
> About you
> 
>    01. What country are you in?
>    02. What is your preferred non-programming language?
>   (or) What is the language you want computer communicate with you?

How about:  What is your preferred natural language?

>    03. How old are you (in years)?
>        (free form, integer)
>    04. Which programming languages you are proficient with?

Perhaps:
    With which programming languages are you proficient?

>        (The choices include programming languages used by git)
>        (zero or more: multiple choice)
>      - C, shell, Perl, Python, Tcl/Tk
>      + (should we include other languages, like C++, Java, PHP,
>         Ruby,...?)
> 
> 
> Getting started with GIT
> 
>    05. How did you hear about Git?
>        (single choice?, in 2007 it was free-form)
>      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
>        news site or magazine, blog entry, some project uses it,
>        presentation or seminar (real life, not on-line), SCM research,
>        IRC, mailing list, other Internet, other off-line, other(*)
>      + the problem is with having not very long list (not too many
>        choices), but spanning all possibilities.

So go more general?  Don't specify actual news (web)sites.
Don't forge that there is a whole raft of Ruby-n-rails folks who
are embracing Git these days too.  They have their own whole 'nuther
set of mailing lists, websites, (news) lists, etc.

>      + is this question interesting/important to have in survey?

Look to the history to answer this question.  Did we really
learn anything from the earlier surveys by this question?
Maybe it would make more sense to get a feel for which general
camp led them to Git?  That is, did they come from the Kernel
side of the world, or Ruby-on-Rails, or self-exploration, etc.

>    06. Did you find GIT easy to learn?
>      - very easy/easy/reasonably/hard/very hard

But that has to be contrasted with their _current_ notion
in order to know if they make progress or not.  If the
difficulty persists, we're in trouble.  If it is just a
steep learning curve, we might be able to address that.

So maybe some variant questions like:
    How do you find it now (after some use)?
        same [very easy..very hard] scale
    How long have you been using Git?
    Rate your own Git proficiency:
        [noob, casual, I survive, everyday use,
         I answer questions from others,
         I use plumbing in scripts daily,
         Power User, Godly, I am Junio]

>    07. What helped you most in learning to use it?
>        (free form question)
>    08. What did you find hardest in learning Git?
>        What did you find harderst in using Git?
>        (free form question)
>    09. When did you start using git? From which version?
>      - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5

It's likely that most people don't know the specific answer
to that question and will just guess, if anything.  It is
also semi-subject to time-slide as old installs are made on
different distributions [*cough*] Debian.  I think the question
"How long have you been using Git?"  Might be more easily
answered and show better data.  (Adoption curve.)

>      + might be important when checking "what did you find hardest" etc.
>      + perhaps we should ask in addition to this question, or in place
>        of this question (replacing it) what git version one uses; it
>        should be multiple choice, and allow 'master', 'next', 'pu',
>        'dirty (with own modifications)' versions in addition.

> 
> Other SCMs (shortened compared with 2007 survey)
> 
>    10. What other SCM did or do you use?
>        (zero or more: multiple choice)
>      - CVS, Subversion, GNU Arch or arch clone (ArX, tla, ...),
>        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
>        BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
>        Team System, custom, other(*)

What?  No SCCS?

>    10b.If you selected other above, what SCM it was?

s/it was/was it/

>        (free form)
>    11. Why did you choose Git? (if you use Git)

That's a bit vague...  First, maybe they didn't choose Git.
Maybe they are on a project where it was mandated.
So, Why did they choose Git for _what_?

Are we trying to ask "Why did you decide to use Git?" ?

>        What do you like about using Git?
>        (free form, not to be tabulated)

Presuming they do... :-)  So, maybe add:

    I enjoy using Git:           [-5 .. 0 .. +5]
    Git satisfies my use cases:  [-5 .. 0 .. +5]
    I prefer Git over CVS/SVN:   [-5 .. 0 .. +5]

Or so...

>    12. Why did you choose other SCMs? (if you use other SCMs)
>        What do you like about using other SCMs?
>        Note: please write name of SCMs you are talking about.
>        (free form, not to be tabulated).
> 
> 
> How you use Git
> 
>    13. Do you use Git for work, unpaid projects, or both?
>        (single choice)
>      - work/unpaid projects/both

But there are other uses too.  I use it for personal crap
like my Brewing Log.  Sure, it is an "unpaid project", but
that's not very useful information.  Maybe it would make
sense to expand this question into, say, 10 choices that
we feel are likely uses cases and see what the actual
demographics are.  That is, the two-part-with-waffle isn't
that informative.

Maybe:
     I use Git for: [check all that apply]
         Work projects
         Personal data
         Unpaid Open Source Development
         Sharing Data with my Niece
         Maintaining my Website
         Backending my Blog
etc.

My point here is that we can learn what Git is being
used for, and ....

    Although for some reason I can't yet, I would
    really like to use Git for:
        My Wordpress backend
        Maintaining my {pr0n,mp3} Collection
        Work projects
        Sharing data with my boss
etc.

That would give us a sense of direction possibly.
It might provide a notion as to what people are wanting
to do, but for some reason find it hard to pull off.
That is, help us identify use-cases that are being limited
but would otherwise be adoptive.

>    14. How do you obtain Git?
>      - binary package/source package or source script(*)/
>        source tarball/pull from main repository
>        (*) this includes source based distributions like Gentoo
>      + added new option: source package or source script
>      + should this be multiple choice?
>    15. What operating system do you use Git on?
>        (one or more: multiple choice, as one can use more than one OS)
>      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
>        MS Windows/msysGit, MacOS X, other UNIX, other
>      + "What hardware platforms do you use GIT on?" question was
>        removed; should it stay?
>    15b.If you selected "other UNIX", or "other", what operating system
>        or systems it was/were?
>        (free form)
>    16. Which porcelains / interfaces / implementations do you use?
>        (zero or more: multiple choice)
>      - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
>        Pyrite, Easy Git, IsiSetup, jgit, my own scripts, other
>    16b.If you selected "other porcelain", what is its name?
>        (free form)
>    17. Which git GUI (commit tool or history viewer, or both) do you use
>        (zero or more: multiple choice)
>      - CLI, gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
>        (h)gct, qct, KGit, git-cola / ugit, GitNub, Pyrite, git.el, other
>    17b.If you selected "other GUI", what is its name?
>        (free form)
>    18. Which (main) git web interface do you use for your projects?
>        (zero or more: multiple choice)
>      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
>      + should there be a question about web server (Apache, IIS, ...)
>        used to host git web interface?

Probably not.  Most people might not even know.

>    18b.If you selected "other web interface", what it was?
>        (free form)
>    19. How do you publish/propagate your changes?
>        (zero or more: multiple choice)
>      - push, pull request, format-patch + email, bundle, other
>    19b.If the way you publish your changes is not mentioned above, how
>        do you publish your changes?
>        (free form)
>    20. Does git.git repository include code produced by you?
>      - yes/no
> 
> 
> What you think of Git
> 
>    21. Overall, how happy are you with Git?
>      - unhappy/not so happy/happy/very happy/completely ecstatic
>    22. How does Git compare to other SCM tools you have used?
>      - worse/equal (or comparable)/better
>    23. What would you most like to see improved about Git?
>        (features, bugs, plug-ins, documentation, ...)
>    24. If you want to see Git more widely used, what do you
>        think we could do to make this happen?
>      + Is this question necessary/useful?  Do we need wider adoption?

Hmmm.  See some ramblings of mine above too... :-)

> 
> Changes in Git (since year ago, or since you started using it)
> 
>    25. Did you participate in previous Git User's Surveys?
>        (zero or more, multiple choice)
>      - 2006, 2007
>    26. How do you compare current version with version from year ago?
>      - current version is: better/worse/no changes

More fine detail needed there?  To help identify what people
think have improved and what has not yet improved?

Since you started using Git, rate how the following
functional areas have/have-not improved:
    The User Interface          [-5 .. 0 .. +5]
    The command line interface  [-5 .. 0 .. +5]
    The intuitive behavior      [-5 .. 0 .. +5]
    The overall experience
    The behavior of 'fetch'
    The behavior of "git log'
    The config file
etc.

A -5 means it still sucks or got worse, 0 is neutral
or no opinion, and +5 means it rocks or got better.
This would give us direct feedback indicating if we,
as a whole, are headed in the right direction with our
development efforts.  It will also directly tell us
which features people find still suck.

We should attempt to get direct feedback on many Git features.

>    27. Which of the following features do you use?
>        (zero or more: multiple choice)
>      - git-gui or other commit tool, gitk or other history viewer, patch
>        management interface (e.g. StGIT), bundle, eol conversion,
>        gitattributes, submodules, separate worktree, reflog, stash,
>        shallow clone, detaching HEAD, mergetool, interactive rebase,
>        add --interactive or other partial commit helper, commit
>        templates, bisect, other (not mentioned here)
>      + should probably be sorted in some resemblance of order
>      + are there any new features which should be listed here?
>    28. If you use some important Git features not mentioned above,
>        what are it?
>        (free form)
> 
> 
> Documentation
> 
>    29. Do you use the Git wiki?
>     -  yes/no
>    30. Do you find Git wiki useful?
>     -  yes/no/somewhat
>    31. Do you contribute to Git wiki?
>     -  yes/no/only corrections or spam removal

If "no", why not?  [Wikis suck, I don't know the answers, no time...]

>    32. Do you find Git's on-line help (homepage, documentation) useful?
>     -  yes/no/somewhat

Confusing.

>    33. Do you find help distributed with Git useful
>        (manpages, manual, tutorial, HOWTO, release notes)?
>     -  yes/no/somewhat
>    34. What could be improved on the Git homepage?
>        (free form)
>    35. What could be improved in Git documentation?
>        (free form)
> 
> 
> Getting help, staying in touch
> 
>    36. Have you tried to get Git help from other people?
>     -  yes/no
>    37. What channel did you use to request help?
>        (zero or more: multiple choice)
>     -  git mailing list, git users group, IRC, blog post, 
>        other
>     +  this is one question which doesn't need, I think, explanation
>        of "other" choice
>    38. If yes, did you get these problems resolved quickly
>        and to your liking?
>     -  yes/no
>    39. Would commerical (paid) support from a support vendor
>        be of interest to you/your organization?
>     -  yes/no/not applicable

s/commerical/commercial/

>    40. Do you read the mailing list?
>     -  yes/no
>    41. If yes, do you find it useful?
>     -  yes/no (optional)
>    42. Do you find traffic levels on Git mailing list OK.
>     -  yes/no? (optional)

    I find the mailing list traffic level to be:
        [too low, OK, just right, tolerable, intolerable,
        a bit high, absurdly high]

>    43. Do you use the IRC channel (#git on irc.freenode.net)?
>     -  yes/no
>    44. If yes, do you find IRC channel useful?
>     -  yes/no (optional)
>    45. Did you have problems getting GIT help on mailing list or
>        on IRC channel? What were it? What could be improved?
>        (free form)
> 
> Open forum
> 
>    46. What other comments or suggestions do you have that are not
>        covered by the questions above?
>        (free form)
> 

I've got to ... ramble on,
jdl
