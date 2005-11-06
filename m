From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 23:19:52 +0100
Message-ID: <20051106221952.GP1431@pasky.or.cz>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org> <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org> <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 23:21:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYsrl-0004JB-Lx
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVKFWTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKFWTz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:19:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56003 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932308AbVKFWTy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 17:19:54 -0500
Received: (qmail 13893 invoked by uid 2001); 6 Nov 2005 23:19:52 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11232>

Dear diary, on Sun, Nov 06, 2005 at 09:15:38PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Right now, for a 1.0 release, I suspect that the "put the git binaries 
> > somewhere else" just isn't worth it. It will break existing scripts that 
> > use the binaries directly (we've already broken the kernel.org snapshot 
> > scripts about a million times with just _renaming_ the binaries ;)
> 
> Although I _really_ wanted a 1.0 soonish, I personally feel that
> this change is better done now than later, if we are eventually
> going to do it anyway.  "Never" _might_ be better than "now",
> but I suspect "later" or "post 1.0" is worse.

You are also going to break the porcelains (w/o manual user
intervention), so I'm not happy about it but if you are doing it, do it
now, please. :-)

BTW, can I easily get the patch from the 'git' tool, so that I can
extend $PATH appropriately during Cogito initialization?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
