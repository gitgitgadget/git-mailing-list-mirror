From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] fix bug in read-cache.c which loses files when merging a tree
Date: Mon, 18 Apr 2005 23:58:20 +0200
Message-ID: <20050418215819.GH5554@pasky.ji.cz>
References: <1113848239.4998.45.camel@mulgrave> <Pine.LNX.4.58.0504181219480.15725@ppc970.osdl.org> <1113854941.4998.61.camel@mulgrave> <Pine.LNX.4.58.0504181330450.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeCE-0005eg-Sh
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDRV6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDRV6X
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:58:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15023 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261178AbVDRV6W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 17:58:22 -0400
Received: (qmail 3876 invoked by uid 2001); 18 Apr 2005 21:58:20 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504181330450.15725@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 11:19:46PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> I suspect that I should just pass in the SHA1 of the files to the
> "merge-one-file-script" from "merge-cache", rather than unpacking it.  
> After all, the merging script can do the unpacking itself with a simple
> "cat-file blob $sha1".

So, I'm confused. Why did you introduce unpack-file instead of doing
just this?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
