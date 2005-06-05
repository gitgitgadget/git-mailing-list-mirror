From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-init bug -- identified
Date: Sun, 05 Jun 2005 14:11:50 -0700
Message-ID: <7vu0kc1pbd.fsf@assigned-by-dhcp.cox.net>
References: <20050605153053.GA6890@tumblerings.org>
	<20050605172854.GF17462@pasky.ji.cz>
	<20050605175634.GB6890@tumblerings.org>
	<20050605181042.GH17462@pasky.ji.cz>
	<20050605182912.GC6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df2M2-0001jM-3n
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 23:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVFEVLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 17:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFEVLy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 17:11:54 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64141 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261620AbVFEVLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 17:11:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605211152.OULD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 17:11:52 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050605182912.GC6890@tumblerings.org> (Zack Brown's message
 of "Sun, 5 Jun 2005 11:29:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "ZB" == Zack Brown <zbrown@tumblerings.org> writes:

ZB> It turned out one of my files had a "'" in the name, i.e.:

ZB> $ ls
ZB> Zack's_file
ZB> $

ZB> I removed it, and all of a sudden cg-init worked perfectly.

ZB> Is that a Cogito bug? I would expect git to handle any
ZB> filename the filesystem itself can handle.

I'd be very surprised if it were a bug in the core GIT.  On the
other hand, Cogito, being a bunch of shell scripts, has plenty
of pitfalls it can fall in, especially in quoting areas unless
it is written reasonably carefully.

