From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add a "git show" command to show a commit
Date: Sun, 05 Feb 2006 16:25:49 -0800
Message-ID: <7vpsm1coz6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	<Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
	<cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
	<Pine.LNX.4.64.0602020027400.21884@g5.osdl.org>
	<7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
	<7vd5i1h1bx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602051451360.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602051458460.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 06 01:25:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5uCY-0007lP-FN
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 01:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBFAZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 19:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWBFAZv
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 19:25:51 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43492 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750819AbWBFAZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 19:25:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206002448.LXUE3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 19:24:48 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602051458460.3854@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 5 Feb 2006 14:59:37 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15645>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 5 Feb 2006, Linus Torvalds wrote:
>> 
>> You're right. The "--cc" should be in the default flags (instead of -p), 
>> not unconditionally on the command line.
>
> In that vein, for "git diff":

Yes, except that would break "git diff HEAD" ;-).  Only
diff-tree and diff-files understands --cc.  It means slightly
different thing for diff-files, but I do not think the
difference would matter (it shows unmerged case nicer).

I'll fix it up.
