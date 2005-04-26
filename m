From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 13:11:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261310120.18901@ppc970.osdl.org>
References: <20050425214326.512b006e.davem@davemloft.net>
 <20050426005725.6bfe6135.akpm@osdl.org> <20050426183350.GB13224@pasky.ji.cz>
 <20050426115609.0481401b.akpm@osdl.org> <Pine.LNX.4.58.0504261209470.18901@ppc970.osdl.org>
 <20050426125141.6ec38d31.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@ucw.cz, davem@davemloft.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:05:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWIh-0006qQ-Oh
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVDZUKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVDZUKB
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:10:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:10672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261771AbVDZUJc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:09:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QK9Ss4020755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 13:09:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QK9R5K005176;
	Tue, 26 Apr 2005 13:09:27 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050426125141.6ec38d31.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Andrew Morton wrote:
>
> With bk I was resolving that by just smashing the patches on top of each
> other, ignoring the rejects and refreshing the topmost patch.  That
> approach actually resolved this linus-vs-davem dupe as well. 

Oh, wow. I didn't realize that your scripts were quite _that_ stupid, and 
didn't actually take advantage of any automatic merges at all.

If so, git should trivially do everything that BK ever did for you. Which 
is not saying a lot ;)

		Linus
