From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-pull.sh's bad mode
Date: Tue, 8 Nov 2005 20:39:03 +0100
Message-ID: <20051108193903.GH16512@pasky.or.cz>
References: <E1EZUK2-0005EG-56@jdl.com> <7v4q6njecr.fsf@assigned-by-dhcp.cox.net> <20051108163546.GC1431@pasky.or.cz> <7vhdaney4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 20:43:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZZJF-00086P-Hu
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 20:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbVKHTjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 14:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbVKHTjG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 14:39:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54482 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965298AbVKHTjF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 14:39:05 -0500
Received: (qmail 26105 invoked by uid 2001); 8 Nov 2005 20:39:03 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdaney4d.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11353>

Dear diary, on Tue, Nov 08, 2005 at 08:30:10PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> You could perhaps do "make" without install and set PATH to
> include the source directory (you need to do a bit more if we
> ever update templates/ directory and you would want to try it). 

That's what I do.

> The point is that git-pull was generated with +x from
> git-pull.sh, and the mode bits of git-pull.sh (source) does not
> matter anymore.  It used to matter back when we called them
> git-*-script but not these days.

Ah so. I see. Well, still useful when I'm changing something and I'm
lazy to remake after each change. ;-)

Either way, it should be consistent for all the scripts - either +x or
-x (but yes, definitely not a brown paper bag thing :).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
