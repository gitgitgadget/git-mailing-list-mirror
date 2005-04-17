From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [2.1/5] Add merge-base
Date: Sun, 17 Apr 2005 23:21:16 +0200
Message-ID: <20050417212116.GK1461@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171251150.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 23:17:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNH8y-0004G7-0i
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 23:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDQVVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDQVVT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 17:21:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49303 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261467AbVDQVVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 17:21:17 -0400
Received: (qmail 18384 invoked by uid 2001); 17 Apr 2005 21:21:16 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171251150.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 06:51:59PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> merge-base finds one of the best common ancestors of a pair of commits. In
> particular, it finds one of the ones which is fewest commits away from the
> further of the heads.
> 
> Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Note that during merge with Linus (probably the most complicated I've
got so far, but still thankfully not too painful thanks to the rej
tool) I've decided to revert your merge-base in favour of Linus'
version. I did this mainly to make me merging Linus less awful; we
should probably clean it up first and decide which solution to go for in
the first place before possibly replacing it again, I think.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
