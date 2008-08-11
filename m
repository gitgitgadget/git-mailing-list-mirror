From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] TopGit v0.2
Date: Tue, 12 Aug 2008 01:09:17 +0200
Message-ID: <20080811230917.GJ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgWt-0005fI-08
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbYHKXJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYHKXJT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:09:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53577 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYHKXJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:09:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5A07B393B303; Tue, 12 Aug 2008 01:09:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92020>

  Hi!

  This is v0.2 of TopGit; we are steady on our way to v1.0! ;-)

  TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
and others, of course in an attempt to Get It Right this time around.
TopGit is absolutely minimal porcelain layer that will manage your
patch queue for you using topic branches, one patch per branch,
never rewriting the history in order to enable fully distributed
workflow.  You can get TopGit at

	http://repo.or.cz/w/topgit.git

and read up on its design, usage and implementation at:

	http://repo.or.cz/w/topgit.git?a=blob;f=README


  This version features changed usage of tg create, new tg export command
that can export your patch queue either to a Git branch or Quilt series,
a huge amount of bugfixes, and improved documentation infrastructure.

  Thanks go to Bert Wesarg, Russel Steicke and Antonio Ospite for their
patches - please keep them coming - and to martin f. krafft for
the testing, ideas and presentation to fellow Debian packagers.


Antonio Ospite (1):
      tg.sh: Add -h, --help aliases for the help command

Bert Wesarg (7):
      tg-create.sh: fix help string
      tg-create.sh: Introduce topgit.subjectprefix config option
      tg-info: pretty print dependencies
      tg.sh: Runtime tg-* command check
      tg.sh: Check for read permissions of help files
      Makefile: mkdir $(bindir)
      tg.sh: it's info/attributes not info/gitattributes

Petr Baudis (33):
      README: Fix synopsis of resuming tg create
      README: Two TODOs for tg summary
      README: TODO for tg depend
      README: TODO for tg tidy
      tg.sh: setup_hook(): Test existence instead of -x
      tg-info.sh: Fix list of >1 dependencies
      tg-patch.sh: Bring deplist format in sync with tg info
      tg-info.sh: Show missing dependencies (needs_update() enhancement)
      tg-update.sh: Abort on missing dependencies
      needs_update(): Return non-zero if update is required
      tg-summary.sh: Mark branches with missing dependencies by '\!'
      tg-summary.sh: Fix nonempty indicator misalignment
      tg-summary.sh: Clean up printing status columns
      README: TODO tg tidy -> tg collapse
      tg-create.sh: Change usage (-d -> arguments)
      README: Mark future tg patch features as TODO clearly
      tg-create.sh: Introduce topgit.{to,cc,bcc} config options
      needs_update(): Fix $missing_deps passing
      tg-create.sh: Pre-fill [PATCH] line with patch name
      create-help.sh: Fix 'tg update' generated help text
      needs_update(): Split to recurse_deps() and branch_needs_update() helpers
      recurse_deps(): _-prefix $depsfile
      measure_branch(): Use _bname instead of _name local variable
      branch_needs_update(): Fox branch_contains call: $1 -> $_name
      recurse_deps(): Call itself, not needs_update(), recursively
      tg-export: New command for cleaning up history
      tg.sh: Avoid use of non-SUS 'echo -e'
      README: tg collapse is already implemented (as tg export)
      tg export: Really remove TopGit metadata files when exporting
      tg update: Do not use ${:n:m} substitution (bash extension)
      tg export: Support --quilt for exporting to quilt series
      tg export: Print progress messages _before_ the action
      TopGit-0.2

Russell Steicke (3):
      Check for pre-commit hook existence.
      Make "tg help cmd" print cmd help
      Pretty print the help creation commands in Makefile.


  Have fun,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
