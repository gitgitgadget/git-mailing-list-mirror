From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make git diff-generation use a simpler spawn-like interface
Date: Sun, 26 Feb 2006 16:25:27 -0800
Message-ID: <7v7j7h6420.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602261547440.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 01:25:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDWCk-00053c-A0
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWB0AZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWB0AZb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:25:31 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19446 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751458AbWB0AZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 19:25:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227002351.UECA6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 19:23:51 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602261547440.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 26 Feb 2006 15:51:24 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16812>

Linus Torvalds <torvalds@osdl.org> writes:

> This actually ends up simplifying the code, and should make it much
> easier to make it efficient under broken operating systems (read: Windows).
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> Now, somebody else might disagree with my contention that this also makes 
> things simpler, but I like how we separate out the "run an external 
> program" phase from the actual setup and header printing phase.

I agree this is going in the right direction.

A note that is offtopic to this particular patch but is related
to Andrew's point.  I had a wrong version of pre-applypatch hook
in the sample shipped as "templates", and after I rebuilt my
private development repository I've been running with the
version without a fix I personally had.  I've pushed out the fix
in the master branch.

I'll look at your patch to git-apply next.
