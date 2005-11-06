From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sun, 06 Nov 2005 12:15:38 -0800
Message-ID: <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
	<7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
	<7vy84249re.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511060816390.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 21:15:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYqvZ-0004T6-Gi
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 21:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKFUPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKFUPm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 15:15:42 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57289 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751203AbVKFUPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 15:15:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106201456.TSSV29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 15:14:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 6 Nov 2005 08:20:41 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11226>

Linus Torvalds <torvalds@osdl.org> writes:

> Right now, for a 1.0 release, I suspect that the "put the git binaries 
> somewhere else" just isn't worth it. It will break existing scripts that 
> use the binaries directly (we've already broken the kernel.org snapshot 
> scripts about a million times with just _renaming_ the binaries ;)

Although I _really_ wanted a 1.0 soonish, I personally feel that
this change is better done now than later, if we are eventually
going to do it anyway.  "Never" _might_ be better than "now",
but I suspect "later" or "post 1.0" is worse.
