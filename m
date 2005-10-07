From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 01:45:47 +0200
Message-ID: <20051007234547.GC8893@steel.home>
References: <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <7vfyrdyre5.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 01:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1v1-0007pF-Cw
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVJGXp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJGXp4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:45:56 -0400
Received: from devrace.com ([198.63.210.113]:25359 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964883AbVJGXpz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 19:45:55 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j97NwEbF081497;
	Fri, 7 Oct 2005 18:58:14 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EO1uN-0006cl-00; Sat, 08 Oct 2005 01:45:47 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EO1uN-00027u-It; Sat, 08 Oct 2005 01:45:47 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyrdyre5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.1 required=4.5 tests=AWL,BAYES_05,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9830>

Junio C Hamano, Fri, Oct 07, 2005 23:00:02 +0200:
> > "Sounds like a thinly veiled threat or a very effective prodding" 8)
> > ---
> >
> > Make read_cache copy the index into memory, to improve portability on
> > other OS's which have mmap too, tend to use it less commonly.
> >
> 
> Huh?  where is your memcpy?
> 

Junio, unless there already are pressing reasons to put the patch in
GIT, could you postpone its inclusion (if you ever considered)? Or at
least put "#ifdef __cygwin" (I hope this is the define) around it?

It just so ugly... And besides, GIT reportedly works without problems
for many people even without it.

Anyway, the patch is out, so anyone with the problems can just patch
their copy to workaround this specific win2k problem.

Thanks,
Alex
