From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Fri, 10 Feb 2006 21:50:54 -0800
Message-ID: <7vslqqo341.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602102032410.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 06:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7nes-0001WM-JJ
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 06:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWBKFu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 00:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBKFu4
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 00:50:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45046 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751207AbWBKFuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 00:50:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211054737.JHTH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 00:47:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602102032410.3691@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 10 Feb 2006 20:37:26 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15930>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, we should print out the other "stages" too - the checkout in 
> particular can be a big part of the overhead, and it would probably make 
> sense to tell people about the fact that "hey, now we're checking the 
> result out, we're not actually trying to destroy your disk".

Would you suggest doing that with "checkout-index -v", that
shows "1 path1\r2 path2\r3 path3\r...\rDone.\n"?
