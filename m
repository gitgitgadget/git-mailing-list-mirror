From: Junio C Hamano <junkio@cox.net>
Subject: Re: prune/prune-packed
Date: Sat, 21 Oct 2006 21:59:20 -0700
Message-ID: <7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
References: <20061022035919.GA4420@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 06:59:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbVQj-0001uB-Ms
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 06:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJVE7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 00:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJVE7W
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 00:59:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18683 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422985AbWJVE7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 00:59:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022045920.FTZK18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 00:59:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dGzQ1V00A1kojtg0000000
	Sun, 22 Oct 2006 00:59:24 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20061022035919.GA4420@fieldses.org> (J. Bruce Fields's message
	of "Sat, 21 Oct 2006 23:59:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29709>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Both "man prune" and everyday.txt say that git-prune also runs
> git-prune-packed.  But that doesn't seem to be true.  Is the bug in the
> documentation?

I think it is a regression when prune was rewritten as a
built-in.
