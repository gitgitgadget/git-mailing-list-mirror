From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Dec 2008, #03; Sun, 21)
Date: Sun, 21 Dec 2008 04:22:52 -0800
Message-ID: <7vskohpvj7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Paul Mackerras <paulus@samba.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 13:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LENMG-0003BL-PR
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 13:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYLUMXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2008 07:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYLUMXG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 07:23:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYLUMXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2008 07:23:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E879489D19;
	Sun, 21 Dec 2008 07:23:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6654089D18; Sun,
 21 Dec 2008 07:22:54 -0500 (EST)
X-maint-at: 718258e256b74622aa55f5ee0cb9cff4cce6bf9f
X-master-at: b3eae84dc10e452add0e79c7373ceee16f73f7f0
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C46F904-CF5A-11DD-8D3B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103698>

The 'maint' branch is at 1.6.0.6, which hopefully will be the last
maintenance release until 1.6.1 final.

Earlier I said I'd like to have 1.6.1 final this weekend, but I'd rathe=
r
play safe and tag -rc4 tonight (gee, it is already 04:00am), and leave =
the
final 1.6.0 as Christmas present to git users.

 * Paul has one patch on his gitk branch I have fetched but not merged =
yet;
   waiting for his go-ahead.

 * I am undecided whether I should include the "rebase -i -p" patch fro=
m
   j6t in 1.6.1 and have been waiting for comments from Dscho.

 * A documentation patch from Boyd Stephen Smith Jr. to add a reference=
 to
   the new HowTo page from git-revert manpage and an additional warning=
 to
   git-revert from Robin Rosenberg are still not in yet, but I would li=
ke
   to have them with updates in 1.6.1 final.

Other than that, the 'master' I am pusing out is pretty much it for
1.6.1.

By the way, 'master' and 'maint' of git.git repository are also mirrore=
d
at git://git.sourceforge.jp/gitroot/git-core/git.git (and they have git=
web
http://git.sourceforge.jp/view?p=3Dgit-core/git.git).  People who are
following my blog may already have been aware of this, though.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

Alexander Gavrilov (3):
  git-gui: Fix handling of relative paths in blame.
  git-gui: Fix commit encoding handling.
  Documentation: Describe git-gui Tools menu configuration options.

Arjen Laarhoven (1):
  Enable threaded delta search on Mac OS X/Darwin

Christian Stimming (1):
  git-gui: Update German (completed) translation.

=46redrik Skolmli (1):
  git-gui: Starting translation for Norwegian

Johannes Schindelin (2):
  Get rid of the last remnants of GIT_CONFIG_LOCAL
  git-gui: Get rid of the last remnants of GIT_CONFIG_LOCAL

Junio C Hamano (6):
  gitweb: do not run "git diff" that is Porcelain
  make_absolute_path(): check bounds when seeing an overlong symlink
  builtin-blame.c: use strbuf_readlink()
  combine-diff.c: use strbuf_readlink()
  Make sure lockfiles are unlocked when dying on SIGPIPE
  send-email: futureproof split_addrs() sub

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
  git-sh-setup: Fix scripts whose PWD is a symlink into a git work-dir

Markus Heidelberg (5):
  Documentation: fix description for enabling hooks
  doc/git-reset: add reference to git-stash
  Documentation: sync example output with git output
  Documentation: fix typos, grammar, asciidoc syntax
  Documentation/git-show-branch: work around "single quote" typesetting
    glitch

Michael J Gruber (1):
  test overlapping ignore patterns

Michele Ballabio (1):
  git gui: update Italian translation

Miklos Vajna (3):
  git-gui: Update Hungarian translation for 0.12
  git-daemon documentation: use {tilde}
  githooks documentation: add a note about the +x mode

Nanako Shiraishi (3):
  git-gui: Update Japanese translation for 0.12
  Clarify documentation of "git checkout <tree-ish> paths" syntax
  Add a documentat on how to revert a faulty merge

Peter Krefting (2):
  git-gui: Updated Swedish translation (515t0f0u).
  git-gui: Fixed typos in Swedish translation.

Ren=C3=A9 Scharfe (3):
  Fix type-mismatch compiler warning from diff_populate_filespec()
  connect.c: stricter port validation, silence compiler warning
  fast-import.c: stricter strtoul check, silence compiler warning

Shawn O. Pearce (2):
  git-gui: Update po template to include 'Mirroring %s' message
  git-gui 0.12

YONETANI Tomokazu (1):
  git-fast-import possible memory corruption problem
