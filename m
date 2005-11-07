From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sun, 06 Nov 2005 16:08:57 -0800
Message-ID: <7virv5wc86.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
	<7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
	<7vy84249re.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511060816390.3316@g5.osdl.org>
	<7v7jbly1lh.fsf@assigned-by-dhcp.cox.net>
	<20051106221952.GP1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 01:09:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYuZL-0003eR-O6
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 01:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKGAI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKGAI7
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 19:08:59 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22723 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932377AbVKGAI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 19:08:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107000828.MMQM4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 19:08:28 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051106221952.GP1431@pasky.or.cz> (Petr Baudis's message of
	"Sun, 6 Nov 2005 23:19:52 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11240>

Petr Baudis <pasky@suse.cz> writes:

> You are also going to break the porcelains (w/o manual user
> intervention), so I'm not happy about it but if you are doing it, do it
> now, please. :-)

I thought Porcelains and people's script can just say 'git foo'
everywhere where it currently says 'git-foo', and it should work
before and after the change, and that is what I did to my
private scripts.  But you are right, it is nicer if 'git-foo'
continued to work with a single patch to cg-Xlib or somewhere
central like that.

> BTW, can I easily get the patch from the 'git' tool, so that I can
> extend $PATH appropriately during Cogito initialization?

Do you mean 'git --show-git-libdir' or something like that?
