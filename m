From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.6
Date: Fri, 07 Apr 2006 17:56:27 -0700
Message-ID: <7vek08j35w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 02:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FS1kx-00080n-IO
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 02:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWDHA4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 20:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDHA43
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 20:56:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:202 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751379AbWDHA43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 20:56:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408005628.WCKO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 20:56:28 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18508>

The latest maintenance release GIT 1.2.6 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.6.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.6-1.$arch.rpm	(RPM)

These fixes are my birthday present to git ;-).  I'll also do
the 1.3.0-rc3 tonight.

----------------------------------------------------------------

Changes since v1.2.5 are as follows:

Junio C Hamano:
      parse_date(): fix parsing 03/10/2006
      diff_flush(): leakfix.
      count-delta: match get_delta_hdr_size() changes.

Nicolas Pitre:
      check patch_delta bounds more carefully
