From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.5
Date: Tue, 04 Apr 2006 15:38:24 -0700
Message-ID: <7vzmj155lr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 00:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQuAU-00071h-K9
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 00:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWDDWi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWDDWi0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 18:38:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36511 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750831AbWDDWiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 18:38:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404223825.OIXO17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 18:38:25 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18409>

The latest maintenance release GIT 1.2.5 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.5.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.5-1.$arch.rpm	(RPM)

This is primarily made to help Solaris folks who were bitten by
pack-objects (hence cloning from a repository hosted on Solaris)
broken by the progress-bar eye-candy.  People who follow the
"master" branch, and people who run 1.2.4 on platforms with BSD
signal semantics (which automatically restarts interrupted
read() upon signal) need not worry.

With the "master" branch work nearing 1.3.0, hopefully this will
be the last 1.2.X release.

----------------------------------------------------------------

Changes since v1.2.4 are as follows:

Jason Riedy:
      Use sigaction and SA_RESTART in read-tree.c; add option in Makefile.

Junio C Hamano:
      read-tree --aggressive: remove deleted entry from the working tree.
      tar-tree: file/dirmode fix.
      safe_fgets() - even more anal fgets()

Linus Torvalds:
      Fix Solaris stdio signal handling stupidities
      pack-objects: be incredibly anal about stdio semantics
