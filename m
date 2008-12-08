From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1-rc2
Date: Sun, 07 Dec 2008 18:53:09 -0800
Message-ID: <7vbpvnbcoa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 03:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WGZ-0002nG-Bc
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbYLHCxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2008 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYLHCxS
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:53:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbYLHCxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2008 21:53:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67FCE185B8;
	Sun,  7 Dec 2008 21:53:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8A753185B6; Sun, 
 7 Dec 2008 21:53:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5CBEE622-C4D3-11DD-A478-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102519>

Another week, another rc.  There are no outstanding features that shoul=
d
graduate from 'next' anymore until final.

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.1-rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.1-rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.1-rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also there.

  testing/git-*-1.6.1-rc2-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

Changes since v1.6.1-rc1 are as follows:

Alex Riesen (3):
      Make some of fwrite/fclose/write/close failures visible
      Make chdir failures visible
      Report symlink failures in merge-recursive

Alexander Gavrilov (2):
      gitk: Make line origin search update the busy status
      gitk: Add a menu option to start git gui

Christian Couder (2):
      bisect: fix "git bisect skip <commit>" and add tests cases
      Documentation: describe how to "bisect skip" a range of commits

Christian Stimming (1):
      gitk: Update German translation

Davide Libenzi (1):
      xdiff: give up scanning similar lines early

Deskin Miller (1):
      git-svn: Make branch use correct svn-remote

Giuseppe Bilotta (2):
      gitweb: make gitweb_check_feature a boolean wrapper
      Update comment on gitweb_check/get_feature

Jakub Narebski (2):
      gitweb: Fix handling of non-ASCII characters in inserted HTML fil=
es
      gitweb: Make project specific override for 'grep' feature work

Jeff King (2):
      add stage to gitignore
      tag: delete TAG_EDITMSG only on successful tag

Johannes Sixt (1):
      t4030-diff-textconv: Make octal escape sequence more portable

Junio C Hamano (17):
      builtin-rm.c: explain and clarify the "local change" logic
      git add --intent-to-add: fix removal of cached emptiness
      git add --intent-to-add: do not let an empty blob be committed by=
 accident
      gitweb: fix 'ctags' feature check and others
      gitweb: rename gitweb_check_feature to gitweb_get_feature
      Makefile: introduce NO_PTHREADS
      Install git-stage in exec-path
      git-am --whitespace: do not lose the command line option
      git-am: propagate -C<n>, -p<n> options as well
      git-am: propagate --3way options as well
      Test that git-am does not lose -C/-p/--whitespace options
      git-am: rename apply_opt_extra file to apply-opt
      Update draft release notes to 1.6.1
      GIT 1.6.0.5
      Update draft release notes for 1.6.1
      Revert "git-stash: use git rev-parse -q"
      Point "stale" 1.6.0.5 documentation from the main git documentati=
on page

Linus Torvalds (1):
      Add backslash to list of 'crud' characters in real name

Mark Burton (1):
      git-gui: Teach start_push_anywhere_action{} to notice when remote=
 is a mirror.

Matt McCutchen (1):
      "git diff <tree>{3,}": do not reverse order of arguments

Miklos Vajna (8):
      User's Manual: remove duplicated url at the end of Appendix B
      git-stash: use git rev-parse -q
      filter-branch: use git rev-parse -q
      lost-found: use git rev-parse -q
      pull: use git rev-parse -q
      rebase: use git rev-parse -q
      submodule: use git rev-parse -q
      http.c: use 'git_config_string' to get 'curl_http_proxy'

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      Extend index to save more flags

Paul Mackerras (3):
      gitk: Fix context menu items for generating diffs when in tree mo=
de
      gitk: Highlight only when search type is "containing:".
      gitk: Fix bug in accessing undefined "notflag" variable

Scott Chacon (1):
      Add a built-in alias for 'stage' to the 'add' command

Thomas Rast (1):
      fetch-pack: Avoid memcpy() with src=3D=3Ddst

Tor Arvid Lund (1):
      git-p4: Fix bug in p4Where method.
