From: Junio C Hamano <junkio@cox.net>
Subject: Re: More verbose "git fetch"?
Date: Sat, 03 Jun 2006 22:28:41 -0700
Message-ID: <7v7j3xebg6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606031809550.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 04 07:28:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmlAM-0003WA-8l
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 07:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFDF2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 01:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWFDF2n
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 01:28:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3271 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750945AbWFDF2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 01:28:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604052842.PTXU11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 01:28:42 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21245>

Linus Torvalds <torvalds@osdl.org> writes:

> Has it always spit out those annoying
>
> 	xyz: same as branch 'xyz' of so-and-so-repo
>
> even without "-v"? I thought I killed them at some point, but 
> either they're back, or I'm just confused.

"same" is protected with [ "$verboase" ] only on the tag side
but not on the head side, which I think is a bug.  Will fix.
