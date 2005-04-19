From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 00:58:30 +0200
Message-ID: <20050419225830.GH9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
	<Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	<426583D5.2020308@mesatop.com> <20050419222609.GE9305@pasky.ji.cz>
	<7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>, Linus Torvalds <torvalds@osdl.org>,
        Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
        Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
        sensors@Stimpy.netroedge.com
X-From: lm78@Stimpy.netroedge.com Wed Apr 20 00:55:25 2005
Return-path: <lm78@Stimpy.netroedge.com>
Received: from stimpy.netroedge.com ([206.228.191.3])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1cd-0000BE-Li
	for gls-sensors@gmane.org; Wed, 20 Apr 2005 00:55:12 +0200
Received: from Stimpy.netroedge.com (IDENT:lm78@localhost [127.0.0.1])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id j3JN0apv024909;
	Tue, 19 Apr 2005 16:00:36 -0700
Received: (from lm78@localhost)
	by Stimpy.netroedge.com (8.12.10/8.12.8/Submit) id j3JN0YaE024908;
	Tue, 19 Apr 2005 16:00:34 -0700
Received: from machine.sinus.cz (qmailr@w241.dkm.cz [62.24.88.241])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with SMTP id j3JN0Vpv024889
	for <sensors@stimpy.netroedge.com>; Tue, 19 Apr 2005 16:00:32 -0700
Received: (qmail 2813 invoked by uid 2001); 19 Apr 2005 22:58:30 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
X-sensors-spam: ham; 0.03

Dear diary, on Wed, Apr 20, 2005 at 12:45:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> I'm wondering if doing
> 
> PB> if [ "$(show-diff)" ]; then
> PB> 	git diff | git apply
> PB> else
> PB> 	checkout-cache -f -a
> PB> fi
> 
> PB> would actually buy us some time; or, how common is it for people to have
> PB> no local changes whatsoever, and whether relative slowdown of additional
> PB> show-diff to git diff would actually matter.
> 
> "show-diff -s" perhaps.  Also wouldn't it be faster to pipe
> show-diff output (not git diff output) to patch (not git apply)?

Excellent idea, thanks. Changed git merge to do this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
