From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.1.4
Date: Fri, 20 Jan 2006 00:42:38 -0800
Message-ID: <7v1wz31e9t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 09:42:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezrr3-0000Ey-8e
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 09:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWATIml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 03:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWATIml
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 03:42:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22681 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbWATImk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 03:42:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120084124.XBDQ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 03:41:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14955>

The latest maintenance release GIT 1.1.4 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.4.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.4-1.$arch.rpm	(RPM)

This contains one minor fix and one performance fix.

----------------------------------------------------------------

Changes since v1.1.3 are as follows:

Johannes Schindelin:
      git-fetch-pack: really do not ask for funny refs

      * This fixes a case where "git-fetch-pack" is asked to
        fetch all the refs; git barebone Porcelain never
        triggers it and that is one reason why it was never
        noticed so far.

Junio C Hamano:
      Revert "check_packed_git_idx(): check integrity of the idx file itself."

      * This was causing significant performance degradation
        compared to 0.99.9x.  First noticed and complained by
        Andrew, and the bisect tool by Linus helped to pinpoint
        it.  I just took credit for what the two kernel titans
        did to help us ;-).
