From: Petr Baudis <pasky@ucw.cz>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sun, 17 Apr 2005 01:37:24 +0200
Message-ID: <20050416233724.GP19099@pasky.ji.cz>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 01:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwnP-0004tO-Ru
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVDPXhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDPXhb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:37:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11911 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261201AbVDPXhZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:37:25 -0400
Received: (qmail 15794 invoked by uid 2001); 16 Apr 2005 23:37:24 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 01:27:43AM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Remove mktemp usage - it doesn't work on
> some Mandrakes, nor on my SuSE 8.2 with
> mktemp-1.5-531.
> 
> Replace with simple use of $$ (pid).
> I've been using this same pattern for
> 20 years on many production scripts;
> it's fast, solid and simple.

And racy. And not guaranteed to come up with fresh new files.

> More robust tmp file removal, using trap,
> so that scripts interrupted by signals
> HUP, INT, QUIT or PIPE will cleanup.

But I like this!

I'm deferring those changes to the introduction of a git shell library,
which several people volunteered to do so far, but noone sent me any
patches for (the last one was probably Martin Mares, only few hours ago
though).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
