From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 15:17:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 00:12:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNI03-0000WY-Vh
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDQWQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDQWQL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:16:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:52391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVDQWP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 18:15:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HMFrs4023398
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 15:15:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HMFqME010749;
	Sun, 17 Apr 2005 15:15:52 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113774736.3884.4.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, David Woodhouse wrote:
> 
> Do you want the commits list running for it yet? Do you want the
> changesets which are already in it re-mailed without a 'TESTING' tag?

I really don't know. I'm actually very happy where this thing is right
now, and completing that first merge successfully was a big milestone to
me personally. That said, actually _using_ this thing is not for the
faint-of-heart, and while I think "git" already is showing itself to be
useful, I'm very very biased.

In other words, I really wonder what an outsider that doesn't have the
same kind of mental bias thinks of the current git tree. Is it useful, or
is it still just a toy for Linus to test out his crazy SCM-wannabe.

Can people usefully track my current kernel git repository, or do you have
to be crazy to do so? That's really the question. You be the judge. Me,
I'm just giddy from a merge that was clearly done using interfaces that
aren't actually really usable for anybody but me, and barely me at that ;)

		Linus

Btw, I also do want this to show up in the BK trees for people who use 
BitKeeper - the same way we always supported tar-ball + patch users 
before. So I'll have to try to come up with some sane way to do that too. 
Any ideas? The first series of 198 patches is obvious enough and can be 
just done that way direcly, but the merge..
