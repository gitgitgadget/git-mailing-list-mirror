From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.3
Date: Sat, 29 Sep 2007 18:27:38 -0700
Message-ID: <7vve9thrhx.fsf@gitster.siamese.dyndns.org>
References: <7vir66pjhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 03:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbnbD-0005a4-Kl
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 03:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXI3B1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 21:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXI3B1v
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 21:27:51 -0400
Received: from rune.pobox.com ([208.210.124.79]:41947 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbXI3B1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 21:27:50 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 302CA13E79A;
	Sat, 29 Sep 2007 21:28:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9606F13E61B;
	Sat, 29 Sep 2007 21:28:02 -0400 (EDT)
In-Reply-To: <7vir66pjhs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Sep 2007 12:01:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59516>

The latest maintenance release GIT 1.5.3.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.3-1.$arch.rpm	(RPM)

GIT v1.5.3.3 Release Notes
==========================

Fixes since v1.5.3.2
--------------------

 * git-quiltimport did not like it when a patch described in the
   series file does not exist.

 * p4 importer missed executable bit in some cases.

 * The default shell on some FreeBSD did not execute the
   argument parsing code correctly and made git unusable.

 * git-svn incorrectly spawned pager even when the user user
   explicitly asked not to.

 * sample post-receive hook overquoted the envelope sender
   value.

 * git-am got confused when the patch contained a change that is
   only about type and not contents.

 * git-mergetool did not show our and their version of the
   conflicted file when started from a subdirectory of the
   project.

 * git-mergetool did not pass correct options when invoking diff3.

 * git-log sometimes invoked underlying "diff" machinery
   unnecessarily.

----------------------------------------------------------------

Changes since v1.5.3.2 are as follows:

Carlos Rica (1):
      Move make_cache_entry() from merge-recursive.c into read-cache.c

Dan Nicholson (1):
      quiltimport: Skip non-existent patches

David Brown (1):
      Detect exec bit in more cases.

David Kastrup (1):
      Supplant the "while case ... break ;; esac" idiom

Eric Wong (1):
      git-svn: don't attempt to spawn pager if we don't want one

Glenn Rempe (1):
      Fixed minor typo in t/t9001-send-email.sh test command line.

J. Bruce Fields (1):
      user-manual: don't assume refs are stored under .git/refs

Jakub Narebski (2):
      gitweb: Remove parse_from_to_diffinfo code from git_patchset_body
      gitweb: No difftree output for trivial merge

Jim Meyering (2):
      unexpected Make output (e.g. from --debug) causes build failure
      Do not over-quote the -f envelopesender value.

Johannes Schindelin (1):
      apply: get rid of --index-info in favor of --build-fake-ancestor

Johannes Sixt (2):
      gitattributes.txt: Remove a duplicated paragraph about 'ident' and 'crlf' interaction.
      gitattributes.txt: Be more to the point in the filter driver description.

Junio C Hamano (3):
      Documentation/git-lost-found.txt: drop unnecessarily duplicated name.
      Mergetool generating blank files (1.5.3)
      GIT 1.5.3.3

Linus Torvalds (1):
      Fix revision log diff setup, avoid unnecessary diff generation

Matt Kraai (2):
      Move the paragraph specifying where the .idx and .pack files should be
      Conjugate "search" correctly in the git-prune-packed man page.

Michael Smith (1):
      user-manual: Explain what submodules are good for.

Miklos Vajna (2):
      User Manual: add a chapter for submodules
      git-bundle: fix commandline examples in the manpage

Randy Dunlap (1):
      core-tutorial: correct URL

Shawn Bohrer (1):
      Fix spelling of overridden in documentation

Theodore Ts'o (2):
      mergetool: fix emerge when running in a subdirectory
      mergetool: Fix typo in options passed to kdiff3
