From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 03:25:03 +0200
Message-ID: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 03:26:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLT7L-00068C-HX
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbYGWBZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYGWBZL
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:25:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22422 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYGWBZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:25:08 -0400
Received: by ug-out-1314.google.com with SMTP id h2so449569ugf.16
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=10Qj99PMulIzkMdyioI0PgT0ZnWWnrxSaZfZ7Fyi+xE=;
        b=W8cgVsAq9pmFxQhWdPPCmPE37dI6OCnHA2csj6LDryQa/UnbcforAebcZbuJo2X+4R
         oq19feOazXydNK362/6vFKPtqwIqIWymxMGPRjt0SaM6ufL4bp4GbEy4O8gWbVKxCXHF
         afRdyTOdyZOtOsMcz6if9Jd5vmXvOOhZQxlGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=U7xLm+OMjbevyyQcWC3SlCkx7/MFsSF9hrhBTu0Kaimhxg6ERsDqZ1sqflVOOWBJQo
         wSmf13pquNwPeuvFqW+JYM9b97d16ZzpSUerjdWEgXhM2uaWHcNqQ3CGfILCjUCa6U9V
         wlEO1/DHxKk2VNyRu0Fbi1Z6n9J4NpgzuTAM4=
Received: by 10.67.121.14 with SMTP id y14mr37927ugm.10.1216776305701;
        Tue, 22 Jul 2008 18:25:05 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.247.139])
        by mx.google.com with ESMTPS id y1sm2858059uge.10.2008.07.22.18.25.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 18:25:04 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89592>

It's been around a year since last Git User's Survey.  It would be
interesting to find what changed since then.  For example to see if 
there were visible improvements in easing learning curve and in 
usability.  Therefore the idea to have another survey.

(If there is no suck^W volunteer to create survey, announce it, and 
finally summarize results and publish summary on Git Wiki, I would do 
the 2008 survey.)


First there is a question about the form of survey. Should we use web
based survey, as the survey before (http://www.survey.net.nz), sending
emails with link to this survey, or perhaps do email based survey,
with email Reply-To: address put for this survey alone?  Should we use 
the same web survey service as before (found by Paolo Ciarrocchi for 
first, 2006 survey, and used also for 2007 survey), or is there one 
better (it would better be free, and without limitations on the number 
of responses; in 2006 there were around 117 responses, in 2007 there 
were 683 individual responses).

Second, what questions should be put in the survey, and in the case of
single choice and ultiple choice questions what possible answers
should be?  I'd rather avoid free-form questions, even if they are more 
interesting, as they are PITA to analyse and summarize, especially to 
create some kind of histogram from free-form replies data (some of 2007 
free-form responses are not fully summarized even now).  Below are 
slightly extended questions from the last survey.  Please comment on 
it.

Third, where to send survey to / where to publish information about the 
survey?  Last year the announcement was send to git mailing list, to
LKML (Linux kernel mailing list), and mailing list for git projects 
found on GitProjects page on GIT wiki.  Now that the number of projects 
using Git as version control system has grown, I don't think it would 
be good idea to "spam" all those mailing list; and if we don't send 
notice to all other projects I'm not sure if we should include LKML.
Last year survey announcement was put on Git Homepage (thanks Pasky), 
and on front page of Git Wiki; info about survey was also put on two 
git hosting sites: kernel.org and repo.or.cz.  It would be nice if it 
was possible to put announcement about Git User's Survey 2008 at front 
pages of other Git hosting sites, like GitHub (one of most popular, I 
think), Gitorious, Freedesktop.org.  If you know some other popular Git 
hosting sites, and even better if you know who to contact about putting 
survey announcement, please write.  Is there some channel that I have 
forgot about?  Should info/announcement about Git User's Survey 2008 be 
sent also to one of on-line magazines like LinuxToday or LWN, or asked 
to put on some blog?  I'll add it as journal entry for #git on Ohloh, 
and try to make it so it would appear in "News" section for Ohloh 
project page for Git: http://www.ohloh.net/projects/git.

Fourth, how long should the survey last?  When sending announcement we 
should say where notice about Git User's Survey 2008 should be taken 
down.  Last year the survey was meant to take three weeks, but was up 
longer.


Below there is initial version of announcement email (I should probably 
come up also with boilerplate announcement for web pages), and initial 
version of this year round of questions.  Comments are prefixed by '+',
and does not mean to be included in the survey text.

----
Hi all,

We would like to ask you a few questions about your use of the Git
version control system. This survey is mainly to understand who is
using Git, how and why.

The results will be published to the Git wiki and discussed on the git
mailing list.

We'll close the survey in <duration> starting from today, <date>.

Please devote a few minutes of your time to fill this simple
questionnaire, it will help a lot the git community to understand your
needs, what you like of git, and of course what you don't like  of it.

The survey can be found here:
  <survey URL>
----
About you

   01. What country are you in?
   02. What is your preferred non-programming language?
  (or) What is the language you want computer communicate with you?
   03. How old are you (in years)?
       (free form, integer)
   04. Which programming languages you are proficient with?
       (The choices include programming languages used by git)
       (zero or more: multiple choice)
     - C, shell, Perl, Python, Tcl/Tk
     + (should we include other languages, like C++, Java, PHP,
        Ruby,...?)


Getting started with GIT

   05. How did you hear about Git?
       (single choice?, in 2007 it was free-form)
     - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
       news site or magazine, blog entry, some project uses it,
       presentation or seminar (real life, not on-line), SCM research,
       IRC, mailing list, other Internet, other off-line, other(*)
     + the problem is with having not very long list (not too many
       choices), but spanning all possibilities.
     + is this question interesting/important to have in survey?
   06. Did you find GIT easy to learn?
     - very easy/easy/reasonably/hard/very hard
   07. What helped you most in learning to use it?
       (free form question)
   08. What did you find hardest in learning Git?
       What did you find harderst in using Git?
       (free form question)
   09. When did you start using git? From which version?
     - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
     + might be important when checking "what did you find hardest" etc.
     + perhaps we should ask in addition to this question, or in place
       of this question (replacing it) what git version one uses; it
       should be multiple choice, and allow 'master', 'next', 'pu',
       'dirty (with own modifications)' versions in addition.


Other SCMs (shortened compared with 2007 survey)

   10. What other SCM did or do you use?
       (zero or more: multiple choice)
     - CVS, Subversion, GNU Arch or arch clone (ArX, tla, ...),
       Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
       BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
       Team System, custom, other(*)
   10b.If you selected other above, what SCM it was?
       (free form)
   11. Why did you choose Git? (if you use Git)
       What do you like about using Git?
       (free form, not to be tabulated)
   12. Why did you choose other SCMs? (if you use other SCMs)
       What do you like about using other SCMs?
       Note: please write name of SCMs you are talking about.
       (free form, not to be tabulated).


How you use Git

   13. Do you use Git for work, unpaid projects, or both?
       (single choice)
     - work/unpaid projects/both
   14. How do you obtain Git?
     - binary package/source package or source script(*)/
       source tarball/pull from main repository
       (*) this includes source based distributions like Gentoo
     + added new option: source package or source script
     + should this be multiple choice?
   15. What operating system do you use Git on?
       (one or more: multiple choice, as one can use more than one OS)
     - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
       MS Windows/msysGit, MacOS X, other UNIX, other
     + "What hardware platforms do you use GIT on?" question was
       removed; should it stay?
   15b.If you selected "other UNIX", or "other", what operating system
       or systems it was/were?
       (free form)
   16. Which porcelains / interfaces / implementations do you use?
       (zero or more: multiple choice)
     - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
       Pyrite, Easy Git, IsiSetup, jgit, my own scripts, other
   16b.If you selected "other porcelain", what is its name?
       (free form)
   17. Which git GUI (commit tool or history viewer, or both) do you use
       (zero or more: multiple choice)
     - CLI, gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
       (h)gct, qct, KGit, git-cola / ugit, GitNub, Pyrite, git.el, other
   17b.If you selected "other GUI", what is its name?
       (free form)
   18. Which (main) git web interface do you use for your projects?
       (zero or more: multiple choice)
     - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
     + should there be a question about web server (Apache, IIS, ...)
       used to host git web interface?
   18b.If you selected "other web interface", what it was?
       (free form)
   19. How do you publish/propagate your changes?
       (zero or more: multiple choice)
     - push, pull request, format-patch + email, bundle, other
   19b.If the way you publish your changes is not mentioned above, how
       do you publish your changes?
       (free form)
   20. Does git.git repository include code produced by you?
     - yes/no


What you think of Git

   21. Overall, how happy are you with Git?
     - unhappy/not so happy/happy/very happy/completely ecstatic
   22. How does Git compare to other SCM tools you have used?
     - worse/equal (or comparable)/better
   23. What would you most like to see improved about Git?
       (features, bugs, plug-ins, documentation, ...)
   24. If you want to see Git more widely used, what do you
       think we could do to make this happen?
     + Is this question necessary/useful?  Do we need wider adoption?


Changes in Git (since year ago, or since you started using it)

   25. Did you participate in previous Git User's Surveys?
       (zero or more, multiple choice)
     - 2006, 2007
   26. How do you compare current version with version from year ago?
     - current version is: better/worse/no changes
   27. Which of the following features do you use?
       (zero or more: multiple choice)
     - git-gui or other commit tool, gitk or other history viewer, patch
       management interface (e.g. StGIT), bundle, eol conversion,
       gitattributes, submodules, separate worktree, reflog, stash,
       shallow clone, detaching HEAD, mergetool, interactive rebase,
       add --interactive or other partial commit helper, commit
       templates, bisect, other (not mentioned here)
     + should probably be sorted in some resemblance of order
     + are there any new features which should be listed here?
   28. If you use some important Git features not mentioned above,
       what are it?
       (free form)


Documentation

   29. Do you use the Git wiki?
    -  yes/no
   30. Do you find Git wiki useful?
    -  yes/no/somewhat
   31. Do you contribute to Git wiki?
    -  yes/no/only corrections or spam removal
   32. Do you find Git's on-line help (homepage, documentation) useful?
    -  yes/no/somewhat
   33. Do you find help distributed with Git useful
       (manpages, manual, tutorial, HOWTO, release notes)?
    -  yes/no/somewhat
   34. What could be improved on the Git homepage?
       (free form)
   35. What could be improved in Git documentation?
       (free form)


Getting help, staying in touch

   36. Have you tried to get Git help from other people?
    -  yes/no
   37. What channel did you use to request help?
       (zero or more: multiple choice)
    -  git mailing list, git users group, IRC, blog post, 
       other
    +  this is one question which doesn't need, I think, explanation
       of "other" choice
   38. If yes, did you get these problems resolved quickly
       and to your liking?
    -  yes/no
   39. Would commerical (paid) support from a support vendor
       be of interest to you/your organization?
    -  yes/no/not applicable
   40. Do you read the mailing list?
    -  yes/no
   41. If yes, do you find it useful?
    -  yes/no (optional)
   42. Do you find traffic levels on Git mailing list OK.
    -  yes/no? (optional)
   43. Do you use the IRC channel (#git on irc.freenode.net)?
    -  yes/no
   44. If yes, do you find IRC channel useful?
    -  yes/no (optional)
   45. Did you have problems getting GIT help on mailing list or
       on IRC channel? What were it? What could be improved?
       (free form)

Open forum

   46. What other comments or suggestions do you have that are not
       covered by the questions above?
       (free form)

-- 
Jakub Narebski
Poland
