From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 08:42:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504180840370.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418150456.GC12750@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 17:37:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNYJ0-0004ZS-FN
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 17:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVDRPkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 11:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVDRPkw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 11:40:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:8577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262117AbVDRPkf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 11:40:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IFeHs4001391
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 08:40:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IFeFBN018357;
	Mon, 18 Apr 2005 08:40:16 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050418150456.GC12750@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Greg KH wrote:
>
> On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> > 
> > Tools absolutely matter. And it will take time for us to build up that 
> > kind of helper infrastructure. So being newbie might be part of it, but 
> > it's the smaller part, I say. Rough interfaces is a big issue.
> 
> Speaking of tools, you had a "dotest" program to apply patches in email
> form to a bk tree.  And from what I can gather, you've changed that to
> handle git archives, right?

Yup.

It's a git archive at 

	kernel.org:/pub/linux/kernel/people/torvalds/git-tools.git

and it seems to work. It's what I've used for all the kernel patches 
(except for the merge), and it's what I use for the git stuff that shows 
up as authored by others.

		Linus
