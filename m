From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Sun, 10 Jul 2005 17:06:09 +0200
Message-ID: <20050710150609.GC24249@pasky.ji.cz>
References: <20050708230750.GA23847@buici.com> <7v4qb46dff.fsf@assigned-by-dhcp.cox.net> <20050709011119.GA10981@buici.com> <pan.2005.07.09.21.04.29.263374@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 17:06:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrdNw-0006mm-EQ
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 17:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVGJPGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVGJPGM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 11:06:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65506 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261953AbVGJPGL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 11:06:11 -0400
Received: (qmail 600 invoked by uid 2001); 10 Jul 2005 15:06:09 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.07.09.21.04.29.263374@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 11:04:37PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> >  o Is there a way to force git to apply and safe the rejects?
> 
> Well, you can use "patch -p1 ..." directly, and manually add the files it
> created to the object cache. Personally I wouldn't, if at all possible.

Or you can do cg-patch, which should handle that for you properly as
well.  I think the "no fuzz" approach is hyper-paranoid. I deal with
small or larger fuzz all the time when I'm reordering patches or
applying them to a few hours younger version than they were based on. I
think the restriction it imposes is overly draconian here and doesn't
trust the developer to know what he is doing as much as it should. (And
that's why cg-patch doesn't use git-apply. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
