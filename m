From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag
 objects and cg-push/git-push don't play nice)
Date: Wed, 19 Oct 2005 07:31:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 16:34:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESEyS-0006o8-Qh
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 16:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJSObP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 10:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVJSObP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 10:31:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750981AbVJSObO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 10:31:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JEV7FC017730
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 07:31:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JEV6x1002795;
	Wed, 19 Oct 2005 07:31:07 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10291>



On Wed, 19 Oct 2005, Martin Langhoff wrote:
> 
> On Debian i386 and Ubuntu i386, the exact same versions work correctly.

Interesting.

As you say, I'm obviously testing on ppc all the time, and if 
git-fetch-pack has problems on ppc, I haven't seen them. And I fetch a 
lot.

It might be just the repo you're using. I can't test, since I obviously 
cannot ssh into the repo you pointed at (I tried to see if you had a 
git-daemon running, but no such luck).

> I'll post more info as soon as I can get my hands on strace,

Even more interesting than strace might be for you to try to run 
git-send-pack (even on an x86) under valgrind. valgrind really is a 
wonderful tool.

One other potential issue: I'm not running debian. I've run YDL, but right 
now the machine I use is FC4. There are likely _lots_ of library 
differences etc there.

		Linus
