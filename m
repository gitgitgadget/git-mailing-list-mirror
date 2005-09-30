From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 19:36:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291918530.3378@g5.osdl.org>
References: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
 <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org> <7vwtkzb9qo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 04:38:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELAlh-0006VJ-Px
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 04:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVI3Cgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 22:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVI3Cgo
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 22:36:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbVI3Cgn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 22:36:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8U2ac4s009907
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 19:36:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8U2abG7017779;
	Thu, 29 Sep 2005 19:36:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtkzb9qo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9533>



On Thu, 29 Sep 2005, Junio C Hamano wrote:
> 
> Wouldn't underneath pub/scm/ be more appropriate and gitweb
> friendly?

Well, I don't actually have write permissions to anything there except for 
udner the kernel tree. Also, I suspect there aren't all that many uemacs 
users out there, and anybody who isn't already a uemacs user probably 
shouldn't pick it up.

I don't think it has gotten any real development for the last ten years, 
and while it was arguably the best editor twenty years ago (not a lot of 
competition - what else worked on DOS, VMS and UNIX without being crazy 
and modal?) it's definitely showing its age.

So since I already had a uemacs subdirectory, I just put the git archive 
there too.

> Hmph.  I vaguely recall in my distant past when I was still in
> school, I did my own Japanization of microEmacs.  I wonder if
> yours share the same root -- I do not have the source of my
> version anymore so I have no way checking which ancient version
> I mucked with.

It's based on 3.9e, with some fixes by Petri Kutvonen at Helsinki 
University. With various (slight) modernizations by yours truly (eg posix 
termios support rather than the old "termio" stuff).

It _shouldn't_ be that hard to teach it about UTF-8, but every time I look 
at it I realize that there is a lot of stuff that should be improved. 
Converting it to K&R, getting rid of the things that made sense in the 
80's but haven't made sense in ten years, re-indenting it (right now 
it's a strange mix of indentation styles)..

And if you open a binary file with it, it will literally spew binary 
characters to the tty, and can seriously confuse it due to the control 
chars. Or if you have a really long line, it can SIGSEGV on you. Cute.

But dammit, I'm not giving it up.

			Linus
