From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Cogito Tutorial If It Helps
Date: Tue, 26 Apr 2005 23:40:38 +0200
Message-ID: <20050426214038.GP13224@pasky.ji.cz>
References: <1114548747.3083.1.camel@kryten> <20050426211834.GO13224@pasky.ji.cz> <1114551403.3083.3.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:36:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXiZ-0004Xx-TU
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVDZVkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDZVkw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:40:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18065 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261803AbVDZVkj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:40:39 -0400
Received: (qmail 14177 invoked by uid 2001); 26 Apr 2005 21:40:38 -0000
To: James Purser <purserj@ksit.dynalias.com>
Content-Disposition: inline
In-Reply-To: <1114551403.3083.3.camel@kryten>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 11:36:43PM CEST, I got a letter
where James Purser <purserj@ksit.dynalias.com> told me that...
> On Wed, 2005-04-27 at 07:18, Petr Baudis wrote:
> > cg-merge is _not_ like doing cg-diff | cg-patch - that's a dangerous
> > thought, and not true at all. cg-diff | cg-patch will just apply the
> > given diff to your working directory, but it won't record any merging
> > metadata, will often get it very wrong, and you will get to all sorts of
> > other troubles. Just always use cg-merge. And probably pass it -b only
> > when you know what are you doing.
> 
> Thanks for that, I've changed it a little to point out that cg-patch
> should really only be used for small single file patches.

No, you've missed the point. It isn't the size of the change what
matters - cg-patch should handle even huge patches (mostly) fine.  What
matters is that you just did was not merge. It was applying some patch
to your working tree, but not merging branches.

So after doing cg-diff | cg-patch several times, you have your working
tree full of huge local changes (making it impossible to sensibly
cg-merge) and your last commit happenned long ago. Or you commit the
cg-patch results, but your commits are wrong, since they don't carry the
appropriate merge information.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
