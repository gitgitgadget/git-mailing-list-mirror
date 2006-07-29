From: Junio C Hamano <junkio@cox.net>
Subject: Re: Call setup_git_directory() early
Date: Fri, 28 Jul 2006 22:06:47 -0700
Message-ID: <7vodv9j8yg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
	<7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 07:07:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6h2K-0004Vd-KL
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 07:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWG2FGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 01:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWG2FGt
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 01:06:49 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45529 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932627AbWG2FGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 01:06:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060729050648.DKZO25430.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Jul 2006 01:06:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607282118230.4168@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 28 Jul 2006 21:21:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24417>

Sorry for the earlier crapoid.  The diffs contained there for
t/trash stuff were due to my earlier version that marked init-db
to be GITDIR_OPTIONAL -- which caused the "optional" discovery
to find the .git/ directory two levels up (relative to t/trash)
and contaminating the primary index file by mistake (Yuck).

Your patch makes a lot of sense.
