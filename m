From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17.1
Date: Sun, 26 Mar 2006 19:56:58 +0200
Message-ID: <20060326175658.GN18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 19:56:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNZTz-0007RL-8d
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 19:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWCZR4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 12:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCZR4q
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 12:56:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46037 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751339AbWCZR4q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 12:56:46 -0500
Received: (qmail 10024 invoked by uid 2001); 26 Mar 2006 19:56:58 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18049>

  Hello,

  cogito-0.17.1 was just released, the next release on the latest stable
line of the Cogito user-friendly Git user interface. Note that the
stable stuff is now happening on the v0.17 branch, just like we did in
the 0.16 times. In addition to that, however, an auto-built
documentation in the man, txt and html format is available in the

	http://www.kernel.org/pub/scm/cogito/cogito-doc.git/

repository. It has the same branch structure as the cogito.git
repository and should also have the same tags if my scripts work
properly. Thanks to Junio for the base version of the script maintaining
this repository.

  So, what's new?

  * Fixed several minor relative path related cg-add and cg-status bugs
  * Fixed cg-add -r not readding cg-rm'd files
  * Fixed support for branch names containing slashes

  * cg-admin-rewritehist - the universal history rewriting tool
  * cg-commit --author
  * cg-commit -p alias for cg-commit --review
  * cg-status -S will show the full contents of the untracked
    directories instead of just the directory name
  * $CG_NORC will make Cogito ignore ~/.cgrc
  * https:// URLs are supported now

  * Several small speed-ups (especially --topo-order in cg-mkpatch)
  * Random documentation updates (most notably cg-ref quick reference)
  * The tutorial script updated


  Who did what:

Dennis Stosberg:
      Cogito: Allow https:// URLs

Jonas Fonseca:
      cg-export: document the -r option
      [PATCH 1/4] Simplify wildcards for match files to be ignored
      [PATCH 2/4] Encode the manpage section in the file name
      [PATCH 3/4] Generate PDF documents using docbook2pdf
      [PATCH 4/4] Add quick reference (cg-ref) to the documentation suite
      Fix multi-paragraph list items in OPTIONS section

Pavel Roskin:
      Use Cogito when possible in the "tutorial" test.
      [PATCH 3/3] Allow the tutorial script to be run by "make test"
      [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to excessive quotes
      Clean up after failed "git merge" in the tutorial script

Petr Baudis:
      Refer to cg-branch-add in cg-clone docs and clarify stuff
      Add example usage to cg-clone per jbl's request
      Easier cut'n'paste
      --merge-order is too slow, always use --topo-order
      TODO: branches/with/slashes and cg-clone -a
      Add cg-commit --author, consolidate author documentation
      Update for the modern conflicts handling
      Improve cg-switch -r shortdesc
      Expand the git-mv workarounds description
      cg-merge: Do not fast-forward when doing an octopus
      Fix some relpath-related cg-add and cg-status bugs
      Make cg-commit -p synonymous with --review
      TODO: cg-shelf - shelve changes temporarily
      Generalize the tac stub (cg-mkpatch -> cg-Xlib)
      Generalize pick_author() to pick_id()
      cg-admin-rewritehist - history rewriting swiss knife
      Update the example usage
      Hopefully fix cg-admin-rewritehist -r
      Umm, update year in the (c) notice ;)
      Properly support multiple -r arguments
      Make the main cycle more efficient
      Another optimization - retrieve the commit object only once
      Accept subsections inside the OPTIONS section
      Do not load ~/.cgrc if $CG_NORC is set
      Remove bogus information from cg-patch docs
      Properly document cg-commit --signoff=STRING
      cg-admin-rewritehist --parent-filter for rewriting parent string
      cg-admin-rewritehist --commit-filter for omitting commits
      Reference cg-ref(7) from cogito(7)
      A quick docs pointer and Getting help section update
      cg-status -S will turn dirsquashing off
      Fix cg-add -r not readding removed files
      Use the new ref format when resetting the HEAD file
      Fix support for branch names containing slashes


P.S.: See us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Pasky the lousy poet" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
