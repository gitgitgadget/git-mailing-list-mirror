From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.1
Date: Wed, 15 Feb 2006 22:25:59 -0800
Message-ID: <7vzmkrizuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 07:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9caj-0000QS-VF
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 07:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWBPG0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 01:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWBPG0D
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 01:26:03 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26337 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750955AbWBPG0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 01:26:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216062450.UKQG15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 01:24:50 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16272>

The latest maintenance release GIT 1.2.1 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.1.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.1-1.$arch.rpm	(RPM)


Nothing earth-shattering but cleanups and cleanups and cleanups.

All the interesting things are happening in "master" and "pu",
which will be a topic for a separate message.

----------------------------------------------------------------

Changes since v1.2.0 are as follows:

Fernando J. Pereda:
      Print an error if cloning a http repo and NO_CURL is set

Fredrik Kuivinen:
      s/SHELL/SHELL_PATH/ in Makefile

Josef Weidendorfer:
      More useful/hinting error messages in git-checkout

Junio C Hamano:
      Documentation: git-commit in 1.2.X series defaults to --include.
      Documentation: git-ls-files asciidocco.
      bisect: remove BISECT_NAMES after done.
      combine-diff: diff-files fix.
      combine-diff: diff-files fix (#2)
      checkout: fix dirty-file display.
