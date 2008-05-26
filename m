From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.5.2
Date: Sun, 25 May 2008 18:26:46 -0700
Message-ID: <7viqx1g8ix.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753754AbYEZB1P@vger.kernel.org Mon May 26 03:28:27 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753754AbYEZB1P@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0RVi-0002MV-C5
	for glk-linux-kernel-3@gmane.org; Mon, 26 May 2008 03:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbYEZB1P (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 25 May 2008 21:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbYEZB1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2008 21:27:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYEZB1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2008 21:27:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4ADED3549;
	Sun, 25 May 2008 21:26:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 51C903547; Sun, 25 May 2008 21:26:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5618324-2AC2-11DD-B40C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82887>

The latest maintenance release GIT 1.5.5.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.5.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.5.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.5.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.5.2-1.$arch.rpm	(RPM)

One side effect of declaring to make the cycle toward 1.5.6 shorter is
that we would not have that many 1.5.5.X maintenance releases.
Nevertheless, there are quite a few fixes accumulated since 1.5.5.1 hence
this one.

----------------------------------------------------------------

Changes since v1.5.5.1 are as follows:

A Large Angry SCM (1):
      git-repack: re-enable parsing of -n command line option

Alex Riesen (2):
      Use "=" instead of "==" in condition as it is more portable
      Fix use after free() in builtin-fetch

Andy Parkins (1):
      post-receive-email: fix accidental removal of a trailing space in signature line

Ariel Badichi (2):
      copy.c: copy_fd - correctly report write errors
      archive.c: format_subst - fixed bogus argument to memchr

Brandon Casey (1):
      git-clone.txt: Adjust note to --shared for new pruning behavior of git-gc

Dan McGee (1):
      Remove 'header' from --signoff option description

Dmitry Potapov (1):
      git-gc --prune is deprecated

Dustin Sallings (1):
      Documentation/config.txt: Mention branch.<name>.rebase applies to "git pull"

Florian Ragwitz (1):
      filter-branch: Documentation fix.

Gerrit Pape (1):
      diff-options.txt: document the new "--dirstat" option

Heikki Orsila (1):
      Add missing "short" alternative to --date in rev-list-options.txt

Ian Hilt (1):
      Documentation/git-describe.txt: make description more readable

Jeff King (11):
      Don't force imap.host to be set when imap.tunnel is set
      t5516: remove ambiguity test (1)
      doc/git-gc: add a note about what is collected
      push: allow unqualified dest refspecs to DWIM
      remote: create fetch config lines with '+'
      fix reflog approxidate parsing bug
      cvsimport: always pass user data to "system" as a list
      checkout: don't rfc2047-encode oneline on detached HEAD
      doc: clarify definition of "update" for git-add -u
      doc/git-daemon: s/uploadarchive/uploadarch/
      git-am: fix typo in usage message

Johannes Sixt (2):
      wt-status.h: declare global variables as extern
      rev-parse --symbolic-full-name: don't print '^' if SHA1 is not a ref

Jon Loeliger (2):
      git-filter-branch: Clarify file removal example.
      git-show.txt: Not very stubby these days.

Junio C Hamano (3):
      write-tree: properly detect failure to write tree objects
      clone: detect and fail on excess parameters
      fetch-pack: brown paper bag fix

Linus Torvalds (1):
      fetch-pack: do not stop traversing an already parsed commit

Matt Graham (1):
      Linked glossary from cvs-migration page

Matthew Ogilvie (1):
      gitattributes: Fix subdirectory attributes specified from root directory

Michael Weber (1):
      svn-git: Use binmode for reading/writing binary rev maps

Miklos Vajna (1):
      diff options documentation: refer to --diff-filter in --name-status

Sam Vilain (1):
      Amend git-push refspec documentation

Shawn O. Pearce (1):
      Clarify repack -n documentation

Sitaram Chamarty (1):
      builtin-commit.c: add -u as short name for --untracked-files

Teemu Likonen (1):
      bash: Add completion for git diff --base --ours --theirs

Thomas Guyot-Sionnest (1):
      git-svn bug with blank commits and author file

martin f. krafft (2):
      Escape project name in regexp
      Escape project names before creating pathinfo URLs
