From: Petr Baudis <pasky@suse.cz>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 18:02:46 +0200
Message-ID: <20060414160246.GZ27689@pasky.or.cz>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 18:02:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUQkb-0005l8-Li
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 18:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWDNQCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWDNQCV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 12:02:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47513 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751263AbWDNQCU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 12:02:20 -0400
Received: (qmail 21129 invoked by uid 2001); 14 Apr 2006 18:02:46 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18689>

Dear diary, on Fri, Apr 14, 2006 at 11:31:36AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Here is a list of topics in the recent git traffic that I feel
> inadequately addressed.  I've commented on some of them to give
> people a feel for what my priorities are.  Somebody might want
> to rehash the ones low on my priority list to conclusion with a
> concrete proposal if they cared about them enough.  The list is
> *not* ordered in any way.

Nice summary!

> * Message-ID: <tnxmzf9sh7k.fsf@arm.com>
>   git could use diff3 instead of merge which is a wrapper around
>   diff3. (Catalin Marinas)
> 
>   If having "diff3" is a lot more common than having "merge", I
>   do not have problem with this; "merge" being a wrapper to
>   "diff3", people who have been happy with the current code
>   would certainly have "diff3" installed so changing to "diff3"
>   would not break them.

I've decided to bite the bullet and made Cogito use diff3 instead of
merge as of now. Let's see if anybody complains...

> * Message-ID: <1143856098.3555.48.camel@dv>
>   Per branch property, esp. where to merge from (Pavel Roskin)
> 
>   This involves user-level "world model" design, which is more
>   Porcelainish than Plumbing, and as people know I do not do
>   Porcelain well; interested parties need to come up with what
>   they want and how they want to use it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
