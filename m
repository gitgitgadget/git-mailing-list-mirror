From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Silent File Mods Being Committed
Date: Thu, 23 Mar 2006 22:47:10 +0100
Message-ID: <20060323214710.GV18185@pasky.or.cz>
References: <E1FMH3o-0001B5-Dw@jdl.com> <7vek0t68we.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 22:46:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMXdh-00029i-3T
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWCWVqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWCWVqi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:46:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:65188 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964942AbWCWVqh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 16:46:37 -0500
Received: (qmail 1534 invoked by uid 2001); 23 Mar 2006 22:47:10 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek0t68we.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17876>

Dear diary, on Thu, Mar 23, 2006 at 06:13:21AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  (2) audit all the scripts to make sure they do not get upset if
>      we add trailing +/- to the status letter, and do that
>      unconditionally, like the attached patch does.

Cogito will get upset since we assume the mode field is one-char in our
regexps, and when we don't, we compare the mode field with strings and
that would obviously fail if you add random stuff to it.

Otherwise, I like this idea, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
