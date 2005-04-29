From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Odd decision of git-pasky-0.7 to do a merge
Date: Fri, 29 Apr 2005 10:44:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291043060.18901@ppc970.osdl.org>
References: <20050429083615.A32271@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRZQH-0003lp-1u
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVD2Rmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVD2Rmn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:42:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:3792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262856AbVD2Rmk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 13:42:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3THgUs4021991
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 10:42:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3THgTPs026218;
	Fri, 29 Apr 2005 10:42:30 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050429083615.A32271@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Russell King wrote:
> 
> Why it decided that a merge was necessary is beyond me.  Any ideas?
> Did Linus forget to merge his tree properly?

It looks like it was unable to find the right common ancestor.

If you only had my stuff in it, the common ancestor _should_ have been the 
parent (c60c390620e0abb60d4ae8c43583714bda27763f), which _should_ have 
been your old top.

But maybe merge-base didn't work right?

		Linus
