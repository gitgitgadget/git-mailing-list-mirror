From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Nov 2008, #01; Sun, 02)
Date: Sun, 02 Nov 2008 13:35:08 -0800
Message-ID: <7vabch3j77.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 22:36:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwkch-0005AT-N8
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 22:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYKBVfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbYKBVfX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 16:35:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbYKBVfV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 16:35:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EA4977113;
	Sun,  2 Nov 2008 16:35:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B1C87710F; Sun,  2 Nov 2008 16:35:15 -0500 (EST)
X-maint-at: 1a9016aae5aa8c468bb2d8d5dd16303d5c005869
X-master-at: 6a509a6f7f38906996ac791449d5bcc2f32eef23
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 267BB07C-A926-11DD-80A4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99877>

There are several topic branches destined for 'maint' that have been
cooking and have graduated to 'master', and I'll make the noise about
1.6.0.4 louder once they are merged, but not yet.

On the 'master' front, there are quite a few git-gui updates.

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (3):
  Plug a memleak in builtin-revert
  Add --verbose|-v to test-chmtime
  Use test-chmtime -v instead of perl in t5000 to get mtime of a file

Charles Bailey (1):
  git-archive: work in bare repos

Deskin Miller (2):
  git-svn: change dashed git-config to git config
  git-svn: change dashed git-commit-tree to git commit-tree

Gustaf Hendeby (1):
  git-gui: Help identify aspell version on Windows too

Jakub Narebski (1):
  Documentation/gitattributes: Add subsection header for each attribute

Jan Kr=C3=BCger (1):
  Documentation: clarify information about 'ident' attribute

Jeff King (4):
  correct cache_entry allocation
  pack-objects: avoid reading uninitalized data
  fix overlapping memcpy in normalize_absolute_path
  send-pack: do not send out single-level refs such as refs/stash

Jonas Fonseca (1):
  asciidoc: add minor workaround to add an empty line after code blocks

Junio C Hamano (1):
  Start 1.6.0.4 cycle

Linus Torvalds (1):
  Add file delete/create info when we overflow rename_limit

Markus Heidelberg (1):
  bash completion: add doubledash to "git show"

Nanako Shiraishi (1):
  Install git-cvsserver in $(bindir)

Pierre Habouzit (1):
  git send-email: avoid leaking directory file descriptors.

Thomas Rast (1):
  add -p: warn if only binary changes present

Tom Preston-Werner (1):
  add instructions on how to send patches to the mailing list with Gmai=
l

Tommi Virtanen (1):
  Install git-shell in bindir, too


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexander Gavrilov (6):
  git-gui: Make Ctrl-T safe to use for conflicting files.
  git-gui: Fix the blame window shape.
  git-gui: Add a search command to the blame viewer.
  git-gui: Fix the blame viewer destroy handler.
  git-gui: Add a dialog that shows the OpenSSH public key.
  git-gui: Add a simple implementation of SSH_ASKPASS.

Christian Stimming (1):
  git-gui: Update German translation.

Jan Kr=C3=BCger (1):
  Introduce receive.denyDeletes

Joey Hess (1):
  git-daemon: set REMOTE_ADDR to client address

Johannes Sixt (6):
  git-gui: Do not automatically stage file after merge tool finishes
  git-gui: Remove space from the end of aspell's reply before processin=
g
  git-gui: Fix switch statement in lib/merge.tcl
  git-gui: Show a round number of bytes of large untracked text files
  git-gui: Mark-up strings in show_{other,unmerged}_diff() for localiza=
tion
  git-gui: Do not munge conflict marker lines in a normal diff

Junio C Hamano (4):
  receive-pack: fix "borrowing from alternate object store" implementat=
ion
  compat/cygwin.c: make runtime detection of lstat/stat lessor impact
  Stop using compat/regex.c on platforms with working regexp library
  Update draft release notes to 1.6.1

Petr Baudis (12):
  git-gui: Clarify the Remote -> Delete... action
  git-gui: Squash populate_{push,fetch}_menu to populate_remotes_menu
  git-gui: Add support for adding remotes
  git-gui: Add support for removing remotes
  git-gui: mkdir -p when initializing new remote repository
  git-gui: Use git web--browser for web browsing
  git-gui: Add Explore Working Copy to the Repository menu
  git-gui: gui.autoexplore makes explorer to pop up automatically after
    picking
  git-gui: Avoid using the term URL when specifying repositories
  git-gui: Make input boxes in init/clone/open dialogs consistent
  git-gui: Fix removing non-pushable remotes
  git-gui: Fix fetching from remotes when adding them

Shawn O. Pearce (1):
  git-gui: Show/hide "Sign Off" based on nocommitmsg option

Tom Preston-Werner (1):
  connect.c: add a way for git-daemon to pass an error back to client
