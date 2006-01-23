From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Subprojects
Date: Mon, 23 Jan 2006 01:50:56 +0100
Message-ID: <20060123005056.GV28365@pasky.or.cz>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de> <7vek37rj83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 01:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0ptd-0000Al-3r
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 01:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWAWAtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 19:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWAWAtW
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 19:49:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49561 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964791AbWAWAtV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 19:49:21 -0500
Received: (qmail 1555 invoked by uid 2001); 23 Jan 2006 01:50:56 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek37rj83.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15069>

Dear diary, on Mon, Jan 16, 2006 at 09:49:48PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>    We could introduce "bind the rest" to make write-tree write
>    out a tree that contains only the containing project part and
>    not any of the subproject part (e.g. Makefile, README and
>    src/ but not linux-2.6/ nor gcc-4.0/ in the earlier example).
>    Essentially the contents of such a tree object would be the
>    same as what "gitlink" approach would have had for the
>    containing project in the index file, minus "gitlink" entries
>    themselves).  This is not so surprising, because the missing
>    information "gitlink" approach recorded in the tree object
>    itself is expressed on "bind" lines in the commit object with
>    this approach.

Now, I must have missed the obvious again, but what is the point in
having the write-tree --exclude stuff? My impression (also from your
later mail in this thread) is that now the moment you introduce any
binds, your top-level development changes to "two-tiered" - the
top-level project and the meta-project holding it all together. I'd say
that's pretty confusing and I don't see big gain in this; the simplicity
of the original proposal was a lot more appealing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
