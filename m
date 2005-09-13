From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] Merge driver
Date: Tue, 13 Sep 2005 13:46:29 -0700
Message-ID: <7vk6hk1ysa.fsf@assigned-by-dhcp.cox.net>
References: <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
	<7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
	<43207FE6.2030108@citi.umich.edu>
	<Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
	<432089D8.4060507@citi.umich.edu>
	<7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
	<20050912210813.GA6644@c165.ib.student.liu.se>
	<7vmzmi9ebj.fsf@assigned-by-dhcp.cox.net>
	<20050913203252.GA1737@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 22:49:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFHgX-0000nS-Q0
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVIMUqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVIMUqc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 16:46:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46784 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750823AbVIMUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 16:46:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913204631.SBQL17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 16:46:31 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050913203252.GA1737@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 13 Sep 2005 22:33:06 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8484>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Thinking a bit more about it, maybe it's better to use a temporary
> index file. If go this way we could, at least in principle, allow
> merges which starts with a dirty working directory.

Yeah, I like the idea of using temporary index for doing merges
that are not what the user wanted to do.  The same idea is used
in the 'stupid' thing that tries to find the least-conflicting
merge base.
