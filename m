From: Petr Baudis <pasky@ucw.cz>
Subject: Re: I want to release a "git-1.0"
Date: Fri, 3 Jun 2005 11:47:06 +0200
Message-ID: <20050603094706.GB24873@pasky.ji.cz>
References: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506011742560.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:45:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De8j6-0006Hm-BN
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 11:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFCJr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 05:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFCJr1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 05:47:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56801 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261199AbVFCJrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 05:47:09 -0400
Received: (qmail 25550 invoked by uid 2001); 3 Jun 2005 09:47:06 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506011742560.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 02, 2005 at 12:00:55AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> It shouldn't be hard to do one, except that locking with rsync is going to
> be a pain. I had a patch to make it work with the rpush/rpull pair, but I
> didn't get its dependancies in at the time.

Was that the patch I was replying to recently? It didn't seem to have
any dependencies.

> I can dust those patches off again if you want that functionality included.
> 
> The patches are essentially:
> 
>  - make the transport protocol handle things other than objects
>  - library procedure for locking atomic update of refs files
>  - fetching refs in general
>  - rpull/rpush that updates a specified ref file atomically
> 
> At least the first would be very nice to get in before 1.0, since it is an
> incompatible change to the protocol.

I would like to have this a lot too. Pulling tags now is a PITA, and I
definitively want to go in this way. So it will land at least in git-pb.
:-) (But that's a little troublesome if you say it's incompatible
change.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
