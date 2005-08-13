From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Sat, 13 Aug 2005 14:08:16 +0200
Message-ID: <20050813120815.GC5608@pasky.ji.cz>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 14:09:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3uoz-0007gu-Gx
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 14:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVHMMIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 08:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVHMMIX
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 08:08:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20233 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932154AbVHMMIX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 08:08:23 -0400
Received: (qmail 9270 invoked by uid 2001); 13 Aug 2005 12:08:16 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 11:09:13AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> It was a mistake to use GIT_ALTERNATE_OBJECT_DIRECTORIES
> environment variable to specify what alternate object pools to
> look for missing objects when working with an object database.
> It is not a property of the process running the git commands,
> but a property of the object database that is partial and needs
> other object pools to complete the set of objects it lacks.
> 
> This patch allows you to have $GIT_OBJECT_DIRECTORY/info/alt
> file whose contents is in exactly the same format as the
> environment variable, to let an object database name alternate
> object pools it depends on.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

What about calling it rather info/alternates (or info/alternate)? It
looks better, sounds better, is more namespace-ecological tab-completes
fine and you don't type it that often anyway. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
