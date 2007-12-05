From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 05 Dec 2007 02:57:55 -0800
Message-ID: <7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 11:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzrxS-00080d-Qc
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXLEK6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 05:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbXLEK6E
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:58:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35168 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbXLEK6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 05:58:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 276AE2F2;
	Wed,  5 Dec 2007 05:58:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EB279C321;
	Wed,  5 Dec 2007 05:58:19 -0500 (EST)
X-maint-at: 4e596e988abfd7ce0b4456cdbf27baa16fa7aab8
X-master-at: 7a4a2e1f797724ce15b059f55ce57eab0e6be807
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67138>

I haven't tagged the tip of 'master' as -rc0 yet, this has more than 80=
%
of it.  Graduated to 'master' tonight are:

 * Wincent's "git add -p"
 * "git commit in C" by Kristian and others
 * Steffen Prohaska's clean-up of push/fetch refspec handling.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (2):
  Do not generate full commit log message if it is not going to be used
  Simplify crud() in ident.c

H.Merijn Brand (1):
  Do not rely on the exit status of "unset" for unset variables

Jakub Narebski (1):
  contrib: Make remotes2config.sh script more robust

Jeff King (3):
  git-commit: clean up die messages
  quote_path: fix collapsing of relative paths
  t9600: require cvsps 2.1 to perform tests

Johannes Schindelin (8):
  launch_editor(): read the file, even when EDITOR=3D:
  builtin-commit: fix reflog message generation
  git status: show relative paths when run in a subdirectory
  builtin-commit: fix --signoff
  builtin-commit --s: add a newline if the last line was not a S-o-b
  builtin-commit: resurrect behavior for multiple -m options
  builtin-commit: Add newline when showing which commit was created
  Replace "runstatus" with "status" in the tests

Junio C Hamano (15):
  file_exists(): dangling symlinks do exist
  builtin-commit: do not color status output shown in the message templ=
ate
  builtin-commit: run commit-msg hook with correct message file
  Export three helper functions from ls-files
  Fix add_files_to_cache() to take pathspec, not user specified list of
    files
  builtin-commit: fix partial-commit support
  git-add -i: allow multiple selection in patch subcommand
  Add a few more tests for git-commit
  builtin-add: fix command line building to call interactive
  add -i: Fix running from a subdirectory
  Fix --signoff in builtin-commit differently.
  git-commit: Allow to amend a merge commit that does not change the tr=
ee
  git-commit --allow-empty
  Documentation/git.txt: typofix
  t5510: add a bit more tests for fetch

Kristian H=C3=B8gsberg (10):
  Add testcase for amending and fixing author in git commit.
  Export launch_editor() and make it accept ':' as a no-op editor.
  Port git commit to C.
  builtin-commit: Refresh cache after adding files.
  Call refresh_cache() when updating the user index for --only commits.
  builtin-commit: Clean up an unused variable and a debug fprintf().
  t7501-commit: Add test for git commit <file> with dirty index.
  builtin-commit: Include the diff in the commit message when verbose.
  Fix off-by-one error when truncating the diff out of the commit messa=
ge.
  Use a strbuf for copying the command line for the reflog.

Pascal Obry (1):
  Set OLD_ICONV on Cygwin.

Pierre Habouzit (1):
  builtin-commit.c: export GIT_INDEX_FILE for launch_editor as well.

Ralf Wildenhues (1):
  Document all help keys in "git add -i" patch mode.

Shawn Bohrer (1):
  Make git status usage say git status instead of git commit

Shawn O. Pearce (1):
  Remove git-status from list of scripts as it is builtin

Steffen Prohaska (4):
  push: support pushing HEAD to real branch name
  add refname_match()
  push: use same rules as git-rev-parse to resolve refspecs
  refactor fetch's ref matching to use refname_match()

Wincent Colaiuta (6):
  Teach builtin-add to pass multiple paths to git-add--interactive
  Add path-limiting to git-add--interactive
  Add "--patch" option to git-add--interactive
  Highlight keyboard shortcuts in git-add--interactive
  add -i: allow prefix highlighting for "Add untracked" as well.
  git-add -i: add help text for list-and-choose UI

=C4=B0smail D=C3=B6nmez (1):
  gitweb: use Perl built-in utf8 function for UTF-8 decoding.
