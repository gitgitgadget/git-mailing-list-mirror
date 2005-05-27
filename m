From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Sat, 28 May 2005 00:04:17 +0200
Message-ID: <20050527220417.GC12187@cip.informatik.uni-erlangen.de>
References: <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <7vk6lkwgfl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505271457480.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbmut-0005Pj-1k
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVE0WEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVE0WEg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:04:36 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:64967 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262618AbVE0WEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:04:24 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RM4HS8022515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 22:04:18 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RM4Hol022514;
	Sat, 28 May 2005 00:04:17 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505271457480.17402@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Actually, even that is not actually built into the commit object
> itself, that's just a #define in commit-tree.c.  Change the MAXPARENT
> design from 16 to 1024, and nobody will notice any difference at all,
> except "git-commit-tree.c" will use 20kB more memory ;)

That sounds just way to perfect. :-)

> There's no limit in the data structures, although there clearly is a 
> "sanity" limit (and I personally suspect it comes before you hit 16 ;)

I like how this 'simple' git concepts just fits into all this usage
scenarios. Including this one or the way we can track renames. Name it!
Thanks for giving us this perfect piece of software! :-)

	Thomas
