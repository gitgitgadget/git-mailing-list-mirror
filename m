From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Mon, 7 Nov 2005 01:43:46 +0100
Message-ID: <20051107004346.GR1431@pasky.or.cz>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org> <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org> <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net> <20051106221952.GP1431@pasky.or.cz> <7virv5wc86.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 01:44:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYv75-0002Uy-Hw
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 01:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVKGAnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVKGAns
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 19:43:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51404 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932288AbVKGAns (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 19:43:48 -0500
Received: (qmail 18845 invoked by uid 2001); 7 Nov 2005 01:43:46 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virv5wc86.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11242>

Dear diary, on Mon, Nov 07, 2005 at 01:08:57AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > You are also going to break the porcelains (w/o manual user
> > intervention), so I'm not happy about it but if you are doing it, do it
> > now, please. :-)
> 
> I thought Porcelains and people's script can just say 'git foo'
> everywhere where it currently says 'git-foo', and it should work
> before and after the change, and that is what I did to my
> private scripts.  But you are right, it is nicer if 'git-foo'
> continued to work with a single patch to cg-Xlib or somewhere
> central like that.

I want to avoid extra fork()s and exec()s. They seem to routinely matter
in orders of magnitude of speed in tight loops.

Besides, I'm more used to the dash form. ;-)

> > BTW, can I easily get the patch from the 'git' tool, so that I can
> > extend $PATH appropriately during Cogito initialization?
> 
> Do you mean 'git --show-git-libdir' or something like that?

Yes. Well... you said you have the gitdir changes in your 'pu' branch,
but http://www.kernel.org/git/?p=git/git.git;a=tree;h=pu;hb=pu doesn't
appear to have the changes...?

Is --show-git-libdir already implemented?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
