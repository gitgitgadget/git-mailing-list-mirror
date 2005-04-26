From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Hash collision count
Date: Tue, 26 Apr 2005 02:00:17 +0200
Message-ID: <20050426000017.GN13467@pasky.ji.cz>
References: <20050423234637.GS13222@pasky.ji.cz> <200504252350.QAA02241@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 01:55:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQDQF-0005DA-FG
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 01:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDZAA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDZAA1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:00:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49128 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261182AbVDZAAT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 20:00:19 -0400
Received: (qmail 7490 invoked by uid 2001); 26 Apr 2005 00:00:17 -0000
To: Tom Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <200504252350.QAA02241@emf.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 01:50:31AM CEST, I got a letter
where Tom Lord <lord@emf.net> told me that...
> 
>   From: Petr Baudis <pasky@ucw.cz>
> 
>   Pasky:
> 
>   > No, a collision is pretty common thing, actually. It's the main power of
>   > git, actually - when you do read-tree, modify it and do write-tree
>   > (typically when doing commit), everything you didn't modify (99% of
>   > stuff, most likely) is basically a collision - but it's ok since it
>   > just stays the same.
> 
> That is not the way people ordinarily use the word "collision".
> It's pretty much the opposite of the normal way, actually.

You need to quote me in the context of Jeff Garzik's

> > Third, a data check only occurs in the highly unlikely case that a hash
> > already exists -- a collision.  Rather than "trillions of times", more
> > like "one in a trillion chance."

I just wanted to point out that the data check would hahve to occur
everytime you didn't modify an object.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
