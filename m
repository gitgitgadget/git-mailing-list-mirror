From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Wed, 10 Jun 2009 20:42:13 +0200
Message-ID: <200906102042.15119.jnareb@gmail.com>
References: <200905291855.03328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 20:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MESkr-0006Cd-2j
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 20:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbZFJSmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 14:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZFJSmW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 14:42:22 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35713 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbZFJSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 14:42:20 -0400
Received: by fxm9 with SMTP id 9so1008283fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oyYjW177K06p3KscTSZKZDT7evPx0fqqQ3cv4zMzuPg=;
        b=FA7UgMZfG6QRa4SyN55My0tUtbwHWvFmkSUcCcBczoaJGGRsB+29hHLsEwi2QIdOHb
         1bAw22VymwqzN/ISh4eiq7uH/fLs5vLMjdov1xD/usvFSUAp78pCbRaWk2Rvx0/nFCF5
         mLIskuDPg3eRZfOi+X58L/6oaoUX535SExgHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W3YhRvvqKssr5PSZStgVxBsEhSGKWXTEypwI22Bpn13n+rwHccTjfkCNBe9fYgN6J7
         3REgVm7x/xQQYBU3yLhykX1WzXxHwyNhugm4TpLevb/v+ANidg6RGuJR3tT0sJ8KrI/p
         cm88UdjCpx6izK0hEak+wT/w62GTqFMi4Kjhc=
Received: by 10.103.160.10 with SMTP id m10mr801029muo.50.1244659340585;
        Wed, 10 Jun 2009 11:42:20 -0700 (PDT)
Received: from ?192.168.1.13? (abvn21.neoplus.adsl.tpnet.pl [83.8.211.21])
        by mx.google.com with ESMTPS id j9sm14740524mue.51.2009.06.10.11.42.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 11:42:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905291855.03328.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121291>

As there were not much response to this thread, let me propose
a set of questions for Git User's Survey 2009 (if we plan to have
it this year).  I would probably use Survs.com, like last year.

Comments appreciated!

------------------------------------------------------------------
Git User's Survey 2009: proposed questions

Questions marked with star (e.g. 11.*) are questions which I am not
sure if they should be in this survey.

About you:
^^^^^^^^^^
01. What country do you live in?
    (free-form question, or drop-down list of countries (select))
02. How old are you (in years)?
    (free-form / text entry, or age range: single choice)

I am ambiguous if to count questions in this section against the
number of commits in this survey, which we probably would want to have
no more (or at least not much more) than 20.  I wonder also if
Survs.com would support Geo-IP (finding location based on IP address)
at the time of survey...

I have removed "With which programming languages are you proficient?"
from this section, unless there are some arguments for keeping it.


Getting started with Git
^^^^^^^^^^^^^^^^^^^^^^^^
03. Did you find Git easy to learn?
    (single choice: very hard/hard/reasonably easy/easy/very easy)
04. Did you find Git easy to use?  [NEW!]
    (single choice: very hard/hard/reasonably easy/easy/very easy)
05. Which Git version(s) are you using?
    (multiple choice: pre 1.3, 1.3.x, 1.4.x, 1.5.x, 1.6.x, 'master',
    'next', other - please explain)
06. Rate your own proficiency with Git:
    (single choice: novice/casual, needs advice/everyday use/
    /can offer advice/very well)

I have removed (perhaps a bit difficult to answer correctly) question
"How long do you use Git?"; mainly to limit number of questions in
survey.  I have also removed all the free form questions (what helped
you most in learning, what did you find hardest), as free-form
questions are hard to analyse.

Should we remove some of above questions? Should we keep some of
removed free-form questions?

[The whole section about "Other SCMs" was removed]

How do you use Git?
^^^^^^^^^^^^^^^^^^^
07. I use Git for (check all that apply):
    (multiple choice: work projects, unpaid projects; 
    proprietary code, OSS development, private (unpublished) code; 
    code, personal data, documents, static website, web app;
    sharing data or sync, backup, wiki/blog/other web app backend,
    managing configuration files, frontend to other SCM;
    other - please specify)
08. How do you obtain Git?
    (multiple choice: binary package, source tarball, 
    source package or script[*], pull from main repository)
    [*] so git is installed in a system of packages
09. What operating system do you use Git on?
    (multiple choice: Linux, MacOS X, MS Windows/msysGit, 
    MS Windows/Cygwin, *BSD, other Unix, other - please specify)
10.*What editor, IDE or RAD you use working with Git?
    (either free-form, or multiple choice: Eclipse, NetBeans,
    IntelliJ IDEA, MS Visual Studio, KDevelop, Anjuta, XCode,
    Emacs and XEmacs, Vim, Notepad++, TextMate, gedit, Geany,
    Kate, 'E', SciTE, other - please specify).
11.*Which porcelains / interfaces / implementations do you use?
    (multiple choice: git (core), JGit, Cogito, pg, StGIT, Guilt,
    Easy Git, Pyrite, TopGit, other - please specify)
12. Which of the following git tools do you use?
    (multiple choice: JGit (EGit etc.), Cogito, pg, StGIT, Guilt,
    TopGit, Easy Git, editor/IDE VC integration, gitk, git-gui,
    QGit, GitView, Giggle, tig, git-sh, instaweb, git-cola / ugit,
    GitNub, GitX, GitTortoise, Git Extensions, git-cheetah, Gitosis,
    graphical diff tool, graphical merge tool, other - please specify)
13. Which git hosting site do you use for your projects?
    (multiple choice: GitHub, repo.or.cz, Gitorious, Unfudle,
    Assembla, Alioth, Fedora Hoster, Savannah, SourceForge,
    freedesktop.org, kernel.org, self hosted, generic web site,
    git hosting site for set of projects, other - please specify)
14. How do you fetch/get changes from upstream?  [NEW!]
    (multiple choice: git, ssh, http, rsync, filesystem, bundle,
    foreign SCM import/script like git-svn, other - please specify)
15. How do you publish/propagate your changes?
    (multiple choice: push, pull request, format-patch + email,
    format-patch + other, git bundle, git-svn, foreign SCM,
    other - please specify)
16. Which of the following features do (or did) you use?
    (multiple choice: non-default hooks, working with dirty tree,
    bisect, submodules (subprojects), integration with IDE/editor,
    multiple worktrees (git-new-worktree), gitattributes, stash,
    separate worktree / git.worktree, patch managemtn interface
    (e.g. StGIT), alternates mechanism (sharing object database),
    git bundle (off-line transport), git-filter-branch, commit message
    templates, shallow clone, eol conversion, interactive rebase,
    interactive commit / per-chunk comitting / partial commit,
    detaching HEAD, gitk or other history viewer, git-gui or other
    commit tool, shell completion, git-aware shell prompt)

In this section number of individual operating systems in "What
operating system do you use Git on?" was reduced a bit, based on
answers from previous survey.  We might want to put OpenSolaris as
separate from "other Unices" (which would then be "proprietary
Unix").  The question about hardware platforms got removed.

The trouble with "What editor, IDE or RAD you use working with Git?"
question is coming up with a good list of editors... and that such
list is of necessity fairly long.  Perhaps it would be better to
change it to more generic question
 10.*What kind of editor, IDE or RAD you use working with Git?
    (multiple choice: simple text editor[1], programmers editor[2],
    IDE or RAD[3], WYSIWYG tool[4], other kind - please specify)
    [1] for example pico, nano, joe, Notepad
    [2] for example Vim, Emacs, TextMate (syntax highlighting,
        autoindentation, integration with other tools, etc.)
    [3] for example KDevelop, Anjuta, MS Visual Studio, but also
        Quanta+, BlueFish or Screem for editing HTML, and Kile
        or LyX for LaTeX.
    [4] text processors such as MS Office or OpenOffice.org,
        but also tools such as Adobe Acrobat (for PDF) or GIMP
        (for images)
(if we are not to remove this question entirely).

Two questions in 2008 survey: "Which porcelains / interfaces /
implementations do you use?" and "Which git GUI (commit tool or
history viewer, or both) do you use?" were joined together.  The
question " Which git web interface do you use for your projects/have
installed?" (where "use" was to meant "deploy") was removed... perhaps
unnecessarily.

The longest question in previous survey, "How often do you use the
following forms of git commands or extra git tools?" (which had to be
split in two because of its length) is not present in this survey
proposal, as it adds significantly to difficulity and time to fill
this survey.


What do you think of Git?
^^^^^^^^^^^^^^^^^^^^^^^^^
17. Overall, how happy are you with Git?
    (single choice: unhappy / not so happy / happy / very happy /
    / completely ecstatic)
18.*How does Git compare to other SCM tools you have used?
    (single choice: git is worse / equal / better than other SCM).

This whole section don't bring us much tangible information.
As we removed section about other SCMs, perhaps question comparing git
to other SCMs should also be removed?


Changes in Git
^^^^^^^^^^^^^^
19.*Did you participate in previous Git User's Surveys?
    (multiple choice: in 2008, in 2007, in 2006)
20.*How do you compare current version with version from year ago?
    (single choice: cannot say[1] / worse / better / no changes)
    [1] perhaps this should include situation where one didn't use
        Git for a year?

This whole section is considered for deletion to fit in the 20
questions limit.


Getting help, staying in touch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
21. Which form of documentation do you use?
    (matrix form with columns: never used, not useful, somwehat, useful,
    or multiple choice: wiki, on-line help, help with Git)
22.*Have you tried to get Git help from other people?
    (single choice: yes / no)
23. What channel did you use to request help?
    (multiple choice: git mailing list, IRC (#git), IRC (other),
    request in blog post or on wiki, asking guru/colleague,
    project mailing list or IRC or forum, Twitter or other microblog,
    instant messenging (IM) like XMPP/Jabber, StackOverflow, other
    - please specify)
24.*If yes, did you get these problems resolved quickly
    and to your liking?
    (single choice: yes / somewhat / no)
25. Do you read the mailing list, or watch IRC channel?
    (multiple choice: git@vger.kernel.org, msysGit, Git for Human 
    Beings (Google Group), #git IRC channel, #github IRC channel)

This group is concatenation of former "Documentation" and "Getting
help, staying in touch" groups.  All of "Documentation" questions are
compressed together to single question encompassing most of issue
touched in mentioned group (section).

The question "Have you tried to get Git help from other people?" is a
bit redundant: if one answered "What channel did you use to request
help?" then one did try to get help, isn't it?  But only a bit; I
think it would help to have this question separately, and not only
implied.  I am not sure though about "Did you get these problems
resolved quickly and to your liking?" question...


Open forum
^^^^^^^^^^
26.*Should Git User's Survey be repeated next year?
    (single choice: yes / no / undecided)
27. What other comments or suggestions do you have 
    that are not covered by the questions above?
    (free-form)

As you can see there is only _one_ free-form open-ended question in
the whole survey.  While I am not completely against adding more, 
I'd prefer to keep their number to the absolute minimum.

-- 
Jakub Narebski
Poland
