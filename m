From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Nov 2008, #04; Wed, 26)
Date: Wed, 26 Nov 2008 16:28:03 -0800
Message-ID: <7v8wr6c8rw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 01:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5UlM-0005X3-NK
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 01:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYK0A2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 19:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYK0A2W
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 19:28:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYK0A2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 19:28:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14CF581BC7;
	Wed, 26 Nov 2008 19:28:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3EC4281BC6; Wed,
 26 Nov 2008 19:28:05 -0500 (EST)
X-maint-at: 5aa3bdd50d4e4f59c41ee6e70ae1e738a3a28cc0
X-master-at: aa14a0c3f191ee4df7344eed119be5b4a527a0ff
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4864E012-BC1A-11DD-91EC-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101782>

I suspect many people especially the ones in the US will be in vacation
mode and not near their keyboards til next week, but here is an update.

There are a few 'maint' material cooking in 'next' and v1.6.0.5 should be
tagged at the end of the month.

At around the same time I am hoping majority of topics cooking in 'next'
tonight can be in 'master' and we can tagl v1.6.1-rc1.

* The 'maint' branch has these fixes since the last announcement.

Bryan Drewery (1):
  Fix misleading wording for git-cherry-pick

Junio C Hamano (3):
  builtin-ls-files.c: coding style fix.
  Teach ls-files --with-tree=<tree> to work with options other than -c
  Teach "git diff" to honour --[no-]ext-diff

Matt McCutchen (1):
  config.txt: alphabetize configuration sections

Stefan Naewe (1):
  request-pull: make usage string match manpage


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (2):
  Fix handle leak in sha1_file/unpack_objects if there were damaged object
    data
  Fix t4030-diff-textconv.sh

Alexander Gavrilov (6):
  git-gui: Implement system-wide configuration handling.
  git-gui: Fix the after callback execution in rescan.
  git-gui: Add a Tools menu for arbitrary commands.
  git-gui: Allow Tools request arguments from the user.
  git-gui: Implement automatic rescan after Tool execution.
  git-gui: Fix the search bar destruction handler.

Alexandre Julliard (9):
  git.el: Improve error handling for commits.
  git.el: Remove the env parameter in git-call-process and
    git-call-process-string.
  git.el: Simplify handling of merge heads in the commit log-edit buffer.
  git.el: Properly handle merge commits in git-amend-commit.
  git.el: Fix git-amend-commit to support amending an initial commit.
  git.el: Never clear the status buffer, only update the files.
  git.el: Add an insert file command.
  git.el: Add possibility to mark files directly in
    git-update-status-files.
  git.el: Allow to commit even if there are no marked files.

Brandon Casey (1):
  repack: only unpack-unreachable if we are deleting redundant packs

Cheng Renquan (1):
  git-remote: match usage string with the manual pages

Christian Couder (2):
  Documentation: user-manual: add information about "git help" at the
    beginning
  Documentation: tutorial: add information about "git help" at the
    beginning

Giuseppe Bilotta (1):
  git-gui: try to provide a window icon under X

Jeff King (3):
  define empty tree sha1 as a macro
  wt-status: refactor initial commit printing
  status: show "-v" diff even for initial commit

Jim Meyering (1):
  xdiff-interface.c: remove 10 duplicated lines

Joey Hess (1):
  sha1_file: avoid bogus "file exists" error message

Junio C Hamano (1):
  builtin-remote.c: plug a small memory leak in
    get_one_remote_for_updates()

Linus Torvalds (1):
  Fix machine-parseability of 'git log --source'

Marcel Koeppen (1):
  t9129-git-svn-i18n-commitencoding: Make compare_svn_head_with()
    compatible with OSX sed

Mark Burton (2):
  Documentation: rev-list-options.txt: added --branches, --tags &
    --remotes.
  git-commit.txt - mention that files listed on the command line must be
    known to git.

Miklos Vajna (3):
  builtin-branch: use strbuf in delete_branches()
  builtin-branch: use strbuf in fill_tracking_info()
  builtin-branch: use strbuf in rename_branch()

Shawn O. Pearce (1):
  Update the po template

Trent Piepho (1):
  send-email: Fix Pine address book parsing
