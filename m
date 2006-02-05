From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix git-rev-parse over-eager errors
Date: Sun, 05 Feb 2006 12:11:50 -0800
Message-ID: <7vpsm1h8ft.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	<Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
	<cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
	<Pine.LNX.4.64.0602020027400.21884@g5.osdl.org>
	<7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051155460.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 21:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5qEq-0004Hs-1Z
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBEUL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWBEUL5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 15:11:57 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62606 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750707AbWBEUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 15:11:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205201018.XDWN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 15:10:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602051155460.3854@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 5 Feb 2006 11:58:34 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15637>

Linus Torvalds <torvalds@osdl.org> writes:

> Using "--verify" together with "--no-flags" makes perfect sense, but 
> git-rev-parse would complain about it when it saw a flag, even though it 
> would never actually use/output that flag.

Ah, makes sense.
