From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #04; Sat, 14)
Date: Sat, 14 Mar 2009 23:29:02 -0700
Message-ID: <7vljr78fkh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 07:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lijrr-0000PY-5q
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 07:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZCOG3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 02:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZCOG3M
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 02:29:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbZCOG3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2009 02:29:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A59C2A22FB;
	Sun, 15 Mar 2009 02:29:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96A29A22FA; Sun,
 15 Mar 2009 02:29:04 -0400 (EDT)
X-maint-at: a54a216098db10d551d33123f33667ce8a036510
X-master-at: bba2a7b22fdde7a214516e93d957a950571a2026
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95C25D52-112A-11DE-8309-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113275>

Perhaps I'll cut the first maintenance release since 1.6.2 sometime soo=
n.
It turns out that 1.6.2 cycle was quite successful in producing a solid
release.

Quite a many topics have graduated to 'master'.  Perhaps we can start t=
he
pre-release freeze in two weeks for 1.6.3.

* The 'maint' branch has these fixes since the last announcement.

Chris Johnsen (1):
  builtin-revert.c: release index lock when cherry-picking an empty com=
mit

Christian Couder (1):
  Documentation: fix badly indented paragraphs in "--bisect-all"
    description

Elijah Newren (1):
  Ensure proper setup of git_dir for git-hash-object

=46inn Arne Gangstad (1):
  Support "\" in non-wildcard exclusion entries

Jay Soffian (4):
  send-email: allow send-email to run outside a repo
  send-email: handle multiple Cc addresses when reading mbox message
  send-email: --suppress-cc improvements
  send-email: don't create temporary compose file until it is needed

Jeff King (3):
  never fallback relative times to absolute
  t1300: use test_must_fail as appropriate
  document config --bool-or-int

Junio C Hamano (2):
  git-add -i/-p: learn to unwrap C-quoted paths
  Update draft release notes for 1.6.2.1

Ren=C3=A9 Scharfe (1):
  cleanup: add isascii()


* The 'master' branch has these since the last announcement
  in addition to the above.

Benjamin Kramer (3):
  Remove unused function scope local variables
  Move local variables to narrower scopes
  Remove unused assignments

Daniel Barkalow (1):
  Include log_config module in apache.conf

David Aguilar (1):
  contrib/difftool: use a separate config namespace for difftool comman=
ds

Erik Faye-Lund (1):
  connect.c: remove a few globals by using git_config callback data

Eugene Letuchy (1):
  Make git blame's date output format configurable, like git log

Jay Soffian (3):
  bash completion: fix completion issues with fetch, pull, and push
  bash completion: refactor --strategy completion
  bash completion: teach fetch, pull, and push to complete their option=
s

Jeff King (1):
  clone: run post-checkout hook when checking out

Johannes Schindelin (5):
  Brown paper bag fix for MinGW 64-bit stat
  Add an (optional, since expensive) test for >2gb clones
  MinGW: fix diff --no-index /dev/null ...
  test: do not LoadModule log_config_module unconditionally
  test-lib: write test results to test-results/<basename>-<pid>

Johannes Sixt (1):
  test-suite: Make test script numbers unique

Junio C Hamano (8):
  git-repack: resist stray environment variable
  has_sha1_pack(): refactor "pretend these packs do not exist" interfac=
e
  has_sha1_kept_pack(): take "struct rev_info"
  Consolidate ignore_packed logic more
  Simplify is_kept_pack()
  is_kept_pack(): final clean-up
  Update draft release notes to 1.6.3
  Update release notes to 1.6.3

Michael J Gruber (3):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./, .. and //
  Typo and language fixes for git-checkout.txt

Michael Lai (1):
  git-svn: support intermediate paths when matching tags/branches

Pete Wyckoff (1):
  git-p4: remove tabs from usermap file

Ramsay Allan Jones (1):
  git-instaweb: fix lighttpd configuration on cygwin

Ren=C3=A9 Scharfe (8):
  diffcore-pickaxe: use memmem()
  optimize compat/ memmem()
  parseopt: add PARSE_OPT_KEEP_UNKNOWN
  parseopt: add PARSE_OPT_NO_INTERNAL_HELP
  parseopt: make usage optional
  archive: use parseopt for local-only options
  parseopt: document KEEP_ARGV0, KEEP_UNKNOWN, NO_INTERNAL_HELP
  parseopt: prevent KEEP_UNKNOWN and STOP_AT_NON_OPTION from being used
    together

Tay Ray Chuan (1):
  http.c: use strbuf API in quote_ref_url

Thomas Rast (13):
  format-patch: threading test reactivation
  Support coverage testing with GCC/gcov
  Test that diff can read from stdin
  Test diff --dirstat functionality
  Test log --graph
  Test fsck a bit harder
  Test log --decorate
  Test rev-list --parents/--children
  Test git-patch-id
  format-patch: track several references
  format-patch: thread as reply to cover letter even with in-reply-to
  format-patch: support deep threading
  Documentation: filter-branch: show --ignore-unmatch in main index-fil=
ter
    example

Tor Arne Vestb=C3=B8 (2):
  git-rebase: Add --stat and --no-stat for producing diffstat on rebase
  git-pull: Allow --stat and --no-stat to be used with --rebase
