From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive we are
Date: Tue, 16 Aug 2005 17:16:00 -0700
Message-ID: <7vhddp5sfz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
	<7vll315u3w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5BbC-0006Ks-By
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVHQAQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVHQAQD
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:16:03 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42992 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750766AbVHQAQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 20:16:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817001600.YOZV19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 20:16:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161655460.3553@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 Aug 2005 17:01:23 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Do you want to take the current patch (which buys you very little because 
> not a lot of stuff has been set up to deal with it, but is the basis for 
> all future work anyway) or do you want me to polish it up a bit and 
> re-submit the whole thing?

The developement history would look nicer if you did the latter,
but I am easy and can go either way.

> I'd do at least the "git-diff-tree" part and the "./" and "../" handling,
> and convert at least the "git diff" thing to the new world order and away
> from git-sh-setup-script?

Sounds like fun.
