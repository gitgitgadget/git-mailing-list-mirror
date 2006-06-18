From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17.3
Date: Sun, 18 Jun 2006 02:19:30 +0200
Message-ID: <20060618001930.GL2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 02:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frkzt-0006xG-W0
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 02:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWFRAS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWFRAS2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 20:18:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22240 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751075AbWFRAS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 20:18:27 -0400
Received: (qmail 6827 invoked by uid 2001); 18 Jun 2006 02:19:30 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22043>

  Hello,

  cogito-0.17.3 was just released - bugfixes release on the latest
stable line of the Cogito user-friendly Git user interface.

  Plenty of new stuff, mostly bugfixes - especially cg-admin-rewritehist
was particularily bug-ridden and Git 1.4.0 broke some backwards
compatibility, Cogito 0.17.3 should work smoothly with it again.

  So, what's new?

  * Many cg-admin-rewritehist bugfixes; note that -r semantics was
    changed to match documentation, -k steps in to mean what -r used
    to in practice
  * Some documentation fixes
  * Adjust to some Git 1.4.0 usage changes and new-style git-http-push
  * Several other random things


  Who did what:

Bertrand Jacquin:
      Push over HTTP now works with refs/heads/foo instead of foo

Dennis Stosberg:
      cg-clean fails on files beginning with a dash

Johannes Sixt:
      cg-admin-rewritehist: Seed the commit map with the parents specified with -r
      Enhance the rewritemap seeding when given symbolic commit ids
      cg-admin-rewritehist: fix reappearing files with --filter-tree
      cg-admin-rewritehist: Add the documented but missing --msg-filter option.
      cg-admin-rewritehist: Must use the parent of the start rev to seed the map.
      cg-admin-rewritehist: Support multiple parents of the start revision (-r).
      cg-admin-rewritehist: Support partial rewriting of complicated history.

Jonas Fonseca:
      ciabot: fix post-update hook description
      Portfile: bring it up to date; use description from cogito.spec.in
      Minor doc fixes
      Fix section slicing so help options are not misplaced in cg-commit(1)

Martin Langhoff:
      cg-status -- disambiguate parameters to git-diff-files

Pavel Roskin:
      Fix cg-status with recent git versions
      [PATCH 1/2] Fix cg-patch hanging on terminals with TOSTOP flag
      [PATCH 2/2] Improve the tutorial script

Petr Baudis:
      mkdir -p .git/info since git-init-db won't always create it
      Separate git-diff-* file arguments by --
      Export the $PATH we've set
      Use local Cogito version when running the tutorial script
      Fix cg-rm -r in a subdirectory
      Do not export relpath - fixes cg-add -r in a subdir
      Fix output of cg-status path with path given w/o trailing slash
      cg-status: do not strip subdirs given in path specifier
      Make cg-rm -r subdir fix actually safe
      Fix broken tree timewarp with late git versions
      Use tail -n +2 inst. of tail +2
      Make testcases take input from /dev/null
      Fix cg-tag calls changed by the backported update
      Fix cg-admin-rewritehist -r
      Indentation fix
      cg-admin-rewritehist: Die in case of invalid revisions
      cogito-0.17.3

Yann Dirson:
      [PATCH 2/2] Catch history inconsistency in cg-admin-rewritehist
      Fix cg-object-id to lookup parents in the Right Way
      [PATCH 1/3] cg-admin-rewritehist: catch git-rev-list returning no commit


P.S.: See us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Pasky the lousy poet" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
