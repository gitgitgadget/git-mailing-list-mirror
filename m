From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4-rc3
Date: Fri, 11 Jan 2008 23:11:23 -0800
Message-ID: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDaXR-00068P-Ls
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383AbYALHLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 02:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYALHLr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:11:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYALHLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 02:11:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6884F454B;
	Sat, 12 Jan 2008 02:11:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C6BD4544;
	Sat, 12 Jan 2008 02:11:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70279>

The third rc for the next feature release GIT 1.5.4 is available
at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.rc3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
  testing/git-*-1.5.4.rc3-1.$arch.rpm	(RPM)

Sorry, this is a few days late than I promised.  Partly due to
day-job pressure, partly because I am not familiar with RPM spec
file and ended up failing to get the spec file into a reasonable
shape after gitk i18n merge more than twice, and partly because
I involved myself to discussion on the list I should not have
been deeply involved in during the rc freeze.

In any case, we managed to keep the changes only to fixes (both
code and documentation) this round, aside from the promised gitk
i18n enhancements.  This should be pretty much the same as what
we will have in final, hopefully due by the end of the month.

Please give it a good beating.  Especially if you care about the
final RPM, and you are familiar with RPM generation, I would
appreciate extra set of eyeballs to see if dependencies and
other metainformation is set up correctly, as I do not think
many people have tested it.

----------------------------------------------------------------

Changes since v1.5.4-rc2 are as follows:

Alexandre Julliard (6):
      git.el: Support for getting diffs from inside the log-edit buffer=
=2E
      git.el: Retrieve the permissions for up-to-date files.
      git.el: Display file types and type changes.
      git.el: Make sure we never insert the same file twice.
      git.el: Refresh files from their real state upon commit.
      git.el: Make status refresh faster.

Bernt Hansen (1):
      git-gui: Make commit log messages end with a newline

Brandon Casey (1):
      git-relink.txt: describe more clearly how hard linking occurs

Charles Bailey (1):
      gitk: Fix the Makefile to cope with systems lacking msgfmt

Christian Couder (1):
      Documentation: config: add 'help.*' and 'instaweb.*' variables.

Christian Stimming (10):
      gitk i18n: Add Makefile with rules for po file creation and insta=
llation
      gitk i18n: Import msgcat for message string translation; load tra=
nslation catalogs
      gitk i18n: Markup several strings for translation
      gitk i18n: Initial German translation
      gitk i18n: More markup -- various options menus
      gitk i18n: Recode gitk from latin1 to utf8 so that the (c) copyri=
ght character is valid utf8.
      gitk: Update and fix Makefile
      gitk: Update German translation
      gitk: Fix typo in user message.
      gitk: Update German translation.

Dan McGee (1):
      Documentation: rename gitlink macro to linkgit

Eric Wong (4):
      git-svn: allow dcommit --no-rebase to commit multiple, dependent =
changes
      git-svn: unlink index files that were globbed, too
      git-svn: support for funky branch and project names over HTTP(S)
      git-svn: clarify the "Ignoring error from SVN" piece

=46lorian La Roche (1):
      Change git-gc documentation to reflect gc.packrefs implementation=
=2E

Gerrit Pape (1):
      gitk: use user-configured background in view definition dialog

Gr=C3=A9goire Barbier (1):
      Fix double-free() in http-push.c:remote_exists()

Gustaf Hendeby (1):
      Documentation/user-manual.txt: fix typo

J. Bruce Fields (1):
      Documentation: fix remote.<name>.skipDefaultUpdate description

James Bowes (1):
      Make the git metapackage require the same version of the subpacka=
ges.

Jeff King (8):
      config: handle lack of newline at end of file better
      git-reset: refuse to do hard reset in a bare repository
      add a "basic" diff config callback
      diff: load funcname patterns in "basic" config
      diff: remove lazy config loading
      add--interactive: remove unused diff colors
      add--interactive: allow diff colors without interactive colors
      Document the color.interactive semantics

Jim Meyering (3):
      Fix grammar nits in documentation and in code comments.
      Don't access line[-1] for a zero-length "line" from fgets.
      bundle, fast-import: detect write failure

Johannes Schindelin (2):
      Optimize prefixcmp()
      shortlog: mention the "-e" option in the usage

Johannes Sixt (2):
      git-gui: Move frequently used commands to the top of the context =
menu.
      recv_sideband: Do not use ANSI escape sequence on dumb terminals.

Junio C Hamano (27):
      Documentation/git-submodule.txt: typofix
      "git pull --tags": error out with a better message.
      git-rebase -i behaves better on commits with incomplete messages
      git-rebase -i: clean-up error check codepath.
      lock_any_ref_for_update(): reject wildcard return from check_ref_=
format
      Update callers of check_ref_format()
      Uninline prefixcmp()
      git-clean: make "Would remove ..." path relative to cwd again
      t/t7600: avoid GNUism in grep
      t/t{3600,3800,5401}: do not use egrep when grep would do
      t/t3800: do not use a temporary file to hold expected result.
      Update draft release notes for 1.5.4
      git-stash clear: refuse to work with extra parameter for now
      git-rev-parse --symbolic-full-name
      filter-branch: work correctly with ambiguous refnames
      custom pretty format: tolerate empty e-mail address
      Documentation: remove gitman.info with "make clean"
      Documentation: fix "gitlink::foobar[s]"
      utf8: pick_one_utf8_char()
      utf8_width(): allow non NUL-terminated input
      diff: do not chomp hunk-header in the middle of a character
      Update draft release notes for 1.5.4
      GIT 1.5.3.8
      "git-apply --check" should not report "fixed"
      pack-objects: remove redundant and wrong call to deflateEnd()
      RPM spec: include gitk message files.
      GIT 1.5.4-rc3

Kevin Ballard (1):
      Trim leading / off of paths in git-svn prop_walk

Marco Costalba (2):
      Document git-reset defaults to HEAD if no commit is given
      git-stash: use stdout instead of stderr for non error messages

Mark Levedahl (2):
      git-gui: Unconditionally use absolute paths with Cygwin
      Documentation/Makefile - honor $DESTDIR for quick-install target

Martin Koegler (4):
      receive-pack: check object type of sha1 before using them as comm=
its
      receive-pack: reject invalid refnames
      parse_tag_buffer: don't parse invalid tags
      tree-walk: don't parse incorrect entries

Michael Stefaniuc (1):
      git-am: Run git gc only once and not for every patch.

Michele Ballabio (1):
      Document some default values in config.txt

Miklos Vajna (2):
      git-sh-setup: document git_editor() and get_author_ident_from_com=
mit()
      t/t7001: avoid unnecessary ERE when using grep

Nicolas Pitre (1):
      slightly better auto gc message

Paul Mackerras (2):
      gitk: Recode de.po to UTF-8
      gitk: Restore some widget options whose defaults changed in Tk 8.=
5

Peter Karlsson (1):
      Added Swedish translation.

Ralf Wildenhues (1):
      Documentation: typofix

Rogan Dawes (1):
      Allow git-mergetool to handle paths with a leading space

Shawn O. Pearce (1):
      git-gui: Handle file mode changes (644->755) in diff viewer
