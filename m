From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 13:49:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188>
 <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 22:47:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEO9-000479-6Y
	for gcvg-git@gmane.org; Fri, 20 May 2005 22:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVETUrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVETUrb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 16:47:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:7340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261579AbVETUr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 16:47:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KKlNjA023193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 13:47:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KKlMNC000597;
	Fri, 20 May 2005 13:47:22 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428E49DD.406@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, H. Peter Anvin wrote:

> 
> What I ended up doing for the diff viewer on kernel.org is that every 
> page that's generated gets stuffed in a cache (locklessly indexed by a 
> SHA-1 of a canonicalized form of the query); the pages people actually 
> see are then simply pulled from the cache.  This caching was a just 
> enormous win.

Ok. That still leaves the bandwidth issue (the full diffs are bigger than 
the commit object), but usually the diffs in individual commits aren't 
_that_ large, so maybe it's a non-issue.

Oh, btw, I notice that you moved klibc over to git - care to share your
cvs->git script (I assume you scripted it ;)? That would seem to be an 
obvious addition to the core stuff..

		Linus
