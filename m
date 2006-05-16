From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.3.3
Date: Mon, 15 May 2006 21:49:50 -0700
Message-ID: <7vk68mfua9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 06:49:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfrVO-00024r-1w
	for gcvg-git@gmane.org; Tue, 16 May 2006 06:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWEPEty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 00:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEPEty
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 00:49:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29839 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751281AbWEPEtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 00:49:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516044951.SKAW25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 00:49:51 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20100>

The latest maintenance release GIT 1.3.3 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.3.3.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.3.3-1.$arch.rpm	(RPM)

This contains two notable non-fixes:

 (1) Future-proofing configuration file syntax by Linus.
     Nothing in 1.3.X series takes advantage of it, but it is
     there so 1.3.3 would not barf in a repository that you
     previously used later versions of git to manipulate its
     configuration file.

 (2) core.prefersymlinkrefs configuration can be set in the
     configuration file while bisecting a project that wants to
     use .git/HEAD symbolic link in its historical version
     (notably Linux kernel around January this year).

----------------------------------------------------------------

Changes since v1.3.2 are as follows:

Ben Clifford:
      include header to define uint32_t, necessary on Mac OS X

Dennis Stosberg:
      Fix git-pack-objects for 64-bit platforms
      Fix compilation on newer NetBSD systems

Dmitry V. Levin:
      Separate object name errors from usage errors

Eric Wong:
      apply: fix infinite loop with multiple patches with --index
      Install git-send-email by default

Johannes Schindelin:
      repo-config: trim white-space before comment

Junio C Hamano:
      core.prefersymlinkrefs: use symlinks for .git/HEAD
      repo-config: document what value_regexp does a bit more clearly.
      Fix repo-config set-multivar error return path.
      Documentation: {caret} fixes (git-rev-list.txt)
      checkout: use --aggressive when running a 3-way merge (-m).
      Fix pack-index issue on 64-bit platforms a bit more portably.

Linus Torvalds:
      Fix "git diff --stat" with long filenames
      revert/cherry-pick: use aggressive merge.
      git config syntax updates

Martin Waitz:
      clone: keep --reference even with -l -s
      repack: honor -d even when no new pack was created

Matthias Lederhofer:
      core-tutorial.txt: escape asterisk

Pavel Roskin:
      Release config lock if the regex is invalid

Sean Estabrooks:
      Fix for config file section parsing.
      Another config file parsing fix.
      Ensure author & committer before asking for commit message.

Yakov Lerner:
      read-cache.c: use xcalloc() not calloc()
