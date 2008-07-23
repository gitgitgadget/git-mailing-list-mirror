From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 16:12:24 +0200
Message-ID: <20080723141224.GA17648@leksak.fem-net>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLf5y-00084f-GX
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYGWOMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbYGWOMd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:12:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:46487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751817AbYGWOMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:12:32 -0400
Received: (qmail invoked by alias); 23 Jul 2008 14:12:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp053) with SMTP; 23 Jul 2008 16:12:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18B2YsEBRMBsdA/DVWYbYLneqUyYs3ECjuYfCfnfM
	ZCi9edyAwoxmkk
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLf4q-0005gr-6W; Wed, 23 Jul 2008 16:12:24 +0200
Content-Disposition: inline
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89661>

Hi,

Jakub Narebski wrote:
> I'd rather avoid free-form questions, even if they are more interesting,
> as they are PITA to analyse and summarize, especially to create some 
> kind of histogram from free-form replies data (some of 2007 free-form
> responses are not fully summarized even now).

Then we should use a web-based survey, because e-mail-based will always
be used to write free-form answers, I think.

So for multiple choice questions an "Other" item is often useful, but
-- if the survey service allows it -- I'd prefer if the "Other" item
enables a text input field (free-form) to let the user be more concrete.
Those values are informational only, but could be added to Git User's
Survey 2009, if they occur more than once. :)

> Third, where to send survey to / where to publish information about the 
> survey?  Last year the announcement was send to git mailing list, to
> LKML (Linux kernel mailing list), and mailing list for git projects 
> found on GitProjects page on GIT wiki.  Now that the number of projects 
> using Git as version control system has grown, I don't think it would 
> be good idea to "spam" all those mailing list; and if we don't send 
> notice to all other projects I'm not sure if we should include LKML.

Hmm, perhaps we could spam some news sites[1] on the web and keep the lists
clean.  Of course, this is advertising for git, too ;-)

[1] I could write something for German-speaking pro-linux.de and symlink.ch
    though I don't know if they take it as news.

> Last year survey announcement was put on Git Homepage (thanks Pasky), 
> and on front page of Git Wiki; info about survey was also put on two 
> git hosting sites: kernel.org and repo.or.cz.

Nice. That should be done again ;-)

> Last year the survey was meant to take three weeks, but was up longer.

Perhaps this is much too much, but my first thought was: 8 weeks.
Hmm, perhaps 5 weeks?

>    04. Which programming languages you are proficient with?

This is a really nasty multiple choice question.

>        (The choices include programming languages used by git)
>        (zero or more: multiple choice)
>      - C, shell, Perl, Python, Tcl/Tk
>      + (should we include other languages, like C++, Java, PHP,
>         Ruby,...?)

Perhaps yes.
The programming language list
	https://www.ohloh.net/tools
could be a start %)

>      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
>        news site or magazine, blog entry, some project uses it,
>        presentation or seminar (real life, not on-line), SCM research,
>        IRC, mailing list, other Internet, other off-line, other(*)

- other off-line: told by friend, must be used at job, ...

>      + the problem is with having not very long list (not too many
>        choices), but spanning all possibilities.

Hmmm.
Is this a limitation by the free web-based services or is this due to
survey usability issues?

>    09. When did you start using git? From which version?
>      - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
>      + might be important when checking "what did you find hardest" etc.
>      + perhaps we should ask in addition to this question, or in place
>        of this question (replacing it) what git version one uses; it
>        should be multiple choice, and allow 'master', 'next', 'pu',
>        'dirty (with own modifications)' versions in addition.

Hmm, the master/next/pu/dirty question will be a mystery to most git users
that have never cared about git source code.

> How you use Git

>    16. Which porcelains / interfaces / implementations do you use?
>        (zero or more: multiple choice)
>      - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
>        Pyrite, Easy Git, IsiSetup, jgit, my own scripts, other

I wonder if this could be extended to get an idea how many people use
plumbing directly or, even better, add a question like:

	Which of the following git commands or extra git tools do you use regularly?

	[list of all plumbing, porcelain and tools like stgit, guilt, etc]

or "... have you never used?", or "...have you ever used?"...
Just to get an idea of what commands are often used by the users.

Perhaps it is even useful to extend that list by some behavior-changing
options, like:

	[ ] git add
	[ ] git add -i / -p
	...
	[ ] git am
	[ ] git am -i
	...
	[ ] git merge
	[ ] git merge with strategy
	...
	[ ] git rebase
	[ ] git rebase -i

...though this is also handled by question 27 (see below).

Yes, this will be a long list :-)
And don't forget the [ ] other :)

Of course this question could be split into
 - extra tools
 - guis (like question 17.)
 - helpers
 - porcelain
 - plumbings

Question 27. should be in this section, too:

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

Hmm, I'd remove "git-gui or other commit tool, gitk or other history
viewer, patch management interface (e.g. StGIT)".
And depending of the question I just proposed, "interactive rebase",
"add --interactive [...]", "bisect" could be removed, too.

>    18. Which (main) git web interface do you use for your projects?
>        (zero or more: multiple choice)
>      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
>      + should there be a question about web server (Apache, IIS, ...)
>        used to host git web interface?

No, why should we care about the web server? :)

>    22. How does Git compare to other SCM tools you have used?
>      - worse/equal (or comparable)/better
>    23. What would you most like to see improved about Git?
>        (features, bugs, plug-ins, documentation, ...)
>    24. If you want to see Git more widely used, what do you
>        think we could do to make this happen?
>      + Is this question necessary/useful?  Do we need wider adoption?

Hmmm,
"Do you miss features in git that you know from other SCMs?"
"If yes, what features are these?"

>    26. How do you compare current version with version from year ago?
>      - current version is: better/worse/no changes

Since this is single-choice, a "don't know"/"cannot say" option should 
be added.

>    28. If you use some important Git features not mentioned above,
>        what are it?

"what are it" sounds somehow funny. Is it correct?
"what are them?" or "what are those?"
Or
"If you use some important Git feature not mentioned above, what is it?"

> Documentation
> 
>    29. Do you use the Git wiki?
>     -  yes/no
>    30. Do you find Git wiki useful?
>     -  yes/no/somewhat
>    31. Do you contribute to Git wiki?
>     -  yes/no/only corrections or spam removal
>    32. Do you find Git's on-line help (homepage, documentation) useful?
>     -  yes/no/somewhat
>    33. Do you find help distributed with Git useful
>        (manpages, manual, tutorial, HOWTO, release notes)?
>     -  yes/no/somewhat
>    34. What could be improved on the Git homepage?
>        (free form)
>    35. What could be improved in Git documentation?
>        (free form)

36. Do you think there is too few documentation on the web?
37. Do you think there is too much documentation on the web?

No ;-) Perhaps:

36. Do you think it is easy to find out how to do a specific task with
    git?

> Open forum
> 
>    46. What other comments or suggestions do you have that are not
>        covered by the questions above?
>        (free form)

About the survey

47. Do you have any comments about the survey?
48. Should such a survey be repeated next year?
(Or: Would you take part in such a survey next year again?)
    [ ] Yes
    [ ] No, but 2010 again.
    [ ] No, never again.

Just a poor idea to get "feedback" if people like to take part in this
survey or not.


Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
