From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 16:24:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 01:20:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJ31-0005K4-If
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVDQXWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVDQXWs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:22:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:16824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261542AbVDQXWh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:22:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HNMRs4028114
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 16:22:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HNMQ6f012673;
	Sun, 17 Apr 2005 16:22:26 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417235136.B30656@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
> 
> I pulled it tonight into a pristine tree (which of course worked.)

Goodie.

> In doing so, I noticed that I'd messed up one of the commits - there's
> a missing new file.  Grr.  I'll put that down to being a newbie git.

Actually, you should put that down to horribly bad interface tools.  With
BK, we had these nice tools that pointed out that there were files that
you might want to commit (ie "bk citool"), and made this very obvious.

Tools absolutely matter. And it will take time for us to build up that 
kind of helper infrastructure. So being newbie might be part of it, but 
it's the smaller part, I say. Rough interfaces is a big issue.

		Linus
