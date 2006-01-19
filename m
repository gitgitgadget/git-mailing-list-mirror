From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Thu, 19 Jan 2006 10:03:48 +0100
Message-ID: <20060119090348.GX28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com> <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net> <7v64ohotjj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:02:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzVgh-0001EE-QR
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 10:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161286AbWASJCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 04:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbWASJCc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 04:02:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25568 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161286AbWASJCb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 04:02:31 -0500
Received: (qmail 25115 invoked by uid 2001); 19 Jan 2006 10:03:48 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64ohotjj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14893>

Dear diary, on Thu, Jan 19, 2006 at 03:12:00AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> (2) letting a subproject keep its own independent history that
> does not know about other subprojects even after combination
> happens (as opposed to the coolest merge, after which there is
> no git history that does not have gitk as its part).

Which can be an advantage or disadvantage depending on the situation,
but I suspect that it would be rather a disadvantage here.

> So would Cogito subprojects support (will it be in the 0.17?),

Probably in 0.18. I would have the subprojects support complete when
it's already in, and it will be some work, while I don't want to
postpone 0.17 much anymore. But we'll see. ;)

> but it might look less powerful when compared with the "bind" or
> "gitlink", if it comes in the form of the patch Pasky sent to
> the list, since it does not attempt to tie the versions of two
> projects together.  Certainly that makes it the easiest to use
> and understand what is going on, though.

By now (I wanted to note that in the original thread when I get to make
a new patch), I've decided to extend the format to allow extra
information stored for the subprojects:

	path\t...

This means that I will have to do preprocessing when using this as an
exclude file, but it will let me do the stuff like read-only
subprojects. I could also tie it to a specific version here, but if
gitlink/binds are after all going to get included in Git, I'd rather use
that when it is ready (although the single-git-directory approach does
not make sense to me; but I didn't read part of the thread very
carefully yet).

I think the approaches might be complementary, Cogito subprojects are
just designed for different scenarios than gitlinks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
