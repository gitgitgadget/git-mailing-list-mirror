From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Sat, 05 Jan 2008 02:46:07 -0800
Message-ID: <7v63y8ble8.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
	"Marco Costalba" <mcostalba@gmail.com>, Jeff King <peff@peff.net>,
	Dan McGee <dpmcgee@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 11:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB6YM-0007kO-7v
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 11:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYAEKq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2008 05:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYAEKq0
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 05:46:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAEKqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2008 05:46:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD2F7F9C;
	Sat,  5 Jan 2008 05:46:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E12497F98;
	Sat,  5 Jan 2008 05:46:13 -0500 (EST)
X-maint-at: 4f3d37035a7c735a3b69f962656819f4ff7e4927
X-master-at: d6da3cdeb70e8819f68fe3c91d3457e53ab365d4
In-Reply-To: <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 23 Dec 2007 01:21:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69663>

We are not at -rc3 yet, but we will be soon.  What we have
accumulated in 'master' are mostly fixes, and the official
git-gui 0.9.1 is also included tonight.

I have to apologize that tonight I got a bit carried away
enjoying arguing for the sake of arguing.  Some patches that
might be worthy even though they are late in the cycle are not
in tonight's 'master', mostly because I have to sleep on them,
and partly because I am running out of time tonight.

 * Tsugikazu Shibata's git-diff hunk header change.

   I have a counterproposal that I think is more in line with
   the other parts of the system.  As the kernel project has
   ja_JP, ko_KR and zh_CN directories under Documentation these
   days, the issue this patch addresses is already real, and we
   would want to have a solution in 1.5.4, even though the topic
   was raised too late in the cycle.  I think my first two
   patches could be a good starting point for that.  I'd exclude
   the last patch in the series that acts on gitattributes for
   now.

 * Marco's git-stash changes to output to stdout.

   I'd probably apply this, with a slightly toned down commit
   log message.  Marco says some practice is standard, I
   disagreed, but that is not a reason to say "this practice is
   nonstandard and bad".  Simply saying "some do this and it is
   better to be helpful to them because there is no strong
   reason not to" would be good enough.

 * Jeff's git-add--interactive change to always honor color.diff
   regardless of color.interactive.

   I'd probably apply this, along with the patch to redefine
   what color.interactive means.  "git am -i" could also learn
   to use colors in the future.

   Incidentally I noticed that many of the color.diff.* palette
   options are read by "git-add -i" but never used by the
   script.  We might want to fix this while we are at it.

 * Dan McGee's workaround to breakage caused by changes in
   AsciiDoc 8.2.3.

   I have to do my usual "before-and-after comparison" with
   copies of AsciiDoc versions that should not be affected by
   the breakage, which I did not have time to do so far.  But
   this is probably a must-have before the release.

 * My patch to error out "git stash clear foobar".

   This should be applied; it is a good safety measure
   regardless of where that "git stash drop" thing would go.

An issue worth addressing before the release is still in limbo.

 * Dmitry's git-filter-branch fix to disambiguate the refs being
   rewritten.

   Addition of "git-rev-parse --symbolic-full" may solve this
   more cleanly than the patches in the discussion, but we
   haven't reached the conclusion of this thread yet.

Anything I missed?

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

Alex Riesen (1):
  Allow selection of different cleanup modes for commit messages

Arjen Laarhoven (1):
  Fix "git log --diff-filter" bug

Bernt Hansen (1):
  git-gui: Make commit log messages end with a newline

Eric Wong (2):
  git-svn: allow dcommit --no-rebase to commit multiple, dependent chan=
ges
  git-svn: unlink index files that were globbed, too

Gr=C3=A9goire Barbier (1):
  Fix double-free() in http-push.c:remote_exists()

Gustaf Hendeby (2):
  shortlog manpage documentation: work around asciidoc markup issues
  Documentation/user-manual.txt: fix typo

J. Bruce Fields (1):
  Documentation: fix remote.<name>.skipDefaultUpdate description

Jeff King (6):
  cvsimport: die on cvsps errors
  config: handle lack of newline at end of file better
  git-reset: refuse to do hard reset in a bare repository
  add a "basic" diff config callback
  diff: load funcname patterns in "basic" config
  diff: remove lazy config loading

Jim Meyering (2):
  Fix grammar nits in documentation and in code comments.
  Don't access line[-1] for a zero-length "line" from fgets.

Johannes Schindelin (1):
  Optimize prefixcmp()

Johannes Sixt (1):
  git-gui: Move frequently used commands to the top of the context menu=
=2E

Junio C Hamano (20):
  t7005: do not exit inside test.
  builtin-commit: fix amending of the initial commit
  builtin-commit: avoid double-negation in the code.
  Fix documentation of --first-parent in git-log and copy it to
    git-rev-list
  combine-diff: Fix path quoting
  Fix rewrite_diff() name quoting.
  contrib: resurrect scripted git-revert.
  GIT 1.5.4-rc2
  Documentation/git-submodule.txt: typofix
  "git pull --tags": error out with a better message.
  git-rebase -i behaves better on commits with incomplete messages
  git-rebase -i: clean-up error check codepath.
  lock_any_ref_for_update(): reject wildcard return from check_ref_form=
at
  Update callers of check_ref_format()
  Uninline prefixcmp()
  git-clean: make "Would remove ..." path relative to cwd again
  t/t7600: avoid GNUism in grep
  t/t{3600,3800,5401}: do not use egrep when grep would do
  t/t3800: do not use a temporary file to hold expected result.
  Update draft release notes for 1.5.4

Marco Costalba (1):
  Document git-reset defaults to HEAD if no commit is given

Mark Levedahl (1):
  git-gui: Unconditionally use absolute paths with Cygwin

Martin Koegler (2):
  receive-pack: check object type of sha1 before using them as commits
  receive-pack: reject invalid refnames

Michael Stefaniuc (1):
  git-am: Run git gc only once and not for every patch.

Miklos Vajna (2):
  git-sh-setup: document git_editor() and get_author_ident_from_commit(=
)
  t/t7001: avoid unnecessary ERE when using grep

Peter Karlsson (1):
  Added Swedish translation.

Ren=C3=A9 Scharfe (1):
  Make "--pretty=3Dformat" parser a bit more careful.

Shawn O. Pearce (2):
  git-gui: Handle file mode changes (644->755) in diff viewer
  Improve error messages when int/long cannot be parsed from config
