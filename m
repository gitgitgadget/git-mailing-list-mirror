From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-changes-script to show inter tree changes
Date: Sun, 24 Apr 2005 01:09:37 +0200
Message-ID: <20050423230937.GF13222@pasky.ji.cz>
References: <1114281792.5068.10.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 01:04:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTgD-0002L8-Ki
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVDWXJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDWXJk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:09:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60599 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262160AbVDWXJi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:09:38 -0400
Received: (qmail 29342 invoked by uid 2001); 23 Apr 2005 23:09:37 -0000
To: James Bottomley <James.Bottomley@SteelEye.com>
Content-Disposition: inline
In-Reply-To: <1114281792.5068.10.camel@mulgrave>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 08:43:12PM CEST, I got a letter
where James Bottomley <James.Bottomley@SteelEye.com> told me that...
> One of the features I found most useful about bk changes was the ability
> to see changes in my tree that weren't in the other tree (I use this to
> keep track of what patches I actually have).
> 
> I've modified the gitlog script to take the -L and -R options (local
> directories only; won't work on remotes like bk changes would) to add
> this functionality.

Linus isn't probably the right person to Cc on this, since this is
git-pasky thing.  Can you please post it as a signed-off patch?

I don't get what are you doing anyway. I don't know the "bk changes"
tool. Can't you just do

	git log theothertree yourtree

?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
