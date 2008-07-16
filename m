From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Tue, 15 Jul 2008 20:33:18 -0700
Message-ID: <7vabgiwlj5.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
 <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
 <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org>
 <7v1w25xfd6.fsf@gitster.siamese.dyndns.org>
 <7vmykljahl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 05:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIxmX-0001Am-PD
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 05:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYGPDdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 23:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYGPDdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 23:33:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbYGPDdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 23:33:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 45D6A2D6C1;
	Tue, 15 Jul 2008 23:33:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 342F12D6C0; Tue, 15 Jul 2008 23:33:20 -0400 (EDT)
X-maint-at: 191a8e32b38c7ff0dd884df7bd323b7a5bd4336c
X-master-at: fcab40a389e99786a8276108cdbc1cda8caf502f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F173348E-52E7-11DD-ACB4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88634>

"Merge-in-C" is in, so is "rename .dotest", and remaining Windows bits.
Now it is almost there for 1.6.0-rc0.

* The 'master' branch has these since the last announcement.

Alexander N. Gavrilov (1):
  Fix quadratic performance in rewrite_one.

Brian Gernhardt (1):
  Documentation: mention ORIG_HEAD in am, merge, and rebase

Ciaran McCreesh (1):
  Make git-add -i accept ranges like 7-

Dmitry Kakurin (1):
  Fixed text file auto-detection: treat EOF character 032 at the end of
    file as printable

=46rederik Schwarzer (1):
  git-svn: typofix

Ian Katz (1):
  tutorial: use prompt with user names in example, to clarify who is do=
ing
    what

Johannes Schindelin (6):
  Convert CR/LF to LF in tag signatures
  Add pretty format %aN which gives the author name, respecting .mailma=
p
  Move MERGE_RR from .git/rr-cache/ into .git/
  git-gui: MERGE_RR lives in .git/ directly with newer Git versions
  shortlog: support --pretty=3Dformat: option
  Rename ".dotest/" to ".git/rebase" and ".dotest-merge" to "rebase-mer=
ge"

Jo=C3=A3o Abecasis (1):
  git-svn: find-rev and rebase for SVN::Mirror repositories

Junio C Hamano (10):
  Introduce get_merge_bases_many()
  Introduce reduce_heads()
  Teach "am" and "rebase" to mark the original position with ORIG_HEAD
  branch --contains: default to HEAD
  branch --merged/--no-merged: allow specifying arbitrary commit
  Teach merge.log to "git-merge" again
  Update draft release notes for 1.6.0
  reduce_heads(): protect from duplicate input
  tutorial: clarify "pull" is "fetch + merge"
  Update draft release notes to 1.6.0

Lukas Sandstr=C3=B6m (1):
  git-mailinfo: Fix getting the subject from the in-body [PATCH] line

Mark Levedahl (2):
  git-submodule - make "submodule add" more strict, and document it
  git-submodule - register submodule URL if adding in place

Mike Pape (1):
  We need to check for msys as well as Windows in add--interactive.

Miklos Vajna (15):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move parse-options's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and pull.octopu=
s
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it usable from other builtins
  Introduce get_octopus_merge_bases() in commit.c
  Add new test to ensure git-merge handles more than 25 refs.
  Add new test case to ensure git-merge reduces octopus parents when
    possible
  Add new test case to ensure git-merge prepends the custom merge messa=
ge
  git-commit-tree: make it usable from other builtins
  Fix t7601-merge-pull-config.sh on AIX
  Build in merge
  t6021: add a new test for git-merge-resolve
  Add a new test for git-merge-resolve

Nicolas Pitre (1):
  restore legacy behavior for read_sha1_file()

Olivier Marin (1):
  builtin-rerere: more carefully find conflict markers

Pavel Roskin (1):
  t9600: allow testing with cvsps 2.2, including beta versions

Pierre Habouzit (1):
  parse-options: add PARSE_OPT_LASTARG_DEFAULT flag

Shawn O. Pearce (3):
  bash completion: Append space after file names have been completed
  bash completion: Resolve git show ref:path<tab> losing ref: portion
  bash completion: Remove dashed command completion support

Soeren Finster (1):
  git-gui: Exit shortcut in MacOSX repaired

Steffen Prohaska (3):
  Move code interpreting path relative to exec-dir to new function
    system_path()
  help.c: Add support for htmldir relative to git_exec_path()
  help (Windows): Display HTML in default browser using Windows' shell =
API

Stephan Beyer (1):
  rerere: Separate libgit and builtin functions

Sverre Hvammen Johansen (1):
  reduce_heads(): thinkofix

Teemu Likonen (1):
  bash: Add long option completion for 'git send-email'
