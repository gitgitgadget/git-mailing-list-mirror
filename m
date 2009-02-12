From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Feb 2009, #02; Wed, 11)
Date: Wed, 11 Feb 2009 20:04:21 -0800
Message-ID: <7vmycsqp16.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 05:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXSpo-0003q3-Rt
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 05:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbZBLEEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 23:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZBLEEa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 23:04:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZBLEE3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 23:04:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B72A98273;
	Wed, 11 Feb 2009 23:04:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E3F598271; Wed,
 11 Feb 2009 23:04:23 -0500 (EST)
X-maint-at: e5887c1bda12b31ea7af0ce798bfdee308e1b176
X-master-at: 30aa4fb15fa408596dea59cdc9f00c94eeaa69f1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D35323C-F8BA-11DD-8940-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109571>

There are handful of fixes for 1.6.1.4 on maint that are also in master=
=2E

The 'notes' topic has been kicked out of master for now. =20

I think 'master' is ready to be tagged as v1.6.2-rc1, but I'll be givin=
g a
few days for people to try out the current 'master' before doing so.  I=
've
merged git-svn updates, but haven't pulled either git-gui or gitk updat=
es
yet, which need to happen before -rc1.

* The 'maint' branch has these fixes since the last announcement.

Christian Couder (1):
  rev-list: fix showing distance when using --bisect-all

Elijah Newren (1):
  fast-export: ensure we traverse commits in topological order

Junio C Hamano (3):
  revision traversal and pack: notice and die on missing commit
  Make repack less likely to corrupt repository
  Prepare for 1.6.1.4.

Matt McCutchen (1):
  gitweb: add $prevent_xss option to prevent XSS by repository content

Shawn O. Pearce (2):
  Clear the delta base cache during fast-import checkpoint
  Clear the delta base cache if a pack is rebuilt


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexandre Julliard (1):
  Describe notable git.el changes in the release notes

Anton Gyllenberg (1):
  test case for regression caused by git-svn empty symlink fix

Deskin Miller (1):
  git-svn: Print revision while searching for earliest use of path

Eric Kidd (1):
  filter-branch: Add more error-handling

Eric Wong (2):
  git-svn: allow disabling expensive broken symlink checks
  git-svn: fix broken symlink workaround when switching branches

Johannes Schindelin (3):
  Let ls-files strip trailing slashes in submodules' paths
  submodule: warn about non-submodules
  Add two extra tests for git rebase

Johannes Sixt (4):
  Make test-path-utils more robust against incorrect use
  Move sanitary_path_copy() to path.c and rename it to
    normalize_path_copy()
  Test and fix normalize_path_copy()
  Remove unused normalize_absolute_path()

Junio C Hamano (8):
  Revert "Merge branch 'js/notes'"
  Modernize t5400 test script
  remote prune: warn dangling symrefs
  Warn use of "origin" when remotes/origin/HEAD is dangling
  Drop double-semicolon in C
  receive-pack: receive.denyDeleteCurrent
  builtin-receive-pack.c: do not initialize statics to 0
  Squelch overzealous "ignoring dangling symref" in an empty repository

Lars Hjemli (1):
  tree.c: allow read_tree_recursive() to traverse gitlink entries

Michael J Gruber (1):
  Fix the installation path for html documentation

Pat Notz (1):
  Fix contrib/hooks/post-receive-email for new duplicate branch

Ren=C3=A9 Scharfe (1):
  Fix GIT_CEILING_DIRECTORIES on Windows

Sam Vilain (1):
  git-svn: abstract out a block into new method other_gs()

Santi B=C3=A9jar (1):
  doc/bundle: Use the more conventional suffix '.bundle'

Sitaram Chamarty (1):
  Documentation: clarify commits affected by gitk --merge

Stephan Beyer (3):
  add -p: get rid of Git.pm warnings about unitialized values
  Makefile: resort filenames alphabetically
  Generalize and libify index_is_dirty() to index_differs_from(...)

Ted Pavlic (2):
  completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variable
    errors.
  completion: Get rid of tabbed indentation in comments. Replace with
    spaces.

Todd Zullinger (1):
  git-web--browse: Fix check for /bin/start
