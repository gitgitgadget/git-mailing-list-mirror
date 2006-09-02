From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 02 Sep 2006 13:56:38 -0700
Message-ID: <7vac5iyol5.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021138500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 22:56:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJcXc-00083Z-5Z
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 22:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWIBU4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 16:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWIBU4d
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 16:56:33 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47766 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751580AbWIBU4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 16:56:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902205632.IURD27846.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 16:56:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HYwY1V00K1kojtg0000000
	Sat, 02 Sep 2006 16:56:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609021138500.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 2 Sep 2006 11:43:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26357>

Linus Torvalds <torvalds@osdl.org> writes:

> For me, performance has always been one of the primary goals, but being 
> able to trust the end result has been even _more_ primary.

Agreed, violently ;-).


-- 
VGER BF report: U 0.735423
