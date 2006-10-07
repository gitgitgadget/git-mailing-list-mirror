From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support hiding of chosen repositories from project list
Date: Sat, 07 Oct 2006 12:50:01 -0700
Message-ID: <7v7izbrjme.fsf@assigned-by-dhcp.cox.net>
References: <20061006182822.9194.78330.stgit@rover>
	<7vu02gtqqd.fsf@assigned-by-dhcp.cox.net>
	<20061007123200.GY20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 21:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWIBX-0004CZ-Nj
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWJGTuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWJGTuH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:50:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52659 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932790AbWJGTuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 15:50:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007195002.FLJS21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 15:50:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XXq41V01s1kojtg0000000
	Sat, 07 Oct 2006 15:50:05 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28503>

Petr Baudis <pasky@suse.cz> writes:

> (BTW, I privately consider /pub/git as completely specific to kernel.org
> setup and pure evil to have as default; I would much prefer to have the
> default something more standard and LHS-compliant like /srv/git (almost)
> is. Though I can see the possible pitfalls of changing the default at
> this point (though Google says that only tipc.cslab.ericsson.net uses
> the same path), this default leads to people inventing own random paths
> and chaos reigns: /var/git in Gentoo, /srv/git in SUSE, abomination like
> /var/cache/git (!) in Debian, others don't seem to bother with gitweb.)

While I share the same concern to some degree, distro's usually
use whatever path they want to be consistent with their layout
(which I hope to converge to LHS or something).  As long as we
have it easily overridable from their build system (which we do)
it should not matter too much for them.  For people who build
and install their own, I suspect most of them do so because they
do not either like the version installed by the sysadmin or they
cannot write into system-wide directories, so to them the path
needs to be redefined to point at elsewhere anyway and would not
be an issue either.  But my guess might be grossly wrong.
