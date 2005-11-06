From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 09:23:38 +0100
Message-ID: <20051106082338.GN1431@pasky.or.cz>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <200511060312.jA63CUcv010887@inti.inf.utfsm.cl> <20051106050049.GA5910@vrfy.org> <7v4q6q5ock.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 09:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYfor-00078u-IG
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 09:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVKFIXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 03:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVKFIXl
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 03:23:41 -0500
Received: from w241.dkm.cz ([62.24.88.241]:65186 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932324AbVKFIXk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 03:23:40 -0500
Received: (qmail 26851 invoked by uid 2001); 6 Nov 2005 09:23:38 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q6q5ock.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11195>

Dear diary, on Sun, Nov 06, 2005 at 06:36:59AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> > Note that "libexec" is not LSB conform - whatever that means, but it
> > should probably not be used for new projects. It states: "Applications
> > may use a single subdirectory under /usr/lib."
> 
> I had an impression that there are still UNIXy systems that are
> not even Linux; do they follow LSB and drop libexec?

At least BSDs still seem to have libexec, but they are just as likely to
have lib, I would say, while on Linux it is going away (not that I would
be excited about it). So we could either make this per-system, or
default to something that is going to be present everywhere (lib),
I think.

-- 
			Petr "Pasky libdir=$(prefix)/lib/cogito" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
