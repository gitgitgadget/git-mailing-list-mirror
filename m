From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git/spearce.git (stable)
Date: Tue, 16 Oct 2007 01:56:34 -0400
Message-ID: <20071016055634.GB13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 07:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfQ8-0007ul-KS
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbXJPF4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760388AbXJPF4i
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:56:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59104 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677AbXJPF4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:56:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhfPu-0000jE-QZ
	for git@vger.kernel.org; Tue, 16 Oct 2007 01:56:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3BDC720FBAE; Tue, 16 Oct 2007 01:56:34 -0400 (EDT)
Content-Disposition: inline
X-maint-at: 8492f00b4f28471af84d3887096257822c4d2bc9
X-master-at: 9de6d079200a50c0a61a5489e74419cb73993184
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61081>

* The 'maint' branch has these fixes since the last announcement.
  Please note that the last announcement was from Junio and was
  for the 1.5.3.4 release.

Frank Lichtenheld (1):
  git-config: don't silently ignore options after --list

Gerrit Pape (1):
  git-config: handle --file option with relative pathname properly

Jean-Luc Herren (2):
  git add -i: Fix parsing of abbreviated hunk headers
  git add -i: Remove unused variables

Johannes Schindelin (2):
  clear_commit_marks(): avoid deep recursion
  rebase -i: use diff plumbing instead of porcelain

Linus Torvalds (2):
  Fix embarrassing "git log --follow" bug
  Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT

Mathias Megyei (1):
  Do not remove distributed configure script

Michele Ballabio (2):
  git-reflog: document --verbose
  git-archive: document --exec

Shawn O. Pearce (1):
  Whip post 1.5.3.4 maintenance series into shape.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  fix t5403-post-checkout-hook.sh: built-in test in dash does not
      have "=="

Brandon Casey (2):
  git-gc: by default use safer "-A" option to repack when not
      --prune'ing
  git-gc --auto: simplify "repack" command line building

Brian Ewins (2):
  Add a --dry-run option to git-send-pack.
  Add a --dry-run option to git-push.

Eygene Ryabinkin (1):
  git-svn: respect Subversion's [auth] section configuration values

Frederick Akalin (1):
  gtksourceview2 support for gitview

Jeff King (1):
  git-rebase: document suppression of duplicate commits

Jeff Muizelaar (1):
  fix contrib/hooks/post-receive-email hooks.recipients error message

Johannes Schindelin (2):
  Support cvs via git-shell
  cvsexportcommit: get rid of temporary directory

Josh England (1):
  Minor usage update in setgitperms.perl

Kristof Provost (1):
  makefile: Add a cscope target

Marius Storm-Olsen (1):
  Add 'git-p4 commit' as an alias for 'git-p4 submit'

Michael Gebetsroither (1):
  hg-to-git speedup through selectable repack intervals

Michael Olson (1):
  Documentation/git-tag.txt: Document how to backdate tags

Michael W. Olson (1):
  git-rebase--interactive.sh: Quote arguments to test

Mike Dalessio (2):
  instaweb: allow for use of auto-generated scripts
  instaweb: support for Ruby's WEBrick server

Pierre Habouzit (1):
  Fix in-place editing functions in convert.c

Ralf Wildenhues (6):
  manual: Fix or remove em dashes.
  Fix some typos, punctuation, missing words, minor markup.
  Fix wording in push definition.
  manual: Fix example finding commits referencing given content.
  manual: add some markup.
  manual: use 'URL' instead of 'url'.
