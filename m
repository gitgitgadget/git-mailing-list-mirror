From: Petr Baudis <pasky@ucw.cz>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 12:35:19 +0200
Message-ID: <20050422103519.GB14565@pasky.ji.cz>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org> <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org> <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 12:31:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOvR2-0004f8-GQ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 12:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDVKf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 06:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVDVKfZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 06:35:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29078 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261281AbVDVKfV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 06:35:21 -0400
Received: (qmail 4692 invoked by uid 2001); 22 Apr 2005 10:35:19 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 08:23:41AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
>  - Further admit that to support it without core layer help,
>    what Cogito layer needs to do involves quite a lot of "yuck"
>    factor.

I actually thought that I would just walk to parent directories at the
time of invocation, to find the .git directory, then save that to
$gitdir and use that to always reference to it, setting also
GIT_INDEX_FILE etc. I basically just postponed this until I have some
kind of library or something, and do all this stuff in a single common
init routine. I think it should be doable pretty well in Cogito alone,
but of course I won't mind if someone does it in git core. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
