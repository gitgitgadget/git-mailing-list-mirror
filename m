From: Petr Baudis <pasky@suse.cz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Fri, 21 Oct 2005 11:15:51 +0200
Message-ID: <20051021091551.GE30889@pasky.or.cz>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz> <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 11:16:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESt0c-0001oG-Tz
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 11:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVJUJPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 05:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbVJUJPz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 05:15:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28556 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964844AbVJUJPz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 05:15:55 -0400
Received: (qmail 4228 invoked by uid 2001); 21 Oct 2005 11:15:51 +0200
To: "Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <4358597A.6000306@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10428>

Dear diary, on Fri, Oct 21, 2005 at 04:59:06AM CEST, I got a letter
where "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> told me that...
> Almost. No, truly, I'm very impressed with git-merge.sh, which first 
> does the simple git-read-tree -m, and it can then try several merger 
> scripts to resolve the index. The "smartest" merge resolver we have 
> follows renames, but we could have language-specific and 
> project-specific resolvers, for instance.

Yes, following renames is nice. But as long as it is three-way, it
suffers of inherent and rather nasty problems. Well, I'm watching the
weave merge effort and plan to give it a try to port it to GIT when I
have some time.

> If you combine the coolness of git-merge.sh with the fact that cg-merge 
> right now is buggy[*]... I'm starting to rely on doing cg-fetch and 
> running git-merge.sh by hand.
> 
> * I just merged your latest fixes, knowing that they'd conflict on 
> cg-fetch, but the merge didn't say a thing a bout cg-fetch, and only 
> complained like this:
> 
>    MERGE ERROR: : Not handling case  ->  ->
> 
> But there were no conflicts at all in the tree! It seems to be that it's 
> dropping the upstream changes it doesn't like.

There was a bug in argument parsing of cg-Xmergefile, already fixed now.

Well, it's true that cg-Xmergefile still does not handle all merge
cases, but it certainly will not be silent about it, at least. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
