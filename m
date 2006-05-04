From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.3.2
Date: Thu, 04 May 2006 01:01:28 -0700
Message-ID: <7v4q066wx3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 10:01:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbYmE-0005Gu-OF
	for gcvg-git@gmane.org; Thu, 04 May 2006 10:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWEDIBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 04:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWEDIBa
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 04:01:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13748 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751435AbWEDIB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 04:01:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504080129.ZFFJ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 04:01:29 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19554>

The latest maintenance release GIT 1.3.2 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.3.2.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.3.2-1.$arch.rpm	(RPM)

Mostly documentation and usability fixes, with no exciting new
features, as the maintenance series ought to be.

----------------------------------------------------------------

Changes since v1.3.1 are as follows:

Huw Davies:
      git-format-patch: Use rfc2822 compliant date.

Jon Loeliger:
      Alphabetize the glossary.
      Added definitions for a few words:
      Add a few more words to the glossary.

Junio C Hamano:
      rebase: typofix.
      commit-tree.c: check_valid() microoptimization.
      verify-pack: check integrity in a saner order.
      git-am --resolved: more usable error message.

Linus Torvalds:
      Fix filename verification when in a subdirectory

Martin Langhoff:
      git-send-email: fix version string to be valid perl

Matthias Kestenholz:
      annotate: fix warning about uninitialized scalar
      annotate: display usage information if no filename was given
      fix various typos in documentation

Robert Shearman:
      give "what now" hint to users upon git-am failure.

Sean Estabrooks:
      Update the git-branch man page to include the "-r" option,
      Fix up remaining man pages that use asciidoc "callouts".
      Properly render asciidoc "callouts" in git man pages.
      Fix trivial typo in git-log man page.
