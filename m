From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git pull issues...
Date: Sun, 24 Apr 2005 00:00:50 +0200
Message-ID: <20050423220049.GC13222@pasky.ji.cz>
References: <118833cc050423142573729ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 23:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPSbr-0005FI-Ma
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVDWWA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVDWWA7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 18:00:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58550 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261545AbVDWWAv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 18:00:51 -0400
Received: (qmail 20933 invoked by uid 2001); 23 Apr 2005 22:00:50 -0000
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc050423142573729ce2@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 11:25:32PM CEST, I got a letter
where Morten Welinder <mwelinder@gmail.com> told me that...
> Minor issues with "git pull":
> 
> 1. Multiple rsync call might connect to different servers (with
> round-robin DNS).  The effect
>    will be interesting.  One call, if possible, would be better.

If you can do it without overwriting HEAD, please go ahead and send me
the patch. :-)

> 2. If any rsync fails, the process should be aborted.

Fixed.

> As long as we do have multiple calls:
> 
> 3. The "grep -v '^MOTD:'" should be changed to kill blank lines after
> MOTDs also.

Actually, I currently use this as a poor man's progress indicator. ;-)
*hide*

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
