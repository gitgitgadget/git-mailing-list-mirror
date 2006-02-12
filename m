From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Optimization for git-rev-list --objects
Date: Sat, 11 Feb 2006 18:39:03 -0800
Message-ID: <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 03:39:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F878m-0007lg-Tm
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 03:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBLCjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 21:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBLCjF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 21:39:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29584 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932193AbWBLCjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 21:39:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212023909.NZYS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 21:39:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 11 Feb 2006 18:19:09 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15971>

Linus Torvalds <torvalds@osdl.org> writes:

> Hmm? That would be a lot faster than what we have now, I suspect, and none 
> of the ops are expensive.
>
> Anybody want to try this approach?

I am game.  I was looking at Johannes' patch that uses growing
circular hash and having the same thought.
