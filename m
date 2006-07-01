From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 13:07:11 -0700
Message-ID: <7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 01 22:07:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwlkR-0001gy-Cn
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 22:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWGAUHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 16:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWGAUHO
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 16:07:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1171 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751923AbWGAUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 16:07:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701200712.ZXGL19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 16:07:12 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 1 Jul 2006 13:04:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23063>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 1 Jul 2006, Rene Scharfe wrote:
>> 
>> I wonder why the two clear_commit_marks() calls at the end of
>> get_merge_bases() are not sufficient, though.
>
> Why does that thing check for "parent->object.parsed"?

Oh, I thought I fixed that up when I merged.  Sorry.

> Also, it only clears commit marks if they are contiguous, but some commit 
> marking may not be dense (eg, the "UNINTERESTING" mark may have been set 
> by (PARENT1 && PARENT2) triggering, but is not set in the commits that 
> reach it.

That is true.
