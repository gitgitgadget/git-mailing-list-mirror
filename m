From: Junio C Hamano <junkio@cox.net>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 02 Dec 2005 12:32:17 -0800
Message-ID: <7v4q5r2qb2.fsf@assigned-by-dhcp.cox.net>
References: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
	<20051202091946.1631.qmail@science.horizon.com>
	<7vacfj6c4l.fsf@assigned-by-dhcp.cox.net>
	<20051202130911.GY8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 21:37:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiHZv-0000fh-Sr
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 21:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVLBUcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVLBUcV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 15:32:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:26498 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751041AbVLBUcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 15:32:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202203100.WIMH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 15:31:00 -0500
To: Sven Verdoolaege <skimo@kotnet.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13124>

Sven Verdoolaege <skimo@kotnet.org> writes:

>> 3. It does not matter; nobody types that command by hand.

I should have said "nobody should need to type that, otherwise
fix your Porcelain".

> I do.  git commit won't let me commit an empty tree, or at
> least I haven't figured out how to make it do that.

You are right, at least for the initial commit (for subsequent
commits it happily commits an empty tree).

Now why anybody would want to it is a different matter.  Is it
because you would want to record that your project started from
scratch, as opposed to some import from an existing non
versioned (or versioned by another SCM) working tree?

> I also used it when, after resolving a merge initiated by
> cg-merge, cogito (or at least the version I had installed
> at the time) wouldn't let me commit it because a new file
> I had pulled in contained non-ascii characters in its name.

That sounds like a simple Porcelain bug and I hope neither
Cogito or git wouldn't have that problem now.
