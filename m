From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Wed, 10 Jun 2009 21:30:16 +0200
Message-ID: <20090610193016.GA13512@m62s10.vlinux.de>
References: <200905291855.03328.jnareb@gmail.com> <200906102042.15119.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METOc-00061g-1V
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbZFJTX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756226AbZFJTX2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:23:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:37748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755379AbZFJTX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 15:23:27 -0400
Received: (qmail invoked by alias); 10 Jun 2009 19:23:28 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp056) with SMTP; 10 Jun 2009 21:23:28 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19tcCNhzzFtYK0/RRXNJl0Q/TyJ9+9slV3Lp07EsI
	QTR34roBS85OEg
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id B6E7B180AD; Wed, 10 Jun 2009 21:30:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906102042.15119.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121296>

On Wed, Jun 10, 2009 at 08:42:13PM +0200, Jakub Narebski wrote:
> As there were not much response to this thread, let me propose
> a set of questions for Git User's Survey 2009 (if we plan to have
> it this year).  I would probably use Survs.com, like last year.
> 
> Comments appreciated!
> 
> ------------------------------------------------------------------
> Git User's Survey 2009: proposed questions
> 

[ ... leaving out some questions ... ]

> 11.*Which porcelains / interfaces / implementations do you use?
>     (multiple choice: git (core), JGit, Cogito, pg, StGIT, Guilt,
>     Easy Git, Pyrite, TopGit, other - please specify)
> 12. Which of the following git tools do you use?
>     (multiple choice: JGit (EGit etc.), Cogito, pg, StGIT, Guilt,
>     TopGit, Easy Git, editor/IDE VC integration, gitk, git-gui,
>     QGit, GitView, Giggle, tig, git-sh, instaweb, git-cola / ugit,
>     GitNub, GitX, GitTortoise, Git Extensions, git-cheetah, Gitosis,
>     graphical diff tool, graphical merge tool, other - please specify)

Those two seems a little redundant. Could we combine those into

> 11.Which porcelains / interfaces / implementations / tools do you use?
     ...

> 13. Which git hosting site do you use for your projects?
>     (multiple choice: GitHub, repo.or.cz, Gitorious, Unfudle,
>     Assembla, Alioth, Fedora Hoster, Savannah, SourceForge,
>     freedesktop.org, kernel.org, self hosted, generic web site,
>     git hosting site for set of projects, other - please specify)
> 14. How do you fetch/get changes from upstream?  [NEW!]
>     (multiple choice: git, ssh, http, rsync, filesystem, bundle,
>     foreign SCM import/script like git-svn, other - please specify)
> 15. How do you publish/propagate your changes?
>     (multiple choice: push, pull request, format-patch + email,
>     format-patch + other, git bundle, git-svn, foreign SCM,
>     other - please specify)
> 16. Which of the following features do (or did) you use?
>     (multiple choice: non-default hooks, working with dirty tree,
>     bisect, submodules (subprojects), integration with IDE/editor,
>     multiple worktrees (git-new-worktree), gitattributes, stash,
>     separate worktree / git.worktree, patch managemtn interface
>     (e.g. StGIT), alternates mechanism (sharing object database),
                 ^ 
                 | - TopGit, Quilt
                  
    
>     git bundle (off-line transport), git-filter-branch, commit message
>     templates, shallow clone, eol conversion, interactive rebase,
>     interactive commit / per-chunk comitting / partial commit,
>     detaching HEAD, gitk or other history viewer, git-gui or other
>     commit tool, shell completion, git-aware shell prompt)
> 
> In this section number of individual operating systems in "What
> operating system do you use Git on?" was reduced a bit, based on
> answers from previous survey.  We might want to put OpenSolaris as
> separate from "other Unices" (which would then be "proprietary
> Unix").  The question about hardware platforms got removed.
> 
> The trouble with "What editor, IDE or RAD you use working with Git?"
> question is coming up with a good list of editors... and that such
> list is of necessity fairly long.  Perhaps it would be better to
> change it to more generic question
>  10.*What kind of editor, IDE or RAD you use working with Git?
>     (multiple choice: simple text editor[1], programmers editor[2],
>     IDE or RAD[3], WYSIWYG tool[4], other kind - please specify)
>     [1] for example pico, nano, joe, Notepad
>     [2] for example Vim, Emacs, TextMate (syntax highlighting,
>         autoindentation, integration with other tools, etc.)
>     [3] for example KDevelop, Anjuta, MS Visual Studio, but also
>         Quanta+, BlueFish or Screem for editing HTML, and Kile
>         or LyX for LaTeX.
>     [4] text processors such as MS Office or OpenOffice.org,
>         but also tools such as Adobe Acrobat (for PDF) or GIMP
>         (for images)
> (if we are not to remove this question entirely).

If you leave the question, you might want to add Eclipse at the appropriate
place.

-Peter
