From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Tue, 6 Jun 2006 20:21:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606062011030.5498@g5.osdl.org>
References: <20060604211931.10117.82695.stgit@machine.or.cz> 
 <20060604212050.GV10488@pasky.or.cz>  <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
  <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
  <20060607000816.GY10488@pasky.or.cz>  <Pine.LNX.4.64.0606061711000.5498@g5.osdl.org>
 <46a038f90606061929i68073677i686a3c1934ed64b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 05:22:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnocG-0005q7-0j
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 05:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFGDVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 23:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFGDVm
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 23:21:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750783AbWFGDVl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 23:21:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k573LV2g002354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 20:21:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k573LUO7013158;
	Tue, 6 Jun 2006 20:21:31 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606061929i68073677i686a3c1934ed64b1@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21426>



On Wed, 7 Jun 2006, Martin Langhoff wrote:
> 
> Why is it not a good default? Unless I expect it to be shorter than
> the terminal, I always tack "| less" after it. Except when I tack ">
> foo.patch" and then the auto-pager knows what to do anyway.

I often tack "| less" after it in some situations, but in other situations 
I _never_ do.

I often use "git diff" as a way to see that my tree is clean. Sure, I 
could do "git status", but if it's not clean, it's usually something 
small, so I want to know what I changed last. At that point, a default 
pager would be very annoying.

The "more" behaviour (which only paginates unto the end) might work for 
me (ie the "git diff" auto-pager would act like "more" or "less -EX")

I dunno.

		Linus
