From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix git-rev-parse over-eager errors
Date: Sun, 05 Feb 2006 22:20:58 -0800
Message-ID: <7vr76hatyt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	<Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
	<cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
	<Pine.LNX.4.64.0602020027400.21884@g5.osdl.org>
	<7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051155460.3854@g5.osdl.org>
	<7vpsm1h8ft.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602051355430.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 07:21:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5zkI-0000Ta-A4
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 07:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWBFGVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 01:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWBFGVB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 01:21:01 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:59364 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751024AbWBFGVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 01:21:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206061813.ELFU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 01:18:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602051355430.3854@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 5 Feb 2006 14:03:43 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15650>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I think the exact same holds true for the "show_file()" case.
>
> You had added a special-case for a similar problem (the "lstat()" check) 
> to disable the check when the path wasn't actually printed out. Strictly 
> speaking, I think that should be handled the same way wrt "verify" too.
>
> Ie something like this.
>
> Comments?

Applied, thanks.
