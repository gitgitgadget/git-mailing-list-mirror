From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 16:24:35 -0700
Message-ID: <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722204120.GD11916@pasky.ji.cz>
	<7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
	<20050722212725.GJ11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:28:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6vz-0003Pm-U3
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVGVX1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVGVX1Q
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:27:16 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59631 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262230AbVGVXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 19:24:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722232433.EMML550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 19:24:33 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050722212725.GJ11916@pasky.ji.cz> (Petr Baudis's message of "Fri, 22 Jul 2005 23:27:25 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Cogito shows '[NMD] filename' in place of @FILELIST@.

Sounds sensible.  Does it parse it to limit the files to be
committed?

> This brings me to another subject, M and N are pretty hard to
> distinguish visually without close inspection of the output. What about
> switching to use A instead of N everywhere?

Although I admit that is minor, I've had the same problem, and
this sounds like a good idea.

However, I'd like to see what the extent of damage would be even
if everybody agrees this is a good change.  Any one of core
barebone Porcelain, Linus git-tools, gitk, gitweb, Cogito, and
StGIT would have a veto over this kind of change, or at least we
should wait until everybody catches up.

If we all decide to go ahead, the transition would not be so
painful, since we do not currently say 'A', the Porcelains can
start accepting 'A' as synonym for 'N' today, and then later we
can change the tools to produce 'A' instead of 'N'.
