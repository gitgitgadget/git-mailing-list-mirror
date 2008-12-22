From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1-rc4
Date: Mon, 22 Dec 2008 01:54:56 -0800
Message-ID: <7vabaok00f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 10:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEhWf-0007A1-Ek
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 10:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbYLVJzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Dec 2008 04:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYLVJzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 04:55:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYLVJzN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Dec 2008 04:55:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E466C1AD84;
	Mon, 22 Dec 2008 04:55:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91B081A642; Mon,
 22 Dec 2008 04:55:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9FBF853A-D00E-11DD-928B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103753>

This hopefully will be the last -rc before 1.6.1 becomes your Christmas
present. =20

Changes since v1.6.1-rc3 are minor and boring details.

Alexander Gavrilov (2):
      git-gui: Fix handling of relative paths in blame.
      git-gui: Fix commit encoding handling.

Arjen Laarhoven (1):
      Enable threaded delta search on Mac OS X/Darwin

Boyd Stephen Smith Jr (1):
      git-revert documentation: refer to new HOWTO on reverting faulty =
merges

Christian Stimming (3):
      git-gui: Update German (completed) translation.
      gitk: Mark forgotten strings (header sentence parts in color choo=
ser) for translation
      gitk: Update German translation

David Aguilar (1):
      git-mergetool: properly handle "git mergetool -- filename"

=46redrik Skolmli (1):
      git-gui: Starting translation for Norwegian

Giuseppe Bilotta (1):
      gitk: Map / to focus the search box

Johannes Schindelin (3):
      fast-import: close pack before unlinking it
      git-gui: Get rid of the last remnants of GIT_CONFIG_LOCAL
      fast-export: deal with tag objects that do not have a tagger

Johannes Sixt (3):
      gitk: Use check-buttons' -text property instead of separate label=
s
      gitk: Ensure that "Reset branch" menu entry is enabled
      gitk: Force the focus to the main window on Windows

Junio C Hamano (12):
      git-show: do not segfault when showing a bad tag
      pager: do not dup2 stderr if it is already redirected
      gitweb: do not run "git diff" that is Porcelain
      GIT 1.5.4.7
      gitweb: do not run "git diff" that is Porcelain
      make_absolute_path(): check bounds when seeing an overlong symlin=
k
      builtin-blame.c: use strbuf_readlink()
      combine-diff.c: use strbuf_readlink()
      fast-import: make tagger information optional
      Make sure lockfiles are unlocked when dying on SIGPIPE
      send-email: futureproof split_addrs() sub
      GIT 1.6.1-rc4

Kevin Ballard (1):
      gitk: Allow unbalanced quotes/braces in commit headers

Kirill A. Korinskiy (1):
      Remove the requirement opaquelocktoken uri scheme

Lee Marlow (2):
      bash completion: Sort config completion variables
      bash completion: Sync config variables with their man pages

Linus Torvalds (5):
      Add generic 'strbuf_readlink()' helper function
      Make 'ce_compare_link()' use the new 'strbuf_readlink()'
      Make 'index_path()' use 'strbuf_readlink()'
      Make 'diff_populate_filespec()' use the new 'strbuf_readlink()'
      Make 'prepare_temp_file()' ignore st_size for symlinks

Marcel M. Cary (1):
      git-sh-setup: Fix scripts whose PWD is a symlink into a git work-=
dir

Markus Heidelberg (7):
      Documentation: fix description for enabling hooks
      doc/git-reset: add reference to git-stash
      Documentation: sync example output with git output
      Documentation: fix typos, grammar, asciidoc syntax
      Documentation: fix typos, grammar, asciidoc syntax
      Documentation/git-show-branch: work around "single quote" typeset=
ting glitch
      doc/git-fsck: change the way for getting heads' SHA1s

Michael J Gruber (1):
      test overlapping ignore patterns

Michele Ballabio (1):
      git gui: update Italian translation

Miklos Vajna (4):
      git-gui: Update Hungarian translation for 0.12
      git-daemon documentation: use {tilde}
      githooks documentation: add a note about the +x mode
      SubmittingPatches: mention the usage of real name in Signed-off-b=
y: lines

Nanako Shiraishi (3):
      git-gui: Update Japanese translation for 0.12
      Clarify documentation of "git checkout <tree-ish> paths" syntax
      Add a documentat on how to revert a faulty merge

Paul Mackerras (1):
      gitk: Fix bugs in blaming code

Peter Krefting (2):
      git-gui: Updated Swedish translation (515t0f0u).
      git-gui: Fixed typos in Swedish translation.

Ren=C3=A9 Scharfe (3):
      Fix type-mismatch compiler warning from diff_populate_filespec()
      connect.c: stricter port validation, silence compiler warning
      fast-import.c: stricter strtoul check, silence compiler warning

Richard Hartmann (2):
      Make help entries alphabetical
      Always show which directory is not a git repository

Robin Rosenberg (1):
      git-revert: record the parent against which a revert was made

Shawn O. Pearce (2):
      git-gui: Update po template to include 'Mirroring %s' message
      git-gui 0.12

Wu Fengguang (1):
      git-send-email: handle email address with quoted comma
