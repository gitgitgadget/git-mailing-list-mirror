From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Sun, 25 Jun 2006 17:27:27 +0200
Message-ID: <20060625152727.GH21864@pasky.or.cz>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 17:27:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuWWL-0008Bg-1P
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 17:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWFYP13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFYP13
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 11:27:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14479 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932435AbWFYP13 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 11:27:29 -0400
Received: (qmail 16438 invoked by uid 2001); 25 Jun 2006 17:27:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk676orjy.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22632>

Dear diary, on Sun, Jun 25, 2006 at 05:14:09AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> > This is not really meant for an application yet since it's not clear
> > if it will alone help anything.

It appears that it did have helped and all went well, according to dst_.

> I would question why the rest of git is not built with Sun CC as
> well if that is the case.

< dst_> Three points: (1) Gcc comes along with solaris, sun cc not.
< dst_> (2) Git used a lot of GCC'isms whan I last checked a few weeks ago
< dst_> (3) a lot of other software will not ompile out of the box with suncc, so gcc is usually the safer choice

Of course (1) is troublesome since this means you can't build Git on
Solaris without installing Sun CC - I have no other answer to this than
that Solaris is horribly broken. :-( Perhaps ExtUtils::MakeMaker could
be convinced to build with gcc, I'm not sure.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
