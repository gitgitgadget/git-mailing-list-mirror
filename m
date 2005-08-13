From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison
Date: Fri, 12 Aug 2005 22:25:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508122223280.19049@g5.osdl.org>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org>
 <20050813031025.GE20812@pasky.ji.cz> <Pine.LNX.4.58.0508122021490.19049@g5.osdl.org>
 <42FD8224.9020700@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:25:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oWZ-00023X-Hl
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVHMFZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHMFZa
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:25:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbVHMFZa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 01:25:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D5PMjA008161
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 22:25:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D5PLPp030557;
	Fri, 12 Aug 2005 22:25:22 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42FD8224.9020700@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, H. Peter Anvin wrote:
> 
> Running it over ssh would be a good way to do authentication...

Well, if you have ssh as an option, you don't need git-daemon any more, 
since the protocol that git-daemon does runs quite well over ssh on its 
own...

The only point of git-daemon really is when you don't have ssh access (ie
you may want to give people a limited interface, but not full ssh). Ie
as-is, it's only for anonymous reads of a git archive, but it obviously
_could_ do more.

		Linus
