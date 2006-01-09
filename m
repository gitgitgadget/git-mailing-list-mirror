From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.0.8
Date: Sun, 08 Jan 2006 17:20:53 -0800
Message-ID: <7vy81qtcwa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 02:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evlj1-00083s-Kt
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 02:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWAIBU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWAIBU6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 20:20:58 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10745 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWAIBU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 20:20:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109011948.TBIN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 20:19:48 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14344>

The latest maintenance release GIT 1.0.8 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.0.8.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.0.8-1.$arch.rpm	(RPM)

This is mostly "small fixes" release.

Changes since v1.0.7 are as follows:

Joe English:
      Substitute "/" with $opt_s in tag names as well as branch names

Junio C Hamano:
      unpack-objects: default to quiet if stderr is not a tty.
      Retire debian/ directory.
      prune: do not show error from pack-redundant when no packs are found.
      Compilation: zero-length array declaration.
      tar-tree: finish honoring extractor's umask in git-tar-tree.
      revert/cherry-pick: handle single quote in author name.
      mailsplit: allow empty input from stdin
      GIT 1.0.8

Yann Dirson:
      Teach cvsexportcommit to add new files
      Fix typo in debug stanza of t2001
      Fix git-format-patch usage string wrt output modes.
