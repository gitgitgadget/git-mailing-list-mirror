From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Wed, 18 May 2005 23:33:09 +0200
Message-ID: <20050518213309.GD10358@pasky.ji.cz>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz> <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net> <20050517203500.GH7136@pasky.ji.cz> <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net> <20050517213752.GO7136@pasky.ji.cz> <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed May 18 23:33:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYW9o-0002yr-0R
	for gcvg-git@gmane.org; Wed, 18 May 2005 23:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVERVdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 17:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVERVdX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 17:33:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34444 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262384AbVERVdL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 17:33:11 -0400
Received: (qmail 7330 invoked by uid 2001); 18 May 2005 21:33:09 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 18, 2005 at 12:13:32AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> But that won't work good enough for me. E.g. when committing in a
> PB> subdirectory, I want to commit only changes made in the subdirectory,
> PB> etc.
> 
> Assuming that you have something that lets you commit selected
> files when you are at the top level (say cg-commit), and further
> assuming that today it only works from the toplevel, that is:
> 
>     $ pwd
>     /usr/src/linux
>     $ cg-commit fs/ext?/Makefile
> 
> works today, what I am saying is:
> 
>     $ pwd
>     /usr/src/linux/fs
>     $ git-run-with-user-path cg-commit -- ext?/Makefile
> 
> would work.

Yes. But if you do just cg-commit in the subdirectory, it won't work.
You could pass the original directory in some environment variable or
whatever, but I think that's just not worth the trouble for Cogito -
it's much easier for it when you just stay in the directory you are in
and instead set the environment variables so that the git toolkit DTRT.
(I like this acronym. :-)

> BTW, I am wondering if your choice of cg-commit as an example
> (as opposed to something else like diff or add) is a flamebait
> or just an innocent random example ;-)?

It was completely innocent. :-) How would it be a flamebait?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
