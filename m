From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 02 Sep 2006 17:32:11 -0700
Message-ID: <7vslj9yelw.fsf@assigned-by-dhcp.cox.net>
References: <20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
	<7vodty1swz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021720500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 09:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJmog-00077f-AK
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 09:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWICHyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWICHyP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 03:54:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54407 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751789AbWICAcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 20:32:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903003203.CVIE21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 20:32:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HcY41V00C1kojtg0000000
	Sat, 02 Sep 2006 20:32:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609021720500.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 2 Sep 2006 17:27:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26364>

Linus Torvalds <torvalds@osdl.org> writes:

> I have to say, that adding another pack-objects-specific flag to rev-list 
> doesn't necessarily strike me as very nice.
>
> It might be much better to just teach "git pack-objects" to walk the 
> object list by hand. The whole "git-rev-list | git-pack-objects" approach 
> made more sense back when git-rev-list was the _only_ think listing 
> objects, but now that we've librarized the whole object listing thing, 
> maybe it's time to avoid the pipeline and just do it inside the packer 
> logic.
>...
> Hmm? Comments?

Yes it all makes perfect sense, though I am a bit too tired to
assess how much work it would involve right now.


-- 
VGER BF report: S 0.993177
