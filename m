From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 00:30:06 +0200
Message-ID: <20050417223006.GN1461@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <4262DA30.2030500@roemling.net> <20050417150921.58d6db68.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jochen Roemling <jochen@roemling.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:26:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNIDk-0001cJ-4L
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDQWaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVDQWaP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:30:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51608 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261527AbVDQWaI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 18:30:08 -0400
Received: (qmail 23962 invoked by uid 2001); 17 Apr 2005 22:30:06 -0000
To: "Randy.Dunlap" <rddunlap@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050417150921.58d6db68.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 12:09:21AM CEST, I got a letter
where "Randy.Dunlap" <rddunlap@osdl.org> told me that...
> On Sun, 17 Apr 2005 23:50:40 +0200 Jochen Roemling wrote:
> 
> | Linus Torvalds wrote:
> | 
> | >Ie we have two phases to the merge: first get the objects, with something
> | >like
> | >
> | >	repo=kernel.org:/pub/kernel/people/torvalds/linux-2.6.git
> | >	rsync --ignore-existing -acv $(repo)/ .git/
> | >  
> | >
> | Could you place a tarball there for people like me who are no "real" 
> | kernel hackers and don't have a kernel.org account? Or is there an 
> | "anonymous" account that I'm just to ignorant to know of?
> 
> You don't need a kernel.org account to rsync it... this works too:
> 
> rsync -avz -e ssh --progress --ignore-existing  rsync://rsync.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git/ .git/

Or

	mkdir linux-2.6.git
	cd linux-2.6.git
	RSYNC_FLAGS="--progress --stats" git init rsync://rsync.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git/

which also does the initial checkout for you. ;-) (Requires latest
git-pasky, though.) Then you can bring the latest and greatest to your
tree by a mere git pull.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
