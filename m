From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-clone progress: finishing touches.
Date: Sun, 12 Feb 2006 13:50:04 -0800
Message-ID: <7vu0b48cxf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org>
	<7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602121230370.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 22:50:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8P6h-0006lH-3h
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 22:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWBLVuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 16:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWBLVuH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 16:50:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1665 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751467AbWBLVuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 16:50:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212214653.DAAZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 16:46:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121230370.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Feb 2006 12:37:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16020>

Linus Torvalds <torvalds@osdl.org> writes:

> ssh will only set up a pty pair if it starts an interactive shell, not if 
> you use the "ssh host cmd" form.

True.  Or we _could_ use "ssh -t", but I've decided to make
progress the default.  If some script wants quiet behaviour they
can say 'pack-objects -q'.
