From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 11:53:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLb2N-0002NT-MV
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYGWJwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYGWJwg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:52:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:42536 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752108AbYGWJwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:52:35 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:52:32 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp013) with SMTP; 23 Jul 2008 11:52:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ha654vzbhww/a8otGxeyHKa/9kAZm9zC8xqH6CE
	lymaruxVpBDC9O
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89618>

Hi,

On Wed, 23 Jul 2008, Jakub Narebski wrote:

> First there is a question about the form of survey. Should we use web
> based survey, as the survey before (http://www.survey.net.nz), sending
> emails with link to this survey, or perhaps do email based survey,
> with email Reply-To: address put for this survey alone?

Some people prefer to stay anonymous, so I think email is out.

>    04. Which programming languages you are proficient with?
>        (The choices include programming languages used by git)
>        (zero or more: multiple choice)
>      - C, shell, Perl, Python, Tcl/Tk
>      + (should we include other languages, like C++, Java, PHP,
>         Ruby,...?)

Yes, I think this should be a long list.

>    07. What helped you most in learning to use it?
>        (free form question)

Is it possible to have multiple choice, with "other" (free-form)?  Then 
I'd suggest:

	Colleague/Instructor, User Manual, Manpages, Tutorials, Tutorials 
	(elsewhere; not in git.git), Mailing list, IRC, Git Wiki, Other.

>    08. What did you find hardest in learning Git?
>        What did you find harderst in using Git?

s/harderst/hardest.

>        (free form question)

Again, I'd suggest a multiple choice + Other:

	The amount of commands, the amount of options, the index (AKA 
	staging), branching, user interface, bugs, Other.

> Other SCMs (shortened compared with 2007 survey)
> 
>    10. What other SCM did or do you use?
>        (zero or more: multiple choice)
>      - CVS, Subversion, GNU Arch or arch clone (ArX, tla, ...),
>        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
>        BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
>        Team System, custom, other(*)

PVCS seems to be pretty popular, too.

>    11. Why did you choose Git? (if you use Git)
>        What do you like about using Git?
>        (free form, not to be tabulated)

Again, to avoid hassles with free-form:

	Mandatory: work, mandatory: open source project I am participating 
	in, speed, scalability, It's What Linus Uses, Other.

>    12. Why did you choose other SCMs? (if you use other SCMs)
>        What do you like about using other SCMs?
>        Note: please write name of SCMs you are talking about.
>        (free form, not to be tabulated).

Again:

	ease-of use, simplicity, existing project uses it, I Do Not Like 
	Linus, Other

>    15. What operating system do you use Git on?
>        (one or more: multiple choice, as one can use more than one OS)
>      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
>        MS Windows/msysGit, MacOS X, other UNIX, other

You should include "Dunno", which gets automatically mapped to "MS 
Windows/msysGit" ;-)

>    19. How do you publish/propagate your changes?
>        (zero or more: multiple choice)
>      - push, pull request, format-patch + email, bundle, other

git svn

You might laugh, but it is a sad fact that some guy promotes "Using Git 
with Google Code" by using git-svn to drive their crappy Subversion.

>    22. How does Git compare to other SCM tools you have used?
>      - worse/equal (or comparable)/better
>    23. What would you most like to see improved about Git?
>        (features, bugs, plug-ins, documentation, ...)

Maybe here should be another question "What are the most useful features 
of Git?" but maybe that is covered by earlier questions.

>    24. If you want to see Git more widely used, what do you
>        think we could do to make this happen?
>      + Is this question necessary/useful?  Do we need wider adoption?

I agree with Junio: this is not so interesting for us; we are no company, 
and we have no sales department who could wank of on these answers.

>    27. Which of the following features do you use?
>        (zero or more: multiple choice)
>      - git-gui or other commit tool, gitk or other history viewer, patch
>        management interface (e.g. StGIT), bundle, eol conversion,

For our Windows friends, we should add " (crlf)" to the last item.

>    42. Do you find traffic levels on Git mailing list OK.
>     -  yes/no? (optional)

/too low?  *ducksandrunsforcover*

>    44. If yes, do you find IRC channel useful?
>     -  yes/no (optional)

/somewhat.  Even if I would be the only one choosing that option.

>    45. Did you have problems getting GIT help on mailing list or
>        on IRC channel? What were it? What could be improved?
>        (free form)

Yeah, I know who will answer to that, and what... "yaddayadda very 
unfriendly yaddayadda especially that Johannes guy yaddayadda" (you know 
who you are)... *lol*

Thanks Jakub, I think that your effort is very useful.

Ciao,
Dscho
