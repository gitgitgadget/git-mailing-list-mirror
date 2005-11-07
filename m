From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.9e
Date: Sun, 06 Nov 2005 21:43:19 -0800
Message-ID: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 06:43:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYzmz-000075-HF
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 06:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVKGFnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVKGFnW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 00:43:22 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22483 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964778AbVKGFnV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 00:43:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107054233.CYHM776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 00:42:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11257>

GIT 0.99.9e maintenance release is found at the usual places:

RPM, tarballs, and deb:

	http://www.kernel.org/pub/software/scm/git/

With git, fetch maint branch from

	git://git.kernel.org/pub/scm/git/git.git/

It contains everything from the master branch.  Since we seem to
be shelving the separate git binary directory idea indefinitely,
what we have here is pretty much what will be in 1.0, from the
source code POV.

 - http-push seems to still have a bug or two but that is to be
   expected for any new code, and I am reasonably sure it can be
   ironed out; preferably before 1.0 but it is not a
   showstopper.

 - I've done the initial round of package splitting for Debian
   side myself, but it probably needs proofreading and fixing by
   experienced Debian person.  Similar RPM package splitting
   that parallels the above is needed.  Although it is not an
   absolute requirement for my sources to have perfect binary
   packaging support (I am just an upstream for binary
   packagers), it is certainly desirable to have RPM specs and
   debian/ files in a presentable shape for 1.0.

 - I still need to go over the tutorial and core-ish
   documentation once for consistency checks.


Changes since 0.99.9d are:

    Johannes Schindelin:
      Allow GIT_DIR to be an absolute path
      http-fetch: do not use curl_message after releasing it

    Jon Loeliger:
      Refactor merge strategies into separate includable file.

    Junio C Hamano:
      test: t4102-apply-rename fails with strict umask (Peter Baumann).
      git-format-patch: silly typo fix.
      Documentation: pull/clone ref mapping clarification (Josef Weidendorfer).
      git-fetch: fail if specified refspec does not match remote.
      Simplify CFLAGS/DEFINES in Makefile
      Package split: Debian.
      Install asciidoc sources as well.
      Further Debian split fixes.
      Debian: test build.
      Merge in http-push first stage.
      Document expat dependency when using http-push.
      ls-files: --others should not say unmerged paths are unknown.
      git-status: do not mark unmerged paths as committable.
      Set up remotes/origin to track all remote branches.

    Nick Hengeveld:
      Add support for pushing to a remote repository using HTTP/DAV
      Verify remote packs, speed up pending request queue
      Support remote references with slashes in their names
      Improve lock handling
      Refresh the remote lock if it is about to expire

    Paul Collins:
      http-push.c: include with angle bracket, not dq.

    Randal L. Schwartz:
      Use fink/darwinport paths for OSX
