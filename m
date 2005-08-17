From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive we are
Date: Tue, 16 Aug 2005 19:00:51 -0700
Message-ID: <7vwtml490s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
	<7vll315u3w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
	<7vhddp5sfz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161803250.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:02:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5DEe-00010c-8Y
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 04:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVHQCAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 22:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVHQCAx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 22:00:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:50106 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750792AbVHQCAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 22:00:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817020052.DJPH17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 22:00:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161803250.3553@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 Aug 2005 18:06:34 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Mostly done. It actually works from inside subdirectories, but "." at the
> top-level is still not done. Small detail. Will fix later. But it would
> help if you would apply this, since I'm going to be off for dinner..

Merged, pushed out, and tested.  Ouch.  Fails on t0000 test.

Next time I'll do merge, test, reject and push out, in that
order.
