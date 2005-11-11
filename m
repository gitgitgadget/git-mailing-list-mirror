From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-admin-setuprepo fails to make a cg-clone'able repo
Date: Fri, 11 Nov 2005 01:13:33 +0100
Message-ID: <20051111001333.GH30496@pasky.or.cz>
References: <86wtjg31lo.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 01:14:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMY0-0005Jd-0I
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVKKANg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 19:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVKKANg
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:13:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21961 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932267AbVKKANf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 19:13:35 -0500
Received: (qmail 27741 invoked by uid 2001); 11 Nov 2005 01:13:33 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86wtjg31lo.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11542>

Dear diary, on Thu, Nov 10, 2005 at 05:32:35PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> Repeat by:
> 
>         cg-admin-setuprepo repo
>         cg-clone $(PWD)/repo myview

You should cg-init locally, then cg-admin-setuprepo the public one and
push to it. I updated cg-admin-setuprepo's description wrt. that now.

> Results:
> 
>     defaulting to local storage area
>     Hard links don't work - using copy
>     cp: illegal option -- b
>     usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
>            cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
>     cg-fetch: unable to get the HEAD branch
>     cg-clone: fetch failed

But this is actually an entirely unrelated bug, it seems - pretty
strange.  I revived another few months old thread because of this, since
it seems the 'b' was actually a typo and we don't want to pass 'cp' this
argument at all, but something different. Does cloning locally otherwise
work?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
