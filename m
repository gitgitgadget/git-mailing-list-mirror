From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison
Date: Fri, 12 Aug 2005 20:28:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508122021490.19049@g5.osdl.org>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org>
 <20050813031025.GE20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 05:29:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3mhf-0004qF-K6
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 05:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVHMD24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 23:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVHMD2z
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 23:28:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750711AbVHMD2z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 23:28:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D3SjjA001463
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 20:28:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D3Si2Z026958;
	Fri, 12 Aug 2005 20:28:44 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813031025.GE20812@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Petr Baudis wrote:
>
> Oh. Sounds nice, are there plans to run this on kernel.org too? (So far,
> 90% of my GIT network activity happens with kernel.org; the rest is with
> my notebook, and I want to keep that ssh.)

Maybe. I don't know what the status of that is, but the plan was to at 
least give it a try.

> BTW, is the pack protocol flexible enough to be extended to support
> pushing?

The _protocol_ could handle it, but you obviously need some kind of secure 
authentication, and quite frankly, one of the selling points on git-daemon 
right now is that it's all read-only and very simple and there should be 
no security issues because it will never write anything at all.

So right now git-daemon only accepts requests from fetch-pack.

> > [ Hey. There's a deer outside my window eating our roses again. Cute ]
> 
> Oh, it must be nice in Oregon. I can't imagine anything like that to
> happen in Czechia unless you live at a solitude or in some lonely tiny
> village.

Deer are really just oversized rats with horns (*). They're cute, though,
and it's kind of funny looking up from the screen and noticing one
munching on the roses just ten feet away. 

			Linus

(*) Did I mention that biology wasn't one of the things I did at Uni?
