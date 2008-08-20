From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 13:14:50 -0700
Message-ID: <7v4p5fqw91.fsf@gitster.siamese.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com>
 <200808200308.26308.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVu69-0000a2-VR
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbYHTUO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYHTUO6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:14:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYHTUO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:14:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D807612F8;
	Wed, 20 Aug 2008 16:14:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2CB9C612F7; Wed, 20 Aug 2008 16:14:51 -0400 (EDT)
In-Reply-To: <200808200308.26308.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 20 Aug 2008 03:08:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A85755E0-6EF4-11DD-9559-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93030>

Jakub Narebski <jnareb@gmail.com> writes:

> This is second revision (version) of proposed questions 
> for Git User's Survey 2008.

Very nicely done.

> Getting started with GIT
>
>    xx. How did you hear about Git?
>        (single choice?, in 2007 it was free-form)
>      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
>        news site or magazine, blog entry, some project uses it,
>        presentation or seminar (real life, not on-line), SCM research,
>        IRC, mailing list, told by friend, word of mouth (off-line),
>        other Internet, must be used at job, other off-line, other(*)
>      + the problem is with having not very long list (not too many
>        choices), but spanning all possibilities.
>      + is this question interesting/important to have in survey?

I'd say this is more interesting than "what programming language do
you speak".

>    xx. Which Git version(s) are you using?
>        (zero or more, multiple choice:
>         one can use different versions on different machines)
>      - pre 1.3, 1.3, 1.4, 1.5, 1.6, master, next
>      + might be important when checking "what did you find hardest" etc.

This is a very good idea.  "What is hardest" grouped by "How proficient
are you with git".

> Other SCMs (shortened compared with 2007 survey)
>
>    xx. What other SCM did or do you use?
>      ! (zero or more: multiple choice)
>        (matrix with the following columns: never/used it/still use)

"Plan to use"?

>      - SCCS, RCS, CVS, Subversion, Arch or clone (ArX, tla, ...),
>        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
>        BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
>        Team System, PVCS, custom, other (please specify)

With this number of "other systems", it is easier to pick if they are
sorted alphabetically.

> How you use Git
>
>    xx. Which (main) git web interface do you use for your projects?
>        (zero or more: multiple choice)
>      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), Gitorious,
>        other (please specify)

You have reworded this question on the site but it has typo "Unless of
cours you are hosting..." (s/cours y/course y/).

>    xx. How do you publish/propagate your changes?
>        (zero or more: multiple choice)
>      - push, pull request, format-patch + email, bundle,
>        git-svn, foreign SCM (not via git-svn),
>        other (see also below)

cvsexportcommit?

>    xx. If the way you publish your changes is not mentioned above, how
>        do you publish your changes?  Please explain.
>        (free form, either input field or textarea)
>    xx. How often do you use the following forms of git commands or extra
>        git tools?
>        (matrix form: never/rare/often)

"never, rarely, *sometimes*, often"?

>         . git add -i / -p
> 	. git add -u
>         . git am
>         . git am -i
> 	. git apply

"apply --whitespace=fix"?

> 	. git cvsserver

"git daemon" and "git daemon (pushing enabled)" as separate items.

> 	. git ... --dirstat

"diff --check"?

>         . git pull

"pull --rebase"?

> 	. git pull <remote>
> 	. git pull <URL> <ref>
>         . git push

Separate "(empty) vs <remote> vs <URL> <refspec>" entries for "git push"?
Also for "git fetch"?

> 	. git stash

"git stash pop"?
"git stash save --keep-index"?

>      + in what order should be those commands; currently they are in
>        alphabetical order?

That is the most sensible.

>    xx. Which of the following features do you use?
>        (zero or more: multiple choice)
>      - git-gui or other commit tool, gitk or other history viewer, patch
>        management interface (e.g. StGIT), bundle, eol conversion (crlf),
>        gitattributes, submodules, separate worktree, reflog, stash,

If you single out "eol conversion", perhaps separate "whitespace
attributes" out of generic "gitattributes"?

s/separate worktree/& (git-new-workdir)/;

> Documentation
>
>    xx. What could be improved on the Git homepage?
>        (free form)
>    xx. What could be improved in Git documentation?
>        (free form)

"What can/will you do to help improve them?"?

> Translating Git
>
>    xx. What is your preferred non-programming language?
>   (or) What is the language you want computer communicate with you?
>    xx. What do you need/want to have translated?
>        (zero or more, multiple choice)
>      - commands messages, manpages, manual & tutorial etc.,
>        technical documentation, HOWTOs, git homepage, git wiki,
>        git-gui/gitk, subcommands and long option names

LOL on the last one ;-)  Please keep it --- we may find amusing results.

> Getting help, staying in touch
>
>    xx. Have you tried to get Git help from other people?
>     -  yes/no
>    xx. What channel did you use to request help?
>        (zero or more: multiple choice)
>     -  git mailing list, git users group, IRC, blog post, 
>        asking git guru/colleague, other

You have "IRC (#git)".  Perhaps a separate item "IRC (#github)"?

> Open forum
>
>    xx. What other comments or suggestions do you have that are not
>        covered by the questions above?
>        (free form)
>    xx. Should such a survey be repeated next year?
>     -  yes/no/no opinion

"Such a", meaning "This"?
